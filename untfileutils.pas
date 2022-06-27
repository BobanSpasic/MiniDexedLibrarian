unit untFileUtils;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, LazFileUtils;

procedure FindFiles(Directory: string; var sl: TStringList);

implementation

procedure FindFiles(Directory: string; var sl: TStringList);
var
  sr: TSearchRec;
begin
  if FindFirst(Directory + '*.syx', faAnyFile, sr) = 0 then
    repeat
      sl.Add(ExtractFileName(sr.Name));
    until FindNext(sr) <> 0;
  FindClose(sr);
end;

end.

