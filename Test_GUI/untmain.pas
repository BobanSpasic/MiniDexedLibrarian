unit untMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, StrUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, JPP.Edit, atshapeline, cyPageControl, ECSlider, ECSwitch,
  ECEditBtns, BCComboBox, untFileUtils, untDX7Bank, untDX7Voice,
  untDX7Utils, untMiniINI, MIDI;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    btSelectDir: TECSpeedBtnPlus;
    cbMidiOut: TBCComboBox;
    cbMidiIn: TBCComboBox;
    Label9: TLabel;
    lbHint: TLabel;
    lbMidiIn: TLabel;
    lbMidiOut: TLabel;
    OpenPerformanceDialog1: TOpenDialog;
    edbtSelDir: TECEditBtn;
    cbMidiCh1: TBCComboBox;
    cbMidiCh2: TBCComboBox;
    cbMidiCh3: TBCComboBox;
    cbMidiCh4: TBCComboBox;
    cbMidiCh5: TBCComboBox;
    cbMidiCh6: TBCComboBox;
    cbMidiCh7: TBCComboBox;
    cbMidiCh8: TBCComboBox;
    edPSlot1: TJppEdit;
    edPSlot2: TJppEdit;
    edPSlot3: TJppEdit;
    edPSlot4: TJppEdit;
    edPSlot5: TJppEdit;
    edPSlot6: TJppEdit;
    edPSlot7: TJppEdit;
    edPSlot8: TJppEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    pnHint: TPanel;
    pnPEffects: TPanel;
    pnPSlot1: TPanel;
    pnPSlot2: TPanel;
    pnPSlot3: TPanel;
    pnPSlot4: TPanel;
    pnPSlot5: TPanel;
    pnPSlot6: TPanel;
    pnPSlot7: TPanel;
    pnPSlot8: TPanel;
    pnPVoice1: TPanel;
    pnPVoice2: TPanel;
    pnPVoice3: TPanel;
    pnPVoice4: TPanel;
    pnPVoice5: TPanel;
    pnPVoice6: TPanel;
    pnPVoice7: TPanel;
    pnPVoice8: TPanel;
    SavePerformanceDialog1: TSaveDialog;
    ShapeLine1: TShapeLine;
    ShapeLine2: TShapeLine;
    ShapeLine3: TShapeLine;
    ShapeLine4: TShapeLine;
    ShapeLine5: TShapeLine;
    ShapeLine6: TShapeLine;
    ShapeLine7: TShapeLine;
    ShapeLine8: TShapeLine;
    ShapeLine9: TShapeLine;
    slCutoff1: TECSlider;
    slCutoff2: TECSlider;
    slCutoff3: TECSlider;
    slCutoff4: TECSlider;
    slCutoff5: TECSlider;
    slCutoff6: TECSlider;
    slCutoff7: TECSlider;
    slCutoff8: TECSlider;
    slDetune1: TECSlider;
    slDetune2: TECSlider;
    slDetune3: TECSlider;
    slDetune4: TECSlider;
    slDetune5: TECSlider;
    slDetune6: TECSlider;
    slDetune7: TECSlider;
    slDetune8: TECSlider;
    slHiNote1: TECSlider;
    slHiNote2: TECSlider;
    slHiNote3: TECSlider;
    slHiNote4: TECSlider;
    slHiNote5: TECSlider;
    slHiNote6: TECSlider;
    slHiNote7: TECSlider;
    slHiNote8: TECSlider;
    slLoNote1: TECSlider;
    slLoNote2: TECSlider;
    slLoNote3: TECSlider;
    slLoNote4: TECSlider;
    slLoNote5: TECSlider;
    slLoNote6: TECSlider;
    slLoNote7: TECSlider;
    slLoNote8: TECSlider;
    slPan1: TECSlider;
    slPan2: TECSlider;
    slPan3: TECSlider;
    slPan4: TECSlider;
    slPan5: TECSlider;
    slPan6: TECSlider;
    slPan7: TECSlider;
    slPan8: TECSlider;
    slPitchBendRange1: TECSlider;
    slPitchBendRange2: TECSlider;
    slPitchBendRange3: TECSlider;
    slPitchBendRange4: TECSlider;
    slPitchBendRange5: TECSlider;
    slPitchBendRange6: TECSlider;
    slPitchBendRange7: TECSlider;
    slPitchBendRange8: TECSlider;
    slPitchBendStep1: TECSlider;
    slPitchBendStep2: TECSlider;
    slPitchBendStep3: TECSlider;
    slPitchBendStep4: TECSlider;
    slPitchBendStep5: TECSlider;
    slPitchBendStep6: TECSlider;
    slPitchBendStep7: TECSlider;
    slPitchBendStep8: TECSlider;
    slPortaTime1: TECSlider;
    slPortaTime2: TECSlider;
    slPortaTime3: TECSlider;
    slPortaTime4: TECSlider;
    slPortaTime5: TECSlider;
    slPortaTime6: TECSlider;
    slPortaTime7: TECSlider;
    slPortaTime8: TECSlider;
    slResonance1: TECSlider;
    slReverbHighDamp: TECSlider;
    slReverbDiffusion: TECSlider;
    slReverbLowDamp: TECSlider;
    slResonance2: TECSlider;
    slResonance3: TECSlider;
    slResonance4: TECSlider;
    slResonance5: TECSlider;
    slResonance6: TECSlider;
    slResonance7: TECSlider;
    slResonance8: TECSlider;
    slReverbLevel: TECSlider;
    slReverbSize: TECSlider;
    slReverbSend1: TECSlider;
    slReverbSend2: TECSlider;
    slReverbSend3: TECSlider;
    slReverbSend4: TECSlider;
    slReverbSend5: TECSlider;
    slReverbSend6: TECSlider;
    slReverbSend7: TECSlider;
    slReverbSend8: TECSlider;
    slReverbLowPass: TECSlider;
    slTranspose1: TECSlider;
    slTranspose2: TECSlider;
    slTranspose3: TECSlider;
    slTranspose4: TECSlider;
    slTranspose5: TECSlider;
    slTranspose6: TECSlider;
    slTranspose7: TECSlider;
    slTranspose8: TECSlider;
    slVolume1: TECSlider;
    slVolume2: TECSlider;
    slVolume3: TECSlider;
    slVolume4: TECSlider;
    slVolume5: TECSlider;
    slVolume6: TECSlider;
    slVolume7: TECSlider;
    slVolume8: TECSlider;
    swPortaGlissando1: TECSwitch;
    swPortaGlissando2: TECSwitch;
    swPortaGlissando3: TECSwitch;
    swPortaGlissando4: TECSwitch;
    swPortaGlissando5: TECSwitch;
    swPortaGlissando6: TECSwitch;
    swPortaGlissando7: TECSwitch;
    swPortaGlissando8: TECSwitch;
    edSlot01: TJppEdit;
    edSlot02: TJppEdit;
    edSlot03: TJppEdit;
    edSlot04: TJppEdit;
    edSlot05: TJppEdit;
    edSlot06: TJppEdit;
    edSlot07: TJppEdit;
    edSlot08: TJppEdit;
    edSlot09: TJppEdit;
    edSlot10: TJppEdit;
    edSlot11: TJppEdit;
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
    edPSlot01: TJppEdit;
    edPSlot02: TJppEdit;
    edPSlot03: TJppEdit;
    edPSlot04: TJppEdit;
    edPSlot05: TJppEdit;
    edPSlot06: TJppEdit;
    edPSlot07: TJppEdit;
    edPSlot08: TJppEdit;
    ilToolbarBankPerformance: TImageList;
    lbChecksum: TLabel;
    lbFiles: TListBox;
    mmLog: TMemo;
    pcBankPerformanceSlots: TcyPageControl;
    pnBankPerformanceSlots: TPanel;
    pnExplorer: TPanel;
    pcMain: TcyPageControl;
    lbVoices: TListBox;
    pnSlot01: TPanel;
    pnSlot02: TPanel;
    pnSlot03: TPanel;
    pnSlot04: TPanel;
    pnSlot05: TPanel;
    pnSlot06: TPanel;
    pnSlot07: TPanel;
    pnSlot08: TPanel;
    pnSlot09: TPanel;
    pnSlot10: TPanel;
    pnSlot11: TPanel;
    pnSlot12: TPanel;
    pnSlot13: TPanel;
    pnSlot14: TPanel;
    pnSlot15: TPanel;
    pnSlot16: TPanel;
    pnSlot17: TPanel;
    pnSlot18: TPanel;
    pnSlot19: TPanel;
    pnPSlot01: TPanel;
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
    pnPSlot02: TPanel;
    pnPSlot03: TPanel;
    pnPSlot04: TPanel;
    pnPSlot05: TPanel;
    pnPSlot06: TPanel;
    pnPSlot07: TPanel;
    pnPSlot08: TPanel;
    pnVoiceManager: TPanel;
    pnFileManager: TPanel;
    SaveBankDialog1: TSaveDialog;
    scPVoice: TScrollBox;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    sl3: TShapeLine;
    sl4: TShapeLine;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    swPortaMode1: TECSwitch;
    swPortaMode2: TECSwitch;
    swPortaMode3: TECSwitch;
    swPortaMode4: TECSwitch;
    swPortaMode5: TECSwitch;
    swPortaMode6: TECSwitch;
    swPortaMode7: TECSwitch;
    swPortaMode8: TECSwitch;
    swReverbEnable: TECSwitch;
    swCompressorEnable: TECSwitch;
    tbBank: TToolBar;
    tbbtOpenBank: TToolButton;
    tbbtSave: TToolButton;
    tbbtSavePerformance: TToolButton;
    tbbtLoadPerformance: TToolButton;
    tbPerfEdit: TToolBar;
    tsBankSlots: TTabSheet;
    tsPerformanceSlots: TTabSheet;
    tsSettings: TTabSheet;
    tsLibrarian: TTabSheet;
    tsPerformanceEdit: TTabSheet;
    procedure btSelectDirClick(Sender: TObject);
    procedure edPSlotDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure edPSlotDragOver(Sender, Source: TObject; X, Y: integer;
      State: TDragState; var Accept: boolean);
    procedure edSlotDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure edSlotDragOver(Sender, Source: TObject; X, Y: integer;
      State: TDragState; var Accept: boolean);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbFilesClick(Sender: TObject);
    procedure lbFilesStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure lbVoicesStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure slSliderChange(Sender: TObject);
    procedure slSliderMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure tbbtLoadPerformanceClick(Sender: TObject);
    procedure tbbtSaveClick(Sender: TObject);
    procedure RefreshSlots;
    procedure tbbtSavePerformanceClick(Sender: TObject);

  private

  public

  end;

