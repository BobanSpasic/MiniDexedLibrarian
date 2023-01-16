unit untPerfSelDlg;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids;

type

  { TfrmPerfSelDlg }

  TfrmPerfSelDlg = class(TForm)
    sgPerfSel: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure sgPerfSelDblClick(Sender: TObject);
  private

  public

  end;

var
  CurrentRow: integer;
  ID: string;
  PerfName: string;
  frmPerfSelDlg: TfrmPerfSelDlg;

implementation

{$R *.lfm}

{ TfrmPerfSelDlg }

procedure TfrmPerfSelDlg.FormShow(Sender: TObject);
begin
  CurrentRow := -1;
  ID := '';
  PerfName := '';
end;

procedure TfrmPerfSelDlg.sgPerfSelDblClick(Sender: TObject);
begin
  CurrentRow := sgPerfSel.Row;
  if CurrentRow <> 0 then
  begin
    ID := sgPerfSel.Cells[3, CurrentRow];
    PerfName := sgPerfSel.Cells[0, CurrentRow];
    ModalResult := mrOk;
  end;
end;

end.
