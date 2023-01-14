{
 *****************************************************************************
  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************

 Author: Boban Spasic

 Unit description:
 Class implementing DX7II Supplement Data and related functions for one Voice.

 See the comments in the untDX7Voice about the Checksumm and CalculateHash functions.
}

unit untDX7IISupplement;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, HlpHashFactory, SysUtils, untUtils, untParConst;

type
  TDX7II_AMEM_Dump = array [0..34] of byte;
  TDX7II_ACED_Dump = array [0..73] of byte;

type
  TDX7II_ACED_Params = packed record
    case boolean of
      True: (params: TDX7II_ACED_Dump);
      False: (
        OP6_Scaling_mode: byte;           //       0-1    normal/fraction
        OP5_Scaling_mode: byte;           //       0-1    normal/fraction
        OP4_Scaling_mode: byte;           //       0-1    normal/fraction
        OP3_Scaling_mode: byte;           //       0-1    normal/fraction
        OP2_Scaling_mode: byte;           //       0-1    normal/fraction
        OP1_Scaling_mode: byte;           //       0-1    normal/fraction
        OP6_AM_Sensitivity: byte;         //       0-7
        OP5_AM_Sensitivity: byte;         //       0-7
        OP4_AM_Sensitivity: byte;         //       0-7
        OP3_AM_Sensitivity: byte;         //       0-7
        OP2_AM_Sensitivity: byte;         //       0-7
        OP1_AM_Sensitivity: byte;         //       0-7
        Pitch_EG_Range: byte;             //       0-3    8va/4va/1va/0.5va
        LFO_Key_Trigger: byte;            //       0-1    single/multi
        Pitch_EG_by_velocity: byte;       //       0-1    off/on
        PMOD: byte;
        //       0-3    bit0:poly/mono bit1:unison off/on
        Pitch_Bend_Range: byte;           //       0-12
        Pitch_Bend_Step: byte;            //       0-12
        Pitch_Bend_Mode: byte;            //       0-2    low/high/k.on
        Random_Pitch_Fluct: byte;         //       0-7    off/5c-41c
        Portamento_Mode: byte;            //       0-1    rtn/fllw  fngrd/flltm
        Portamento_Step: byte;            //       0-12
        Portamento_Time: byte;            //       0-99
        ModWhell_Pitch_Mod_Range: byte;   //       0-99
        ModWhell_Ampl_Mod_Range: byte;    //       0-99
        ModWhell_EG_Bias_Range: byte;     //       0-99
        FootCtr_Pitch_Mod_Range: byte;    //       0-99
        FootCtr_Ampl_Mod_Range: byte;     //       0-99
        FootCtr_EG_Bias_Range: byte;      //       0-99
        FootCtr_Volume_Mod_Range: byte;   //       0-99
        BrthCtr_Pitch_Mod_Range: byte;    //       0-99
        BrthCtr_Ampl_Mod_Range: byte;     //       0-99
        BrthCtr_EG_Bias_Range: byte;      //       0-99
        BrthCtr_Pitch_Bias_Range: byte;   //       0-99
        AftrTch_Pitch_Mod_Range: byte;    //       0-99
        AftrTch_Ampl_Mod_Range: byte;     //       0-99
        AftrTch_EG_Bias_Range: byte;      //       0-99
        AftrTch_Pitch_Bias_Range: byte;   //       0-99
        Pitch_EG_Rate_Scaling_Depth: byte;//       0-7
        Reserved: array [39..63] of byte;
        FootCtr2_Pitch_Mod_Range: byte;   //       0-99
        FootCtr2_Ampl_Mod_Range: byte;    //       0-99
        FootCtr2_EG_Bias_Range: byte;     //       0-99
        FootCtr2_Volume_Mod_Range: byte;  //       0-99
        MIDICtr_Pitch_Mod_Range: byte;    //       0-99
        MIDICtr_Ampl_Mod_Range: byte;     //       0-99
        MIDICtr_EG_Bias_Range: byte;      //       0-99
        MIDICtr_Volume_Mod_Range: byte;   //       0-99
        Unison_Detune_Depth: byte;        //       0-7
        FootCtr1_as_CS1: byte;            //       0-1
      );
  end;

  TDX7II_AMEM_Params = packed record
    case boolean of
      True: (params: TDX7II_AMEM_Dump);
      False: (
        Scaling_Mode: byte;               //       0 | OP1| OP2| OP3| OP4| OP5| OP6|
        AM_Sensitivity5_6: byte;          //       0 |     OP5      |     OP6      |
        AM_Sensitivity3_4: byte;          //       0 |     OP3      |     OP4      |
        AM_Sensitivity1_2: byte;          //       0 |     OP1      |     OP2      |
        RNDP_VPSW_LTRG_PEGR: byte;        //           RNDP    |VPSW|LTRG|  PEGR   |
        PBR_PMOD: byte;                   //       0 |   PBR   |         |   PMOD  |
        PBM_PBS: byte;                    //       0 |   PBM   |        PBS        |
        PQNT_PORM: byte;                  //       0 |  0 |    PQNT           |PORM|
        Portamento_Time: byte;            //       0-99
        ModWhell_Pitch_Mod_Range: byte;   //       0-99
        ModWhell_Ampl_Mod_Range: byte;    //       0-99
        ModWhell_EG_Bias_Range: byte;     //       0-99
        FootCtr_Pitch_Mod_Range: byte;    //       0-99
        FootCtr_Ampl_Mod_Range: byte;     //       0-99
        FootCtr_EG_Bias_Range: byte;      //       0-99
        FootCtr_Volume_Mod_Range: byte;   //       0-99
        BrthCtr_Pitch_Mod_Range: byte;    //       0-99
        BrthCtr_Ampl_Mod_Range: byte;     //       0-99
        BrthCtr_EG_Bias_Range: byte;      //       0-99
        BrthCtr_Pitch_Bias_Range: byte;   //       0-99
        AftrTch_Pitch_Mod_Range: byte;    //       0-99
        AftrTch_Ampl_Mod_Range: byte;     //       0-99
        AftrTch_EG_Bias_Range: byte;      //       0-99
        AftrTch_Pitch_Bias_Range: byte;   //       0-99
        Pitch_EG_Rate_Scaling_Depth: byte;//       0-7
        Reserved: byte;                   //       0
        FootCtr2_Pitch_Mod_Range: byte;   //       0-99
        FootCtr2_Ampl_Mod_Range: byte;    //       0-99
        FootCtr2_EG_Bias_Range: byte;     //       0-99
        FootCtr2_Volume_Mod_Range: byte;  //       0-99
        MIDICtr_Pitch_Mod_Range: byte;    //       0-99
        MIDICtr_Ampl_Mod_Range: byte;     //       0-99
        MIDICtr_EG_Bias_Range: byte;      //       0-99
        MIDICtr_Volume_Mod_Range: byte;   //       0-99
        FCCS1_UDTN: byte;                 //       0 |  0 |  0 |FCCS|       UDTN   |
      );
  end;