var
  dragItem: integer;
  FBankDX: TDX7BankContainer;
  FSlotsDX: TDX7BankContainer;
  FPerfSlotsDX: array [1..8] of TDX7VoiceContainer;
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

procedure TfrmMain.edPSlotDragDrop(Sender, Source: TObject; X, Y: integer);
var
  dmp: TMemoryStream;
  f: string;
  itm: string;
  i, j: integer;
  tmpVoice: TDX7VoiceContainer;
begin
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
        FPerfSlotsDX[(Sender as TJppEdit).Tag + 1].SetVoiceParams(
          tmpVoice.GetVoiceParams);
        tmpVoice.Free;
      end;
      i := 0;
      if ContainsDX7VoiceDump(dmp, i, j) then  //single voice file
      begin
        tmpVoice := TDX7VoiceContainer.Create;
        tmpVoice.LoadExpandedVoiceFromStream(dmp, j);
        FPerfSlotsDX[(Sender as TJppEdit).Tag + 1].SetVoiceParams(
          tmpVoice.GetVoiceParams);
        tmpVoice.Free;
      end;
      RefreshSlots;
      dmp.Free;
    end;
  end;
end;

procedure TfrmMain.edPSlotDragOver(Sender, Source: TObject; X, Y: integer;
  State: TDragState; var Accept: boolean);
