{
 *****************************************************************************
  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************

 Author: Boban Spasic

 Unit description:
 Class implementing TX7 Function Bank and related functions.

 Glossary: DX7 Voice Data + TX7 Function Data = Performance in Yamaha's User Manual

 TX7 Function Bank contains 64 slots for parameters, where TX7 uses just the
 first half (1 to 32).
 It seems that Yamaha added the slots 33 to 64 for future use in some
 other synth or synt module. At least I do not know the use of the data in slots 33 to 64.

 See the comments in the untDX7Voice about the Checksumm and CalculateHash functions.
}

unit untTX7FunctBank;

{$mode ObjFPC}{$H+}


interface

uses
  Classes, SysUtils, TypInfo, untTX7Function;

type
  TTX7_PMEM_FunctBankDump = array [1..64] of TTX7_PMEM_Dump;

type
  TTX7FunctBankContainer = class(TPersistent)
  private
    FTX7FunctBankParams: array [1..64] of TTX7FunctionContainer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadFunctBankFromStream(var aStream: TMemoryStream; Position: integer);
    function GetFunction(aFunctionNr: integer;
      var FTX7Function: TTX7FunctionContainer): boolean;
    function SetFunction(aFunctionNr: integer;
      var FTX7Function: TTX7FunctionContainer): boolean;
    function GetChecksum: integer;
    function SaveFunctBankToSysExFile(aFile: string): boolean;
    procedure SysExFunctBankToStream(aCh: integer; var aStream: TMemoryStream);
    procedure AppendSysExFunctBankToStream(aCh: integer; var aStream: TMemoryStream);
    function CalculateHash(aFunctionNr: integer): string;
    procedure InitFunctBank;
    function FunctIsInit(nr: integer): boolean;
  end;

implementation

constructor TTX7FunctBankContainer.Create;
var
  i: integer;
begin
  inherited;
  for i := 1 to 64 do
  begin
    FTX7FunctBankParams[i] := TTX7FunctionContainer.Create;
    FTX7FunctBankParams[i].InitFunction;
  end;
end;

destructor TTX7FunctBankContainer.Destroy;
var
  i: integer;
begin
  for i := 64 downto 1 do
    if Assigned(FTX7FunctBankParams[i]) then
      FTX7FunctBankParams[i].Destroy;
  inherited;
end;

function TTX7FunctBankContainer.GetFunction(aFunctionNr: integer;
  var FTX7Function: TTX7FunctionContainer): boolean;
begin
  if (aFunctionNr > 0) and (aFunctionNr < 65) then
  begin
    if Assigned(FTX7FunctBankParams[aFunctionNr]) then
    begin
      FTX7Function.Set_PMEM_Params(FTX7FunctBankParams[aFunctionNr].Get_PMEM_Params);
      Result := True;
    end
    else
      Result := False;
  end
  else
    Result := False;
end;

function TTX7FunctBankContainer.SetFunction(aFunctionNr: integer;
  var FTX7Function: TTX7FunctionContainer): boolean;
begin
  if (aFunctionNr > 0) and (aFunctionNr < 65) then
  begin
    FTX7FunctBankParams[aFunctionNr].Set_PMEM_Params(FTX7Function.Get_PMEM_Params);
    Result := True;
  end
  else
    Result := False;
end;

procedure TTX7FunctBankContainer.LoadFunctBankFromStream(var aStream: TMemoryStream;
  Position: integer);
var
  j: integer;
begin
  if (Position < aStream.Size) and ((aStream.Size - Position) > 1120) then   //????
    aStream.Position := Position
  else
    Exit;
  try
    for  j := 1 to 64 do
    begin
      if assigned(FTX7FunctBankParams[j]) then
        FTX7FunctBankParams[j].Load_PMEM_FromStream(aStream, aStream.Position);
    end;
  except

  end;
end;

function TTX7FunctBankContainer.GetChecksum: integer;
var
  i: integer;
  checksum: integer;
begin
  //it seems that TX7 PMEM Checksumm is $00 if the PMEM is not used
  //thats I've found in a lot of files with TX7 PMEM
  //dunno how to implement this...
  //I get $80 for PMEM full with initial values

  checksum := 0;
  try
    for i := 1 to 64 do
      checksum := checksum + FTX7FunctBankParams[i].GetChecksumPart;
    Result := ((not (checksum and 255)) and 127) + 1;
  except
    on e: Exception do Result := 0;
  end;
end;

function TTX7FunctBankContainer.SaveFunctBankToSysExFile(aFile: string): boolean;
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
    tmpStream.WriteByte($02);
    tmpStream.WriteByte($20);
    tmpStream.WriteByte($00);
    for i := 1 to 64 do
      if FTX7FunctBankParams[i].Save_PMEM_ToStream(tmpStream) = False then
        Result := False;
    tmpStream.WriteByte(GetChecksum);
    tmpStream.WriteByte($F7);
    if Result = True then
      tmpStream.SaveToFile(aFile);
  finally
    tmpStream.Free;
  end;
end;

procedure TTX7FunctBankContainer.SysExFunctBankToStream(aCh: integer; var aStream: TMemoryStream);
var
  i: integer;
  FCh: byte;
begin
  FCh := aCh - 1;
  aStream.Clear;
  aStream.Position := 0;
  aStream.WriteByte($F0);
  aStream.WriteByte($43);
  aStream.WriteByte($00 + FCh);
  aStream.WriteByte($02);
  aStream.WriteByte($20);
  aStream.WriteByte($00);
  for i := 1 to 64 do
    FTX7FunctBankParams[i].Save_PMEM_ToStream(aStream);
  aStream.WriteByte(GetChecksum);
  aStream.WriteByte($F7);
end;

procedure TTX7FunctBankContainer.AppendSysExFunctBankToStream(aCh: integer; var aStream: TMemoryStream);
var
  i: integer;
  FCh: byte;
begin
  FCh := aCh - 1;
  aStream.WriteByte($F0);
  aStream.WriteByte($43);
  aStream.WriteByte($00 + FCh);
  aStream.WriteByte($02);
  aStream.WriteByte($20);
  aStream.WriteByte($00);
  for i := 1 to 64 do
    FTX7FunctBankParams[i].Save_PMEM_ToStream(aStream);
  aStream.WriteByte(GetChecksum);
  aStream.WriteByte($F7);
end;

function TTX7FunctBankContainer.CalculateHash(aFunctionNr: integer): string;
begin
  if (aFunctionNr > 0) and (aFunctionNr < 65) then
    Result := FTX7FunctBankParams[aFunctionNr].CalculateHash
  else
    Result := '';
end;

procedure TTX7FunctBankContainer.InitFunctBank;
var
  i: integer;
begin
  for i := 1 to 64 do
    FTX7FunctBankParams[i].InitFunction;
end;

function TTX7FunctBankContainer.FunctIsInit(nr: integer): boolean;
begin
  Result := FTX7FunctBankParams[nr].FunctIsInit;
end;

end.