type
  TDX7IISupplementContainer = class(TPersistent)
  private
    FDX7II_ACED_Params: TDX7II_ACED_Params;
    FDX7II_AMEM_Params: TDX7II_AMEM_Params;
  public
    function Load_AMEM_FromStream(var aStream: TMemoryStream;
      Position: integer): boolean;
    function Load_ACED_FromStream(var aStream: TMemoryStream;
      Position: integer): boolean;
    procedure InitSupplement; //set defaults
    function Get_AMEM_Params: TDX7II_AMEM_Params;
    function Get_ACED_Params: TDX7II_ACED_Params;
    function Set_AMEM_Params(aParams: TDX7II_AMEM_Params): boolean;
    function Save_AMEM_ToStream(var aStream: TMemoryStream): boolean;
    function Save_ACED_ToStream(var aStream: TMemoryStream): boolean;
    function GetChecksumPart: integer;
    function GetChecksum: integer;
    function SupplIsInit: boolean;
    procedure SysExSupplementToStream(ch: integer; var aStream: TMemoryStream);
    function CalculateHash: string;
  end;

function ACEDtoAMEM(aPar: TDX7II_ACED_Params): TDX7II_AMEM_Params;
function AMEMtoACED(aPar: TDX7II_AMEM_Params): TDX7II_ACED_Params;

