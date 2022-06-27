unit untMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, JPP.Edit, atshapeline, cyPageControl, attabs,
  ECSlider, ECSwitch, ECEditBtns, untFileUtils, untDX7Bank, untDX7Voice, untDX7Utils;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    btSelectDir: TECSpeedBtnPlus;
    edbtSelDir: TECEditBtn;
    edSlot01: TJppEdit;
    edSlot10: TJppEdit;
    edSlot11: TJppEdit;
    edSlot02: TJppEdit;
    edSlot03: TJppEdit;
    edSlot04: TJppEdit;
    edSlot05: TJppEdit;
    edSlot06: TJppEdit;
    edSlot07: TJppEdit;
    edSlot08: TJppEdit;
    edSlot09: TJppEdit;
    edSlot12: TJppEdit;
    edSlot13: TJppEdit;
    edSlot14: TJppEdit;
    edSlot15: TJppEdit;
    edSlot16: TJppEdit;
    edSlot17: TJppEdit;
    edSlot18: TJppEdit;
    edSlot19: TJppEdit;
    edSlot20: TJppEdit;
    edSlot21: TJppEdit;
    edSlot22: TJppEdit;
    edSlot23: TJppEdit;
    edSlot24: TJppEdit;
    edSlot25: TJppEdit;
    edSlot26: TJppEdit;
    edSlot27: TJppEdit;
    edSlot28: TJppEdit;
    edSlot29: TJppEdit;
    edSlot30: TJppEdit;
    edSlot31: TJppEdit;
    edSlot32: TJppEdit;
    imLogo: TImage;
    lbFiles: TListBox;
    mmLog: TMemo;
    pnSlot01: TPanel;
    pnBankEditor: TPanel;
    pnExplorer: TPanel;
    pcMain: TcyPageControl;
    ECSlider1: TECSlider;
    ECSwitch1: TECSwitch;
    lbVoices: TListBox;
    pnSlot10: TPanel;
    pnSlot11: TPanel;
    pnSlot02: TPanel;
    pnSlot03: TPanel;
    pnSlot04: TPanel;
    pnSlot05: TPanel;
    pnSlot06: TPanel;
    pnSlot07: TPanel;
    pnSlot08: TPanel;
    pnSlot09: TPanel;
    pnSlot12: TPanel;
    pnSlot13: TPanel;
    pnSlot14: TPanel;
    pnSlot15: TPanel;
    pnSlot16: TPanel;
    pnSlot17: TPanel;
    pnSlot18: TPanel;
    pnSlot19: TPanel;
    pnSlot20: TPanel;
    pnSlot21: TPanel;
    pnSlot22: TPanel;
    pnSlot23: TPanel;
    pnSlot24: TPanel;
    pnSlot25: TPanel;
    pnSlot26: TPanel;
    pnSlot27: TPanel;
    pnSlot28: TPanel;
    pnSlot29: TPanel;
    pnSlot30: TPanel;
    pnSlot31: TPanel;
    pnSlot32: TPanel;
    pnVoiceManager: TPanel;
    pnFileManager: TPanel;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    sl3: TShapeLine;
    sl4: TShapeLine;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    tsSettings: TTabSheet;
    tsLibrarian: TTabSheet;
    tsPerformanceEdit: TTabSheet;
    procedure btSelectDirClick(Sender: TObject);
    procedure edSlotDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure edSlotDragOver(Sender, Source: TObject; X, Y: integer;
      State: TDragState; var Accept: boolean);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure lbFilesClick(Sender: TObject);
    procedure lbFilesStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure lbVoicesStartDrag(Sender: TObject; var DragObject: TDragObject);

  private

  public

  end;

var
  dragItem: integer;
  FBankDX: TDX7BankContainer;
  FSlotsDX: TDX7BankContainer;
  frmMain: TfrmMain;

implementation

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.btSelectDirClick(Sender: TObject);
var
  sl: TStringList;
begin
  if SelectDirectoryDialog1.Execute then
  begin
    edbtSelDir.Text := SelectDirectoryDialog1.FileName;
    sl := TStringList.Create;
    FindFiles(IncludeTrailingPathDelimiter(SelectDirectoryDialog1.FileName), sl);
    lbFiles.Items.Clear;
    lbFiles.Items.AddStrings(sl);
    sl.Free;
  end;
end;

procedure TfrmMain.edSlotDragDrop(Sender, Source: TObject; X, Y: integer);
var
  dmp: TMemoryStream;
  f: string;
  itm: string;
  i, j: integer;
  tmpVoice: TDX7VoiceContainer;
