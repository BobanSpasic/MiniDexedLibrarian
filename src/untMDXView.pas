unit untMDXView;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids,
  untMDXSupplement, untParConst, untUtils;

type

  { TfrmMDXView }

  TfrmMDXView = class(TForm)
    sgView: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure sgViewHeaderClick(Sender: TObject; IsColumn: boolean; Index: integer);
    procedure sgViewPrepareCanvas(Sender: TObject; aCol, aRow: integer;
      aState: TGridDrawState);
    procedure ViewMDX(ms: TMemoryStream);
  private

  public

  end;

var
  frmMDXView: TfrmMDXView;
  FMDXSuppl:  TMDXSupplementContainer;
  toggle:     boolean;

implementation

{$R *.lfm}

{ TfrmMDXView }

procedure TfrmMDXView.FormCreate(Sender: TObject);
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
  for i := low(MDX_PCEDx_NAMES) to high(MDX_PCEDx_NAMES) do
    slNames.Add(MDX_PCEDx_NAMES[i, integer(toggle)]);
  sgView.Cols[1] := slNames;
  slNames.Free;
  FMDXSuppl := TMDXSupplementContainer.Create;
  FMDXSuppl.InitPCEDx;
  msInits := TMemoryStream.Create;
  FMDXSuppl.Save_PCEDx_ToStream(msInits);

  msInits.Position := 0;
  for i := 1 to sgView.RowCount - 1 do
  begin
    b := msInits.ReadByte;
    case i of
      2: sgView.Cells[3, i] := IntToStr(b) + '     (' + IntToStr(b - 64) + ')';
      7: sgView.Cells[3, i] := IntToStr(b) + '     ' + Nr2NoteMDX(b);
      8: sgView.Cells[3, i] := IntToStr(b) + '     ' + Nr2NoteMDX(b);
      9: sgView.Cells[3, i] := IntToStr(b) + '     (' + IntToStr(b - 24) + ')';
      12: sgView.Cells[3, i] := IntToStr(b) + '     ' + transPORM[b];
      13: sgView.Cells[3, i] := IntToStr(b) + '     ' + transPOGL[b];
      15: sgView.Cells[3, i] := IntToStr(b) + '     ' + transMONO[b];
      17: sgView.Cells[3, i] := IntToStr(b) + '     ' + transASGN[b];
      19: sgView.Cells[3, i] := IntToStr(b) + '     ' + transASGN[b];
      21: sgView.Cells[3, i] := IntToStr(b) + '     ' + transASGN[b];
      23: sgView.Cells[3, i] := IntToStr(b) + '     ' + transASGN[b];
      else
        sgView.Cells[3, i] := IntToStr(b);
    end;
  end;
  FMDXSuppl.Free;
  msInits.Free;
end;

procedure TfrmMDXView.sgViewHeaderClick(Sender: TObject; IsColumn: boolean;
  Index: integer);
var
  slNames: TStringList;
  i: integer;
begin
  Unused(IsColumn, Index);
  toggle := not toggle;
  slNames := TStringList.Create;
  slNames.Add('Parameter');
  for i := low(MDX_PCEDx_NAMES) to high(MDX_PCEDx_NAMES) do
    slNames.Add(MDX_PCEDx_NAMES[i, integer(toggle)]);
  sgView.Cols[1] := slNames;
  slNames.Free;
end;

procedure TfrmMDXView.sgViewPrepareCanvas(Sender: TObject; aCol, aRow: integer;
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

procedure TfrmMDXView.ViewMDX(ms: TMemoryStream);
var
  i: integer;
  b: byte;
begin
  ms.Position := 0;
  for i := 1 to sgView.RowCount - 1 do
  begin
    b := ms.ReadByte;
    case i of
      2: sgView.Cells[2, i] := IntToStr(b) + '     (' + IntToStr(b - 64) + ')';
      7: sgView.Cells[2, i] := IntToStr(b) + '     ' + Nr2NoteMDX(b);
      8: sgView.Cells[2, i] := IntToStr(b) + '     ' + Nr2NoteMDX(b);
      9: sgView.Cells[2, i] := IntToStr(b) + '     (' + IntToStr(b - 24) + ')';
      12: sgView.Cells[2, i] := IntToStr(b) + '     ' + transPORM[b];
      13: sgView.Cells[2, i] := IntToStr(b) + '     ' + transPOGL[b];
      15: sgView.Cells[2, i] := IntToStr(b) + '     ' + transMONO[b];
      17: sgView.Cells[2, i] := IntToStr(b) + '     ' + transASGN[b];
      19: sgView.Cells[2, i] := IntToStr(b) + '     ' + transASGN[b];
      21: sgView.Cells[2, i] := IntToStr(b) + '     ' + transASGN[b];
      23: sgView.Cells[2, i] := IntToStr(b) + '     ' + transASGN[b];
      else
        sgView.Cells[2, i] := IntToStr(b);
    end;
  end;
end;

end.
