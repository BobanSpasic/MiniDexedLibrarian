{
 *****************************************************************************
  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************

 Author: Boban Spasic

 Unit description:
 Class implementing DX7II Supplement Bank and related functions.

 See the comments in the untDX7Voice about the Checksumm and CalculateHash functions.
}

unit untDX7IISupplBank;

{$mode ObjFPC}{$H+}


interface

uses
  Classes, SysUtils, TypInfo, untDX7IISupplement;

type
  TDX7II_AMEM_SupplBankDump = array [1..32] of TDX7II_AMEM_Dump;

type
  TDX7IISupplBankContainer = class(TPersistent)
  private
    FDX7IISupplBankParams: array [1..32] of TDX7IISupplementContainer;
  public
    constructor Create;
    destructor Destroy; override;
    //function Load_AMEM_SupplBank(aPar: TDX7II_AMEM_SupplBankDump): boolean;
    procedure LoadSupplBankFromStream(var aStream: TMemoryStream; Position: integer);
    function GetSupplement(aSupplementNr: integer;
      var FDX7IISupplement: TDX7IISupplementContainer): boolean;
    function SetSupplement(aSupplementNr: integer;
      var FDX7IISupplement: TDX7IISupplementContainer): boolean;
    function GetChecksum: integer;
    function SaveSupplBankToSysExFile(aFile: string): boolean;
    procedure SysExSupplBankToStream(var aStream: TMemoryStream);
    procedure AppendSysExSupplBankToStream(var aStream: TMemoryStream);
    function CalculateHash(aSupplementNr: integer): string;
    procedure InitSupplBank;
    function SupplIsInit(nr: integer): boolean;
  end;

implementation

constructor TDX7IISupplBankContainer.Create;
var
  i: integer;
begin
  inherited;
  for i := 1 to 32 do
  begin
    FDX7IISupplBankParams[i] := TDX7IISupplementContainer.Create;
    FDX7IISupplBankParams[i].InitSupplement;
  end;
end;

destructor TDX7IISupplBankContainer.Destroy;
var
  i: integer;
begin
  for i := 32 downto 1 do
    if Assigned(FDX7IISupplBankParams[i]) then
      FDX7IISupplBankParams[i].Destroy;
  inherited;
end;

function TDX7IISupplBankContainer.GetSupplement(aSupplementNr: integer;
  var FDX7IISupplement: TDX7IISupplementContainer): boolean;
begin
  if (aSupplementNr > 0) and (aSupplementNr < 33) then
  begin
    if Assigned(FDX7IISupplBankParams[aSupplementNr]) then
    begin
      FDX7IISupplement.Set_AMEM_Params(
        FDX7IISupplBankParams[aSupplementNr].Get_AMEM_Params);
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
    FDX7IISupplBankParams[aSupplementNr].Set_AMEM_Params(
      FDX7IISupplement.Get_AMEM_Params);
    Result := True;
  end
  else
    Result := False;
end;

procedure TDX7IISupplBankContainer.LoadSupplBankFromStream(
  var aStream: TMemoryStream; Position: integer);
var
  j: integer;
begin
  if (Position < aStream.Size) and ((aStream.Size - Position) > 1120) then   //????
    aStream.Position := Position
  else
    Exit;
  try
    for  j := 1 to 32 do
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
    for i := 1 to 32 do
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
    for i := 1 to 32 do
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
  for i := 1 to 32 do
    FDX7IISupplBankParams[i].Save_AMEM_ToStream(aStream);
  aStream.WriteByte(GetChecksum);
  aStream.WriteByte($F7);
end;

procedure TDX7IISupplBankContainer.AppendSysExSupplBankToStream(
  var aStream: TMemoryStream);
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
    FDX7IISupplBankParams[i].Save_AMEM_ToStream(aStream);
  aStream.WriteByte(GetChecksum);
  aStream.WriteByte($F7);
end;

function TDX7IISupplBankContainer.CalculateHash(aSupplementNr: integer): string;
begin
  if (aSupplementNr > 0) and (aSupplementNr < 33) then
    Result := FDX7IISupplBankParams[aSupplementNr].CalculateHash
  else
    Result := '';
end;

procedure TDX7IISupplBankContainer.InitSupplBank;
var
  i: integer;
begin
  for i := 1 to 32 do
    FDX7IISupplBankParams[i].InitSupplement;
end;

function TDX7IISupplBankContainer.SupplIsInit(nr: integer): boolean;
begin
  Result := FDX7IISupplBankParams[nr].SupplIsInit;
end;

end.
