{
 *****************************************************************************
  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************

 Author: Boban Spasic

 Unit description:
 A couple of functions and procedures for general use in other units.
 Functions are ripped from midi.pas in order to be usable in *nix IFDEFs
}

unit untSysExUtils;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

function SysExStreamToStr(const aStream: TMemoryStream): ansistring;
function StrToSysExStream(const aString: ansistring;
  const aStream: TMemoryStream): boolean;
function Conv7to8(MSB7, LSB7: byte): integer;
function Conv8to7(MSB8, LSB8: byte; var MSB7, LSB7: byte): boolean;

implementation

function SysExStreamToStr(const aStream: TMemoryStream): ansistring;
var
  i: integer;
begin
  Result := '';
  aStream.Position := 0;
  for i := 0 to aStream.Size - 1 do
    Result := Result + Format('%.2x ', [byte(pansichar(aStream.Memory)[i])]);
end;

function StrToSysExStream(const aString: ansistring;
  const aStream: TMemoryStream): boolean;
const
  cHex: ansistring = '123456789ABCDEF';
var
  lStr: ansistring;
  i: integer;
  L: integer;
begin
  Result := True;
  L := length(aString);
  if not (L mod 2 = 0) // as HEX every byte must be two AnsiChars long, for example '0F'
  then Result := False
  else if l < 10  // shortest System Exclusive Message = 5 bytes = 10 hex AnsiChars
  then Result := False;

  lStr := StringReplace(AnsiUpperCase(aString), ' ', '', [rfReplaceAll]);
  aStream.Size := Length(lStr) div 2; // ' - 1' removed by BREAKOUTBOX 2009-07-15
  aStream.Position := 0;

  for i := 1 to aStream.Size do
    pansichar(aStream.Memory)[i - 1] :=
      ansichar(AnsiPos(lStr[i * 2 - 1], cHex) shl 4 + AnsiPos(lStr[i * 2], cHex));
end;

//ToDo - test these two functions
function Conv7to8(MSB7, LSB7: byte): integer;
var
  MSB, LSB: byte;
begin
  MSB := MSB7 and 127;
  LSB := LSB7 and 127;
  Result := MSB * 128 + LSB;
end;

function Conv8to7(MSB8, LSB8: byte; var MSB7, LSB7: byte): boolean;
var
  CB: byte;
begin
  Result := False;
  if (MSB8 * 256 + LSB8) > 16383 then exit
  else
  begin
    LSB7 := LSB8 and 127;
    CB := (LSB8 and 128) shr 7;
    MSB7 := (MSB8 shl 1) + CB;
    Result := True;
  end;
end;

end.
