{
 *****************************************************************************
  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************

 Author: Boban Spasic

 Unit description:
 View DX7II ACED parameters
}

unit untDX7IIView;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids,
  untDX7IISupplement, untParConst, untUtils;

type

  { TfrmDX7IIView }

  TfrmDX7IIView = class(TForm)
    sgView: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure sgViewHeaderClick(Sender: TObject; IsColumn: boolean; Index: integer);
    procedure sgViewPrepareCanvas(Sender: TObject; aCol, aRow: integer;
      aState: TGridDrawState);
    procedure ViewDX7II(ms: TMemoryStream);
  private

  public

  end;

var
  frmDX7IIView: TfrmDX7IIView;
  FDX7IISuppl: TDX7IISupplementContainer;
  toggle: boolean;

implementation

{$R *.lfm}

{ TfrmDX7IIView }

procedure TfrmDX7IIView.FormCreate(Sender: TObject);
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
  for i := low(DX7II_ACED_NAMES) to high(DX7II_ACED_NAMES) do
    slNames.Add(DX7II_ACED_NAMES[i, integer(toggle)]);
  sgView.Cols[1] := slNames;
  slNames.Free;
  FDX7IISuppl := TDX7IISupplementContainer.Create;
  FDX7IISuppl.InitSupplement;
  msInits := TMemoryStream.Create;
  FDX7IISuppl.Save_ACED_ToStream(msInits);

  msInits.Position := 0;
  for i := 1 to sgView.RowCount - 1 do
  begin
    b := msInits.ReadByte;
    case i of
      1: sgView.Cells[3, i] := IntToStr(b) + '     ' + transSCMD[b];
      2: sgView.Cells[3, i] := IntToStr(b) + '     ' + transSCMD[b];
      3: sgView.Cells[3, i] := IntToStr(b) + '     ' + transSCMD[b];
      4: sgView.Cells[3, i] := IntToStr(b) + '     ' + transSCMD[b];
      5: sgView.Cells[3, i] := IntToStr(b) + '     ' + transSCMD[b];
      6: sgView.Cells[3, i] := IntToStr(b) + '     ' + transSCMD[b];
      13: sgView.Cells[3, i] := IntToStr(b) + '     ' + transPEGR[b];
      14: sgView.Cells[3, i] := IntToStr(b) + '     ' + transLTRG[b];
      16: sgView.Cells[3, i] := IntToStr(b) + '     ' + transPMOD[b];
      19: sgView.Cells[3, i] := IntToStr(b) + '     ' + transPBM[b];
      20: sgView.Cells[3, i] := IntToStr(b) + '     ' + transRPF[b];
      21: sgView.Cells[3, i] := IntToStr(b) + '     ' + transPORM[b];
      34: sgView.Cells[3, i] := IntToStr(b) + '     (' + IntToStr(b - 50) + ')';
      38: sgView.Cells[3, i] := IntToStr(b) + '     (' + IntToStr(b - 50) + ')';
      else
        sgView.Cells[3, i] := IntToStr(b);
    end;
  end;
  FDX7IISuppl.Free;
  msInits.Free;
end;

procedure TfrmDX7IIView.sgViewHeaderClick(Sender: TObject; IsColumn: boolean;
  Index: integer);
var
  slNames: TStringList;
  i: integer;
begin
  Unused(IsColumn, Index);
  toggle := not toggle;
  slNames := TStringList.Create;
  slNames.Add('Parameter');
  for i := low(DX7II_ACED_NAMES) to high(DX7II_ACED_NAMES) do
    slNames.Add(DX7II_ACED_NAMES[i, integer(toggle)]);
  sgView.Cols[1] := slNames;
  slNames.Free;
end;

procedure TfrmDX7IIView.sgViewPrepareCanvas(Sender: TObject;
  aCol, aRow: integer; aState: TGridDrawState);
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

procedure TfrmDX7IIView.ViewDX7II(ms: TMemoryStream);
var
  i: integer;
  b: byte;
begin
  ms.Position := 0;
  for i := 1 to sgView.RowCount - 1 do
  begin
    b := ms.ReadByte;
    case i of
      1: sgView.Cells[2, i] := IntToStr(b) + '     ' + transSCMD[b];
      2: sgView.Cells[2, i] := IntToStr(b) + '     ' + transSCMD[b];
      3: sgView.Cells[2, i] := IntToStr(b) + '     ' + transSCMD[b];
      4: sgView.Cells[2, i] := IntToStr(b) + '     ' + transSCMD[b];
      5: sgView.Cells[2, i] := IntToStr(b) + '     ' + transSCMD[b];
      6: sgView.Cells[2, i] := IntToStr(b) + '     ' + transSCMD[b];
      13: sgView.Cells[2, i] := IntToStr(b) + '     ' + transPEGR[b];
      14: sgView.Cells[2, i] := IntToStr(b) + '     ' + transLTRG[b];
      16: sgView.Cells[2, i] := IntToStr(b) + '     ' + transPMOD[b];
      19: sgView.Cells[2, i] := IntToStr(b) + '     ' + transPBM[b];
      20: sgView.Cells[2, i] := IntToStr(b) + '     ' + transRPF[b];
      21: sgView.Cells[2, i] := IntToStr(b) + '     ' + transPORM[b];
      34: sgView.Cells[2, i] := IntToStr(b) + '     (' + IntToStr(b - 50) + ')';
      38: sgView.Cells[2, i] := IntToStr(b) + '     (' + IntToStr(b - 50) + ')';
      else
        sgView.Cells[2, i] := IntToStr(b);
    end;
  end;
end;

end.
