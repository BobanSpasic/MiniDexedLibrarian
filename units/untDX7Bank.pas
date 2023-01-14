{
 *****************************************************************************
  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************

 Author: Boban Spasic

 Unit description:
 Class implementing DX7 Voice Bank Data and related functions for 32 Voices.

 See the comments in the untDX7Voice about the Checksumm and CalculateHash functions.
}

unit untDX7Bank;

{$mode ObjFPC}{$H+}


interface

uses
  Classes, SysUtils, TypInfo, untDX7Voice;

type
  TDX7_VMEM_BankDump = array [1..32] of TDX7_VMEM_Dump;

type
  TDX7BankContainer = class(TPersistent)
  private
    FDX7BankParams: array [1..32] of TDX7VoiceContainer;
  public
    constructor Create;
    destructor Destroy; override;
    function GetVoice(aVoiceNr: integer; var FDX7Voice: TDX7VoiceContainer): boolean;
    function SetVoice(aVoiceNr: integer; var FDX7Voice: TDX7VoiceContainer): boolean;
    procedure LoadBankFromStream(var aStream: TMemoryStream; Position: integer);
    function GetVoiceName(aVoiceNr: integer): string;
    function GetChecksum: integer;
    function SaveBankToSysExFile(aFile: string): boolean;
    procedure SysExBankToStream(var aStream: TMemoryStream);
    procedure AppendSysExBankToStream(var aStream: TMemoryStream);
    function CalculateHash(aVoiceNr: integer): string;
  end;

implementation

constructor TDX7BankContainer.Create;
var
  i: integer;
begin
  inherited;
  for i := 1 to 32 do
  begin
    FDX7BankParams[i] := TDX7VoiceContainer.Create;
    FDX7BankParams[i].InitVoice;
  end;
end;

destructor TDX7BankContainer.Destroy;
var
  i: integer;
begin
  for i := 32 downto 1 do
    if Assigned(FDX7BankParams[i]) then
      FDX7BankParams[i].Destroy;
  inherited;
end;

function TDX7BankContainer.GetVoice(aVoiceNr: integer;
  var FDX7Voice: TDX7VoiceContainer): boolean;
begin
  if (aVoiceNr > 0) and (aVoiceNr < 33) then
  begin
    if Assigned(FDX7BankParams[aVoiceNr]) then
    begin
      FDX7Voice.Set_VMEM_Params(FDX7BankParams[aVoiceNr].Get_VMEM_Params);
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
    FDX7BankParams[aVoiceNr].Set_VMEM_Params(FDX7Voice.Get_VMEM_Params);
    Result := True;
  end
  else
    Result := False;
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
    for  j := 1 to 32 do
    begin
      if assigned(FDX7BankParams[j]) then
        FDX7BankParams[j].Load_VMEM_FromStream(aStream, aStream.Position);
    end;
  except

  end;
end;

function TDX7BankContainer.GetVoiceName(aVoiceNr: integer): string;
begin
  if (aVoiceNr > 0) and (aVoiceNr < 33) then
    Result := FDX7BankParams[aVoiceNr].GetVoiceName
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
    for i := 1 to 32 do
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
    for i := 1 to 32 do
      if FDX7BankParams[i].Save_VMEM_ToStream(tmpStream) = False then
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
  for i := 1 to 32 do
    FDX7BankParams[i].Save_VMEM_ToStream(aStream);
  aStream.WriteByte(GetChecksum);
  aStream.WriteByte($F7);
end;

procedure TDX7BankContainer.AppendSysExBankToStream(var aStream: TMemoryStream);
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
    FDX7BankParams[i].Save_VMEM_ToStream(aStream);
  aStream.WriteByte(GetChecksum);
  aStream.WriteByte($F7);
end;

function TDX7BankContainer.CalculateHash(aVoiceNr: integer): string;
begin
  if (aVoiceNr > 0) and (aVoiceNr < 33) then
    Result := FDX7BankParams[aVoiceNr].CalculateHash
  else
    Result := '';
end;

end.
