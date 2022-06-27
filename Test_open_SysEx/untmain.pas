unit untMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  ShellCtrls, untDX7Bank, untDX7Voice, untDX7Utils, ComCtrls;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    mnuLoad: TMenuItem;
    mnuMain: TMainMenu;
    mmLog: TMemo;
    mnuFile: TMenuItem;
    OpenDialog1: TOpenDialog;
    ShellListView1: TShellListView;
    ShellTreeView1: TShellTreeView;
    procedure mnuLoadClick(Sender: TObject);
    procedure ShellListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: boolean);
    procedure ShellTreeView1Click(Sender: TObject);
  private

  public

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.mnuLoadClick(Sender: TObject);
var
  dmp: TMemoryStream;
  i, j: integer;
  v, b: boolean;
begin
  if OpenDialog1.Execute then
  begin
    dmp := TMemoryStream.Create;
    dmp.LoadFromFile(OpenDialog1.FileName);
    mmLog.Lines.Clear;
    i := 0;
    j := 0;
    v := False;
    b := False;
    if ContainsDX7VoiceDump(dmp, i, j) then
    begin
      mmLog.Lines.Add('File ' + OpenDialog1.FileName +
        ' contains DX7 single voice header at position ' + IntToStr(i));
    end
    else
      v := True;
    i := 0;
    if ContainsDX7BankDump(dmp, i, j) then
    begin
      mmLog.Lines.Add('File ' + OpenDialog1.FileName +
        ' contains DX7 bank voice header at position ' + IntToStr(i));
    end
    else
      b := True;
    if b and v then
      mmLog.Lines.Add('File ' + OpenDialog1.FileName + ' contains no DX7 dumps');
    dmp.Free;
  end;
end;

procedure TfrmMain.ShellListView1SelectItem(Sender: TObject; Item: TListItem;
  Selected: boolean);
var
  dmp: TMemoryStream;
  i, j: integer;
  v, b: boolean;
  dbg: string;
  Itm: TListItem;
  dx: TDX7BankContainer;
  dxv : TDX7VoiceContainer;
  nr: integer;
begin

  Itm := TShellListView(Sender).Selected;
  if Assigned(Itm) then
  begin
    dbg := IncludeTrailingPathDelimiter(TShellListView(Sender).Root) + Itm.Caption;
    if dbg = '' then exit;
    if FileExists(dbg) then
    begin
      dmp := TMemoryStream.Create;
      dmp.LoadFromFile(dbg);
      mmLog.Lines.Clear;
      i := 0;
      j := 0;
      v := False;
      b := False;
      ContainsDXData(dmp, i, mmLog.Lines);
      if ContainsDX7VoiceDump(dmp, i, j) then
      begin
        mmLog.Lines.Add('File ' + Itm.Caption +
          ' contains DX7 single voice header at position ' + IntToStr(i));
        dxv := TDX7VoiceContainer.Create;
        dxv.LoadExpandedVoiceFromStream(dmp, j);
        mmLog.Lines.Add('Voice:  ' + dxv.GetVoiceName);
        dxv.Free;
      end
      else
        v := True;
      i := 0;
      if ContainsDX7BankDump(dmp, i, j) then
      begin
        mmLog.Lines.Add('File ' + Itm.Caption +
          ' contains DX7 voice bank header at position ' + IntToStr(i));
        dx := TDX7BankContainer.Create;
        dx.LoadBankFromStream(dmp, j);
        for nr := 1 to 32 do
          mmLog.Lines.Add('Voice ' + IntToStr(nr) + ':  ' + dx.GetVoiceName(nr));
        dx.Free;
      end
      else
        b := True;
      if b and v then
        mmLog.Lines.Add('File ' + Itm.Caption + ' contains no DX7 dumps');
      dmp.Free;
    end;
  end;
end;

procedure TfrmMain.ShellTreeView1Click(Sender: TObject);
begin
end;

end.
