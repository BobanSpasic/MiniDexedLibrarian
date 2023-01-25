{
 *****************************************************************************
  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************

 Author: Boban Spasic

 Unit description:
 This unit implements the internal bank container used by Control Center.
 For details, see the comments in untCCVoice
}

unit untCCBank;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, untDX7Voice, untDX7IISupplement,
  untTX7Function, untCCVoice;

type
  TCCBankContainer = class(TPersistent)
  private
    FCCBankParams: array [1..32] of TCCVoiceContainer;
    FHasGlobalSuppl: boolean;
    FHasGlobalFunct: boolean;
  public
    constructor Create;
    destructor Destroy; override;

    function HasGlobalSuppl: boolean;
    function HasGlobalFunct: boolean;
    function HasSuppl(aNr: integer): boolean;
    function HasFunct(aNr: integer): boolean;
    procedure SetHasSuppl(aNr: integer; b: boolean);
    procedure SetHasFunct(aNr: integer; b: boolean);
    procedure CLoadVoiceBankFromStream(var aStream: TMemoryStream; Position: integer);
    procedure CLoadSupplBankFromStream(var aStream: TMemoryStream; Position: integer);
    procedure CLoadFunctBankFromStream(var aStream: TMemoryStream; Position: integer);
    procedure CSaveVoiceBankToStream(var aStream: TMemoryStream);
    procedure CSaveSupplBankToStream(var aStream: TMemoryStream);
    procedure CSaveFunctBankToStream(var aStream: TMemoryStream);
    function CGetVoice(aVoiceNr: integer; var FDX7Voice: TDX7VoiceContainer): boolean;
    function CGetSupplement(aSupplementNr: integer;
      var FDX7IISupplement: TDX7IISupplementContainer): boolean;
    function CGetFunction(aFunctionNr: integer;
      var FTX7Function: TTX7FunctionContainer): boolean;
    function CSetVoice(aVoiceNr: integer; var FDX7Voice: TDX7VoiceContainer): boolean;
    function CSetSupplement(aSupplementNr: integer;
      var FDX7IISupplement: TDX7IISupplementContainer): boolean;
    function CSetFunction(aFunctionNr: integer;
      var FTX7Function: TTX7FunctionContainer): boolean;
    function CGetVoiceName(aVoiceNr: integer): string;

    //export functions
    procedure AppendSysExBankToStream(var aStream: TMemoryStream);
    procedure AppendSysExSupplBankToStream(var aStream: TMemoryStream);
    procedure AppendSysExFunctBankToStream(var aStream: TMemoryStream);

    function CSaveBankToSysExFile(aFile: string): boolean;
    procedure CSysExBankToStream(aCh: integer; var aStream: TMemoryStream);
    procedure CInitVoices;
    procedure CInitSuppl;
    procedure CInitFunct;

    function GetChecksumV: integer;
    function GetChecksumA: integer;
    function GetChecksumP: integer;
  end;

implementation

constructor TCCBankContainer.Create;
var
  i: integer;
begin
  inherited;
  for i := 1 to 32 do
  begin
    FCCBankParams[i] := TCCVoiceContainer.Create;
    FCCBankParams[i].InitVoice;
  end;
  FHasGlobalSuppl := False;
  FHasGlobalFunct := False;
end;

destructor TCCBankContainer.Destroy;
var
  i: integer;
begin
  for i := 32 downto 1 do
    if Assigned(FCCBankParams[i]) then
      FCCBankParams[i].Destroy;
  inherited;
end;

function TCCBankContainer.HasGlobalSuppl: boolean;
begin
  Result := FHasGlobalSuppl;
end;

function TCCBankContainer.HasGlobalFunct: boolean;
begin
  Result := FHasGlobalFunct;
end;

function TCCBankContainer.HasSuppl(aNr: integer): boolean;
begin
  Result := FCCBankParams[aNr].HasSuppl;
end;

function TCCBankContainer.HasFunct(aNr: integer): boolean;
begin
  Result := FCCBankParams[aNr].HasFunct;
end;

procedure TCCBankContainer.SetHasSuppl(aNr: integer; b: boolean);
begin
  FCCBankParams[aNr].HasSuppl := b;
end;

procedure TCCBankContainer.SetHasFunct(aNr: integer; b: boolean);
begin
  FCCBankParams[aNr].HasFunct := b;
end;

procedure TCCBankContainer.CLoadVoiceBankFromStream(var aStream: TMemoryStream;
  Position: integer);
var
  j: integer;