implementation

function ACEDtoAMEM(aPar: TDX7II_ACED_Params): TDX7II_AMEM_Params;
var
  t: TDX7II_AMEM_Params;
begin
  //first the parameters without conversion
  t.Portamento_Time := aPar.Portamento_Time;
  t.ModWhell_Pitch_Mod_Range := aPar.ModWhell_Pitch_Mod_Range and 127;
  t.ModWhell_Ampl_Mod_Range := aPar.ModWhell_Ampl_Mod_Range and 127;
  t.ModWhell_EG_Bias_Range := aPar.ModWhell_EG_Bias_Range and 127;
  t.FootCtr_Pitch_Mod_Range := aPar.FootCtr_Pitch_Mod_Range and 127;
  t.FootCtr_Ampl_Mod_Range := aPar.FootCtr_Ampl_Mod_Range and 127;
  t.FootCtr_EG_Bias_Range := aPar.FootCtr_EG_Bias_Range and 127;
  t.FootCtr_Volume_Mod_Range := aPar.FootCtr_Volume_Mod_Range and 127;
  t.BrthCtr_Pitch_Mod_Range := aPar.BrthCtr_Pitch_Mod_Range and 127;
  t.BrthCtr_Ampl_Mod_Range := aPar.BrthCtr_Ampl_Mod_Range and 127;
  t.BrthCtr_EG_Bias_Range := aPar.BrthCtr_EG_Bias_Range and 127;
  t.BrthCtr_Pitch_Bias_Range := aPar.BrthCtr_Pitch_Bias_Range and 127;
  t.AftrTch_Pitch_Mod_Range := aPar.AftrTch_Pitch_Mod_Range and 127;
  t.AftrTch_Ampl_Mod_Range := aPar.AftrTch_Ampl_Mod_Range and 127;
  t.AftrTch_EG_Bias_Range := aPar.AftrTch_EG_Bias_Range and 127;
  t.AftrTch_Pitch_Bias_Range := aPar.AftrTch_Pitch_Bias_Range and 127;
  t.Reserved := 0;
  t.FootCtr2_Pitch_Mod_Range := aPar.FootCtr2_Pitch_Mod_Range and 127;
  t.FootCtr2_Ampl_Mod_Range := aPar.FootCtr2_Ampl_Mod_Range and 127;
  t.FootCtr2_EG_Bias_Range := aPar.FootCtr2_EG_Bias_Range and 127;
  t.FootCtr2_Volume_Mod_Range := aPar.FootCtr2_Volume_Mod_Range and 127;
  t.MIDICtr_Pitch_Mod_Range := aPar.MIDICtr_Pitch_Mod_Range and 127;
  t.MIDICtr_Ampl_Mod_Range := aPar.MIDICtr_Ampl_Mod_Range and 127;
  t.MIDICtr_EG_Bias_Range := aPar.MIDICtr_EG_Bias_Range and 127;
  t.MIDICtr_Volume_Mod_Range := aPar.MIDICtr_Volume_Mod_Range and 127;
  t.Pitch_EG_Rate_Scaling_Depth := aPar.Pitch_EG_Rate_Scaling_Depth and 127;

  //now parameters with conversion
  t.Scaling_Mode := (aPar.OP1_Scaling_mode shl 5) + (aPar.OP2_Scaling_mode shl 4) +
    (aPar.OP3_Scaling_mode shl 3) + (aPar.OP4_Scaling_mode shl 2) +
    (aPar.OP5_Scaling_mode shl 1) + aPar.OP6_Scaling_mode;
  t.AM_Sensitivity5_6 := (aPar.OP5_AM_Sensitivity shl 3) + aPar.OP6_AM_Sensitivity;
  t.AM_Sensitivity3_4 := (aPar.OP3_AM_Sensitivity shl 3) + aPar.OP4_AM_Sensitivity;
  t.AM_Sensitivity1_2 := (aPar.OP1_AM_Sensitivity shl 3) + aPar.OP2_AM_Sensitivity;
  t.RNDP_VPSW_LTRG_PEGR := (aPar.Random_Pitch_Fluct shl 4) +
    (aPar.Pitch_EG_by_velocity shl 3) + (aPar.LFO_Key_Trigger shl 2) +
    aPar.Pitch_EG_Range;
  t.PBR_PMOD := (aPar.Pitch_Bend_Range shl 2) + aPar.PMOD;
  t.PBM_PBS := (aPar.Pitch_Bend_Mode shl 4) + aPar.Pitch_Bend_Step;
  t.PQNT_PORM := (aPar.Portamento_Step shl 1) + aPar.Portamento_Mode;
  t.FCCS1_UDTN := (aPar.FootCtr1_as_CS1 shl 3) + aPar.Unison_Detune_Depth;

  Result := t;
