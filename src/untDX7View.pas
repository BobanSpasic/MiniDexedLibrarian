{
 *****************************************************************************
  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************

 Author: Boban Spasic

 Unit description:
 View DX7 VCED parameters
}

unit untDX7View;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids, untDX7Voice, untParConst, untUtils;

type

  { TfrmDX7View }

  TfrmDX7View = class(TForm)
    sgView: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure sgViewHeaderClick(Sender: TObject; IsColumn: boolean; Index: integer);
    procedure sgViewPrepareCanvas(Sender: TObject; aCol, aRow: integer;
      aState: TGridDrawState);
    procedure ViewDX7(ms: TMemoryStream);
  private

  public

  end;

var
  frmDX7View: TfrmDX7View;
  FDX7Voice:  TDX7VoiceContainer;
  toggle:     boolean;

implementation

{$R *.lfm}

{ TfrmDX7View }

procedure TfrmDX7View.FormCreate(Sender: TObject);
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
  for i := low(DX7_VCED_NAMES) to high(DX7_VCED_NAMES) do
    slNames.Add(DX7_VCED_NAMES[i, integer(toggle)]);
  sgView.Cols[1] := slNames;
  slNames.Free;
  FDX7Voice := TDX7VoiceContainer.Create;
  FDX7Voice.InitVoice;
  msInits := TMemoryStream.Create;
  FDX7Voice.Save_VCED_ToStream(msInits);

  msInits.Position := 0;
  for i := 1 to sgView.RowCount - 1 do
  begin
    b := msInits.ReadByte;
    case i of
      9: sgView.Cells[3, i] := IntToStr(b) + '     ' + Nr2Note(b);
      10: sgView.Cells[3, i] := IntToStr(b) + '     ' + Nr2Note(b);
      11: sgView.Cells[3, i] := IntToStr(b) + '     ' + Nr2Note(b);
      12: sgView.Cells[3, i] := IntToStr(b) + '     ' + transSCL[b];
      13: sgView.Cells[3, i] := IntToStr(b) + '     ' + transSCL[b];
      18: sgView.Cells[3, i] := IntToStr(b) + '     ' + transOSC[b];
      21: sgView.Cells[3, i] := IntToStr(b) + '     (' + IntToStr(b - 7) + ')';
      30: sgView.Cells[3, i] := IntToStr(b) + '     ' + Nr2Note(b);
      31: sgView.Cells[3, i] := IntToStr(b) + '     ' + Nr2Note(b);
      32: sgView.Cells[3, i] := IntToStr(b) + '     ' + Nr2Note(b);
      33: sgView.Cells[3, i] := IntToStr(b) + '     ' + transSCL[b];
      34: sgView.Cells[3, i] := IntToStr(b) + '     ' + transSCL[b];
      39: sgView.Cells[3, i] := IntToStr(b) + '     ' + transOSC[b];
      42: sgView.Cells[3, i] := IntToStr(b) + '     (' + IntToStr(b - 7) + ')';
      51: sgView.Cells[3, i] := IntToStr(b) + '     ' + Nr2Note(b);
      52: sgView.Cells[3, i] := IntToStr(b) + '     ' + Nr2Note(b);
      53: sgView.Cells[3, i] := IntToStr(b) + '     ' + Nr2Note(b);
      54: sgView.Cells[3, i] := IntToStr(b) + '     ' + transSCL[b];
      55: sgView.Cells[3, i] := IntToStr(b) + '     ' + transSCL[b];
      60: sgView.Cells[3, i] := IntToStr(b) + '     ' + transOSC[b];
      63: sgView.Cells[3, i] := IntToStr(b) + '     (' + IntToStr(b - 7) + ')';
      72: sgView.Cells[3, i] := IntToStr(b) + '     ' + Nr2Note(b);
      73: sgView.Cells[3, i] := IntToStr(b) + '     ' + Nr2Note(b);
      74: sgView.Cells[3, i] := IntToStr(b) + '     ' + Nr2Note(b);
      75: sgView.Cells[3, i] := IntToStr(b) + '     ' + transSCL[b];
      76: sgView.Cells[3, i] := IntToStr(b) + '     ' + transSCL[b];
      81: sgView.Cells[3, i] := IntToStr(b) + '     ' + transOSC[b];
      84: sgView.Cells[3, i] := IntToStr(b) + '     (' + IntToStr(b - 7) + ')';
      93: sgView.Cells[3, i] := IntToStr(b) + '     ' + Nr2Note(b);
      94: sgView.Cells[3, i] := IntToStr(b) + '     ' + Nr2Note(b);
      95: sgView.Cells[3, i] := IntToStr(b) + '     ' + Nr2Note(b);
      96: sgView.Cells[3, i] := IntToStr(b) + '     ' + transSCL[b];
      97: sgView.Cells[3, i] := IntToStr(b) + '     ' + transSCL[b];
      102: sgView.Cells[3, i] := IntToStr(b) + '     ' + transOSC[b];
      105: sgView.Cells[3, i] := IntToStr(b) + '     (' + IntToStr(b - 7) + ')';
      114: sgView.Cells[3, i] := IntToStr(b) + '     ' + Nr2Note(b);
      115: sgView.Cells[3, i] := IntToStr(b) + '     ' + Nr2Note(b);
      116: sgView.Cells[3, i] := IntToStr(b) + '     ' + Nr2Note(b);
      117: sgView.Cells[3, i] := IntToStr(b) + '     ' + transSCL[b];
      118: sgView.Cells[3, i] := IntToStr(b) + '     ' + transSCL[b];
      123: sgView.Cells[3, i] := IntToStr(b) + '     ' + transOSC[b];
      126: sgView.Cells[3, i] := IntToStr(b) + '     (' + IntToStr(b - 7) + ')';
      143: sgView.Cells[3, i] := IntToStr(b) + '     ' + transLFW[b];
      else
        if (i > 145) and (i < 156) then sgView.Cells[3, i] :=
            IntToStr(b) + '     ' + Chr(b)
        else
          sgView.Cells[3, i] := IntToStr(b);
    end;
  end;
  FDX7Voice.Free;
  msInits.Free;
