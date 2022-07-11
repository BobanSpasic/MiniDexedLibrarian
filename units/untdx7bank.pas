{
 *****************************************************************************
  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************

 Author: Boban Spasic

}

unit untDX7Bank;

{$mode ObjFPC}{$H+}


interface

uses
  Classes, TypInfo, SysUtils, untDX7Voice;

type
  TDX7PackedBankDump = array [0..31] of TDX7PackedVoiceDump;
  TDX7ExpandedBankDump = array [0..31] of TDX7ExpandedVoiceDump;

type
  TDX7BankContainer = class(TPersistent)
  private
    FDX7BankParams: array [0..31] of TDX7VoiceContainer;
  public
    constructor Create;
    destructor Destroy; override;
    function LoadPackedBank(aPar: TDX7PackedBankDump): boolean;
    procedure LoadBankFromStream(var aStream: TMemoryStream; Position: integer);
    function GetVoiceName(aVoiceNr: integer): string;
    function GetVoice(aVoiceNr: integer; var FDX7Voice: TDX7VoiceContainer): boolean;
    function SetVoice(aVoiceNr: integer; var FDX7Voice: TDX7VoiceContainer): boolean;
    function GetChecksum: integer;
    function SaveBankToSysExFile(aFile: string): boolean;
    procedure SysExBankToStream(var aStream: TMemoryStream);
  end;

implementation

constructor TDX7BankContainer.Create;
var
  i: integer;
begin
  inherited;
  for i := 0 to 31 do
  begin
    FDX7BankParams[i] := TDX7VoiceContainer.Create;
    FDX7BankParams[i].InitVoice;
  end;
end;

destructor TDX7BankContainer.Destroy;
var
  i: integer;
begin
  for i := 31 downto 0 do
    if Assigned(FDX7BankParams[i]) then
      FDX7BankParams[i].Destroy;
  inherited;
end;

function TDX7BankContainer.GetVoice(aVoiceNr: integer;
  var FDX7Voice: TDX7VoiceContainer): boolean;
begin
  if (aVoiceNr > 0) and (aVoiceNr < 33) then
  begin
    if Assigned(FDX7BankParams[aVoiceNr - 1]) then
    begin
      FDX7Voice.SetVoiceParams(FDX7BankParams[aVoiceNr - 1].GetVoiceParams);
      Result := True;
    end
    else
      Result := False;
  end
  else
    Result := False;
end;

function TDX7BankContainer.SetVoice(aVoiceNr: integer;
  var FDX7Voice: TDX7VoiceContainer): boolean;
begin
  if (aVoiceNr > 0) and (aVoiceNr < 33) then
  begin
    FDX7BankParams[aVoiceNr - 1].SetVoiceParams(FDX7Voice.GetVoiceParams);
    Result := True;
  end
  else
    Result := False;
end;

function TDX7BankContainer.LoadPackedBank(aPar: TDX7PackedBankDump): boolean;
var
  i, j: integer;
begin
  Result := True;
  try
    for j := 0 to 31 do
      for i := low(aPar[j]) to high(aPar[j]) do
        FillByte(FDX7BankParams[j], SizeOf(byte), aPar[j][i]);
  except
    on e: Exception do Result := False;
  end;
end;

procedure TDX7BankContainer.LoadBankFromStream(var aStream: TMemoryStream;
  Position: integer);
var
  j: integer;
begin
  if (Position < aStream.Size) and ((aStream.Size - Position) > 4096) then   //????
    aStream.Position := Position
  else
    Exit;
  try
    for  j := 0 to 31 do
    begin
      if assigned(FDX7BankParams[j]) then
        FDX7BankParams[j].LoadPackedVoiceFromStream(aStream, aStream.Position);
    end;
  except

  end;
end;

function TDX7BankContainer.GetVoiceName(aVoiceNr: integer): string;
begin
  if (aVoiceNr > 0) and (aVoiceNr < 33) then
    Result := FDX7BankParams[aVoiceNr - 1].GetVoiceName
  else
    Result := '';
end;

function TDX7BankContainer.GetChecksum: integer;
var
  i: integer;
  checksum: integer;
begin
  checksum := 0;
  try
    for i := 0 to 31 do
      checksum := checksum + FDX7BankParams[i].GetChecksumPart;
    Result := ((not (checksum and 255)) and 127) + 1;
  except
    on e: Exception do Result := 0;
  end;
end;

function TDX7BankContainer.SaveBankToSysExFile(aFile: string): boolean;
var
  tmpStream: TMemoryStream;
  i: integer;
begin
  tmpStream := TMemoryStream.Create;
  try
    Result := True;
    tmpStream.WriteByte($F0);
    tmpStream.WriteByte($43);
    tmpStream.WriteByte($00);
    tmpStream.WriteByte($09);
    tmpStream.WriteByte($20);
    tmpStream.WriteByte($00);
    for i := 0 to 31 do
      if FDX7BankParams[i].SavePackedVoiceToStream(tmpStream) = False then
        Result := False;
    tmpStream.WriteByte(GetChecksum);
    tmpStream.WriteByte($F7);
    if Result = True then
      tmpStream.SaveToFile(aFile);
  finally
    tmpStream.Free;
  end;
end;

procedure TDX7BankContainer.SysExBankToStream(var aStream: TMemoryStream);
var
  i: integer;
begin
  aStream.Clear;
  aStream.Position := 0;
  aStream.WriteByte($F0);
  aStream.WriteByte($43);
  aStream.WriteByte($00);
  aStream.WriteByte($09);
  aStream.WriteByte($20);
  aStream.WriteByte($00);
  for i := 0 to 31 do
    FDX7BankParams[i].SavePackedVoiceToStream(aStream);
  aStream.WriteByte(GetChecksum);
  aStream.WriteByte($F7);
end;

end.