end;

function AMEMtoACED(aPar: TDX7II_AMEM_Params): TDX7II_ACED_Params;
var
  t: TDX7II_ACED_Params;
  i: integer;
begin
  //first the parameters without conversion
  for i := 39 to 63 do
    t.Reserved[i] := aPar.Reserved and 127;
  t.Portamento_Time := aPar.Portamento_Time and 127;
  t.ModWhell_Pitch_Mod_Range := aPar.ModWhell_Pitch_Mod_Range and 127;
  t.ModWhell_Ampl_Mod_Range := aPar.ModWhell_Ampl_Mod_Range and 127;
  t.ModWhell_EG_Bias_Range := aPar.ModWhell_EG_Bias_Range and 127;
  t.FootCtr_Pitch_Mod_Range := aPar.FootCtr_Pitch_Mod_Range and 127;
  t.FootCtr_Ampl_Mod_Range := aPar.FootCtr_Ampl_Mod_Range and 127;
  t.FootCtr_EG_Bias_Range := aPar.FootCtr_EG_Bias_Range and 127;
  t.FootCtr_Volume_Mod_Range := aPar.FootCtr_Volume_Mod_Range and 127;
  t.BrthCtr_Pitch_Mod_Range := aPar.BrthCtr_Pitch_Mod_Range and 127;
  t.BrthCtr_Ampl_Mod_Range := aPar.BrthCtr_Ampl_Mod_Range and 127;
  t.BrthCtr_EG_Bias_Range := aPar.BrthCtr_EG_Bias_Range and 127;
  t.BrthCtr_Pitch_Bias_Range := aPar.BrthCtr_Pitch_Bias_Range and 127;
  t.AftrTch_Pitch_Mod_Range := aPar.AftrTch_Pitch_Mod_Range and 127;
  t.AftrTch_Ampl_Mod_Range := aPar.AftrTch_Ampl_Mod_Range and 127;
  t.AftrTch_EG_Bias_Range := aPar.AftrTch_EG_Bias_Range and 127;
  t.AftrTch_Pitch_Bias_Range := aPar.AftrTch_Pitch_Bias_Range and 127;
  t.FootCtr2_Pitch_Mod_Range := aPar.FootCtr2_Pitch_Mod_Range and 127;
  t.FootCtr2_Ampl_Mod_Range := aPar.FootCtr2_Ampl_Mod_Range and 127;
  t.FootCtr2_EG_Bias_Range := aPar.FootCtr2_EG_Bias_Range and 127;
  t.FootCtr2_Volume_Mod_Range := aPar.FootCtr2_Volume_Mod_Range and 127;
  t.MIDICtr_Pitch_Mod_Range := aPar.MIDICtr_Pitch_Mod_Range and 127;
  t.MIDICtr_Ampl_Mod_Range := aPar.MIDICtr_Ampl_Mod_Range and 127;
  t.MIDICtr_EG_Bias_Range := aPar.MIDICtr_EG_Bias_Range and 127;
  t.MIDICtr_Volume_Mod_Range := aPar.MIDICtr_Volume_Mod_Range and 127;
  t.Pitch_EG_Rate_Scaling_Depth := aPar.Pitch_EG_Rate_Scaling_Depth and 7;

  //now parameters with conversion
  t.OP1_Scaling_mode := (aPar.Scaling_Mode shr 5) and 1;
  t.OP2_Scaling_mode := (aPar.Scaling_Mode shr 4) and 1;
  t.OP3_Scaling_mode := (aPar.Scaling_Mode shr 3) and 1;
  t.OP4_Scaling_mode := (aPar.Scaling_Mode shr 2) and 1;
  t.OP5_Scaling_mode := (aPar.Scaling_Mode shr 1) and 1;
  t.OP6_Scaling_mode := aPar.Scaling_Mode and 1;
  t.OP6_AM_Sensitivity := aPar.AM_Sensitivity5_6 and 7;
  t.OP5_AM_Sensitivity := (aPar.AM_Sensitivity5_6 shr 3) and 7;
  t.OP4_AM_Sensitivity := aPar.AM_Sensitivity3_4 and 7;
  t.OP3_AM_Sensitivity := (aPar.AM_Sensitivity3_4 shr 3) and 7;
  t.OP2_AM_Sensitivity := aPar.AM_Sensitivity1_2 and 7;
  t.OP1_AM_Sensitivity := (aPar.AM_Sensitivity1_2 shr 3) and 7;
  t.Random_Pitch_Fluct := (aPar.RNDP_VPSW_LTRG_PEGR shr 4) and 7;
  t.Pitch_EG_by_velocity := (aPar.RNDP_VPSW_LTRG_PEGR shr 3) and 1;
  t.LFO_Key_Trigger := (aPar.RNDP_VPSW_LTRG_PEGR shr 2) and 1;
  t.Pitch_EG_Range := aPar.RNDP_VPSW_LTRG_PEGR and 3;
  t.Pitch_Bend_Range := (aPar.PBR_PMOD shr 2) and 15;
  t.PMOD := aPar.PBR_PMOD and 3;
  t.Pitch_Bend_Mode := (aPar.PBM_PBS shr 4) and 3;
  t.Pitch_Bend_Step := aPar.PBM_PBS and 15;
  t.Portamento_Step := (aPar.PQNT_PORM shr 1) and 15;
  t.Portamento_Mode := aPar.PQNT_PORM and 1;
  t.Unison_Detune_Depth := aPar.FCCS1_UDTN and 7;
  t.FootCtr1_as_CS1 := (aPar.FCCS1_UDTN shr 3) and 1;

  Result := t;
