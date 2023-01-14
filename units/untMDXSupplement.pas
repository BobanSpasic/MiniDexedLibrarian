{
 *****************************************************************************
  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************

 Author: Boban Spasic

 Unit description:
 Class implementing MiniDexed supplement data and related functions for one Voice.

 See the comments in the untDX7Voice about the Checksumm and CalculateHash functions.
}

unit untMDXSupplement;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, HlpHashFactory, SysUtils, untParConst;

const
  lastParam: integer = 52; //because of moving target

type
  //TMDX_PCEDx_Dump = array [0..lastParam] of byte;
  TMDX_PCEDx_Dump = array [0..52] of byte;

type
  TMDX_PCEDx_Params = packed record
    case boolean of
      True: (params: TMDX_PCEDx_Dump);
      False: (
        Volume: byte;
        Pan: byte;
        DetuneSGN: byte;
        DetuneVAL: byte;
        Cutoff: byte;
        Resonance: byte;
        NoteLimitLow: byte;
        NoteLimitHigh: byte;
        NoteShift: byte;
        PitchBendRange: byte;
        PitchBendStep: byte;
        PortamentoMode: byte;
        PortamentoGlissando: byte;
        PortamentoTime: byte;
        MonoMode: byte;
        ModulationWheelRange: byte;
        ModulationWheelTarget: byte;
        FootControlRange: byte;
        FootControlTarget: byte;
        BreathControlRange: byte;
        BreathControlTarget: byte;
        AftertouchRange: byte;
        AftertouchTarget: byte;
        VelocityLimitLow: byte;
        VelocityLimitHigh: byte;
        FX1Send: byte;
        FX2Send: byte;
        FX3Send: byte;
        FX4Send: byte;
        FX5Send: byte;
        FX6Send: byte;
        FX7Send: byte;
        FX8Send: byte;
        Res_01: byte;
        Res_02: byte;
        Res_03: byte;
        Res_04: byte;
        Res_05: byte;
        Res_06: byte;
        Res_07: byte;
        Res_08: byte;
        Res_09: byte;
        Res_10: byte;
        Res_11: byte;
        Res_12: byte;
        Res_13: byte;
        Res_14: byte;
        Res_15: byte;
        Res_16: byte;
        Res_17: byte;
        Res_18: byte;
        Res_19: byte;
        Res_20: byte;
      );
  end;

type
  TMDXSupplementContainer = class(TPersistent)
  private
    FMDX_PCEDx_Params: TMDX_PCEDx_Params;
  public
    function Load_PCEDx_FromStream(var aStream: TMemoryStream;
      Position: integer): boolean;
    procedure InitPCEDx; //set defaults
    function Get_PCEDx_Params: TMDX_PCEDx_Params;
    function Set_PCEDx_Params(aParams: TMDX_PCEDx_Params): boolean;
    function Save_PCEDx_ToStream(var aStream: TMemoryStream): boolean;
    function GetChecksumPart: integer;
    function GetChecksum: integer;
    procedure SysExFunctionToStream(ch: integer; var aStream: TMemoryStream);
    function CalculateHash: string;
  end;

implementation

function TMDXSupplementContainer.Load_PCEDx_FromStream(var aStream: TMemoryStream;
  Position: integer): boolean;
var
  i: integer;
begin
  Result := False;
  if (Position + lastParam) <= aStream.Size then
    aStream.Position := Position
  else
    Exit;
  try
    for i := 0 to lastParam do
      FMDX_PCEDx_Params.params[i] := aStream.ReadByte;

    Result := True;
  except
    Result := False;
  end;
end;

procedure TMDXSupplementContainer.InitPCEDx;
begin
  GetDefinedValues(MDX, fInit, FMDX_PCEDx_Params.params);
end;

function TMDXSupplementContainer.Get_PCEDx_Params: TMDX_PCEDx_Params;
begin
  Result := FMDX_PCEDx_Params;
end;

function TMDXSupplementContainer.Set_PCEDx_Params(aParams: TMDX_PCEDx_Params): boolean;
begin
  FMDX_PCEDx_Params := aParams;
  Result := True;
end;

function TMDXSupplementContainer.Save_PCEDx_ToStream(
  var aStream: TMemoryStream): boolean;
var
  i: integer;
begin
  //dont clear the stream here or else bulk dump won't work
  if Assigned(aStream) then
  begin
    for i := 0 to lastParam do
      aStream.WriteByte(FMDX_PCEDx_Params.params[i]);
    Result := True;
  end
  else
    Result := False;
end;

function TMDXSupplementContainer.CalculateHash: string;
var
  aStream: TMemoryStream;
  i: integer;
begin
  aStream := TMemoryStream.Create;
  for i := 0 to lastParam do
    aStream.WriteByte(FMDX_PCEDx_Params.params[i]);
  aStream.Position := 0;
  Result := THashFactory.TCrypto.CreateSHA2_256().ComputeStream(aStream).ToString();
  aStream.Free;
end;

function TMDXSupplementContainer.GetChecksumPart: integer;
var
  checksum: integer;
  i: integer;
  tmpStream: TMemoryStream;
begin
  checksum := 0;
  tmpStream := TMemoryStream.Create;
  Save_PCEDx_ToStream(tmpStream);
  tmpStream.Position := 0;
  for i := 0 to tmpStream.Size - 1 do
    checksum := checksum + tmpStream.ReadByte;
  Result := checksum;
  tmpStream.Free;
end;

function TMDXSupplementContainer.GetChecksum: integer;
var
  checksum: integer;
begin
  checksum := 0;
  try
    checksum := GetChecksumPart;
    Result := ((not (checksum and 255)) and 127) + 1;
  except
    on e: Exception do Result := 0;
  end;
end;

procedure TMDXSupplementContainer.SysExFunctionToStream(ch: integer;
  var aStream: TMemoryStream);
begin
  //ToDo - decide the ID for PCEDx
  aStream.Clear;
  aStream.Position := 0;
  aStream.WriteByte($F0);
  aStream.WriteByte($43);
  aStream.WriteByte($00 + ch); //MIDI channel
  aStream.WriteByte($01);       //Function
  aStream.WriteByte($00);
  aStream.WriteByte($5E);
  Save_PCEDx_ToStream(aStream);
  aStream.WriteByte(GetChecksum);
  aStream.WriteByte($F7);
end;

end.