begin
  if (Position < aStream.Size) and ((aStream.Size - Position) >= 4096) then
    aStream.Position := Position
  else
    Exit;
  try
    for  j := 1 to 32 do
    begin
      if assigned(FCCBankParams[j]) then
        FCCBankParams[j].Load_VMEM_FromStream(aStream, aStream.Position);
    end;
    FHasGlobalSuppl := False;
    FHasGlobalFunct := False;
  except

  end;
end;

procedure TCCBankContainer.CLoadSupplBankFromStream(var aStream: TMemoryStream;
  Position: integer);
var
  j: integer;
begin
  if (Position < aStream.Size) and ((aStream.Size - Position) >= 1120) then   //????
    aStream.Position := Position
  else
    Exit;
  try
    for  j := 1 to 32 do
    begin
      if assigned(FCCBankParams[j]) then
        FCCBankParams[j].Load_AMEM_FromStream(aStream, aStream.Position);
    end;
  except

  end;
  FHasGlobalSuppl := True;
end;

procedure TCCBankContainer.CLoadFunctBankFromStream(var aStream: TMemoryStream;
  Position: integer);
var
  j: integer;
begin
  if (Position < aStream.Size) and ((aStream.Size - Position) >= 2048) then
    //???? 64 PMEMs pack
    aStream.Position := Position
  else
    Exit;
  try
    for  j := 1 to 32 do
    begin
      if assigned(FCCBankParams[j]) then
        FCCBankParams[j].Load_PMEM_FromStream(aStream, aStream.Position);
    end;
  except

  end;
  FHasGlobalFunct := True;
end;

procedure TCCBankContainer.CSaveVoiceBankToStream(var aStream: TMemoryStream);
var
  j: integer;
begin
  try
    for  j := 1 to 32 do
    begin
      if assigned(FCCBankParams[j]) then
        FCCBankParams[j].Save_VMEM_ToStream(aStream);
    end;
  except

  end;
end;

procedure TCCBankContainer.CSaveSupplBankToStream(var aStream: TMemoryStream);
var
  j: integer;
begin
  try
    for  j := 1 to 32 do
    begin
      if assigned(FCCBankParams[j]) then
        FCCBankParams[j].Save_AMEM_ToStream(aStream);
    end;
  except

  end;
end;

procedure TCCBankContainer.CSaveFunctBankToStream(var aStream: TMemoryStream);
var
  j: integer;
begin
  try
    for  j := 1 to 32 do
    begin
      if assigned(FCCBankParams[j]) then
        FCCBankParams[j].Save_PMEM_ToStream(aStream);
    end;
  except

  end;
end;

function TCCBankContainer.CGetVoice(aVoiceNr: integer;
  var FDX7Voice: TDX7VoiceContainer): boolean;
begin
  Result := FDX7Voice.Set_VMEM_Params(FCCBankParams[aVoiceNr].Get_VMEM_Params);
end;

function TCCBankContainer.CGetSupplement(aSupplementNr: integer;
  var FDX7IISupplement: TDX7IISupplementContainer): boolean;
begin
  Result := FDX7IISupplement.Set_AMEM_Params(
    FCCBankParams[aSupplementNr].Get_AMEM_Params);
end;

function TCCBankContainer.CGetFunction(aFunctionNr: integer;
  var FTX7Function: TTX7FunctionContainer): boolean;
begin
  Result := FTX7Function.Set_PMEM_Params(FCCBankParams[aFunctionNr].Get_PMEM_Params);
end;

function TCCBankContainer.CSetVoice(aVoiceNr: integer;
  var FDX7Voice: TDX7VoiceContainer): boolean;
begin
  Result := FCCBankParams[aVoiceNr].Set_VMEM_Params(FDX7Voice.Get_VMEM_Params);
end;

function TCCBankContainer.CSetSupplement(aSupplementNr: integer;
  var FDX7IISupplement: TDX7IISupplementContainer): boolean;
begin
  Result := FCCBankParams[aSupplementNr].Set_AMEM_Params(
    FDX7IISupplement.Get_AMEM_Params);
end;

function TCCBankContainer.CSetFunction(aFunctionNr: integer;
  var FTX7Function: TTX7FunctionContainer): boolean;
begin
  Result := FCCBankParams[aFunctionNr].Set_PMEM_Params(FTX7Function.Get_PMEM_Params);
end;

function TCCBankContainer.CGetVoiceName(aVoiceNr: integer): string;
begin
  Result := FCCBankParams[aVoiceNr].GetVoiceName;
end;

procedure TCCBankContainer.AppendSysExBankToStream(var aStream: TMemoryStream);
var
  i: integer;
