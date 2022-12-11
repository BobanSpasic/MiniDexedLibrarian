{
 *****************************************************************************
  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************

 Author: Boban Spasic

}

unit untUtils;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, LazFileUtils, SysUtils;

procedure FindSYX(Directory: string; var sl: TStringList);
procedure FindPERF(Directory: string; var sl: TStringList);
function SysExStreamToStr(const aStream: TMemoryStream): ansistring;
procedure Unused(const A1);
procedure Unused(const A1, A2);
procedure Unused(const A1, A2, A3);

implementation

procedure FindSYX(Directory: string; var sl: TStringList);
var
  sr: TSearchRec;
begin
  if FindFirst(Directory + '*.syx', faAnyFile, sr) = 0 then
    repeat
      sl.Add(ExtractFileName(sr.Name));
    until FindNext(sr) <> 0;
  FindClose(sr);
end;

procedure FindPERF(Directory: string; var sl: TStringList);
var
  sr: TSearchRec;
begin
  if FindFirst(Directory + '*.ini', faAnyFile, sr) = 0 then
    repeat
      sl.Add(ExtractFileName(sr.Name));
    until FindNext(sr) <> 0;
  FindClose(sr);
end;

function SysExStreamToStr(const aStream: TMemoryStream): ansistring;
var
  i: integer;
begin
  Result := '';
  aStream.Position := 0;
  for i := 0 to aStream.Size - 1 do
    Result := Result + Format('%.2x ', [byte(pansichar(aStream.Memory)[i])]);
end;

{$PUSH}{$HINTS OFF}
procedure Unused(const A1);
begin
end;

procedure Unused(const A1, A2);
begin
end;

procedure Unused(const A1, A2, A3);
begin
end;

{$POP}

end.