begin
  if Source = lbFiles then
  begin
    if lbFiles.ItemIndex = -1 then exit;
    itm := lbFiles.Items[dragItem];
    f := IncludeTrailingPathDelimiter(edbtSelDir.Text) + itm;
    if FileExists(f) then
    begin
      dmp := TMemoryStream.Create;
      dmp.LoadFromFile(f);
      i := 0;
      j := 0;
      if ContainsDX7BankDump(dmp, i, j) then
      begin
        FSlotsDX.LoadBankFromStream(dmp, j);
        for i := 0 to 31 do
        begin
          TJppEdit(FindComponent(Format('edSlot%.2d', [i + 1]))).Text :=
            FSlotsDX.GetVoiceName(i + 1);
        end;
      end;
      dmp.Free;
    end;
  end;
  if Source = lbVoices then
  begin
    if (lbVoices.ItemIndex = -1) or (lbFiles.ItemIndex = -1) then Exit;
    itm := lbFiles.Items[lbFiles.ItemIndex];
    f := IncludeTrailingPathDelimiter(edbtSelDir.Text) + itm;
    if FileExists(f) then
    begin
      dmp := TMemoryStream.Create;
      dmp.LoadFromFile(f);
      i := 0;
      j := 0;
      if ContainsDX7BankDump(dmp, i, j) then  //voice is a part of a bank
      begin
        tmpVoice := TDX7VoiceContainer.Create;
        FBankDX.GetVoice(lbVoices.ItemIndex + 1, tmpVoice);
        FSlotsDX.SetVoice((Sender as TJppEdit).Tag + 1, tmpVoice);
        (Sender as TJppEdit).Text := FSlotsDX.GetVoiceName((Sender as TJppEdit).Tag + 1);
        tmpVoice.Free;
      end;
      i := 0;
      if ContainsDX7VoiceDump(dmp, i, j) then  //single voice file
      begin
        tmpVoice := TDX7VoiceContainer.Create;
        tmpVoice.LoadExpandedVoiceFromStream(dmp, j);
        FSlotsDX.SetVoice((Sender as TJppEdit).Tag, tmpVoice);
        (Sender as TJppEdit).Text := FSlotsDX.GetVoiceName((Sender as TJppEdit).Tag + 1);
        tmpVoice.Free;
      end;
      dmp.Free;
    end;
  end;
end;

procedure TfrmMain.edSlotDragOver(Sender, Source: TObject; X, Y: integer;
  State: TDragState; var Accept: boolean);
begin
  if (Sender = lbFiles) and (dragItem <> -1) then Accept := True;
  if (Sender = lbVoices) and (dragItem <> -1) then Accept := True;
end;

procedure TfrmMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FBankDX.Free;
  FSlotsDX.Free;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  i: integer;
begin
  FBankDX := TDX7BankContainer.Create;
  FSlotsDX := TDX7BankContainer.Create;
  for i := 0 to 31 do
  begin
    TJppEdit(FindComponent(Format('edSlot%.2d', [i + 1]))).Text :=
      FSlotsDX.GetVoiceName(i + 1);
  end;
end;

procedure TfrmMain.lbFilesClick(Sender: TObject);
var
  dmp: TMemoryStream;
  i, j: integer;
  v, b: boolean;
  dbg: string;
  Itm: string;
  dxv: TDX7VoiceContainer;
  nr: integer;
begin
  if lbFiles.ItemIndex = -1 then exit;
  Itm := lbFiles.Items[lbFiles.ItemIndex];
  dbg := IncludeTrailingPathDelimiter(edbtSelDir.Text) + Itm;
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
      mmLog.Lines.Add('File ' + Itm +
        ' contains DX7 single voice header at position ' + IntToStr(i));
      dxv := TDX7VoiceContainer.Create;
      dxv.LoadExpandedVoiceFromStream(dmp, j);
      if dxv.GetVoiceName <> '' then lbVoices.Items.Add(dxv.GetVoiceName);
      dxv.Free;
    end
    else
      v := True;
    i := 0; //read from the begining of the stream again
    if ContainsDX7BankDump(dmp, i, j) then
    begin
      lbVoices.Items.Clear;
      mmLog.Lines.Add('File ' + Itm +
        ' contains DX7 voice bank header at position ' + IntToStr(i));
      FBankDX.LoadBankFromStream(dmp, j);
      for nr := 1 to 32 do
        lbVoices.Items.Add(FBankDX.GetVoiceName(nr));
    end
    else
      b := True;
    if b and v then
      mmLog.Lines.Add('File ' + Itm + ' contains no DX7 dumps');
    dmp.Free;
  end;
end;

procedure TfrmMain.lbFilesStartDrag(Sender: TObject; var DragObject: TDragObject);
begin
  if lbFiles.ItemIndex <> -1 then
    dragItem := lbFiles.ItemIndex;
end;

procedure TfrmMain.lbVoicesStartDrag(Sender: TObject; var DragObject: TDragObject);
begin
  if lbVoices.ItemIndex <> -1 then
    dragItem := lbVoices.ItemIndex;
end;

end.