begin
  if (Sender = lbVoices) and (dragItem <> -1) then Accept := True;
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
        lbChecksum.Caption := 'Checksum: $' + IntToHex(FSlotsDX.GetChecksum, 2);
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
      lbChecksum.Caption := 'Checksum: $' + IntToHex(FSlotsDX.GetChecksum, 2);
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
var
  i: integer;
begin
  FBankDX.Free;
  FSlotsDX.Free;
  for i := 1 to 8 do
    FPerfSlotsDX[i].Free;
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
  for i := 1 to 8 do
  begin
    FPerfSlotsDX[i] := TDX7VoiceContainer.Create;
    FPerfSlotsDX[i].InitVoice;
    TJppEdit(FindComponent(Format('edPSlot%.2d', [i]))).Text :=
      FPerfSlotsDX[i].GetVoiceName;
  end;
  pcMain.ActivePage := tsLibrarian;
  pcBankPerformanceSlots.ActivePage := tsBankSlots;
  RefreshSlots;
  pnHint.BringToFront;
  lbHint.Caption := '';

  //fill MIDI ports to ComboBoxes
  cbMidiIn.Items.Clear;
  for i := 0 to MidiInput.Devices.Count - 1 do
    cbMidiIn.Items.Add(MidiInput.Devices[i]);

  cbMidiOut.Items.Clear;
  for i := 0 to MidiOutput.Devices.Count - 1 do
    cbMidiOut.Items.Add(MidiOutput.Devices[i]);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin

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

procedure TfrmMain.slSliderChange(Sender: TObject);
var
  pt: TPoint;
  ctrl: TControl;
begin
  pt := ScreenToClient(Mouse.CursorPos);
  ctrl := ControlAtPos(pt, [capfRecursive, capfAllowWinControls]);
  if ctrl.Name.Contains('Note') then
    lbHint.Caption := PadLeft(GetNoteName(trunc(TECSlider(Sender).Position)), 4)
  else
  if ctrl.Name.Contains('Pan') then
  begin
    if trunc(TECSlider(Sender).Position) = 64 then lbHint.Caption := ' <C>';
    if trunc(TECSlider(Sender).Position) < 64 then
      lbHint.Caption := Format('L %.2d', [64 - trunc(TECSlider(Sender).Position)]);
    if trunc(TECSlider(Sender).Position) > 64 then
      lbHint.Caption := Format('R %.2d', [trunc(TECSlider(Sender).Position) - 64]);
  end
  else
    lbHint.Caption := PadLeft(Format('%.3d', [trunc(TECSlider(Sender).Position)]), 4);
  if Assigned(ctrl) then
  begin
    pnHint.Parent := ctrl.Parent;
    pnHint.Left := ctrl.Left + ctrl.Width - lbHint.Width;
    pnHint.Top := ctrl.Top + (ctrl.Height div 2) - (lbHint.Height div 2);
    lbHint.Visible := True;
  end;
end;

procedure TfrmMain.slSliderMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  lbHint.Visible := False;
end;

procedure TfrmMain.tbbtLoadPerformanceClick(Sender: TObject);
var
  ini: TMiniINIFile;
  hexstream: TMemoryStream;
  hexstring: string;
