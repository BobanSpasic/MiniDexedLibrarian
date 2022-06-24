unit untDX7Bank;

{$mode ObjFPC}{$H+}


interface

uses
  Classes, SysUtils, untDX7Voice;

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
  end;

implementation

constructor TDX7BankContainer.Create;
var
  i: integer;
begin
  inherited;
  for i := 0 to 31 do
    FDX7BankParams[i] := TDX7VoiceContainer.Create;
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
  if (Position < aStream.Size) and ((aStream.Size - Position) > 4096) then
    aStream.Position := Position else Exit;
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
    Result := FDX7BankParams[aVoiceNr - 1].GetVoiceName;
end;

end.
