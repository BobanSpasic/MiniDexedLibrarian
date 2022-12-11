{
 *****************************************************************************
  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************

 Author: Boban Spasic

}

unit untDX7IISupplBank;

{$mode ObjFPC}{$H+}


interface

uses
  Classes, SysUtils, TypInfo, untDX7IISupplement;

type
  TDX7II_AMEM_SupplBankDump   = array [0..31] of TDX7II_AMEM_Dump;

type
  TDX7IISupplBankContainer = class(TPersistent)
  private
    FDX7IISupplBankParams: array [0..31] of TDX7IISupplementContainer;
  public
    constructor Create;
    destructor Destroy; override;
    //function Load_AMEM_SupplBank(aPar: TDX7II_AMEM_SupplBankDump): boolean;
    procedure LoadSupplBankFromStream(var aStream: TMemoryStream; Position: integer);
    function GetSupplement(aSupplementNr: integer; var FDX7IISupplement: TDX7IISupplementContainer): boolean;
    function SetSupplement(aSupplementNr: integer; var FDX7IISupplement: TDX7IISupplementContainer): boolean;
    function GetChecksum: integer;
    function SaveSupplBankToSysExFile(aFile: string): boolean;
    procedure SysExSupplBankToStream(var aStream: TMemoryStream);
    function CalculateHash(aSupplementNr: integer): string;
    procedure InitBank;
  end;

implementation

constructor TDX7IISupplBankContainer.Create;
var
  i: integer;
begin
  inherited;
  for i := 0 to 31 do
  begin
    FDX7IISupplBankParams[i] := TDX7IISupplementContainer.Create;
    FDX7IISupplBankParams[i].InitSupplement;
  end;
end;

destructor TDX7IISupplBankContainer.Destroy;
var
  i: integer;
begin
  for i := 31 downto 0 do
    if Assigned(FDX7IISupplBankParams[i]) then
      FDX7IISupplBankParams[i].Destroy;
  inherited;
end;

function TDX7IISupplBankContainer.GetSupplement(aSupplementNr: integer;
  var FDX7IISupplement: TDX7IISupplementContainer): boolean;
begin
  if (aSupplementNr > 0) and (aSupplementNr < 33) then
  begin
    if Assigned(FDX7IISupplBankParams[aSupplementNr - 1]) then
    begin
      FDX7IISupplement.SetSupplementParams(FDX7IISupplBankParams[aSupplementNr - 1].GetSupplementParams);
      Result := True;
    end
    else
      Result := False;
  end
  else
    Result := False;
end;

function TDX7IISupplBankContainer.SetSupplement(aSupplementNr: integer;
  var FDX7IISupplement: TDX7IISupplementContainer): boolean;
begin
  if (aSupplementNr > 0) and (aSupplementNr < 33) then
  begin
    FDX7IISupplBankParams[aSupplementNr - 1].SetSupplementParams(FDX7IISupplement.GetSupplementParams);
    Result := True;
  end
  else
    Result := False;
end;

procedure TDX7IISupplBankContainer.LoadSupplBankFromStream(var aStream: TMemoryStream;
  Position: integer);
var
  j: integer;
begin
  if (Position < aStream.Size) and ((aStream.Size - Position) > 1120) then   //????
    aStream.Position := Position
  else
    Exit;
  try
    for  j := 0 to 31 do
    begin
      if assigned(FDX7IISupplBankParams[j]) then
        FDX7IISupplBankParams[j].Load_AMEM_FromStream(aStream, aStream.Position);
    end;
  except

  end;
end;

function TDX7IISupplBankContainer.GetChecksum: integer;
var
  i: integer;
  checksum: integer;
begin
  checksum := 0;
  try
    for i := 0 to 31 do
      checksum := checksum + FDX7IISupplBankParams[i].GetChecksumPart;
    Result := ((not (checksum and 255)) and 127) + 1;
  except
    on e: Exception do Result := 0;
  end;
end;

function TDX7IISupplBankContainer.SaveSupplBankToSysExFile(aFile: string): boolean;
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
    tmpStream.WriteByte($06);
    tmpStream.WriteByte($08);
    tmpStream.WriteByte($60);
    for i := 0 to 31 do
      if FDX7IISupplBankParams[i].Save_AMEM_ToStream(tmpStream) = False then
        Result := False;
    tmpStream.WriteByte(GetChecksum);
    tmpStream.WriteByte($F7);
    if Result = True then
      tmpStream.SaveToFile(aFile);
  finally
    tmpStream.Free;
  end;
end;

procedure TDX7IISupplBankContainer.SysExSupplBankToStream(var aStream: TMemoryStream);
var
  i: integer;
begin
  aStream.Clear;
  aStream.Position := 0;
  aStream.WriteByte($F0);
  aStream.WriteByte($43);
  aStream.WriteByte($00);
  aStream.WriteByte($06);
  aStream.WriteByte($08);
  aStream.WriteByte($60);
  for i := 0 to 31 do
    FDX7IISupplBankParams[i].Save_AMEM_ToStream(aStream);
  aStream.WriteByte(GetChecksum);
  aStream.WriteByte($F7);
end;

function TDX7IISupplBankContainer.CalculateHash(aSupplementNr: integer): string;
begin
  if (aSupplementNr > 0) and (aSupplementNr < 33) then
    Result := FDX7IISupplBankParams[aSupplementNr - 1].CalculateHash
  else
    Result := '';
end;

procedure TDX7IISupplBankContainer.InitBank;
var
  i: integer;
begin
  for i := 0 to 31 do
    FDX7IISupplBankParams[i].InitSupplement;
end;

end.