end;

function TDX7IISupplementContainer.Load_AMEM_FromStream(var aStream: TMemoryStream;
  Position: integer): boolean;
var
  i: integer;
begin
  Result := False;
  if (Position + 34) <= aStream.Size then
    aStream.Position := Position
  else
    Exit;
  try
    for i := 0 to 34 do
      FDX7II_AMEM_Params.params[i] := aStream.ReadByte;

    FDX7II_ACED_Params := AMEMtoACED(FDX7II_AMEM_Params);
    Result := True;
  except
    Result := False;
  end;
end;

function TDX7IISupplementContainer.Load_ACED_FromStream(var aStream: TMemoryStream;
  Position: integer): boolean;
var
  i: integer;
begin
  Result := False;
  if (Position + 73) <= aStream.Size then
    aStream.Position := Position
  else
    Exit;
  try
    for i := 0 to 73 do
      FDX7II_ACED_Params.params[i] := aStream.ReadByte;

    FDX7II_AMEM_Params := ACEDtoAMEM(FDX7II_ACED_Params);
    Result := True;
  except
    Result := False;
  end;
end;

procedure TDX7IISupplementContainer.InitSupplement;
begin
  GetDefinedValues(DX7II, fInit, FDX7II_ACED_Params.params);
  FDX7II_AMEM_Params := ACEDtoAMEM(FDX7II_ACED_Params);