begin
  if OpenPerformanceDialog1.Execute then
  begin
    ini := TMiniINIFile.Create;
    ini.LoadFromFile(OpenPerformanceDialog1.FileName);
    hexstream := TMemoryStream.Create;
    if ini.ReadInteger('MIDIChannel1', 1) > 16 then cbMidiCh1.ItemIndex := 17
    else
      cbMidiCh1.ItemIndex := ini.ReadInteger('MIDIChannel1', 1);
    slVolume1.Position := ini.ReadInteger('Volume1', 100);
    slPan1.Position := ini.ReadInteger('Pan1', 0);
    slDetune1.Position := ini.ReadInteger('Detune1', 0);
    slCutoff1.Position := ini.ReadInteger('Cutoff1', 99);
    slResonance1.Position := ini.ReadInteger('Resonance1', 0);
    slLoNote1.Position := ini.ReadInteger('NoteLimitLow1', 0);
    slHiNote1.Position := ini.ReadInteger('NoteLimitHigh1', 127);
    slTranspose1.Position := ini.ReadInteger('NoteShift1', 0);
    slReverbSend1.Position := ini.ReadInteger('ReverbSend1', 0);
    slPitchBendRange1.Position := ini.ReadInteger('PitchBendRange1', 2);
    slPitchBendStep1.Position := ini.ReadInteger('PitchBendStep1', 0);
    swPortaMode1.Checked := ini.ReadInteger('PortamentoMode1', 0) = 1;
    swPortaGlissando1.Checked := ini.ReadInteger('PortamentoGlissando1', 0) = 1;
    slPortaTime1.Position := ini.ReadInteger('PortamentoTime1', 0);
    hexstring := ini.ReadString('VoiceData1', '');
    if hexstring <> '' then
    begin
      hexstream.Position := 0;
      ExpandedHexToStream(hexstring, hexstream);
      FPerfSlotsDX[1].LoadExpandedVoiceFromStream(hexstream, 0);
    end
    else
      FPerfSlotsDX[1].InitVoice;

    if ini.ReadInteger('MIDIChannel2', 1) > 16 then cbMidiCh2.ItemIndex := 17
    else
      cbMidiCh2.ItemIndex := ini.ReadInteger('MIDIChannel2', 1);
    slVolume2.Position := ini.ReadInteger('Volume2', 100);
    slPan2.Position := ini.ReadInteger('Pan2', 0);
    slDetune2.Position := ini.ReadInteger('Detune2', 0);
    slCutoff2.Position := ini.ReadInteger('Cutoff2', 99);
    slResonance2.Position := ini.ReadInteger('Resonance2', 0);
    slLoNote2.Position := ini.ReadInteger('NoteLimitLow2', 0);
    slHiNote2.Position := ini.ReadInteger('NoteLimitHigh2', 127);
    slTranspose2.Position := ini.ReadInteger('NoteShift2', 0);
    slReverbSend2.Position := ini.ReadInteger('ReverbSend2', 0);
    slPitchBendRange2.Position := ini.ReadInteger('PitchBendRange2', 2);
    slPitchBendStep2.Position := ini.ReadInteger('PitchBendStep2', 0);
    swPortaMode2.Checked := ini.ReadInteger('PortamentoMode2', 0) = 1;
    swPortaGlissando2.Checked := ini.ReadInteger('PortamentoGlissando2', 0) = 1;
    slPortaTime2.Position := ini.ReadInteger('PortamentoTime2', 0);
    hexstring := ini.ReadString('VoiceData2', '');
    if hexstring <> '' then
    begin
      hexstream.Position := 0;
      ExpandedHexToStream(hexstring, hexstream);
      FPerfSlotsDX[2].LoadExpandedVoiceFromStream(hexstream, 0);
    end
    else
      FPerfSlotsDX[2].InitVoice;

    if ini.ReadInteger('MIDIChannel3', 1) > 16 then cbMidiCh3.ItemIndex := 17
    else
      cbMidiCh3.ItemIndex := ini.ReadInteger('MIDIChannel3', 1);
    slVolume3.Position := ini.ReadInteger('Volume3', 100);
    slPan3.Position := ini.ReadInteger('Pan3', 0);
    slDetune3.Position := ini.ReadInteger('Detune3', 0);
    slCutoff3.Position := ini.ReadInteger('Cutoff3', 99);
    slResonance3.Position := ini.ReadInteger('Resonance3', 0);
    slLoNote3.Position := ini.ReadInteger('NoteLimitLow3', 0);
    slHiNote3.Position := ini.ReadInteger('NoteLimitHigh3', 127);
    slTranspose3.Position := ini.ReadInteger('NoteShift3', 0);
    slReverbSend3.Position := ini.ReadInteger('ReverbSend3', 0);
    slPitchBendRange3.Position := ini.ReadInteger('PitchBendRange3', 2);
    slPitchBendStep3.Position := ini.ReadInteger('PitchBendStep3', 0);
    swPortaMode3.Checked := ini.ReadInteger('PortamentoMode3', 0) = 1;
    swPortaGlissando3.Checked := ini.ReadInteger('PortamentoGlissando3', 0) = 1;
    slPortaTime3.Position := ini.ReadInteger('PortamentoTime3', 0);
    hexstring := ini.ReadString('VoiceData3', '');
    if hexstring <> '' then
    begin
      hexstream.Position := 0;
      ExpandedHexToStream(hexstring, hexstream);
      FPerfSlotsDX[3].LoadExpandedVoiceFromStream(hexstream, 0);
    end
    else
      FPerfSlotsDX[3].InitVoice;

    if ini.ReadInteger('MIDIChannel4', 1) > 16 then cbMidiCh4.ItemIndex := 17
    else
      cbMidiCh4.ItemIndex := ini.ReadInteger('MIDIChannel4', 1);
    slVolume4.Position := ini.ReadInteger('Volume4', 100);
    slPan4.Position := ini.ReadInteger('Pan4', 0);
    slDetune4.Position := ini.ReadInteger('Detune4', 0);
    slCutoff4.Position := ini.ReadInteger('Cutoff4', 99);
    slResonance4.Position := ini.ReadInteger('Resonance4', 0);
    slLoNote4.Position := ini.ReadInteger('NoteLimitLow4', 0);
    slHiNote4.Position := ini.ReadInteger('NoteLimitHigh4', 127);
    slTranspose4.Position := ini.ReadInteger('NoteShift4', 0);
    slReverbSend4.Position := ini.ReadInteger('ReverbSend4', 0);
    slPitchBendRange4.Position := ini.ReadInteger('PitchBendRange4', 2);
    slPitchBendStep4.Position := ini.ReadInteger('PitchBendStep4', 0);
    swPortaMode4.Checked := ini.ReadInteger('PortamentoMode4', 0) = 1;
    swPortaGlissando4.Checked := ini.ReadInteger('PortamentoGlissando4', 0) = 1;
    slPortaTime4.Position := ini.ReadInteger('PortamentoTime4', 0);
    hexstring := ini.ReadString('VoiceData4', '');
    if hexstring <> '' then
    begin
      hexstream.Position := 0;
      ExpandedHexToStream(hexstring, hexstream);
      FPerfSlotsDX[4].LoadExpandedVoiceFromStream(hexstream, 0);
    end
    else
      FPerfSlotsDX[4].InitVoice;

    if ini.ReadInteger('MIDIChannel5', 1) > 16 then cbMidiCh5.ItemIndex := 17
    else
      cbMidiCh5.ItemIndex := ini.ReadInteger('MIDIChannel5', 1);
    slVolume5.Position := ini.ReadInteger('Volume5', 100);
    slPan5.Position := ini.ReadInteger('Pan5', 0);
    slDetune5.Position := ini.ReadInteger('Detune5', 0);
    slCutoff5.Position := ini.ReadInteger('Cutoff5', 99);
    slResonance5.Position := ini.ReadInteger('Resonance5', 0);
    slLoNote5.Position := ini.ReadInteger('NoteLimitLow5', 0);
    slHiNote5.Position := ini.ReadInteger('NoteLimitHigh5', 127);
    slTranspose5.Position := ini.ReadInteger('NoteShift5', 0);
    slReverbSend5.Position := ini.ReadInteger('ReverbSend5', 0);
    slPitchBendRange5.Position := ini.ReadInteger('PitchBendRange5', 2);
    slPitchBendStep5.Position := ini.ReadInteger('PitchBendStep5', 0);
    swPortaMode5.Checked := ini.ReadInteger('PortamentoMode5', 0) = 1;
    swPortaGlissando5.Checked := ini.ReadInteger('PortamentoGlissando5', 0) = 1;
    slPortaTime5.Position := ini.ReadInteger('PortamentoTime5', 0);
    hexstring := ini.ReadString('VoiceData5', '');
    if hexstring <> '' then
    begin
      hexstream.Position := 0;
      ExpandedHexToStream(hexstring, hexstream);
      FPerfSlotsDX[5].LoadExpandedVoiceFromStream(hexstream, 0);
    end
    else
      FPerfSlotsDX[5].InitVoice;

    if ini.ReadInteger('MIDIChannel6', 1) > 16 then cbMidiCh6.ItemIndex := 17
    else
      cbMidiCh6.ItemIndex := ini.ReadInteger('MIDIChannel6', 1);
    slVolume6.Position := ini.ReadInteger('Volume6', 100);
    slPan6.Position := ini.ReadInteger('Pan6', 0);
    slDetune6.Position := ini.ReadInteger('Detune6', 0);
    slCutoff6.Position := ini.ReadInteger('Cutoff6', 99);
    slResonance6.Position := ini.ReadInteger('Resonance6', 0);
    slLoNote6.Position := ini.ReadInteger('NoteLimitLow6', 0);
    slHiNote6.Position := ini.ReadInteger('NoteLimitHigh6', 127);
    slTranspose6.Position := ini.ReadInteger('NoteShift6', 0);
    slReverbSend6.Position := ini.ReadInteger('ReverbSend6', 0);
    slPitchBendRange6.Position := ini.ReadInteger('PitchBendRange6', 2);
    slPitchBendStep6.Position := ini.ReadInteger('PitchBendStep6', 0);
    swPortaMode6.Checked := ini.ReadInteger('PortamentoMode6', 0) = 1;
    swPortaGlissando6.Checked := ini.ReadInteger('PortamentoGlissando6', 0) = 1;
    slPortaTime6.Position := ini.ReadInteger('PortamentoTime6', 0);
    hexstring := ini.ReadString('VoiceData6', '');
    if hexstring <> '' then
    begin
      hexstream.Position := 0;
      ExpandedHexToStream(hexstring, hexstream);
      FPerfSlotsDX[6].LoadExpandedVoiceFromStream(hexstream, 0);
    end
    else
      FPerfSlotsDX[6].InitVoice;

    if ini.ReadInteger('MIDIChannel7', 1) > 16 then cbMidiCh7.ItemIndex := 17
    else
      cbMidiCh7.ItemIndex := ini.ReadInteger('MIDIChannel7', 1);
    slVolume7.Position := ini.ReadInteger('Volume7', 100);
    slPan7.Position := ini.ReadInteger('Pan7', 0);
    slDetune7.Position := ini.ReadInteger('Detune7', 0);
    slCutoff7.Position := ini.ReadInteger('Cutoff7', 99);
    slResonance7.Position := ini.ReadInteger('Resonance7', 0);
    slLoNote7.Position := ini.ReadInteger('NoteLimitLow7', 0);
    slHiNote7.Position := ini.ReadInteger('NoteLimitHigh7', 127);
    slTranspose7.Position := ini.ReadInteger('NoteShift7', 0);
    slReverbSend7.Position := ini.ReadInteger('ReverbSend7', 0);
    slPitchBendRange7.Position := ini.ReadInteger('PitchBendRange7', 2);
    slPitchBendStep7.Position := ini.ReadInteger('PitchBendStep7', 0);
    swPortaMode7.Checked := ini.ReadInteger('PortamentoMode7', 0) = 1;
    swPortaGlissando7.Checked := ini.ReadInteger('PortamentoGlissando7', 0) = 1;
    slPortaTime7.Position := ini.ReadInteger('PortamentoTime7', 0);
    hexstring := ini.ReadString('VoiceData7', '');
    if hexstring <> '' then
    begin
      hexstream.Position := 0;
      ExpandedHexToStream(hexstring, hexstream);
      FPerfSlotsDX[7].LoadExpandedVoiceFromStream(hexstream, 0);
    end
    else
      FPerfSlotsDX[7].InitVoice;

    if ini.ReadInteger('MIDIChannel8', 1) > 16 then cbMidiCh8.ItemIndex := 17
    else
      cbMidiCh8.ItemIndex := ini.ReadInteger('MIDIChannel8', 1);
    slVolume8.Position := ini.ReadInteger('Volume8', 100);
    slPan8.Position := ini.ReadInteger('Pan8', 0);
    slDetune8.Position := ini.ReadInteger('Detune8', 0);
    slCutoff8.Position := ini.ReadInteger('Cutoff8', 99);
    slResonance8.Position := ini.ReadInteger('Resonance8', 0);
    slLoNote8.Position := ini.ReadInteger('NoteLimitLow8', 0);
    slHiNote8.Position := ini.ReadInteger('NoteLimitHigh8', 127);
    slTranspose8.Position := ini.ReadInteger('NoteShift8', 0);
    slReverbSend8.Position := ini.ReadInteger('ReverbSend8', 0);
    slPitchBendRange8.Position := ini.ReadInteger('PitchBendRange8', 2);
    slPitchBendStep8.Position := ini.ReadInteger('PitchBendStep8', 0);
    swPortaMode8.Checked := ini.ReadInteger('PortamentoMode8', 0) = 1;
    swPortaGlissando8.Checked := ini.ReadInteger('PortamentoGlissando8', 0) = 1;
    slPortaTime8.Position := ini.ReadInteger('PortamentoTime8', 0);
    hexstring := ini.ReadString('VoiceData8', '');
    if hexstring <> '' then
    begin
      ExpandedHexToStream(hexstring, hexstream);
      FPerfSlotsDX[8].LoadExpandedVoiceFromStream(hexstream, 0);
    end
    else
      FPerfSlotsDX[8].InitVoice;

    swCompressorEnable.Checked := ini.ReadInteger('CompressorEnable', 1) = 1;
    swReverbEnable.Checked := ini.ReadInteger('ReverbEnable', 1) = 1;
    slReverbSize.Position := ini.ReadInteger('ReverbSize', 70);
    slReverbHighDamp.Position := ini.ReadInteger('ReverbHighDamp', 50);
    slReverbLowDamp.Position := ini.ReadInteger('ReverbLowDamp', 50);
    slReverbLowPass.Position := ini.ReadInteger('ReverbLowPass', 30);
    slReverbDiffusion.Position := ini.ReadInteger('ReverbDiffusion', 65);
    slReverbLevel.Position := ini.ReadInteger('ReverbLevel', 80);

    RefreshSlots;
    hexstream.Free;
    ini.Init;
    ini.Free;
  end;