end;

procedure TfrmDX7View.sgViewHeaderClick(Sender: TObject; IsColumn: boolean;
  Index: integer);
var
  slNames: TStringList;
  i: integer;
begin
  Unused(IsColumn, Index);
  toggle := not toggle;
  slNames := TStringList.Create;
  slNames.Add('Parameter');
  for i := low(DX7_VCED_NAMES) to high(DX7_VCED_NAMES) do
    slNames.Add(DX7_VCED_NAMES[i, integer(toggle)]);
  sgView.Cols[1] := slNames;
  slNames.Free;
end;

procedure TfrmDX7View.sgViewPrepareCanvas(Sender: TObject; aCol, aRow: integer;
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

procedure TfrmDX7View.ViewDX7(ms: TMemoryStream);
var
  i: integer;
  b: byte;
begin
  ms.Position := 0;
  for i := 1 to sgView.RowCount - 1 do
  begin
    b := ms.ReadByte;
    case i of
      9: sgView.Cells[2, i] := IntToStr(b) + '     ' + Nr2Note(b);
      10: sgView.Cells[2, i] := IntToStr(b) + '     ' + Nr2Note(b);
      11: sgView.Cells[2, i] := IntToStr(b) + '     ' + Nr2Note(b);
      12: sgView.Cells[2, i] := IntToStr(b) + '     ' + transSCL[b];
      13: sgView.Cells[2, i] := IntToStr(b) + '     ' + transSCL[b];
      18: sgView.Cells[2, i] := IntToStr(b) + '     ' + transOSC[b];
      21: sgView.Cells[2, i] := IntToStr(b) + '     (' + IntToStr(b - 7) + ')';
      30: sgView.Cells[2, i] := IntToStr(b) + '     ' + Nr2Note(b);
      31: sgView.Cells[2, i] := IntToStr(b) + '     ' + Nr2Note(b);
      32: sgView.Cells[2, i] := IntToStr(b) + '     ' + Nr2Note(b);
      33: sgView.Cells[2, i] := IntToStr(b) + '     ' + transSCL[b];
      34: sgView.Cells[2, i] := IntToStr(b) + '     ' + transSCL[b];
      39: sgView.Cells[2, i] := IntToStr(b) + '     ' + transOSC[b];
      42: sgView.Cells[2, i] := IntToStr(b) + '     (' + IntToStr(b - 7) + ')';
      51: sgView.Cells[2, i] := IntToStr(b) + '     ' + Nr2Note(b);
      52: sgView.Cells[2, i] := IntToStr(b) + '     ' + Nr2Note(b);
      53: sgView.Cells[2, i] := IntToStr(b) + '     ' + Nr2Note(b);
      54: sgView.Cells[2, i] := IntToStr(b) + '     ' + transSCL[b];
      55: sgView.Cells[2, i] := IntToStr(b) + '     ' + transSCL[b];
      60: sgView.Cells[2, i] := IntToStr(b) + '     ' + transOSC[b];
      63: sgView.Cells[2, i] := IntToStr(b) + '     (' + IntToStr(b - 7) + ')';
      72: sgView.Cells[2, i] := IntToStr(b) + '     ' + Nr2Note(b);
      73: sgView.Cells[2, i] := IntToStr(b) + '     ' + Nr2Note(b);
      74: sgView.Cells[2, i] := IntToStr(b) + '     ' + Nr2Note(b);
      75: sgView.Cells[2, i] := IntToStr(b) + '     ' + transSCL[b];
      76: sgView.Cells[2, i] := IntToStr(b) + '     ' + transSCL[b];
      81: sgView.Cells[2, i] := IntToStr(b) + '     ' + transOSC[b];
      84: sgView.Cells[2, i] := IntToStr(b) + '     (' + IntToStr(b - 7) + ')';
      93: sgView.Cells[2, i] := IntToStr(b) + '     ' + Nr2Note(b);
      94: sgView.Cells[2, i] := IntToStr(b) + '     ' + Nr2Note(b);
      95: sgView.Cells[2, i] := IntToStr(b) + '     ' + Nr2Note(b);
      96: sgView.Cells[2, i] := IntToStr(b) + '     ' + transSCL[b];
      97: sgView.Cells[2, i] := IntToStr(b) + '     ' + transSCL[b];
      102: sgView.Cells[2, i] := IntToStr(b) + '     ' + transOSC[b];
      105: sgView.Cells[2, i] := IntToStr(b) + '     (' + IntToStr(b - 7) + ')';
      114: sgView.Cells[2, i] := IntToStr(b) + '     ' + Nr2Note(b);
      115: sgView.Cells[2, i] := IntToStr(b) + '     ' + Nr2Note(b);
      116: sgView.Cells[2, i] := IntToStr(b) + '     ' + Nr2Note(b);
      117: sgView.Cells[2, i] := IntToStr(b) + '     ' + transSCL[b];
      118: sgView.Cells[2, i] := IntToStr(b) + '     ' + transSCL[b];
      123: sgView.Cells[2, i] := IntToStr(b) + '     ' + transOSC[b];
      126: sgView.Cells[2, i] := IntToStr(b) + '     (' + IntToStr(b - 7) + ')';
      143: begin
        try
          sgView.Cells[2, i] := IntToStr(b) + '     ' + transLFW[b];
        except
          on e: Exception do sgView.Cells[2, i] := IntToStr(b) + '     Exception';
        end;
      end
      else
        if (i > 145) and (i < 156) then sgView.Cells[2, i] :=
            IntToStr(b) + '     ' + Chr(b)
        else
          sgView.Cells[2, i] := IntToStr(b);
    end;
  end;
end;

end.