end;

function TDX7IISupplementContainer.Get_AMEM_Params: TDX7II_AMEM_Params;
begin
  Result.params := FDX7II_AMEM_Params.params;
end;

function TDX7IISupplementContainer.Get_ACED_Params: TDX7II_ACED_Params;
begin
  Result := FDX7II_ACED_Params;
end;

function TDX7IISupplementContainer.Set_AMEM_Params(aParams:
  TDX7II_AMEM_Params): boolean;
begin
  FDX7II_AMEM_Params.params := aParams.params;
  FDX7II_ACED_Params := AMEMtoACED(FDX7II_AMEM_Params);
  Result := True;
end;

function TDX7IISupplementContainer.Save_AMEM_ToStream(
  var aStream: TMemoryStream): boolean;
var
  i: integer;
begin
  //dont clear the stream here or else bulk dump won't work
  if Assigned(aStream) then
  begin
    for i := 0 to 34 do
      aStream.WriteByte(FDX7II_AMEM_Params.params[i]);
    Result := True;
  end
  else
    Result := False;
end;

function TDX7IISupplementContainer.Save_ACED_ToStream(
  var aStream: TMemoryStream): boolean;
var
  i: integer;
begin
  if Assigned(aStream) then
  begin
    aStream.Clear;
    for i := 0 to 73 do
      aStream.WriteByte(FDX7II_ACED_Params.params[i]);
    Result := True;
  end
  else
    Result := False;
end;

function TDX7IISupplementContainer.CalculateHash: string;
var
  aStream: TMemoryStream;
  i: integer;
begin
  aStream := TMemoryStream.Create;
  for i := 0 to 73 do
    aStream.WriteByte(FDX7II_ACED_Params.params[i]);
  aStream.Position := 0;
  Result := THashFactory.TCrypto.CreateSHA2_256().ComputeStream(aStream).ToString();
  aStream.Free;
end;

function TDX7IISupplementContainer.SupplIsInit: boolean;
var
  init: TDX7II_ACED_Dump;
begin
  GetDefinedValues(DX7II, fInit, init);
  Result := SameArrays(FDX7II_ACED_Params.params, init);
end;

function TDX7IISupplementContainer.GetChecksumPart: integer;
var
  checksum: integer;
  i: integer;
  tmpStream: TMemoryStream;
begin
  checksum := 0;
  tmpStream := TMemoryStream.Create;
  Save_AMEM_ToStream(tmpStream);
  tmpStream.Position := 0;
  for i := 0 to tmpStream.Size - 1 do
    checksum := checksum + tmpStream.ReadByte;
  Result := checksum;
  tmpStream.Free;
end;

function TDX7IISupplementContainer.GetChecksum: integer;
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

procedure TDX7IISupplementContainer.SysExSupplementToStream(ch: integer;
  var aStream: TMemoryStream);
begin
  aStream.Clear;
  aStream.Position := 0;
  aStream.WriteByte($F0);
  aStream.WriteByte($43);
  aStream.WriteByte($00 + ch); //MIDI channel
  aStream.WriteByte($06);      //supplement
  aStream.WriteByte($08);
  aStream.WriteByte($60);
  Save_ACED_ToStream(aStream);
  aStream.WriteByte(GetChecksum);
  aStream.WriteByte($F7);
end;

end.
