{
 *****************************************************************************
  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************

 Author: Boban Spasic

 Unit description:
 View TX7 PCED parameters
}

unit untTX7View;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids,
  untTX7Function, untParConst, untUtils;

type

  { TfrmTX7View }

  TfrmTX7View = class(TForm)
    sgView: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure sgViewHeaderClick(Sender: TObject; IsColumn: boolean; Index: integer);
    procedure sgViewPrepareCanvas(Sender: TObject; aCol, aRow: integer;
      aState: TGridDrawState);
    procedure ViewTX7(ms: TMemoryStream);
  private

  public

  end;

var
  frmTX7View: TfrmTX7View;
  FTX7Funct:  TTX7FunctionContainer;
  toggle:     boolean;

implementation

{$R *.lfm}

{ TfrmTX7View }

procedure TfrmTX7View.FormCreate(Sender: TObject);
var
  i: integer;
  slNames: TStringList;
  msInits: TMemoryStream;
  b: byte;
begin
  toggle := False;
  for i := 1 to sgView.RowCount - 1 do
    sgView.Cells[0, i] := IntToStr(i - 1);
  slNames := TStringList.Create;
  slNames.Add('Parameter');
  for i := low(TX7_PCED_NAMES) to high(TX7_PCED_NAMES) do
    slNames.Add(TX7_PCED_NAMES[i, integer(toggle)]);
  sgView.Cols[1] := slNames;
  slNames.Free;
  FTX7Funct := TTX7FunctionContainer.Create;
  FTX7Funct.InitFunction;
  msInits := TMemoryStream.Create;
  FTX7Funct.Save_PCED_ToStream(msInits);

  msInits.Position := 0;
  for i := 1 to sgView.RowCount - 1 do
  begin
    b := msInits.ReadByte;
    case i of
      8: sgView.Cells[3, i] := IntToStr(b) + '     ' + transPORM[b];
      11: sgView.Cells[3, i] := IntToStr(b) + '     ' + transASGN[b];
      13: sgView.Cells[3, i] := IntToStr(b) + '     ' + transASGN[b];
      15: sgView.Cells[3, i] := IntToStr(b) + '     ' + transASGN[b];
      17: sgView.Cells[3, i] := IntToStr(b) + '     ' + transASGN[b];
      38: sgView.Cells[3, i] := IntToStr(b) + '     ' + transPORM[b];
      41: sgView.Cells[3, i] := IntToStr(b) + '     ' + transASGN[b];
      43: sgView.Cells[3, i] := IntToStr(b) + '     ' + transASGN[b];
      45: sgView.Cells[3, i] := IntToStr(b) + '     ' + transASGN[b];
      47: sgView.Cells[3, i] := IntToStr(b) + '     ' + transASGN[b];
      else
        if i > 64 then sgView.Cells[3, i] := IntToStr(b) + '     ' + Chr(b)
        else
          sgView.Cells[3, i] := IntToStr(b);
    end;
  end;
  FTX7Funct.Free;
  msInits.Free;
end;

procedure TfrmTX7View.sgViewHeaderClick(Sender: TObject; IsColumn: boolean;
  Index: integer);
var
  slNames: TStringList;
  i: integer;
begin
  Unused(IsColumn, Index);
  toggle := not toggle;
  slNames := TStringList.Create;
  slNames.Add('Parameter');
  for i := low(TX7_PCED_NAMES) to high(TX7_PCED_NAMES) do
    slNames.Add(TX7_PCED_NAMES[i, integer(toggle)]);
  sgView.Cols[1] := slNames;
  slNames.Free;
end;

procedure TfrmTX7View.sgViewPrepareCanvas(Sender: TObject; aCol, aRow: integer;
  aState: TGridDrawState);
begin
  Unused(aState);
  if aRow > 0 then
  begin
    if (aCol = 2) then
    begin
      if trim(TStringGrid(Sender).Cells[2, aRow]) <>
        trim(TStringGrid(Sender).Cells[3, aRow]) then
        TStringGrid(Sender).Canvas.Brush.Color := clSkyBlue
      else
        TStringGrid(Sender).Canvas.Brush.Color := clDefault;
    end
    else
      TStringGrid(Sender).Canvas.Brush.Color := clDefault;
  end;
end;

procedure TfrmTX7View.ViewTX7(ms: TMemoryStream);
var
  i: integer;
  b: byte;
begin
  ms.Position := 0;
  for i := 1 to sgView.RowCount - 1 do
  begin
    b := ms.ReadByte;
    case i of
      8: sgView.Cells[2, i] := IntToStr(b) + '     ' + transPORM[b];
      11: sgView.Cells[2, i] := IntToStr(b) + '     ' + transASGN[b];
      13: sgView.Cells[2, i] := IntToStr(b) + '     ' + transASGN[b];
      15: sgView.Cells[2, i] := IntToStr(b) + '     ' + transASGN[b];
      17: sgView.Cells[2, i] := IntToStr(b) + '     ' + transASGN[b];
      38: sgView.Cells[2, i] := IntToStr(b) + '     ' + transPORM[b];
      41: sgView.Cells[2, i] := IntToStr(b) + '     ' + transASGN[b];
      43: sgView.Cells[2, i] := IntToStr(b) + '     ' + transASGN[b];
      45: sgView.Cells[2, i] := IntToStr(b) + '     ' + transASGN[b];
      47: sgView.Cells[2, i] := IntToStr(b) + '     ' + transASGN[b];
      else
        if i > 64 then sgView.Cells[2, i] := IntToStr(b) + '     ' + Chr(b)
        else
          sgView.Cells[2, i] := IntToStr(b);
    end;
  end;
end;

end.