end;

procedure TfrmMain.tbbtSaveClick(Sender: TObject);
begin
  if SaveBankDialog1.Execute then
    FSlotsDX.SaveBankToSysExFile(SaveBankDialog1.FileName);
end;

procedure TfrmMain.RefreshSlots;
var
  i: integer;
begin
  edpSlot1.Text := FPerfSlotsDX[1].GetVoiceName;
  edpSlot2.Text := FPerfSlotsDX[2].GetVoiceName;
  edpSlot3.Text := FPerfSlotsDX[3].GetVoiceName;
  edpSlot4.Text := FPerfSlotsDX[4].GetVoiceName;
  edpSlot5.Text := FPerfSlotsDX[5].GetVoiceName;
  edpSlot6.Text := FPerfSlotsDX[6].GetVoiceName;
  edpSlot7.Text := FPerfSlotsDX[7].GetVoiceName;
  edpSlot8.Text := FPerfSlotsDX[8].GetVoiceName;
  edpSlot01.Text := FPerfSlotsDX[1].GetVoiceName;
  edpSlot02.Text := FPerfSlotsDX[2].GetVoiceName;
  edpSlot03.Text := FPerfSlotsDX[3].GetVoiceName;
  edpSlot04.Text := FPerfSlotsDX[4].GetVoiceName;
  edpSlot05.Text := FPerfSlotsDX[5].GetVoiceName;
  edpSlot06.Text := FPerfSlotsDX[6].GetVoiceName;
  edpSlot07.Text := FPerfSlotsDX[7].GetVoiceName;
  edpSlot08.Text := FPerfSlotsDX[8].GetVoiceName;
  for i := 1 to 32 do
  begin
    TJppEdit(FindComponent(Format('edSlot%.2d', [i]))).Text :=
      FSlotsDX.GetVoiceName(i);
  end;