begin
  aStream.WriteByte($F0);
  aStream.WriteByte($43);
  aStream.WriteByte($00);
  aStream.WriteByte($09);
  aStream.WriteByte($20);
  aStream.WriteByte($00);
  for i := 1 to 32 do
    FCCBankParams[i].Save_VMEM_ToStream(aStream);
  aStream.WriteByte(GetChecksumV);
  aStream.WriteByte($F7);
end;

procedure TCCBankContainer.AppendSysExSupplBankToStream(var aStream: TMemoryStream);
var
  i: integer;
begin
  aStream.WriteByte($F0);
  aStream.WriteByte($43);
  aStream.WriteByte($00);
  aStream.WriteByte($06);
  aStream.WriteByte($08);
  aStream.WriteByte($60);
  for i := 1 to 32 do
    FCCBankParams[i].Save_AMEM_ToStream(aStream);
  aStream.WriteByte(GetChecksumA);
  aStream.WriteByte($F7);
end;

procedure TCCBankContainer.AppendSysExFunctBankToStream(var aStream: TMemoryStream);
var
  i: integer;
begin
  aStream.WriteByte($F0);
  aStream.WriteByte($43);
  aStream.WriteByte($00);
  aStream.WriteByte($02);
  aStream.WriteByte($20);
  aStream.WriteByte($00);
  //TX7 expects 64 PMEMs, thus just do it twice
  for i := 1 to 32 do
    FCCBankParams[i].Save_PMEM_ToStream(aStream);
  for i := 1 to 32 do
    FCCBankParams[i].Save_PMEM_ToStream(aStream);
  aStream.WriteByte(GetChecksumP);
  aStream.WriteByte($F7);
end;

function TCCBankContainer.CSaveBankToSysExFile(aFile: string): boolean;
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    Result := True;
    try
      AppendSysExBankToStream(ms);
      if FHasGlobalSuppl then
        AppendSysExSupplBankToStream(ms);
      if FHasGlobalFunct then
        AppendSysExFunctBankToStream(ms);
      ms.SaveToFile(aFile);
    except
      on e: Exception do Result := False;
    end;
  finally
    ms.Free;
  end;
end;

procedure TCCBankContainer.CSysExBankToStream(aCh: integer; var aStream: TMemoryStream);
var
  i: integer;
  FCh: byte;
begin
  FCh := aCH - 1;
  aStream.Clear;
  aStream.Position := 0;
  aStream.WriteByte($F0);
  aStream.WriteByte($43);
  aStream.WriteByte($00 + FCh);
  aStream.WriteByte($09);
  aStream.WriteByte($20);
  aStream.WriteByte($00);
  for i := 1 to 32 do
    FCCBankParams[i].Save_VMEM_ToStream(aStream);
  aStream.WriteByte(GetChecksumV);
  aStream.WriteByte($F7);
  {it is used just to send MIDI dump to DX7-compatible devices,
  thus the AMEM and PMEM data is not included}
end;

procedure TCCBankContainer.CInitVoices;
var
  i: integer;
begin
  for i := 1 to 32 do
    FCCBankParams[i].InitVoice;
end;

procedure TCCBankContainer.CInitSuppl;
var
  i: integer;
begin
  for i := 1 to 32 do
    FCCBankParams[i].InitSuppl;
end;

procedure TCCBankContainer.CInitFunct;
var
  i: integer;
begin
  for i := 1 to 32 do
    FCCBankParams[i].InitFunct;
end;

function TCCBankContainer.GetChecksumV: integer;
var
  i: integer;
  checksum: integer;
begin
  checksum := 0;
  try
    for i := 1 to 32 do
      checksum := checksum + FCCBankParams[i].GetChecksumPartV;
    Result := ((not (checksum and 255)) and 127) + 1;
  except
    on e: Exception do Result := 0;
  end;
end;

function TCCBankContainer.GetChecksumA: integer;
var
  i: integer;
  checksum: integer;
begin
  checksum := 0;
  try
    for i := 1 to 32 do
      checksum := checksum + FCCBankParams[i].GetChecksumPartA;
    Result := ((not (checksum and 255)) and 127) + 1;
  except
    on e: Exception do Result := 0;
  end;
end;

function TCCBankContainer.GetChecksumP: integer;
var
  i: integer;
  checksum: integer;
begin
  checksum := 0;
  try
    //TX7 expects 64 PMEMs, thus just do it twice
    for i := 1 to 32 do
      checksum := checksum + FCCBankParams[i].GetChecksumPartP;
    for i := 1 to 32 do
      checksum := checksum + FCCBankParams[i].GetChecksumPartP;
    Result := ((not (checksum and 255)) and 127) + 1;
  except
    on e: Exception do Result := 0;
  end;
end;

end.