end;

procedure TfrmMain.tbbtSavePerformanceClick(Sender: TObject);
var
  ini: TMiniINIFile;
  hexstream: TMemoryStream;
  hexstring: string;
begin
  if SavePerformanceDialog1.Execute then
  begin
    ini := TMiniINIFile.Create;
    ini.Init;
    //ini.LoadFromFile(OpenPerformanceDialog1.FileName);
    hexstream := TMemoryStream.Create;

    ini.WriteInteger('MIDIChannel1', cbMidiCh1.ItemIndex);
    ini.WriteInteger('Volume1', trunc(slVolume1.Position));
    ini.WriteInteger('Pan1', trunc(slPan1.Position));
    ini.WriteInteger('Detune1', trunc(slDetune1.Position));
    ini.WriteInteger('Cutoff1', trunc(slCutoff1.Position));
    ini.WriteInteger('Resonance1', trunc(slResonance1.Position));
    ini.WriteInteger('NoteLimitLow1', trunc(slLoNote1.Position));
    ini.WriteInteger('NoteLimitHigh1', trunc(slHiNote1.Position));
    ini.WriteInteger('NoteShift1', trunc(slTranspose1.Position));
    ini.WriteInteger('ReverbSend1', trunc(slReverbSend1.Position));
    ini.WriteInteger('PitchBendRange1', trunc(slPitchBendRange1.Position));
    ini.WriteInteger('PitchBendStep1', trunc(slPitchBendStep1.Position));
    ini.WriteInteger('PortamentoMode1', byte(swPortaMode1.Checked));
    ini.WriteInteger('PortamentoGlissando1', byte(swPortaGlissando1.Checked));
    ini.WriteInteger('PortamentoTime1', trunc(slPortaTime1.Position));
    FPerfSlotsDX[1].SaveExpandedVoiceToStream(hexstream);
    hexstring := StreamToExpandedHex(hexstream);
    ini.WriteString('VoiceData1', hexstring);

    ini.WriteInteger('MIDIChannel2', cbMidiCh2.ItemIndex);
    ini.WriteInteger('Volume2', trunc(slVolume2.Position));
    ini.WriteInteger('Pan2', trunc(slPan2.Position));
    ini.WriteInteger('Detune2', trunc(slDetune2.Position));
    ini.WriteInteger('Cutoff2', trunc(slCutoff2.Position));
    ini.WriteInteger('Resonance2', trunc(slResonance2.Position));
    ini.WriteInteger('NoteLimitLow2', trunc(slLoNote2.Position));
    ini.WriteInteger('NoteLimitHigh2', trunc(slHiNote2.Position));
    ini.WriteInteger('NoteShift2', trunc(slTranspose2.Position));
    ini.WriteInteger('ReverbSend2', trunc(slReverbSend2.Position));
    ini.WriteInteger('PitchBendRange2', trunc(slPitchBendRange2.Position));
    ini.WriteInteger('PitchBendStep2', trunc(slPitchBendStep2.Position));
    ini.WriteInteger('PortamentoMode2', byte(swPortaMode2.Checked));
    ini.WriteInteger('PortamentoGlissando2', byte(swPortaGlissando2.Checked));
    ini.WriteInteger('PortamentoTime2', trunc(slPortaTime2.Position));
    FPerfSlotsDX[2].SaveExpandedVoiceToStream(hexstream);
    hexstring := StreamToExpandedHex(hexstream);
    ini.WriteString('VoiceData2', hexstring);

    ini.WriteInteger('MIDIChannel3', cbMidiCh3.ItemIndex);
    ini.WriteInteger('Volume3', trunc(slVolume3.Position));
    ini.WriteInteger('Pan3', trunc(slPan3.Position));
    ini.WriteInteger('Detune3', trunc(slDetune3.Position));
    ini.WriteInteger('Cutoff3', trunc(slCutoff3.Position));
    ini.WriteInteger('Resonance3', trunc(slResonance3.Position));
    ini.WriteInteger('NoteLimitLow3', trunc(slLoNote3.Position));
    ini.WriteInteger('NoteLimitHigh3', trunc(slHiNote3.Position));
    ini.WriteInteger('NoteShift3', trunc(slTranspose3.Position));
    ini.WriteInteger('ReverbSend3', trunc(slReverbSend3.Position));
    ini.WriteInteger('PitchBendRange3', trunc(slPitchBendRange3.Position));
    ini.WriteInteger('PitchBendStep3', trunc(slPitchBendStep3.Position));
    ini.WriteInteger('PortamentoMode3', byte(swPortaMode3.Checked));
    ini.WriteInteger('PortamentoGlissando3', byte(swPortaGlissando3.Checked));
    ini.WriteInteger('PortamentoTime3', trunc(slPortaTime3.Position));
    FPerfSlotsDX[3].SaveExpandedVoiceToStream(hexstream);
    hexstring := StreamToExpandedHex(hexstream);
    ini.WriteString('VoiceData3', hexstring);

    ini.WriteInteger('MIDIChannel4', cbMidiCh4.ItemIndex);
    ini.WriteInteger('Volume4', trunc(slVolume4.Position));
    ini.WriteInteger('Pan4', trunc(slPan4.Position));
    ini.WriteInteger('Detune4', trunc(slDetune4.Position));
    ini.WriteInteger('Cutoff4', trunc(slCutoff4.Position));
    ini.WriteInteger('Resonance4', trunc(slResonance4.Position));
    ini.WriteInteger('NoteLimitLow4', trunc(slLoNote4.Position));
    ini.WriteInteger('NoteLimitHigh4', trunc(slHiNote4.Position));
    ini.WriteInteger('NoteShift4', trunc(slTranspose4.Position));
    ini.WriteInteger('ReverbSend4', trunc(slReverbSend4.Position));
    ini.WriteInteger('PitchBendRange4', trunc(slPitchBendRange4.Position));
    ini.WriteInteger('PitchBendStep4', trunc(slPitchBendStep4.Position));
    ini.WriteInteger('PortamentoMode4', byte(swPortaMode4.Checked));
    ini.WriteInteger('PortamentoGlissando4',
      byte(swPortaGlissando4.Checked));
    ini.WriteInteger('PortamentoTime4', trunc(slPortaTime4.Position));
    FPerfSlotsDX[4].SaveExpandedVoiceToStream(hexstream);
    hexstring := StreamToExpandedHex(hexstream);
    ini.WriteString('VoiceData4', hexstring);

    ini.WriteInteger('MIDIChannel5', cbMidiCh5.ItemIndex);
    ini.WriteInteger('Volume5', trunc(slVolume5.Position));
    ini.WriteInteger('Pan5', trunc(slPan5.Position));
    ini.WriteInteger('Detune5', trunc(slDetune5.Position));
    ini.WriteInteger('Cutoff5', trunc(slCutoff5.Position));
    ini.WriteInteger('Resonance5', trunc(slResonance5.Position));
    ini.WriteInteger('NoteLimitLow5', trunc(slLoNote5.Position));
    ini.WriteInteger('NoteLimitHigh5', trunc(slHiNote5.Position));
    ini.WriteInteger('NoteShift5', trunc(slTranspose5.Position));
    ini.WriteInteger('ReverbSend5', trunc(slReverbSend5.Position));
    ini.WriteInteger('PitchBendRange5',
      trunc(slPitchBendRange5.Position));
    ini.WriteInteger('PitchBendStep5', trunc(slPitchBendStep5.Position));
    ini.WriteInteger('PortamentoMode5', byte(swPortaMode5.Checked));
    ini.WriteInteger('PortamentoGlissando5',
      byte(swPortaGlissando5.Checked));
    ini.WriteInteger('PortamentoTime5', trunc(slPortaTime5.Position));
    FPerfSlotsDX[5].SaveExpandedVoiceToStream(hexstream);
    hexstring := StreamToExpandedHex(hexstream);
    ini.WriteString('VoiceData5', hexstring);

    ini.WriteInteger('MIDIChannel6', cbMidiCh6.ItemIndex);
    ini.WriteInteger('Volume6', trunc(slVolume6.Position));
    ini.WriteInteger('Pan6', trunc(slPan6.Position));
    ini.WriteInteger('Detune6', trunc(slDetune6.Position));
    ini.WriteInteger('Cutoff6', trunc(slCutoff6.Position));
    ini.WriteInteger('Resonance6', trunc(slResonance6.Position));
    ini.WriteInteger('NoteLimitLow6', trunc(slLoNote6.Position));
    ini.WriteInteger('NoteLimitHigh6', trunc(slHiNote6.Position));
    ini.WriteInteger('NoteShift6', trunc(slTranspose6.Position));
    ini.WriteInteger('ReverbSend6', trunc(slReverbSend6.Position));
    ini.WriteInteger('PitchBendRange6',
      trunc(slPitchBendRange6.Position));
    ini.WriteInteger('PitchBendStep6',
      trunc(slPitchBendStep6.Position));
    ini.WriteInteger('PortamentoMode6', byte(swPortaMode6.Checked));
    ini.WriteInteger('PortamentoGlissando6',
      byte(swPortaGlissando6.Checked));
    ini.WriteInteger('PortamentoTime6',
      trunc(slPortaTime6.Position));
    FPerfSlotsDX[6].SaveExpandedVoiceToStream(hexstream);
    hexstring := StreamToExpandedHex(hexstream);
    ini.WriteString('VoiceData6', hexstring);

    ini.WriteInteger('MIDIChannel7', cbMidiCh7.ItemIndex);
    ini.WriteInteger('Volume7', trunc(slVolume7.Position));
    ini.WriteInteger('Pan7', trunc(slPan7.Position));
    ini.WriteInteger('Detune7', trunc(slDetune7.Position));
    ini.WriteInteger('Cutoff7', trunc(slCutoff7.Position));
    ini.WriteInteger('Resonance7', trunc(slResonance7.Position));
    ini.WriteInteger('NoteLimitLow7', trunc(slLoNote7.Position));
    ini.WriteInteger('NoteLimitHigh7', trunc(slHiNote7.Position));
    ini.WriteInteger('NoteShift7', trunc(slTranspose7.Position));
    ini.WriteInteger('ReverbSend7', trunc(slReverbSend7.Position));
    ini.WriteInteger('PitchBendRange7', trunc(slPitchBendRange7.Position));
    ini.WriteInteger('PitchBendStep7', trunc(slPitchBendStep7.Position));
    ini.WriteInteger('PortamentoMode7', byte(swPortaMode7.Checked));
    ini.WriteInteger('PortamentoGlissando7', byte(swPortaGlissando7.Checked));
    ini.WriteInteger('PortamentoTime7', trunc(slPortaTime7.Position));
    FPerfSlotsDX[7].SaveExpandedVoiceToStream(hexstream);
    hexstring := StreamToExpandedHex(hexstream);
    ini.WriteString('VoiceData7', hexstring);

    ini.WriteInteger('MIDIChannel8', cbMidiCh8.ItemIndex);
    ini.WriteInteger('Volume8', trunc(slVolume8.Position));
    ini.WriteInteger('Pan8', trunc(slPan8.Position));
    ini.WriteInteger('Detune8', trunc(slDetune8.Position));
    ini.WriteInteger('Cutoff8', trunc(slCutoff8.Position));
    ini.WriteInteger('Resonance8', trunc(slResonance8.Position));
    ini.WriteInteger('NoteLimitLow8', trunc(slLoNote8.Position));
    ini.WriteInteger('NoteLimitHigh8', trunc(slHiNote8.Position));
    ini.WriteInteger('NoteShift8', trunc(slTranspose8.Position));
    ini.WriteInteger('ReverbSend8', trunc(slReverbSend8.Position));
    ini.WriteInteger('PitchBendRange8', trunc(slPitchBendRange8.Position));
    ini.WriteInteger('PitchBendStep8', trunc(slPitchBendStep8.Position));
    ini.WriteInteger('PortamentoMode8', byte(swPortaMode8.Checked));
    ini.WriteInteger('PortamentoGlissando8', byte(swPortaGlissando8.Checked));
    ini.WriteInteger('PortamentoTime8', trunc(slPortaTime8.Position));
    FPerfSlotsDX[8].SaveExpandedVoiceToStream(hexstream);
    hexstring := StreamToExpandedHex(hexstream);
    ini.WriteString('VoiceData8', hexstring);

    ini.WriteInteger('CompressorEnable', byte(swCompressorEnable.Checked));
    ini.WriteInteger('ReverbEnable', byte(swReverbEnable.Checked));
    ini.WriteInteger('ReverbSize', Trunc(slReverbSize.Position));
    ini.WriteInteger('ReverbHighDamp', Trunc(slReverbHighDamp.Position));
    ini.WriteInteger('ReverbLowDamp', Trunc(slReverbLowDamp.Position));
    ini.WriteInteger('ReverbLowPass', Trunc(slReverbLowPass.Position));
    ini.WriteInteger('ReverbDiffusion', Trunc(slReverbDiffusion.Position));
    ini.WriteInteger('ReverbLevel', Trunc(slReverbLevel.Position));

    ini.SaveToFile(SavePerformanceDialog1.FileName);
    ini.Free;
    hexstream.Free;
  end;
end;

end.
