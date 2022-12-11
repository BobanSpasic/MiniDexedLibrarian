{
 *****************************************************************************
  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************

 Author: Boban Spasic

}

unit untMain;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  {$IFDEF WINDOWS}
  Messages,
  {$ENDIF}
  SysUtils, StrUtils, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Grids, Spin, DBGrids, atshapeline,
  ECSlider, ECSwitch, ECEditBtns, untUtils, untDX7Bank, untDX7Voice,
  untDX7IISupplement, untDX7IISupplBank,
  untDXUtils, untMiniINI, Types, SQLite3Conn, SQLDB, SQLite3DS, DB,
  untPopUp, LCLIntf, LazFileUtils
  {$IFDEF WINDOWS}
  ,MIDI, untUnPortMIDI
  {$ENDIF}
  {$IFDEF LINUX}
  ,untLinuxMIDI, PortMidi
  {$ENDIF}  ;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    btSelectDir: TECSpeedBtnPlus;
    btSelSDCard: TECSpeedBtnPlus;
    btCatLoad: TButton;
    btCatSave: TButton;
    btDeleteVoiceDB: TButton;
    btDeleteCategoryDB: TButton;
    btSDCardRenameVoices: TButton;
    btSDCardRenamePerformances: TButton;
    cbBtnActionBack: TComboBox;
    cbBtnActionHome: TComboBox;
    cbBtnActionNext: TComboBox;
    cbBtnActionPrev: TComboBox;
    cbBtnActionSelect: TComboBox;
    cbBtnBack: TComboBox;
    cbBtnHome: TComboBox;
    cbBtnNext: TComboBox;
    cbBtnPrev: TComboBox;
    cbBtnSelect: TComboBox;
    cbBtnShortcut: TComboBox;
    cbDisplayPinD4: TComboBox;
    cbDisplayPinD5: TComboBox;
    cbDisplayPinD6: TComboBox;
    cbDisplayPinD7: TComboBox;
    cbDisplayPinEN: TComboBox;
    cbDisplayPinRS: TComboBox;
    cbDisplayPinRW: TComboBox;
    cbDisplayResolution: TComboBox;
    cbEncoderClockPin: TComboBox;
    cbEncoderDataPin: TComboBox;
    cbLibMIDIChannel: TComboBox;
    cbMidiCh1: TComboBox;
    cbMidiCh2: TComboBox;
    cbMidiCh3: TComboBox;
    cbMidiCh4: TComboBox;
    cbMidiCh5: TComboBox;
    cbMidiCh6: TComboBox;
    cbMidiCh7: TComboBox;
    cbMidiCh8: TComboBox;
    cbMidiIn: TComboBox;
    cbMidiOut: TComboBox;
    cbMIDIThruFrom: TComboBox;
    cbMIDIThruTo: TComboBox;
    cbVoicesCategory: TComboBox;
    cbSoundDevChunkSize: TComboBox;
    cbSoundDevSampleRate: TComboBox;
    cbPerfCategory: TComboBox;
    edBtnDblClickTOut: TLabeledEdit;
    edBtnLngPressTOut: TLabeledEdit;
    edbtSelSDCard: TECEditBtn;
    edbtSelSysExDir: TECEditBtn;
    edDisplayi2sAddr: TLabeledEdit;
    edDisplayi2sCols: TLabeledEdit;
    edDisplayi2sRows: TLabeledEdit;
    edPerfOrigin: TEdit;
    edPerfName: TEdit;
    edMIDIBaudRate: TLabeledEdit;
    edVoicesOrigin: TEdit;
    edPSlot01: TLabeledEdit;
    edPSlot02: TLabeledEdit;
    edPSlot03: TLabeledEdit;
    edPSlot04: TLabeledEdit;
    edPSlot05: TLabeledEdit;
    edPSlot06: TLabeledEdit;
    edPSlot07: TLabeledEdit;
    edPSlot08: TLabeledEdit;
    edPSlot1: TLabeledEdit;
    edPSlot2: TLabeledEdit;
    edPSlot3: TLabeledEdit;
    edPSlot4: TLabeledEdit;
    edPSlot5: TLabeledEdit;
    edPSlot6: TLabeledEdit;
    edPSlot7: TLabeledEdit;
    edPSlot8: TLabeledEdit;
    edSlot01: TLabeledEdit;
    edSlot02: TLabeledEdit;
    edSlot03: TLabeledEdit;
    edSlot04: TLabeledEdit;
    edSlot05: TLabeledEdit;
    edSlot06: TLabeledEdit;
    edSlot07: TLabeledEdit;
    edSlot08: TLabeledEdit;
    edSlot09: TLabeledEdit;
    edSlot10: TLabeledEdit;
    edSlot11: TLabeledEdit;
    edSlot12: TLabeledEdit;
    edSlot13: TLabeledEdit;
    edSlot14: TLabeledEdit;
    edSlot15: TLabeledEdit;
    edSlot16: TLabeledEdit;
    edSlot17: TLabeledEdit;
    edSlot18: TLabeledEdit;
    edSlot19: TLabeledEdit;
    edSlot20: TLabeledEdit;
    edSlot21: TLabeledEdit;
    edSlot22: TLabeledEdit;
    edSlot23: TLabeledEdit;
    edSlot24: TLabeledEdit;
    edSlot25: TLabeledEdit;
    edSlot26: TLabeledEdit;
    edSlot27: TLabeledEdit;
    edSlot28: TLabeledEdit;
    edSlot29: TLabeledEdit;
    edSlot30: TLabeledEdit;
    edSlot31: TLabeledEdit;
    edSlot32: TLabeledEdit;
    edSoundDevi2sAddr: TLabeledEdit;
    edSoundDevOther: TLabeledEdit;
    Label1: TLabel;
    Label10: TLabel;
    lbVoicesDBOptions: TLabel;
    lbVoicesCategory: TLabel;
    lbPerfOrigin: TLabel;
    lbPerfName: TLabel;
    lbFontSize: TLabel;
    lbPerfCategory: TLabel;
    lbVoicesOrigin: TLabel;
    lbPerfSelToLoad: TLabel;
    lbDbgProfile: TLabel;
    lbDbgMIDIDump: TLabel;
    lbSoundDevSwapCh: TLabel;
    lbMIDIAcceptProgCh: TLabel;
    lbMIDIThruEnable: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lbBtnBack: TLabel;
    lbBtnHome: TLabel;
    lbBtnNext: TLabel;
    lbBtnPrev: TLabel;
    lbBtnSelect: TLabel;
    lbBtnShortcut: TLabel;
    lbBtnTimeouts: TLabel;
    lbButtons: TLabel;
    lbComments: TLabel;
    lbDbgOptions: TLabel;
    lbDisplay: TLabel;
    lbDisplayPinD4: TLabel;
    lbDisplayPinD5: TLabel;
    lbDisplayPinD6: TLabel;
    lbDisplayPinD7: TLabel;
    lbDisplayPinEN: TLabel;
    lbDisplayPinRS: TLabel;
    lbDisplayPinRW: TLabel;
    lbDIsplayResolution: TLabel;
    lbEncoderClockPin: TLabel;
    lbEncoderDataPin: TLabel;
    lbFiles: TListBox;
    lbGPIOPins: TLabel;
    lbMIDIDevice: TLabel;
    lbMidiIn: TLabel;
    lbMidiOut: TLabel;
    lbMIDIThruFrom: TLabel;
    lbMIDIThruTo: TLabel;
    lbPerfOptions: TLabel;
    lbRotaryEncoder: TLabel;
    lbSoundDev: TLabel;
    lbSoundDevChunkSize: TLabel;
    lbSoundDevSampleRate: TLabel;
    lbVoices: TListBox;
    mmINIComments: TMemo;
    mmLog: TMemo;
    mmLogSettings: TMemo;
    OpenMiniDexedINI: TOpenDialog;
    lbHint: TLabel;
    OpenPerformanceDialog1: TOpenDialog;
    pcFilesDatabase: TPageControl;
    pcBankPerformanceSlots: TPageControl;
    pcMain: TPageControl;
    pcMiniDexedFiles: TPageControl;
    pcTGs: TPageControl;
    pnBankPerformanceSlots: TPanel;
    pnButtons: TPanel;
    pnComments: TPanel;
    pnDebug: TPanel;
    pnDisplay: TPanel;
    pnEncoder: TPanel;
    pnExplorer: TPanel;
    pnFileManager: TPanel;
    pnHint: TPanel;
    pnMIDIDevice: TPanel;
    pnMiniDexedFiles: TPanel;
    pnPEffects: TPanel;
    pnPerfOptions: TPanel;
    pnPSlot01: TPanel;
    pnPSlot02: TPanel;
    pnPSlot03: TPanel;
    pnPSlot04: TPanel;
    pnPSlot05: TPanel;
    pnPSlot06: TPanel;
    pnPSlot07: TPanel;
    pnPSlot08: TPanel;
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
    pnSelSDCard: TPanel;
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
    pnSoundDevice: TPanel;
    pnVoiceManager: TPanel;
    rbDisplayDiscrete: TRadioButton;
    rbDisplayi2cHD44780: TRadioButton;
    rbDisplayi2cSSD1306: TRadioButton;
    rbDisplayNone: TRadioButton;
    rbEncoderDiscrete: TRadioButton;
    rbEncoderNone: TRadioButton;
    rbSoundDevHDMI: TRadioButton;
    rbSoundDevi2s: TRadioButton;
    rbSoundDevOther: TRadioButton;
    rbSoundDevPWM: TRadioButton;
    SaveMiniDexedINI: TSaveDialog;
    SavePerformanceDialog1: TSaveDialog;
    SelectSDCardDirectoryDialog1: TSelectDirectoryDialog;
    ilToolbarBankPerformance: TImageList;
    SaveBankDialog1: TSaveDialog;
    SelectSysExDirectoryDialog1: TSelectDirectoryDialog;
    sgCategories: TStringGrid;
    sgGPIO: TStringGrid;
    sgSDPerfFiles: TStringGrid;
    ShapeLine1: TShapeLine;
    ShapeLine2: TShapeLine;
    ShapeLine3: TShapeLine;
    ShapeLine4: TShapeLine;
    ShapeLine5: TShapeLine;
    ShapeLine6: TShapeLine;
    ShapeLine7: TShapeLine;
    ShapeLine8: TShapeLine;
    ShapeLine9: TShapeLine;
    sl3: TShapeLine;
    sl4: TShapeLine;
    slAfterTouchRange1: TECSlider;
    slAfterTouchRange2: TECSlider;
    slAfterTouchRange3: TECSlider;
    slAfterTouchRange4: TECSlider;
    slAfterTouchRange5: TECSlider;
    slAfterTouchRange6: TECSlider;
    slAfterTouchRange7: TECSlider;
    slAfterTouchRange8: TECSlider;
    slBreathCtrlRange1: TECSlider;
    slBreathCtrlRange2: TECSlider;
    slBreathCtrlRange3: TECSlider;
    slBreathCtrlRange4: TECSlider;
    slBreathCtrlRange5: TECSlider;
    slBreathCtrlRange6: TECSlider;
    slBreathCtrlRange7: TECSlider;
    slBreathCtrlRange8: TECSlider;
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
    slFootCtrlRange1: TECSlider;
    slFootCtrlRange2: TECSlider;
    slFootCtrlRange3: TECSlider;
    slFootCtrlRange4: TECSlider;
    slFootCtrlRange5: TECSlider;
    slFootCtrlRange6: TECSlider;
    slFootCtrlRange7: TECSlider;
    slFootCtrlRange8: TECSlider;
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
    slModWhRange1: TECSlider;
    slModWhRange2: TECSlider;
    slModWhRange3: TECSlider;
    slModWhRange4: TECSlider;
    slModWhRange5: TECSlider;
    slModWhRange6: TECSlider;
    slModWhRange7: TECSlider;
    slModWhRange8: TECSlider;
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
    slResonance2: TECSlider;
    slResonance3: TECSlider;
    slResonance4: TECSlider;
    slResonance5: TECSlider;
    slResonance6: TECSlider;
    slResonance7: TECSlider;
    slResonance8: TECSlider;
    slReverbDiffusion: TECSlider;
    slReverbHighDamp: TECSlider;
    slReverbLevel: TECSlider;
    slReverbLowDamp: TECSlider;
    slReverbLowPass: TECSlider;
    slReverbSend1: TECSlider;
    slReverbSend2: TECSlider;
    slReverbSend3: TECSlider;
    slReverbSend4: TECSlider;
    slReverbSend5: TECSlider;
    slReverbSend6: TECSlider;
    slReverbSend7: TECSlider;
    slReverbSend8: TECSlider;
    slReverbSize: TECSlider;
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
    seFontSize: TSpinEdit;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    SQLite3Con: TSQLite3Connection;
    SQLQuery: TSQLQuery;
    SQLTrans: TSQLTransaction;
    sgSDSysExFiles: TStringGrid;
    sgDB: TStringGrid;
    swAfterTouchA1: TECSwitch;
    swAfterTouchA2: TECSwitch;
    swAfterTouchA3: TECSwitch;
    swAfterTouchA4: TECSwitch;
    swAfterTouchA5: TECSwitch;
    swAfterTouchA6: TECSwitch;
    swAfterTouchA7: TECSwitch;
    swAfterTouchA8: TECSwitch;
    swAfterTouchEG1: TECSwitch;
    swAfterTouchEG2: TECSwitch;
    swAfterTouchEG3: TECSwitch;
    swAfterTouchEG4: TECSwitch;
    swAfterTouchEG5: TECSwitch;
    swAfterTouchEG6: TECSwitch;
    swAfterTouchEG7: TECSwitch;
    swAfterTouchEG8: TECSwitch;
    swAfterTouchP1: TECSwitch;
    swAfterTouchP2: TECSwitch;
    swAfterTouchP3: TECSwitch;
    swAfterTouchP4: TECSwitch;
    swAfterTouchP5: TECSwitch;
    swAfterTouchP6: TECSwitch;
    swAfterTouchP7: TECSwitch;
    swAfterTouchP8: TECSwitch;
    swBreathA1: TECSwitch;
    swBreathA2: TECSwitch;
    swBreathA3: TECSwitch;
    swBreathA4: TECSwitch;
    swBreathA5: TECSwitch;
    swBreathA6: TECSwitch;
    swBreathA7: TECSwitch;
    swBreathA8: TECSwitch;
    swBreathEG1: TECSwitch;
    swBreathEG2: TECSwitch;
    swBreathEG3: TECSwitch;
    swBreathEG4: TECSwitch;
    swBreathEG5: TECSwitch;
    swBreathEG6: TECSwitch;
    swBreathEG7: TECSwitch;
    swBreathEG8: TECSwitch;
    swBreathP1: TECSwitch;
    swBreathP2: TECSwitch;
    swBreathP3: TECSwitch;
    swBreathP4: TECSwitch;
    swBreathP5: TECSwitch;
    swBreathP6: TECSwitch;
    swBreathP7: TECSwitch;
    swBreathP8: TECSwitch;
    swCompressorEnable: TECSwitch;
    swDbgMIDIDump: TECSwitch;
    swDbgProfile: TECSwitch;
    swFootA1: TECSwitch;
    swFootA2: TECSwitch;
    swFootA3: TECSwitch;
    swFootA4: TECSwitch;
    swFootA5: TECSwitch;
    swFootA6: TECSwitch;
    swFootA7: TECSwitch;
    swFootA8: TECSwitch;
    swFootEG1: TECSwitch;
    swFootEG2: TECSwitch;
    swFootEG3: TECSwitch;
    swFootEG4: TECSwitch;
    swFootEG5: TECSwitch;
    swFootEG6: TECSwitch;
    swFootEG7: TECSwitch;
    swFootEG8: TECSwitch;
    swFootP1: TECSwitch;
    swFootP2: TECSwitch;
    swFootP3: TECSwitch;
    swFootP4: TECSwitch;
    swFootP5: TECSwitch;
    swFootP6: TECSwitch;
    swFootP7: TECSwitch;
    swFootP8: TECSwitch;
    swMIDIProgChange: TECSwitch;
    swMIDIThruEnable: TECSwitch;
    swModA1: TECSwitch;
    swModA2: TECSwitch;
    swModA3: TECSwitch;
    swModA4: TECSwitch;
    swModA5: TECSwitch;
    swModA6: TECSwitch;
    swModA7: TECSwitch;
    swModA8: TECSwitch;
    swModEG1: TECSwitch;
    swModEG2: TECSwitch;
    swModEG3: TECSwitch;
    swModEG4: TECSwitch;
    swModEG5: TECSwitch;
    swModEG6: TECSwitch;
    swModEG7: TECSwitch;
    swModEG8: TECSwitch;
    swModP1: TECSwitch;
    swModP2: TECSwitch;
    swModP3: TECSwitch;
    swModP4: TECSwitch;
    swModP5: TECSwitch;
    swModP6: TECSwitch;
    swModP7: TECSwitch;
    swModP8: TECSwitch;
    swMonoMode1: TECSwitch;
    swMonoMode2: TECSwitch;
    swMonoMode3: TECSwitch;
    swMonoMode4: TECSwitch;
    swMonoMode5: TECSwitch;
    swMonoMode6: TECSwitch;
    swMonoMode7: TECSwitch;
    swMonoMode8: TECSwitch;
    swPerfSelToLoad: TECSwitch;
    swPortaGlissando1: TECSwitch;
    swPortaGlissando2: TECSwitch;
    swPortaGlissando3: TECSwitch;
    swPortaGlissando4: TECSwitch;
    swPortaGlissando5: TECSwitch;
    swPortaGlissando6: TECSwitch;
    swPortaGlissando7: TECSwitch;
    swPortaGlissando8: TECSwitch;
    swPortaMode1: TECSwitch;
    swPortaMode2: TECSwitch;
    swPortaMode3: TECSwitch;
    swPortaMode4: TECSwitch;
    swPortaMode5: TECSwitch;
    swPortaMode6: TECSwitch;
    swPortaMode7: TECSwitch;
    swPortaMode8: TECSwitch;
    swReverbEnable: TECSwitch;
    swSoundDevSwapCh: TECSwitch;
    tbDatabase: TToolBar;
    tbbtRefresh: TToolButton;
    tbbtCommit: TToolButton;
    tbSeparator2: TToolButton;
    tbSeparator3: TToolButton;
    tbExtractPerfVoicesToDB: TToolButton;
    tsFiles: TTabSheet;
    tsDatabase: TTabSheet;
    tbBank: TToolBar;
    tbbtLoadPerformance: TToolButton;
    tbbtOpenBank: TToolButton;
    tbbtOpenINIFiles: TToolButton;
    tbbtSaveBank: TToolButton;
    tbbtSaveINIFiles: TToolButton;
    tbbtSavePerformance: TToolButton;
    tbbtSendVoiceDump: TToolButton;
    tbINIFiles: TToolBar;
    tbPerfEdit: TToolBar;
    tbSeparator1: TToolButton;
    tbStoreToDB: TToolButton;
    tsBankSlots: TTabSheet;
    tsIniFiles: TTabSheet;
    tsLibrarian: TTabSheet;
    tsPerformance: TTabSheet;
    tsPerformanceSlots: TTabSheet;
    tsSDCard: TTabSheet;
    tsSettings: TTabSheet;
    tsSyxFiles: TTabSheet;
    tsTG1_4: TTabSheet;
    tsTG5_8: TTabSheet;
    procedure btCatLoadClick(Sender: TObject);
    procedure btCatSaveClick(Sender: TObject);
    procedure btDeleteCategoryDBClick(Sender: TObject);
    procedure btDeleteVoiceDBClick(Sender: TObject);
    procedure btSDCardRenamePerformancesClick(Sender: TObject);
    procedure btSDCardRenameVoicesClick(Sender: TObject);
    procedure btSelectDirClick(Sender: TObject);
    procedure cbDisplayEncoderChange(Sender: TObject);
    procedure cbDisplayResolutionChange(Sender: TObject);
    procedure cbMidiInChange(Sender: TObject);
    procedure cbMidiOutChange(Sender: TObject);
    procedure btSelSDCardClick(Sender: TObject);
    procedure edPSlotDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure edPSlotDragOver(Sender, Source: TObject; X, Y: integer;
      State: TDragState; var Accept: boolean);
    procedure edSlotDblClick(Sender: TObject);
    procedure edSlotDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure edSlotDragOver(Sender, Source: TObject; X, Y: integer;
      State: TDragState; var Accept: boolean);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure lbFilesClick(Sender: TObject);
    procedure lbFilesStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure lbVoicesStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure rbDisplayDiscreteChange(Sender: TObject);
    procedure rbDisplayi2cHD44780Change(Sender: TObject);
    procedure rbDisplayi2cSSD1306Change(Sender: TObject);
    procedure rbEncoderDiscreteChange(Sender: TObject);
    procedure rbSoundDevHDMIChange(Sender: TObject);
    procedure rbSoundDevi2sChange(Sender: TObject);
    procedure rbSoundDevOtherChange(Sender: TObject);
    procedure rbSoundDevPWMChange(Sender: TObject);
    procedure seFontSizeChange(Sender: TObject);
    procedure sgCategoriesDrawCell(Sender: TObject; aCol, aRow: integer;
      aRect: TRect; aState: TGridDrawState);
    procedure sgDBAfterSelection(Sender: TObject; aCol, aRow: integer);
    procedure sgDBBeforeSelection(Sender: TObject; aCol, aRow: integer);
    procedure sgDBDragOver(Sender, Source: TObject; X, Y: integer;
      State: TDragState; var Accept: boolean);
    procedure sgDBEditingDone(Sender: TObject);
    procedure sgDBStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure sgGPIODrawCell(Sender: TObject; aCol, aRow: integer;
      aRect: TRect; aState: TGridDrawState);
    procedure sgSDPerfFilesDblClick(Sender: TObject);
    procedure sgSDPerfFilesDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure sgSDPerfFilesDragOver(Sender, Source: TObject; X, Y: integer;
      State: TDragState; var Accept: boolean);
    procedure sgSDPerfFilesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure sgSDSysExFilesDblClick(Sender: TObject);
    procedure sgSDSysExFilesDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure sgSDSysExFilesDragOver(Sender, Source: TObject;
      X, Y: integer; State: TDragState; var Accept: boolean);
    procedure sgSDSysExFilesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure sgSDSysExFilesValidateEntry(Sender: TObject; aCol, aRow: integer;
      const OldValue: string; var NewValue: string);
    procedure slSliderChange(Sender: TObject);
    procedure slSliderMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure swMIDIThruEnableChange(Sender: TObject);
    procedure tbbtCommitClick(Sender: TObject);
    procedure tbbtLoadPerformanceClick(Sender: TObject);
    procedure tbbtOpenINIFilesClick(Sender: TObject);
    procedure tbbtRefreshClick(Sender: TObject);
    procedure tbbtSaveBankClick(Sender: TObject);
    procedure RefreshSlots;
    procedure tbbtSaveINIFilesClick(Sender: TObject);
    procedure tbbtSavePerformanceClick(Sender: TObject);
    procedure CalculateGPIO;
    procedure tbbtSendVoiceDumpClick(Sender: TObject);
    procedure SendSingleVoice(aCh, aVoiceNr: integer);
    procedure LoadLastStateBank;
    procedure FillFilesList(aFolder: string);
    procedure OpenSysEx(aName: string);
    procedure OpenPerformance(aName: string);
    procedure SQLCreateTables;
    procedure SQLAddVoice(aID, aName, aCategory, aData, aSupplement, aOrigin: string);
    procedure SQLGetVoice(aID: string; var sl: TMemoryStream);
    procedure SQLLoadCategories;
    procedure SQLSaveCategories;
    procedure tbExtractPerfVoicesToDBClick(Sender: TObject);
    procedure tbStoreToDBClick(Sender: TObject);
    procedure LoadSDCard(dir: string);
    procedure myDBGridRefresh;
    procedure myDBGridCommit(aID, aName, aCategory, aOrigin: string);
    procedure UpdateCategoryLists;
    procedure SQLiteVacuum;
    procedure SQLCleanTable(ATable: string);

  private
    {$IFDEF WINDOWS}
    procedure MIDIdataIn(var msg: TMessage); message WM_MIDIDATA_ARRIVED;
    {$ENDIF}
  public
    procedure OnMidiInData(const aDeviceIndex: integer;
      const aStatus, aData1, aData2: byte);
    procedure OnSysExData(const aDeviceIndex: integer; const aStream: TMemoryStream);
  end;

var
  dragItem:  integer;
  sgSyxDragItem: integer;
  sgPerfDragItem: integer;
  FBankDX:   TDX7BankContainer;
  FSupplBankDXII: TDX7IISupplBankContainer;
  FSlotsDX:  TDX7BankContainer;
  FSlotsSupplDX7II: TDX7IISupplBankContainer;
  FPerfSlotsDX: array [1..8] of TDX7VoiceContainer;
  FPerfSlotsSupplDX7II: array [1..8] of TDX7IISupplementContainer;
  FMidiIn:   string;
  FMidiInInt: integer;
  FMidiOut:  string;
  FMidiOutInt: integer;
  FMidiIsActive: boolean;
  frmMain:   TfrmMain;
  LastSysExOpenDir: string;
  LastSysExSaveDir: string;
  LastSysEx: string;
  LastPerfOpenDir: string;
  LastPerfSaveDir: string;
  LastPerf:  string;
  LastSDCardDir: string;
  FUpdatingForm: boolean;
  HD44780Addr: string;
  SSD1306Addr: string;
  DBName:    string;
  HomeDir:   string;
  AppDir:    string;
  SDCardSysExFiles: TStringList;
  SDCardPerfFiles: TStringList;
  compArray: array [0..3] of string;
  compList:  TStringList;
  lastSelectedRow: integer;

implementation

{$R *.lfm}

{$IFDEF WINDOWS}
//uses JWAwindows;
{$ENDIF}

{ TfrmMain }

procedure TfrmMain.SQLCreateTables;
begin
  if SQLite3Con.Connected then
  begin
    SQLQuery.Close;
    SQLQuery.SQL.Text :=
      'CREATE TABLE IF NOT EXISTS CATEGORY (NAME VARCHAR(32) UNIQUE NOT NULL, COMMENT VARCHAR(256));';
    SQLQuery.ExecSQL;
    SQLTrans.Commit;
    SQLQuery.Close;
    SQLQuery.SQL.Text :=
      'CREATE TABLE IF NOT EXISTS VOICES (ID VARCHAR(256) UNIQUE NOT NULL, NAME VARCHAR(32) NOT NULL, CATEGORY VARCHAR(32) NOT NULL, DATA VARCHAR(500) NOT NULL, SUPPLEMENT VARCHAR(500), ORIGIN VARCHAR(256));';
    SQLQuery.ExecSQL;
    SQLTrans.Commit;
  end
  else
    ShowMessage('No database file assigned');
end;

procedure TfrmMain.SQLGetVoice(aID: string; var sl: TMemoryStream);
var
  Data: string;
begin
  Data := '';
  if SQLite3Con.Connected then
  begin
    SQLQuery.Close;
    SQLQuery.SQL.Text :=
      'SELECT * FROM VOICES WHERE ID = :AID';
    SQLQuery.Params.ParamByName('AID').AsString := aID;
    SQLTrans.StartTransaction;
    SQLQuery.Open;
    while not SQLQuery.EOF do
    begin
      if SQLQuery.FieldCount > 0 then
      begin
        Data := SQLQuery.Fields[3].AsString;
        Break;
      end;
      SQLQuery.Next;
    end;
    mmLog.Lines.Add(Data);
    StrToSysExStream(Data, sl);
    SQLQuery.Close;
    SQLTrans.Commit;
  end;
end;

procedure TfrmMain.UpdateCategoryLists;
var
  sl: TStringList;
begin
  if SQLite3Con.Connected then
  begin
    sl := TStringList.Create;
    SQLQuery.Close;
    SQLQuery.SQL.Text := 'SELECT * FROM CATEGORY';
    SQLTrans.StartTransaction;
    SQLQuery.Open;
    while not SQLQuery.EOF do
    begin
      sl.Add(SQLQuery.Fields[0].AsString);
      SQLQuery.Next;
    end;
    SQLQuery.Close;
    SQLTrans.Commit;
    sgDB.Columns[1].PickList := sl;
    cbPerfCategory.Items := sl;
    if cbPerfCategory.Items.Count > 0 then cbPerfCategory.ItemIndex := 0;
    cbVoicesCategory.Items := sl;
    if cbVoicesCategory.Items.Count > 0 then cbVoicesCategory.ItemIndex := 0;
    sl.Free;
  end;
end;

procedure TfrmMain.tbExtractPerfVoicesToDBClick(Sender: TObject);
var
  voiceStream: TMemoryStream;
  i: integer;
begin
  for i := 1 to 8 do
  begin
    try
      voiceStream := TMemoryStream.Create;
      FPerfSlotsDX[i].Save_VCED_ToStream(voiceStream);
      SQLAddVoice(FPerfSlotsDX[i].CalculateHash, FPerfSlotsDX[i].GetVoiceName,
        cbPerfCategory.Text, SysExStreamToStr(voiceStream), '', edPerfOrigin.Text);
    finally
      voiceStream.Free;
    end;
  end;
end;

procedure TfrmMain.SQLiteVacuum;
var
  tmpDataset: TSqlite3Dataset;
  wasConnected: boolean;
begin
  wasConnected := SQLite3Con.Connected;

  SQLite3Con.Close;
  repeat
  until not SQLite3Con.Connected;

  tmpDataset := TSqlite3Dataset.Create(nil);
  tmpDataset.FileName := SQLite3Con.DatabaseName;
  tmpDataset.ExecSQL('VACUUM;');
  tmpDataset.Free;

  SQLite3Con.Connected := wasConnected;
end;

procedure TfrmMain.SQLCleanTable(ATable: string);
begin
  if SQLite3Con.Connected then
  begin
    SQLQuery.Close;
    SQLQuery.SQL.Text := 'DELETE FROM ' + ATable;
    SQLQuery.ExecSQL;
    SQLTrans.Commit;
  end
  else
    ShowMessage('No database file assigned');
end;

procedure TfrmMain.SQLAddVoice(aID, aName, aCategory, aData, aSupplement,
  aOrigin: string);
var
  aExists: boolean;
  aExName: string;
begin
  aExists := False;
  if SQLite3Con.Connected then
  begin
    SQLQuery.Close;
    aExName := '';
    SQLQuery.SQL.Text :=
      'SELECT * FROM VOICES WHERE ID = :AID';
    SQLQuery.Params.ParamByName('AID').AsString := aID;
    SQLTrans.StartTransaction;
    SQLQuery.Open;
    while not SQLQuery.EOF do
    begin
      if SQLQuery.FieldCount > 0 then
      begin
        aExName := SQLQuery.Fields[1].AsString;
        aExists := True;
        Break;
      end;
      SQLQuery.Next;
    end;
    SQLQuery.Close;
    SQLTrans.Commit;

    if aExists and (MessageDlg('Duplicate', aName + ' is a duplicate of ' +
      aExName + #13#10 + 'Overwrite?', mtConfirmation, mbYesNo, 0) = mrNo) then
      Exit
    else
    begin
      SQLQuery.SQL.Text :=
        'INSERT OR REPLACE INTO VOICES (ID, NAME, CATEGORY, DATA, SUPPLEMENT, ORIGIN) VALUES (:AID, :AName, :ACategory, :AData, :ASupplement, :AOrigin);';
      SQLQuery.Params.ParamByName('AID').AsString := aID;
      SQLQuery.Params.ParamByName('AName').AsString := aName;
      SQLQuery.Params.ParamByName('ACategory').AsString := aCategory;
      SQLQuery.Params.ParamByName('AData').AsString := aData;
      SQLQuery.Params.ParamByName('ASupplement').AsString := aSupplement;
      SQLQuery.Params.ParamByName('AOrigin').AsString := aOrigin;
      SQLQuery.ExecSQL;
      SQLTrans.Commit;
    end;
  end
  else
    ShowMessage('No database file assigned');
end;

procedure TfrmMain.tbStoreToDBClick(Sender: TObject);
var
  voiceStream: TMemoryStream;
  tmpVoice: TDX7VoiceContainer;
  supplStream: TMemoryStream;
  tmpSuppl: TDX7IISupplementContainer;
  i: integer;
begin
  for i := 1 to 32 do
  begin
    try
      voiceStream := TMemoryStream.Create;
      tmpVoice := TDX7VoiceContainer.Create;
      supplStream := TMemoryStream.Create;
      tmpSuppl := TDX7IISupplementContainer.Create;

      FSlotsDX.GetVoice(i, tmpVoice);
      tmpVoice.Save_VCED_ToStream(voiceStream);
      FSlotsSupplDX7II.GetSupplement(i, tmpSuppl);
      tmpSuppl.Save_ACED_ToStream(supplStream);

      SQLAddVoice(tmpVoice.CalculateHash, tmpVoice.GetVoiceName,
        cbVoicesCategory.Text, SysExStreamToStr(voiceStream),
        SysExStreamToStr(supplStream), edVoicesOrigin.Text);

    finally
      voiceStream.Free;
      tmpVoice.Free;
      supplStream.Free;
      tmpSuppl.Free;
    end;
  end;
end;

procedure TfrmMain.myDBGridRefresh;
var
  sl: TStringList;
  i: integer;
begin
  sgDB.RowCount := 1;
  if SQLite3Con.Connected then
  begin
    sgDB.BeginUpdate;
    sl := TStringList.Create;
    sl.Delimiter := ';';
    SQLQuery.SQL.Text := 'SELECT * FROM voices';
    SQLTrans.StartTransaction;
    SQLQuery.Open;
    while not SQLQuery.EOF do
    begin
      sl.Add('"' + SQLQuery.Fields[1].AsString + '";"' +
        SQLQuery.Fields[2].AsString + '";"' + SQLQuery.Fields[5].AsString +
        '";"' + SQLQuery.Fields[0].AsString + '"');
      SQLQuery.Next;
    end;
    SQLQuery.Close;
    SQLTrans.Commit;
    sgDB.RowCount := sl.Count + 1;
    for i := 0 to sl.Count - 1 do
    begin
      sgDB.Rows[i + 1].Delimiter := ';';
      sgDB.Rows[i + 1].QuoteChar := '"';
      sgDB.Rows[i + 1].StrictDelimiter := True;
      sgDB.Rows[i + 1].DelimitedText := sl[i];
    end;
    sl.Free;
    sgDB.EndUpdate(True);
    UpdateCategoryLists;
  end
  else
    ShowMessage('No database file assigned');
end;

procedure TfrmMain.myDBGridCommit(aID, aName, aCategory, aOrigin: string);
var
  aSupplement: string;
  aData: string;
  aExists: boolean;
begin
  aData := '';
  aSupplement := '';
  if SQLite3Con.Connected then
  begin
    aExists := False;
    SQLQuery.Close;
    SQLQuery.SQL.Text :=
      'SELECT * FROM VOICES WHERE ID = :AID';
    SQLQuery.Params.ParamByName('AID').AsString := aID;
    SQLTrans.StartTransaction;
    SQLQuery.Open;
    while not SQLQuery.EOF do
    begin
      if SQLQuery.FieldCount > 0 then
      begin
        aData := SQLQuery.Fields[3].AsString;
        aSupplement := SQLQuery.Fields[4].AsString;
        aExists := True;
        Break;
      end;
      SQLQuery.Next;
    end;
    SQLQuery.Close;
    SQLTrans.Commit;
    if aExists then
    begin
      SQLQuery.SQL.Text :=
        'INSERT OR REPLACE INTO VOICES (ID, NAME, CATEGORY, DATA, SUPPLEMENT, ORIGIN) VALUES (:AID, :AName, :ACategory, :AData, :ASupplement, :AOrigin);';
      SQLQuery.Params.ParamByName('AID').AsString := aID;
      SQLQuery.Params.ParamByName('AName').AsString := aName;
      SQLQuery.Params.ParamByName('ACategory').AsString := aCategory;
      SQLQuery.Params.ParamByName('AData').AsString := aData;
      SQLQuery.Params.ParamByName('ASupplement').AsString := aSupplement;
      SQLQuery.Params.ParamByName('AOrigin').AsString := aOrigin;
      SQLQuery.ExecSQL;
      SQLTrans.Commit;
    end;
  end
  else
    ShowMessage('No database file assigned');
end;

procedure TfrmMain.OnMidiInData(const aDeviceIndex: integer;
  const aStatus, aData1, aData2: byte);
begin
  //do not call GUI elements from a callback function, use Messages

  // skip active sensing signals from keyboard
  if aStatus = $FE then Exit;  //skip active sensing
  if aStatus = $F8 then Exit;  //skip real-time clock
  {$IFDEF WINDOWS}
  PostMessage(Application.MainForm.Handle,
    WM_MIDIDATA_ARRIVED,
    aDeviceIndex,
    aStatus + (aData1 and $ff) shl 8 + (aData2 and $FF) shl 16);
  {$ENDIF}
end;

{$IFDEF WINDOWS}
procedure TfrmMain.MIDIdataIn(var msg: TMessage);
begin
  // simply display the values:
  if (Msg.lParamlo <> $F8)     // IGNORE real-time message clock $F8 = 248
    and (Msg.lParamlo <> $FE)  // IGNORE "Active Sensing" $FE = 254
  then
  begin
      {
      Memo1.Append( IntToStr( Msg.wParamhi) +' '
                       +IntToStr( Msg.wParamlo) +'  '
                       // MIDI Note on / off
                       +IntToHex( Msg.lParamlo and $FF, 2) +' '
                       // MIDI Note value
                       +IntToHex( (Msg.lParamlo shr 8) and $FF, 2) +' '
                       // MIDI Key On Velocity
                       +IntToHex( Msg.lParamhi and $FF, 2)
                       );

                       // this value always contains NULL and can be ignored :
                       //+IntToHex( (Msg.lParamhi shr 8) and $FF, 2)
                       }
  end;
end;
{$ENDIF}

procedure TfrmMain.OnSysExData(const aDeviceIndex: integer;
  const aStream: TMemoryStream);
begin
  //do something with data

  //memLog.Lines.BeginUpdate;
  try
    // print the message log
    {memLog.Lines.Insert( 0, Format( '[%s] %s: <Bytes> %d <SysEx> %s',
      [ FormatDateTime( 'HH:NN:SS.ZZZ', now ),
        MidiInput.Devices[aDeviceIndex],
        aStream.Size,
        SysExStreamToStr( aStream ) ] )); }
  finally
    //memLog.Lines.EndUpdate;
  end;
end;

procedure TfrmMain.btSelectDirClick(Sender: TObject);
begin
  if SelectSysExDirectoryDialog1.Execute then
  begin
    edbtSelSysExDir.Text := SelectSysExDirectoryDialog1.FileName;
    LastSysExOpenDir := IncludeTrailingPathDelimiter(
      SelectSysExDirectoryDialog1.FileName);
    FillFilesList(SelectSysExDirectoryDialog1.FileName);
  end;
end;

procedure TfrmMain.SQLLoadCategories;
var
  sl: TStringList;
  i: integer;
begin
  sgDB.RowCount := 1;
  if SQLite3Con.Connected then
  begin
    sgCategories.BeginUpdate;
    sl := TStringList.Create;
    sl.Delimiter := ';';
    SQLQuery.SQL.Text := 'SELECT * FROM category';
    SQLTrans.StartTransaction;
    SQLQuery.Open;
    while not SQLQuery.EOF do
    begin
      sl.Add('"' + SQLQuery.Fields[0].AsString + '";"' +
        SQLQuery.Fields[1].AsString + '"');
      SQLQuery.Next;
    end;
    SQLQuery.Close;
    SQLTrans.Commit;
    sgCategories.RowCount := sl.Count + 1;
    for i := 0 to sl.Count - 1 do
    begin
      sgCategories.Rows[i + 1].Delimiter := ';';
      sgCategories.Rows[i + 1].QuoteChar := '"';
      sgCategories.Rows[i + 1].StrictDelimiter := True;
      sgCategories.Rows[i + 1].DelimitedText := sl[i];
    end;
    sl.Free;
    sgCategories.EndUpdate(True);
    if sgCategories.RowCount = 1 then sgCategories.RowCount := 2;
  end
  else
    ShowMessage('No database file assigned');
end;

procedure TfrmMain.SQLSaveCategories;
var
  i: integer;
begin
  if SQLite3Con.Connected then
  begin
    SQLQuery.Close;
    SQLQuery.SQL.Text := 'DELETE FROM CATEGORY WHERE (NAME = '''');';
    SQLQuery.ExecSQL;
    SQLTrans.Commit;
    for i := 1 to sgCategories.RowCount - 1 do
    begin
      if trim(sgCategories.Cells[0, i]) <> '' then
      begin
        SQLQuery.SQL.Text :=
          'INSERT OR REPLACE INTO CATEGORY (NAME, COMMENT) VALUES (:AName, :AComment);';
        SQLQuery.Params.ParamByName('AName').AsString := sgCategories.Cells[0, i];
        SQLQuery.Params.ParamByName('AComment').AsString := sgCategories.Cells[1, i];
        SQLQuery.ExecSQL;
      end;
    end;
    SQLTrans.Commit;
  end;
end;

procedure TfrmMain.btCatLoadClick(Sender: TObject);
begin
  SQLLoadCategories;
end;

procedure TfrmMain.btCatSaveClick(Sender: TObject);
begin
  SQLSaveCategories;
  UpdateCategoryLists;
end;

procedure TfrmMain.btDeleteCategoryDBClick(Sender: TObject);
begin
  if MessageDlg('Confirm deletion of Category database',
    'This operation is not reversible.' + #13#10 + 'Are you sure?',
    mtWarning, mbYesNo, 0) = mrYes then
  begin
    SQLCleanTable('CATEGORY');
    SQLiteVacuum;
  end;
end;

procedure TfrmMain.btDeleteVoiceDBClick(Sender: TObject);
begin
  if MessageDlg('Confirm deletion of Voices database',
    'This operation is not reversible.' + #13#10 + 'Are you sure?',
    mtWarning, mbYesNo, 0) = mrYes then
  begin
    SQLCleanTable('VOICES');
    SQLiteVacuum;
  end;
end;

procedure TfrmMain.btSDCardRenamePerformancesClick(Sender: TObject);
var
  folder: string;
  oldName: string;
  newName: string;
  i: integer;
begin
  folder := IncludeTrailingPathDelimiter(edbtSelSDCard.Text) + 'performance' + PathDelim;

  for i := 1 to sgSDPerfFiles.RowCount - 1 do
  begin
    if trim(sgSDPerfFiles.Cells[0, i]) <> '' then
      oldName := folder + sgSDPerfFiles.Cells[0, i] + '_' + sgSDPerfFiles.Cells[2, i]
    else
      oldName := folder + sgSDPerfFiles.Cells[2, i];
    newName := folder + sgSDPerfFiles.Cells[1, i] + '_' + sgSDPerfFiles.Cells[2, i];
    if newName <> oldName then
      if not FileExists(newName) then
        RenameFile(oldName, newName)
      else
        ShowMessage('Error: File ' + ExtractFileName(newName) + ' already exists');
  end;
  LoadSDCard(IncludeTrailingPathDelimiter(edbtSelSDCard.Text));
  PopUp('Done!', 3);
end;

procedure TfrmMain.btSDCardRenameVoicesClick(Sender: TObject);
var
  folder: string;
  oldName: string;
  newName: string;
  i: integer;
begin
  folder := IncludeTrailingPathDelimiter(edbtSelSDCard.Text) + 'sysex' +
    PathDelim + 'voice' + PathDelim;

  for i := 1 to sgSDSysExFiles.RowCount - 1 do
  begin
    if trim(sgSDSysExFiles.Cells[0, i]) <> '' then
      oldName := folder + sgSDSysExFiles.Cells[0, i] + '_' + sgSDSysExFiles.Cells[2, i]
    else
      oldName := folder + sgSDSysExFiles.Cells[2, i];
    newName := folder + sgSDSysExFiles.Cells[1, i] + '_' + sgSDSysExFiles.Cells[2, i];
    if newName <> oldName then
      if not FileExists(newName) then
        RenameFile(oldName, newName)
      else
        ShowMessage('Error: File ' + ExtractFileName(newName) + ' already exists');
  end;
  LoadSDCard(IncludeTrailingPathDelimiter(edbtSelSDCard.Text));
  PopUp('Done!', 3);
end;

procedure TfrmMain.cbDisplayEncoderChange(Sender: TObject);
begin
  CalculateGPIO;
end;

procedure TfrmMain.cbDisplayResolutionChange(Sender: TObject);
begin
  case cbDisplayResolution.ItemIndex of
    0: begin
      edDisplayi2sCols.Text := '20';
      edDisplayi2sRows.Text := '2';
    end;
    1: begin
      edDisplayi2sCols.Text := '20';
      edDisplayi2sRows.Text := '4';
    end;
  end;
end;

procedure TfrmMain.cbMidiInChange(Sender: TObject);
var
  i: integer;
  err: PmError;
begin
  for i := 0 to MidiInput.Devices.Count - 1 do
    MidiInput.Close(i);
  if cbMidiIn.ItemIndex <> -1 then
  begin
    FMidiIn := cbMidiIn.Text;
    FMidiInInt := cbMidiIn.ItemIndex;
    err := MidiInput.Open(FMidiInInt);
    if (err = 0) or (err = 1) then
    begin
      mmLogSettings.Lines.Add('Opening port ' + IntToStr(FMidiInInt) + ' successfull');
      FMidiIsActive := True;
    end
    else
    begin
      mmLogSettings.Lines.Add('Opening port ' + IntToStr(FMidiInInt) +
        ' failed: ' + Pm_GetErrorText(err));
      cbMidiIn.ItemIndex := -1;
    end;
  end;
end;

procedure TfrmMain.cbMidiOutChange(Sender: TObject);
var
  i: integer;
  err: PmError;
begin
  for i := 0 to MidiOutput.Devices.Count - 1 do
    MidiOutput.Close(i);
  if cbMidiOut.ItemIndex <> -1 then
  begin
    FMidiOut := cbMidiOut.Text;
    FMidiOutInt := cbMidiOut.ItemIndex;
    err := MidiOutput.Open(FMidiOutInt);
    if (err = 0) or (err = 1) then
    begin
      mmLogSettings.Lines.Add('Opening port ' + IntToStr(FMidiOutInt) + ' successful');
      FMidiIsActive := True;
    end
    else
    begin
      mmLogSettings.Lines.Add('Opening port ' + IntToStr(FMidiOutInt) +
        ' failed: ' + Pm_GetErrorText(err));
      cbMidiOut.ItemIndex := -1;
    end;
  end;
end;

procedure TfrmMain.LoadSDCard(dir: string);
var
  SysExDir: string;
  PerfDir: string;
  sl: TStringList;
  i: integer;
  chkString: string;
begin
  if DirectoryExists(dir) then
  begin
    LastSDCardDir := IncludeTrailingPathDelimiter(dir);
    edbtSelSDCard.Text := IncludeTrailingPathDelimiter(dir);
    SysExDir := IncludeTrailingPathDelimiter(LastSDCardDir + 'sysex' +
      PathDelim + 'voice');
    PerfDir := IncludeTrailingPathDelimiter(LastSDCardDir + 'performance');

    sl := TStringList.Create;
    sl.Sorted := True;
    FindSYX(SysExDir, sl);
    if sl.Count > 0 then
    begin
      SDCardSysExFiles.Clear;
      SDCardSysExFiles.AddStrings(sl);
      sgSDSysExFiles.RowCount := sl.Count + 1;
      for i := 0 to sl.Count - 1 do
      begin
        chkString := copy(sl[i], 1, 6);
        if StrToInt64Def(chkString, -1) <> -1 then
        begin
          sgSDSysExFiles.Cells[0, i + 1] := copy(sl[i], 1, 6);
          sgSDSysExFiles.Cells[2, i + 1] := copy(sl[i], 8, Length(sl[i]) - 7);
          sgSDSysExFiles.Cells[1, i + 1] := Format('%.6d', [i]);
        end
        else
        begin
          sgSDSysExFiles.Cells[0, i + 1] := '';
          sgSDSysExFiles.Cells[2, i + 1] := sl[i];
          sgSDSysExFiles.Cells[1, i + 1] := Format('%.6d', [i]);
        end;
      end;
    end;

    sl.Clear;
    FindPerf(PerfDir, sl);
    if sl.Count > 0 then
    begin
      SDCardPerfFiles.Clear;
      SDCardPerfFiles.AddStrings(sl);
      sgSDPerfFiles.RowCount := sl.Count + 1;
      for i := 0 to sl.Count - 1 do
      begin
        chkString := copy(sl[i], 1, 6);
        if StrToInt64Def(chkString, -1) <> -1 then
        begin
          sgSDPerfFiles.Cells[0, i + 1] := copy(sl[i], 1, 6);
          sgSDPerfFiles.Cells[2, i + 1] := copy(sl[i], 8, Length(sl[i]) - 7);
          sgSDPerfFiles.Cells[1, i + 1] := Format('%.6d', [i]);
        end
        else
        begin
          sgSDPerfFiles.Cells[0, i + 1] := '';
          sgSDPerfFiles.Cells[2, i + 1] := sl[i];
          sgSDPerfFiles.Cells[1, i + 1] := Format('%.6d', [i]);
        end;
      end;
    end;
    sl.Free;
  end;
end;

procedure TfrmMain.btSelSDCardClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
    SelectSDCardDirectoryDialog1.InitialDir:='::{20D04FE0-3AEA-1069-A2D8-08002B30309D}';
  {$ENDIF}
  {$IFDEF LINUX}
    SelectSDCardDirectoryDialog1.InitialDir:='/mnt/';
  {$ENDIF}
  if SelectSDCardDirectoryDialog1.Execute then
  begin
    if FileExists(IncludeTrailingPathDelimiter(SelectSDCardDirectoryDialog1.FileName) +
      'minidexed.ini') then
      LoadSDCard(SelectSDCardDirectoryDialog1.FileName)
    else
      PopUp('Not a MiniDexed SDCard', 3);
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
  Unused(X, Y);
  if Source = lbVoices then
  begin
    if (lbVoices.ItemIndex = -1) or (lbFiles.ItemIndex = -1) then Exit;
    itm := lbFiles.Items[lbFiles.ItemIndex];
    f := IncludeTrailingPathDelimiter(edbtSelSysExDir.Text) + itm;
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
        FPerfSlotsDX[(Sender as TLabeledEdit).Tag + 1].SetVoiceParams(
          tmpVoice.GetVoiceParams);
        tmpVoice.Free;
      end;
      i := 0;
      if ContainsDX7VoiceDump(dmp, i, j) then  //single voice file
      begin
        tmpVoice := TDX7VoiceContainer.Create;
        tmpVoice.Load_VCED_FromStream(dmp, j);
        FPerfSlotsDX[(Sender as TLabeledEdit).Tag + 1].SetVoiceParams(
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
  Unused(Source, State);
  Unused(X, Y);
  if (Sender = lbVoices) and (dragItem <> -1) then Accept := True;
end;

procedure TfrmMain.edSlotDblClick(Sender: TObject);
begin
  SendSingleVoice(cbLibMIDIChannel.ItemIndex + 1, (Sender as TLabeledEdit).Tag + 1);
  (Sender as TLabeledEdit).SelLength := 0;
  Self.ActiveControl := nil;
end;

procedure TfrmMain.edSlotDragDrop(Sender, Source: TObject; X, Y: integer);
var
  dmp: TMemoryStream;
  f: string;
  itm: string;
  i, j: integer;
  tmpVoice: TDX7VoiceContainer;
  tmpSuppl: TDX7IISupplementContainer;
begin
  Unused(X, Y);
  if Source = lbFiles then
  begin
    if lbFiles.ItemIndex = -1 then exit;
    itm := lbFiles.Items[dragItem];
    f := IncludeTrailingPathDelimiter(edbtSelSysExDir.Text) + itm;
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
          TLabeledEdit(FindComponent(Format('edSlot%.2d', [i + 1]))).Text :=
            FSlotsDX.GetVoiceName(i + 1);
        end;
        i := dmp.Position;
        if ContainsDX7IISupplBankDump(dmp, i, j) then
          FSlotsSupplDX7II.LoadSupplBankFromStream(dmp, j);
      end;
      dmp.Free;
    end;
  end;
  if Source = lbVoices then
  begin
    if (lbVoices.ItemIndex = -1) or (lbFiles.ItemIndex = -1) then Exit;
    itm := lbFiles.Items[lbFiles.ItemIndex];
    f := IncludeTrailingPathDelimiter(edbtSelSysExDir.Text) + itm;
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
        FSlotsDX.SetVoice((Sender as TLabeledEdit).Tag + 1, tmpVoice);
        (Sender as TLabeledEdit).Text :=
          FSlotsDX.GetVoiceName((Sender as TLabeledEdit).Tag + 1);
        tmpVoice.Free;
        i := j;
        if ContainsDX7IISupplBankDump(dmp, i, j) then
        begin
          tmpSuppl := TDX7IISupplementContainer.Create;
          FSupplBankDXII.GetSupplement(lbVoices.ItemIndex + 1, tmpSuppl);
          FSlotsSupplDX7II.SetSupplement((Sender as TLabeledEdit).Tag + 1, tmpSuppl);
          tmpSuppl.Free;
        end;
      end;
      i := 0;
      if ContainsDX7VoiceDump(dmp, i, j) then  //single voice file
      begin
        tmpVoice := TDX7VoiceContainer.Create;
        tmpVoice.Load_VCED_FromStream(dmp, j);
        if FSlotsDX.SetVoice((Sender as TLabeledEdit).Tag + 1, tmpVoice) then
          (Sender as TLabeledEdit).Text :=
            FSlotsDX.GetVoiceName((Sender as TLabeledEdit).Tag + 1);
        tmpVoice.Free;
        i := j;
        if ContainsDX7IISupplementDump(dmp, i, j) then
        begin
          tmpSuppl := TDX7IISupplementContainer.Create;
          tmpSuppl.Load_ACED_FromStream(dmp, j);
          FSlotsSupplDX7II.SetSupplement((Sender as TLabeledEdit).Tag + 1, tmpSuppl);
          tmpSuppl.Free;
        end;
      end;
      dmp.Free;
    end;
  end;
  if Source = sgDB then
  begin
    dmp := TMemoryStream.Create;
    SQLGetVoice(sgDB.Cells[3, dragItem], dmp);
    tmpVoice := TDX7VoiceContainer.Create;
    tmpVoice.Load_VCED_FromStream(dmp, 0);
    if FSlotsDX.SetVoice((Sender as TLabeledEdit).Tag + 1, tmpVoice) then
      (Sender as TLabeledEdit).Text :=
        FSlotsDX.GetVoiceName((Sender as TLabeledEdit).Tag + 1);
    tmpVoice.Free;
    dmp.Free;
  end;
end;

procedure TfrmMain.edSlotDragOver(Sender, Source: TObject; X, Y: integer;
  State: TDragState; var Accept: boolean);
begin
  Unused(Source, State);
  Unused(X, Y);
  if (Sender = lbFiles) and (dragItem <> -1) then Accept := True;
  if (Sender = lbVoices) and (dragItem <> -1) then Accept := True;
  if (Sender = sgDB) and (dragItem <> -1) then Accept := True;
end;

procedure TfrmMain.FillFilesList(aFolder: string);
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  FindSYX(IncludeTrailingPathDelimiter(aFolder), sl);
  lbFiles.Items.Clear;
  lbFiles.Items.AddStrings(sl);
  sl.Free;
end;

procedure TfrmMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  i: integer;
begin
  Unused(CloseAction);
  FBankDX.Free;
  FSlotsDX.Free;
  FSupplBankDXII.Free;
  FSlotsSupplDX7II.Free;

  for i := 1 to 8 do
  begin
    FPerfSlotsDX[i].Free;
    FPerfSlotsSupplDX7II[i].Free;
  end;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: boolean);
var
  ini: TMiniINIFile;
begin
  CanClose := False;
  try
    ini := TMiniINIFile.Create;
    ini.LoadFromFile(HomeDir + 'settings.ini');
    if cbMIDIIn.ItemIndex <> -1 then
      ini.WriteString('MIDIInput', cbMidiIn.Text);
    if cbMidiOut.ItemIndex <> -1 then
      ini.WriteString('MIDIOutput', cbMidiOut.Text);
    ini.WriteString('LastSysExOpenDir', LastSysExOpenDir);
    ini.WriteString('LastSysExSaveDir', LastSysExSaveDir);
    ini.WriteString('LastSysEx', LastSysEx);
    ini.WriteString('LastPerfOpenDir', LastPerfOpenDir);
    ini.WriteString('LastPerfSaveDir', LastPerfSaveDir);
    ini.WriteString('LastPerf', LastPerf);
    ini.WriteString('LastSDCardDir', LastSDCardDir);
    ini.WriteInteger('FontSize', frmMain.Font.Height);
    ini.SaveToFile(HomeDir + 'settings.ini');
    FSlotsDX.SaveBankToSysExFile(HomeDir + 'lastState.syx');
  finally
    ini.Free;
  end;

  SDCardSysExFiles.Free;
  SDCardPerfFiles.Free;

  compList.Free;

  if FMidiIsActive then
  begin
    MidiInput.CloseAll;
    MidiOutput.CloseAll;

    CanClose := True;
  end
  else
    CanClose := True;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  i: integer;
  ini: TMiniINIFile;
begin
  HomeDir := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(GetUserDir) +
    'MiniDexedCC');
  if not DirectoryExists(HomeDir) then CreateDir(HomeDir);
  AppDir := IncludeTrailingPathDelimiter(ExtractFileDir(Application.Params[0]));
  FBankDX := TDX7BankContainer.Create;
  FSlotsDX := TDX7BankContainer.Create;
  FSupplBankDXII := TDX7IISupplBankContainer.Create;
  FSlotsSupplDX7II := TDX7IISupplBankContainer.Create;
  for i := 0 to 31 do
  begin
    TLabeledEdit(FindComponent(Format('edSlot%.2d', [i + 1]))).Text :=
      FSlotsDX.GetVoiceName(i + 1);
  end;
  for i := 1 to 8 do
  begin
    FPerfSlotsDX[i] := TDX7VoiceContainer.Create;
    FPerfSlotsDX[i].InitVoice;
    FPerfSlotsSupplDX7II[i] := TDX7IISupplementContainer.Create;
    FPerfSlotsSupplDX7II[i].InitSupplement;

    TLabeledEdit(FindComponent(Format('edPSlot%.2d', [i]))).Text :=
      FPerfSlotsDX[i].GetVoiceName;
  end;
  pcMain.ActivePage := tsLibrarian;
  pcFilesDatabase.ActivePage := tsFiles;
  pcBankPerformanceSlots.ActivePage := tsBankSlots;
  pcMiniDexedFiles.ActivePage := tsIniFiles;
  pcTGs.ActivePage := tsTG1_4;
  RefreshSlots;
  pnHint.BringToFront;
  pnHint.Visible := False;
  lbHint.Caption := '';
  pnHint.Top := frmMain.Height;
  pnHint.Left := frmMain.Width;

  FMidiIsActive := False;
  FMidiInInt := -1;
  FMidiOutInt := -1;
  FMidiIn := '';
  FMidiOut := '';
  {$IFDEF WINDOWS}
  MidiInput.OnMidiData := @Self.OnMidiInData;
  MidiInput.OnSysExData := @Self.OnSysExData;
  {$ENDIF}

  //fill MIDI ports to ComboBoxes
  cbMidiIn.Items.Clear;
  cbMidiOut.Items.Clear;
  cbMidiIn.Items.Assign(MidiInput.Devices);
  cbMidiOut.Items.Assign(MidiOutput.Devices);

  //DB Stuff
  DBName := HomeDir + 'SysExDB.sqlite';
  SQLite3Con.Connected := False;
  SQLite3Con.DatabaseName := DBName;
  SQLite3Con.Connected := True;
  SQLCreateTables;
  //create default category
  SQLQuery.Close;
  SQLQuery.SQL.Text :=
    'INSERT OR REPLACE INTO CATEGORY (NAME, COMMENT) VALUES (''Default'', ''Default category'');';
  SQLQuery.ExecSQL;
  SQLTrans.Commit;
  //Load the DB values into the GUI components
  SQLLoadCategories;
  UpdateCategoryLists;

  //SDCard lists
  SDCardSysExFiles := TStringList.Create;
  SDCardPerfFiles := TStringList.Create;
  sgSDSysExFiles.FastEditing := False;
  sgSDPerfFiles.FastEditing := False;

  //stringgrid sgDB list of changed rows
  compList := TStringList.Create;
  compList.Sorted := True;
  compList.Duplicates := dupIgnore;
  lastSelectedRow := -1;
  sgDB.FastEditing := False;

  LastSysExOpenDir := '';
  LastSysExSaveDir := '';
  LastSysEx := '';
  LastPerfOpenDir := '';
  LastPerfSaveDir := '';
  LastPerf := '';
  LastSDCardDir := '';

  try
    ini := TMiniINIFile.Create;
    ini.LoadFromFile(HomeDir + 'settings.ini');
    cbMIDIIn.ItemIndex := cbMidiIn.Items.IndexOf(ini.ReadString('MIDIInput', ''));
    if cbMidiIn.ItemIndex <> -1 then
    begin
      FMidiIn := cbMidiIn.Text;
      FMidiInInt := cbMidiIn.ItemIndex;
      MidiInput.Open(FMidiInInt);
      FMidiIsActive := True;
    end;
    cbMidiOut.ItemIndex := cbMidiOut.Items.IndexOf(ini.ReadString('MIDIOutput', ''));
    if cbMidiOut.ItemIndex <> -1 then
    begin
      FMidiOut := cbMidiOut.Text;
      FMidiOutInt := cbMidiOut.ItemIndex;
      MidiOutput.Open(FMidiOutInt);
      FMidiIsActive := True;
    end;
    LastSysExOpenDir := ini.ReadString('LastSysExOpenDir', '');
    LastSysExSaveDir := ini.ReadString('LastSysExSaveDir', '');
    LastSysEx := ini.ReadString('LastSysEx', '');
    LastPerfOpenDir := ini.ReadString('LastPerfOpenDir', '');
    LastPerfSaveDir := ini.ReadString('LastPerfSaveDir', '');
    LastPerf := ini.ReadString('LastPerf', '');
    LastSDCardDir := ini.ReadString('LastSDCardDir', '');
    frmMain.Font.Height := ini.ReadInteger('FontSize', 11);
    seFontSize.Value := frmMain.Font.Height;
    if DirectoryExists(LastSysExOpenDir) then
    begin
      SelectSysExDirectoryDialog1.InitialDir := LastSysExOpenDir;
      edbtSelSysExDir.Text := LastSysExOpenDir;
      FillFilesList(LastSysExOpenDir);
    end;
    if DirectoryExists(LastSysExSaveDir) then
      SaveBankDialog1.InitialDir := LastSysExSaveDir;
    if lbFiles.Items.IndexOf(LastSysEx) <> -1 then
    begin
      lbFiles.ItemIndex := lbFiles.Items.IndexOf(LastSysEx);
      if FileExists(LastSysExOpenDir + LastSysEx) then
        OpenSysEx(LastSysExOpenDir + LastSysEx);
    end;
    if DirectoryExists(LastPerfOpenDir) then
      OpenPerformanceDialog1.InitialDir := LastPerfOpenDir;
    if DirectoryExists(LastPerfSaveDir) then
      SavePerformanceDialog1.InitialDir := LastPerfSaveDir;
    if FileExists(LastPerf) then
    begin
      OpenPerformance(LastPerf);
    end;
    if DirectoryExists(LastSDCardDir) then
    begin
      SelectSDCardDirectoryDialog1.InitialDir := LastSDCardDir;
      edbtSelSDCard.Text := LastSDCardDir;
      LoadSDCard(LastSDCardDir);
    end;
    pnHint.Visible := False;
    LoadLastStateBank;
  finally
    ini.Free;
  end;

  HD44780Addr := '39';
  SSD1306Addr := '60';

  CalculateGPIO;
  rbDisplayDiscreteChange(Self);
  swMIDIThruEnableChange(Self);
  rbEncoderDiscreteChange(Self);
  rbSoundDevOtherChange(Self);
end;

procedure TfrmMain.LoadLastStateBank;
var
  dmp: TMemoryStream;
  i, j: integer;
  Itm: string;
  nr: integer;
begin
  Itm := HomeDir + 'lastState.syx';
  if FileExists(itm) then
  begin
    dmp := TMemoryStream.Create;
    dmp.LoadFromFile(itm);
    i := 0;
    j := 0;
    if ContainsDX7BankDump(dmp, i, j) then
    begin
      FSlotsDX.LoadBankFromStream(dmp, j);
      for nr := 0 to 31 do
      begin
        TLabeledEdit(FindComponent(Format('edSlot%.2d', [nr + 1]))).Text :=
          FSlotsDX.GetVoiceName(nr + 1);
      end;
    end;
    dmp.Free;
  end;
end;

procedure TfrmMain.lbFilesClick(Sender: TObject);
var
  dbg: string;
  Itm: string;
begin
  if lbFiles.ItemIndex = -1 then exit;
  Itm := lbFiles.Items[lbFiles.ItemIndex];
  LastSysEx := itm;
  dbg := IncludeTrailingPathDelimiter(edbtSelSysExDir.Text) + Itm;
  lbVoices.Clear;
  OpenSysEx(dbg);
end;

procedure TfrmMain.lbFilesStartDrag(Sender: TObject; var DragObject: TDragObject);
begin
  Unused(DragObject);
  if lbFiles.ItemIndex <> -1 then
    dragItem := lbFiles.ItemIndex;
end;

procedure TfrmMain.lbVoicesStartDrag(Sender: TObject; var DragObject: TDragObject);
begin
  Unused(DragObject);
  if lbVoices.ItemIndex <> -1 then
    dragItem := lbVoices.ItemIndex;
end;

procedure TfrmMain.OpenPerformance(aName: string);
var
  ini: TMiniINIFile;
  hexstream: TMemoryStream;
  hexstring: string;
  chkStr: string;
  sName: string;
  sCategory: string;
  sOrigin: string;
begin
  ini := TMiniINIFile.Create;
  ini.LoadFromFile(aName);
  sName := ExtractFileNameWithoutExt(ExtractFileName(aName));
  chkStr := copy(sName, 0, 6);
  if StrToInt64Def(chkStr, -1) <> -1 then
    edPerfName.Text := copy(sName, 8, Length(sName) - 7)
  else
    edPerfName.Text := sName;
  //MiniDexedCC-specific
  //overwrite the name if contained in INI
  sName := ini.ReadString('Name', '');
  if sName <> '' then edPerfName.Text := sName;
  sCategory := ini.ReadString('Category', '');
  if sCategory <> '' then
  begin
    if cbPerfCategory.Items.IndexOf(sCategory) <> -1 then
      cbPerfCategory.ItemIndex := cbPerfCategory.Items.IndexOf(sCategory)
    else
    begin
      //add new category
      SQLLoadCategories;
      sgCategories.RowCount := sgCategories.RowCount + 1;
      sgCategories.Cells[0, sgCategories.RowCount - 1] := sCategory;
      sgCategories.Cells[1, sgCategories.RowCount - 1] := 'Added from ' + sName;
      SQLSaveCategories;
      UpdateCategoryLists;
      cbPerfCategory.ItemIndex := cbPerfCategory.Items.IndexOf(sCategory);
    end;
  end;
  sOrigin := ini.ReadString('Origin', '');
  if sOrigin <> '' then edPerfOrigin.Text := sOrigin
  else
    edPerfOrigin.Text := 'Unknown';

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
    VCEDHexToStream(hexstring, hexstream);
    FPerfSlotsDX[1].Load_VCED_FromStream(hexstream, 0);
  end
  else
    FPerfSlotsDX[1].InitVoice;
  swMonoMode1.Checked := ini.ReadInteger('MonoMode1', 0) = 1;
  slModWhRange1.Position := ini.ReadInteger('ModulationWheelRange1', 99);
  swModP1.Checked := ini.ReadInteger('ModulationWheelTarget1', 1) and 1 = 1;
  swModA1.Checked := ini.ReadInteger('ModulationWheelTarget1', 1) and 2 = 2;
  swModEG1.Checked := ini.ReadInteger('ModulationWheelTarget1', 1) and 4 = 4;
  slFootCtrlRange1.Position := ini.ReadInteger('FootControlRange1', 99);
  swFootP1.Checked := ini.ReadInteger('FootControlTarget1', 0) and 1 = 1;
  swFootA1.Checked := ini.ReadInteger('FootControlTarget1', 0) and 2 = 2;
  swFootEG1.Checked := ini.ReadInteger('FootControlTarget1', 0) and 4 = 4;
  slBreathCtrlRange1.Position := ini.ReadInteger('BreathControlRange1', 99);
  swBreathP1.Checked := ini.ReadInteger('BreathControlTarget1', 0) and 1 = 1;
  swBreathA1.Checked := ini.ReadInteger('BreathControlTarget1', 0) and 2 = 2;
  swBreathEG1.Checked := ini.ReadInteger('BreathControlTarget1', 0) and 4 = 4;
  slAfterTouchRange1.Position := ini.ReadInteger('AfterTouchRange1', 99);
  swAfterTouchP1.Checked := ini.ReadInteger('AfterTouchTarget1', 0) and 1 = 1;
  swAfterTouchA1.Checked := ini.ReadInteger('AfterTouchTarget1', 0) and 2 = 2;
  swAfterTouchEG1.Checked := ini.ReadInteger('AfterTouchTarget1', 0) and 4 = 4;

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
    VCEDHexToStream(hexstring, hexstream);
    FPerfSlotsDX[2].Load_VCED_FromStream(hexstream, 0);
  end
  else
    FPerfSlotsDX[2].InitVoice;
  swMonoMode2.Checked := ini.ReadInteger('MonoMode2', 0) = 1;
  slModWhRange2.Position := ini.ReadInteger('ModulationWheelRange2', 99);
  swModP2.Checked := ini.ReadInteger('ModulationWheelTarget2', 1) and 1 = 1;
  swModA2.Checked := ini.ReadInteger('ModulationWheelTarget2', 1) and 2 = 2;
  swModEG2.Checked := ini.ReadInteger('ModulationWheelTarget2', 1) and 4 = 4;
  slFootCtrlRange2.Position := ini.ReadInteger('FootControlRange2', 99);
  swFootP2.Checked := ini.ReadInteger('FootControlTarget2', 0) and 1 = 1;
  swFootA2.Checked := ini.ReadInteger('FootControlTarget2', 0) and 2 = 2;
  swFootEG2.Checked := ini.ReadInteger('FootControlTarget2', 0) and 4 = 4;
  slBreathCtrlRange2.Position := ini.ReadInteger('BreathControlRange2', 99);
  swBreathP2.Checked := ini.ReadInteger('BreathControlTarget2', 0) and 1 = 1;
  swBreathA2.Checked := ini.ReadInteger('BreathControlTarget2', 0) and 2 = 2;
  swBreathEG2.Checked := ini.ReadInteger('BreathControlTarget2', 0) and 4 = 4;
  slAfterTouchRange2.Position := ini.ReadInteger('AfterTouchRange2', 99);
  swAfterTouchP2.Checked := ini.ReadInteger('AfterTouchTarget2', 0) and 1 = 1;
  swAfterTouchA2.Checked := ini.ReadInteger('AfterTouchTarget2', 0) and 2 = 2;
  swAfterTouchEG2.Checked := ini.ReadInteger('AfterTouchTarget2', 0) and 4 = 4;

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
    VCEDHexToStream(hexstring, hexstream);
    FPerfSlotsDX[3].Load_VCED_FromStream(hexstream, 0);
  end
  else
    FPerfSlotsDX[3].InitVoice;
  swMonoMode3.Checked := ini.ReadInteger('MonoMode3', 0) = 1;
  slModWhRange3.Position := ini.ReadInteger('ModulationWheelRange3', 99);
  swModP3.Checked := ini.ReadInteger('ModulationWheelTarget3', 1) and 1 = 1;
  swModA3.Checked := ini.ReadInteger('ModulationWheelTarget3', 1) and 2 = 2;
  swModEG3.Checked := ini.ReadInteger('ModulationWheelTarget3', 1) and 4 = 4;
  slFootCtrlRange3.Position := ini.ReadInteger('FootControlRange3', 99);
  swFootP3.Checked := ini.ReadInteger('FootControlTarget3', 0) and 1 = 1;
  swFootA3.Checked := ini.ReadInteger('FootControlTarget3', 0) and 2 = 2;
  swFootEG3.Checked := ini.ReadInteger('FootControlTarget3', 0) and 4 = 4;
  slBreathCtrlRange3.Position := ini.ReadInteger('BreathControlRange3', 99);
  swBreathP3.Checked := ini.ReadInteger('BreathControlTarget3', 0) and 1 = 1;
  swBreathA3.Checked := ini.ReadInteger('BreathControlTarget3', 0) and 2 = 2;
  swBreathEG3.Checked := ini.ReadInteger('BreathControlTarget3', 0) and 4 = 4;
  slAfterTouchRange3.Position := ini.ReadInteger('AfterTouchRange3', 99);
  swAfterTouchP3.Checked := ini.ReadInteger('AfterTouchTarget3', 0) and 1 = 1;
  swAfterTouchA3.Checked := ini.ReadInteger('AfterTouchTarget3', 0) and 2 = 2;
  swAfterTouchEG3.Checked := ini.ReadInteger('AfterTouchTarget3', 0) and 4 = 4;

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
    VCEDHexToStream(hexstring, hexstream);
    FPerfSlotsDX[4].Load_VCED_FromStream(hexstream, 0);
  end
  else
    FPerfSlotsDX[4].InitVoice;
  swMonoMode4.Checked := ini.ReadInteger('MonoMode4', 0) = 1;
  slModWhRange4.Position := ini.ReadInteger('ModulationWheelRange4', 99);
  swModP4.Checked := ini.ReadInteger('ModulationWheelTarget4', 1) and 1 = 1;
  swModA4.Checked := ini.ReadInteger('ModulationWheelTarget4', 1) and 2 = 2;
  swModEG4.Checked := ini.ReadInteger('ModulationWheelTarget4', 1) and 4 = 4;
  slFootCtrlRange4.Position := ini.ReadInteger('FootControlRange4', 99);
  swFootP4.Checked := ini.ReadInteger('FootControlTarget4', 0) and 1 = 1;
  swFootA4.Checked := ini.ReadInteger('FootControlTarget4', 0) and 2 = 2;
  swFootEG4.Checked := ini.ReadInteger('FootControlTarget4', 0) and 4 = 4;
  slBreathCtrlRange4.Position := ini.ReadInteger('BreathControlRange4', 99);
  swBreathP4.Checked := ini.ReadInteger('BreathControlTarget4', 0) and 1 = 1;
  swBreathA4.Checked := ini.ReadInteger('BreathControlTarget4', 0) and 2 = 2;
  swBreathEG4.Checked := ini.ReadInteger('BreathControlTarget4', 0) and 4 = 4;
  slAfterTouchRange4.Position := ini.ReadInteger('AfterTouchRange4', 99);
  swAfterTouchP4.Checked := ini.ReadInteger('AfterTouchTarget4', 0) and 1 = 1;
  swAfterTouchA4.Checked := ini.ReadInteger('AfterTouchTarget4', 0) and 2 = 2;
  swAfterTouchEG4.Checked := ini.ReadInteger('AfterTouchTarget4', 0) and 4 = 4;

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
    VCEDHexToStream(hexstring, hexstream);
    FPerfSlotsDX[5].Load_VCED_FromStream(hexstream, 0);
  end
  else
    FPerfSlotsDX[5].InitVoice;
  swMonoMode5.Checked := ini.ReadInteger('MonoMode5', 0) = 1;
  slModWhRange5.Position := ini.ReadInteger('ModulationWheelRange5', 99);
  swModP5.Checked := ini.ReadInteger('ModulationWheelTarget5', 1) and 1 = 1;
  swModA5.Checked := ini.ReadInteger('ModulationWheelTarget5', 1) and 2 = 2;
  swModEG5.Checked := ini.ReadInteger('ModulationWheelTarget5', 1) and 4 = 4;
  slFootCtrlRange5.Position := ini.ReadInteger('FootControlRange5', 99);
  swFootP5.Checked := ini.ReadInteger('FootControlTarget5', 0) and 1 = 1;
  swFootA5.Checked := ini.ReadInteger('FootControlTarget5', 0) and 2 = 2;
  swFootEG5.Checked := ini.ReadInteger('FootControlTarget5', 0) and 4 = 4;
  slBreathCtrlRange5.Position := ini.ReadInteger('BreathControlRange5', 99);
  swBreathP5.Checked := ini.ReadInteger('BreathControlTarget5', 0) and 1 = 1;
  swBreathA5.Checked := ini.ReadInteger('BreathControlTarget5', 0) and 2 = 2;
  swBreathEG5.Checked := ini.ReadInteger('BreathControlTarget5', 0) and 4 = 4;
  slAfterTouchRange5.Position := ini.ReadInteger('AfterTouchRange5', 99);
  swAfterTouchP5.Checked := ini.ReadInteger('AfterTouchTarget5', 0) and 1 = 1;
  swAfterTouchA5.Checked := ini.ReadInteger('AfterTouchTarget5', 0) and 2 = 2;
  swAfterTouchEG5.Checked := ini.ReadInteger('AfterTouchTarget5', 0) and 4 = 4;

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
    VCEDHexToStream(hexstring, hexstream);
    FPerfSlotsDX[6].Load_VCED_FromStream(hexstream, 0);
  end
  else
    FPerfSlotsDX[6].InitVoice;
  swMonoMode6.Checked := ini.ReadInteger('MonoMode6', 0) = 1;
  slModWhRange6.Position := ini.ReadInteger('ModulationWheelRange6', 99);
  swModP6.Checked := ini.ReadInteger('ModulationWheelTarget6', 1) and 1 = 1;
  swModA6.Checked := ini.ReadInteger('ModulationWheelTarget6', 1) and 2 = 2;
  swModEG6.Checked := ini.ReadInteger('ModulationWheelTarget6', 1) and 4 = 4;
  slFootCtrlRange6.Position := ini.ReadInteger('FootControlRange6', 99);
  swFootP6.Checked := ini.ReadInteger('FootControlTarget6', 0) and 1 = 1;
  swFootA6.Checked := ini.ReadInteger('FootControlTarget6', 0) and 2 = 2;
  swFootEG6.Checked := ini.ReadInteger('FootControlTarget6', 0) and 4 = 4;
  slBreathCtrlRange6.Position := ini.ReadInteger('BreathControlRange6', 99);
  swBreathP6.Checked := ini.ReadInteger('BreathControlTarget6', 0) and 1 = 1;
  swBreathA6.Checked := ini.ReadInteger('BreathControlTarget6', 0) and 2 = 2;
  swBreathEG6.Checked := ini.ReadInteger('BreathControlTarget6', 0) and 4 = 4;
  slAfterTouchRange6.Position := ini.ReadInteger('AfterTouchRange6', 99);
  swAfterTouchP6.Checked := ini.ReadInteger('AfterTouchTarget6', 0) and 1 = 1;
  swAfterTouchA6.Checked := ini.ReadInteger('AfterTouchTarget6', 0) and 2 = 2;
  swAfterTouchEG6.Checked := ini.ReadInteger('AfterTouchTarget6', 0) and 4 = 4;

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
    VCEDHexToStream(hexstring, hexstream);
    FPerfSlotsDX[7].Load_VCED_FromStream(hexstream, 0);
  end
  else
    FPerfSlotsDX[7].InitVoice;
  swMonoMode7.Checked := ini.ReadInteger('MonoMode7', 0) = 1;
  slModWhRange7.Position := ini.ReadInteger('ModulationWheelRange7', 99);
  swModP7.Checked := ini.ReadInteger('ModulationWheelTarget7', 1) and 1 = 1;
  swModA7.Checked := ini.ReadInteger('ModulationWheelTarget7', 1) and 2 = 2;
  swModEG7.Checked := ini.ReadInteger('ModulationWheelTarget7', 1) and 4 = 4;
  slFootCtrlRange7.Position := ini.ReadInteger('FootControlRange7', 99);
  swFootP7.Checked := ini.ReadInteger('FootControlTarget7', 0) and 1 = 1;
  swFootA7.Checked := ini.ReadInteger('FootControlTarget7', 0) and 2 = 2;
  swFootEG7.Checked := ini.ReadInteger('FootControlTarget7', 0) and 4 = 4;
  slBreathCtrlRange7.Position := ini.ReadInteger('BreathControlRange7', 99);
  swBreathP7.Checked := ini.ReadInteger('BreathControlTarget7', 0) and 1 = 1;
  swBreathA7.Checked := ini.ReadInteger('BreathControlTarget7', 0) and 2 = 2;
  swBreathEG7.Checked := ini.ReadInteger('BreathControlTarget7', 0) and 4 = 4;
  slAfterTouchRange7.Position := ini.ReadInteger('AfterTouchRange7', 99);
  swAfterTouchP7.Checked := ini.ReadInteger('AfterTouchTarget7', 0) and 1 = 1;
  swAfterTouchA7.Checked := ini.ReadInteger('AfterTouchTarget7', 0) and 2 = 2;
  swAfterTouchEG7.Checked := ini.ReadInteger('AfterTouchTarget7', 0) and 4 = 4;

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
    VCEDHexToStream(hexstring, hexstream);
    FPerfSlotsDX[8].Load_VCED_FromStream(hexstream, 0);
  end
  else
    FPerfSlotsDX[8].InitVoice;
  swMonoMode8.Checked := ini.ReadInteger('MonoMode8', 0) = 1;
  slModWhRange8.Position := ini.ReadInteger('ModulationWheelRange8', 99);
  swModP8.Checked := ini.ReadInteger('ModulationWheelTarget8', 1) and 1 = 1;
  swModA8.Checked := ini.ReadInteger('ModulationWheelTarget8', 1) and 2 = 2;
  swModEG8.Checked := ini.ReadInteger('ModulationWheelTarget8', 1) and 4 = 4;
  slFootCtrlRange8.Position := ini.ReadInteger('FootControlRange8', 99);
  swFootP8.Checked := ini.ReadInteger('FootControlTarget8', 0) and 1 = 1;
  swFootA8.Checked := ini.ReadInteger('FootControlTarget8', 0) and 2 = 2;
  swFootEG8.Checked := ini.ReadInteger('FootControlTarget8', 0) and 4 = 4;
  slBreathCtrlRange8.Position := ini.ReadInteger('BreathControlRange8', 99);
  swBreathP8.Checked := ini.ReadInteger('BreathControlTarget8', 0) and 1 = 1;
  swBreathA8.Checked := ini.ReadInteger('BreathControlTarget8', 0) and 2 = 2;
  swBreathEG8.Checked := ini.ReadInteger('BreathControlTarget8', 0) and 4 = 4;
  slAfterTouchRange8.Position := ini.ReadInteger('AfterTouchRange8', 99);
  swAfterTouchP8.Checked := ini.ReadInteger('AfterTouchTarget8', 0) and 1 = 1;
  swAfterTouchA8.Checked := ini.ReadInteger('AfterTouchTarget8', 0) and 2 = 2;
  swAfterTouchEG8.Checked := ini.ReadInteger('AfterTouchTarget8', 0) and 4 = 4;

  swCompressorEnable.Checked := ini.ReadInteger('CompressorEnable', 1) = 1;
  swReverbEnable.Checked := ini.ReadInteger('ReverbEnable', 1) = 1;
  slReverbSize.Position := ini.ReadInteger('ReverbSize', 70);
  slReverbHighDamp.Position := ini.ReadInteger('ReverbHighDamp', 50);
  slReverbLowDamp.Position := ini.ReadInteger('ReverbLowDamp', 50);
  slReverbLowPass.Position := ini.ReadInteger('ReverbLowPass', 30);
  slReverbDiffusion.Position := ini.ReadInteger('ReverbDiffusion', 65);
  slReverbLevel.Position := ini.ReadInteger('ReverbLevel', 80);

  hexstream.Free;
  ini.Free;
  RefreshSlots;
end;

procedure TfrmMain.OpenSysEx(aName: string);
var
  dmp: TMemoryStream;
  i, j: integer;
  bVCED, bVMEM: boolean;
  bACED, bAMEM: boolean;
  dxsupp: TDX7IISupplementContainer;
  dxv: TDX7VoiceContainer;
  nr: integer;
begin
  if aName = '' then exit;
  if FileExists(aName) then
  begin
    dmp := TMemoryStream.Create;
    dmp.LoadFromFile(aName);
    mmLog.Lines.Clear;
    i := 0;
    j := 0;
    bVCED := False;
    bVMEM := False;
    bACED := True;
    bAMEM := True;
    ContainsDXData(dmp, i, mmLog.Lines);
    if ContainsDX7VoiceDump(dmp, i, j) then
    begin
      lbVoices.Items.Clear;
      {$IFDEF ExtraInfo}
      mmLog.Lines.Add('File ' + ExtractFileName(aName) +
        ' contains DX7 single voice header at position ' + IntToStr(i));
      {$ENDIF}
      dxv := TDX7VoiceContainer.Create;
      dxv.Load_VCED_FromStream(dmp, j);
      if dxv.GetVoiceName <> '' then lbVoices.Items.Add(dxv.GetVoiceName);
      dxv.Free;
      {$IFDEF ExtraInfo}
      i := j;
      if ContainsDX7IISupplBankDump(dmp, i, j) then
      begin
        dxsupp := TDX7IISupplementContainer.Create;
        dxsupp.Load_ACED_FromStream(dmp, j);
        mmLog.Lines.Add('and also contains DX7II supplement');
        dxsupp.Free;
      end
      else
        bACED := False;
      {$ENDIF}
    end
    else
      bVCED := True;
    i := 0; //read from the begining of the stream again
    if ContainsDX7BankDump(dmp, i, j) then
    begin
      lbVoices.Items.Clear;
      {$IFDEF ExtraInfo}
      mmLog.Lines.Add('File ' + ExtractFileName(aName) +
        ' contains DX7 voice bank header at position ' + IntToStr(i));
      {$ENDIF}
      FBankDX.LoadBankFromStream(dmp, j);
      for nr := 1 to 32 do
      begin
        lbVoices.Items.Add(FBankDX.GetVoiceName(nr));
      end;
      i := dmp.Position;
      if ContainsDX7IISupplBankDump(dmp, i, j) then
      begin
        FSupplBankDXII.LoadSupplBankFromStream(dmp, i);
        {$IFDEF ExtraInfo}
        mmLog.Lines.Add('and also contains DX7II supplement');
        {$ENDIF}
      end
      else
      begin
        FSupplBankDXII.InitBank;
        bAMEM := False;
      end;
    end
    else
      bVMEM := True;
    {$IFDEF ExtraInfo}
    if bVMEM and bVCED then
      mmLog.Lines.Add('File ' + ExtractFileName(aName) + ' contains no DX7 dumps');
    if not (bAMEM and bACED) then
      mmLog.Lines.Add('File ' + ExtractFileName(aName) +
        ' contains no DX7II supplement dumps');
    {$ENDIF}
    dmp.Free;
  end;
end;

procedure TfrmMain.rbDisplayDiscreteChange(Sender: TObject);
begin
  if rbDisplayDiscrete.Checked then
  begin
    cbDisplayPinRW.Enabled := True;
    cbDisplayPinRS.Enabled := True;
    cbDisplayPinEN.Enabled := True;
    cbDisplayPinD4.Enabled := True;
    cbDisplayPinD5.Enabled := True;
    cbDisplayPinD6.Enabled := True;
    cbDisplayPinD7.Enabled := True;
    edDisplayi2sCols.Enabled := True;
    edDisplayi2sRows.Enabled := True;
    edDisplayi2sAddr.Text := '0';
  end
  else
  begin
    cbDisplayPinRW.Enabled := False;
    cbDisplayPinRS.Enabled := False;
    cbDisplayPinEN.Enabled := False;
    cbDisplayPinD4.Enabled := False;
    cbDisplayPinD5.Enabled := False;
    cbDisplayPinD6.Enabled := False;
    cbDisplayPinD7.Enabled := False;
    edDisplayi2sCols.Enabled := False;
    edDisplayi2sRows.Enabled := False;
  end;
  CalculateGPIO;
end;

procedure TfrmMain.rbDisplayi2cHD44780Change(Sender: TObject);
begin
  if rbDisplayi2cHD44780.Checked then
  begin
    edDisplayi2sAddr.Enabled := True;
    edDisplayi2sCols.Enabled := True;
    edDisplayi2sRows.Enabled := True;
    edDisplayi2sCols.Text := '16';
    edDisplayi2sRows.Text := '2';
    edDisplayi2sAddr.Text := HD44780Addr;
  end
  else
  begin
    edDisplayi2sAddr.Enabled := False;
    edDisplayi2sCols.Enabled := False;
    edDisplayi2sRows.Enabled := False;
  end;
  CalculateGPIO;
end;

procedure TfrmMain.rbDisplayi2cSSD1306Change(Sender: TObject);
begin
  if rbDisplayi2cSSD1306.Checked then
  begin
    edDisplayi2sAddr.Enabled := True;
    edDisplayi2sCols.Enabled := True;
    edDisplayi2sRows.Enabled := True;
    cbDisplayResolution.Enabled := True;
    edDisplayi2sAddr.Text := SSD1306Addr;
    case cbDisplayResolution.ItemIndex of
      0: begin
        edDisplayi2sCols.Text := '20';
        edDisplayi2sRows.Text := '2';
      end;
      1: begin
        edDisplayi2sCols.Text := '20';
        edDisplayi2sRows.Text := '4';
      end;
    end;
  end
  else
  begin
    edDisplayi2sAddr.Enabled := False;
    edDisplayi2sCols.Enabled := False;
    edDisplayi2sRows.Enabled := False;
    cbDisplayResolution.Enabled := False;
  end;
  CalculateGPIO;
end;

procedure TfrmMain.rbEncoderDiscreteChange(Sender: TObject);
begin
  if rbEncoderDiscrete.Checked then
  begin
    cbEncoderClockPin.Enabled := True;
    cbEncoderDataPin.Enabled := True;
  end
  else
  begin
    cbEncoderClockPin.Enabled := False;
    cbEncoderDataPin.Enabled := False;
  end;
  CalculateGPIO;
end;

procedure TfrmMain.rbSoundDevHDMIChange(Sender: TObject);
begin
  if rbSoundDevHDMI.Checked then
  begin
    edSoundDevi2sAddr.Enabled := False;
    edSoundDevOther.Enabled := False;
    CalculateGPIO;
  end;
end;

procedure TfrmMain.rbSoundDevi2sChange(Sender: TObject);
begin
  if rbSoundDevi2s.Checked then
  begin
    edSoundDevi2sAddr.Enabled := True;
    edSoundDevOther.Enabled := False;
    CalculateGPIO;
  end;
end;

procedure TfrmMain.CalculateGPIO;
var
  GPIO_Occupied: array[2..27] of boolean;
  GPIO_Function: array[2..27] of string;
  i: integer;
  slFreeGPIOs: TStringList;
  slButtons: TStringList;
  tmpItem: string;
begin
  for i := 2 to 27 do GPIO_Occupied[i] := False;
  for i := 0 to 19 do
  begin
    sgGPIO.Cells[0, i] := '';
    sgGPIO.Cells[5, i] := '';
  end;
  GPIO_Occupied[7] := True;
  GPIO_Occupied[8] := True;
  GPIO_Occupied[14] := True;
  GPIO_Occupied[15] := True;
  GPIO_Function[7] := 'SPI0_CE1_N';
  GPIO_Function[8] := 'SPI0_CE0_N';
  GPIO_Function[14] := 'TXD';
  GPIO_Function[15] := 'RXD';
  if rbSoundDevi2s.Checked then
  begin
    GPIO_Occupied[18] := True;
    GPIO_Occupied[19] := True;
    GPIO_Occupied[21] := True;
    GPIO_Function[18] := 'DAC BCK';
    GPIO_Function[19] := 'DAC LCK';
    GPIO_Function[21] := 'DAC DIN';
  end;
  if rbDisplayi2cHD44780.Checked then
  begin
    GPIO_Occupied[2] := True;
    GPIO_Occupied[3] := True;
    GPIO_Function[2] := 'I2C SDA';
    GPIO_Function[3] := 'I2C SCL';
  end;
  if rbDisplayi2cSSD1306.Checked then
  begin
    GPIO_Occupied[2] := True;
    GPIO_Occupied[3] := True;
    GPIO_Function[2] := 'I2C SDA';
    GPIO_Function[3] := 'I2C SCL';
  end;
  Application.ProcessMessages;
  if rbDisplayDiscrete.Checked then
  begin
    if cbDisplayPinRW.Text <> '0' then
      GPIO_Occupied[StrToInt(cbDisplayPinRW.Text)] := True;
    if cbDisplayPinRW.Text <> '0' then
      GPIO_Function[StrToInt(cbDisplayPinRW.Text)] := 'LCD RW';
    if cbDisplayPinRS.Text <> '0' then
      GPIO_Occupied[StrToInt(cbDisplayPinRS.Text)] := True;
    if cbDisplayPinRS.Text <> '0' then
      GPIO_Function[StrToInt(cbDisplayPinRS.Text)] := 'LCD RS';
    if cbDisplayPinEN.Text <> '0' then
      GPIO_Occupied[StrToInt(cbDisplayPinEN.Text)] := True;
    if cbDisplayPinEN.Text <> '0' then
      GPIO_Function[StrToInt(cbDisplayPinEN.Text)] := 'LCD EN';
    if cbDisplayPinD4.Text <> '0' then
      GPIO_Occupied[StrToInt(cbDisplayPinD4.Text)] := True;
    if cbDisplayPinD4.Text <> '0' then
      GPIO_Function[StrToInt(cbDisplayPinD4.Text)] := 'LCD D4';
    if cbDisplayPinD5.Text <> '0' then
      GPIO_Occupied[StrToInt(cbDisplayPinD5.Text)] := True;
    if cbDisplayPinD5.Text <> '0' then
      GPIO_Function[StrToInt(cbDisplayPinD5.Text)] := 'LCD D5';
    if cbDisplayPinD6.Text <> '0' then
      GPIO_Occupied[StrToInt(cbDisplayPinD6.Text)] := True;
    if cbDisplayPinD6.Text <> '0' then
      GPIO_Function[StrToInt(cbDisplayPinD6.Text)] := 'LCD D6';
    if cbDisplayPinD7.Text <> '0' then
      GPIO_Occupied[StrToInt(cbDisplayPinD7.Text)] := True;
    if cbDisplayPinD7.Text <> '0' then
      GPIO_Function[StrToInt(cbDisplayPinD7.Text)] := 'LCD D7';
  end;
  if rbEncoderDiscrete.Checked then
  begin
    if cbEncoderClockPin.Text <> '0' then
      GPIO_Occupied[StrToInt(cbEncoderClockPin.Text)] := True;
    if cbEncoderClockPin.Text <> '0' then
      GPIO_Function[StrToInt(cbEncoderClockPin.Text)] := 'ENC CLK/A';
    if cbEncoderDataPin.Text <> '0' then
      GPIO_Occupied[StrToInt(cbEncoderDataPin.Text)] := True;
    if cbEncoderDataPin.Text <> '0' then
      GPIO_Function[StrToInt(cbEncoderDataPin.Text)] := 'ENC DATA/B';
  end;
  //buttons
  if cbBtnPrev.Text <> '0' then
    GPIO_Occupied[StrToInt(cbBtnPrev.Text)] := True;
  if cbBtnPrev.Text <> '0' then
    GPIO_Function[StrToInt(cbBtnPrev.Text)] := 'Button';
  if cbBtnNext.Text <> '0' then
    GPIO_Occupied[StrToInt(cbBtnNext.Text)] := True;
  if cbBtnNext.Text <> '0' then
    GPIO_Function[StrToInt(cbBtnNext.Text)] := 'Button';
  if cbBtnBack.Text <> '0' then
    GPIO_Occupied[StrToInt(cbBtnBack.Text)] := True;
  if cbBtnBack.Text <> '0' then
    GPIO_Function[StrToInt(cbBtnBack.Text)] := 'Button';
  if cbBtnSelect.Text <> '0' then
    GPIO_Occupied[StrToInt(cbBtnSelect.Text)] := True;
  if cbBtnSelect.Text <> '0' then
    GPIO_Function[StrToInt(cbBtnSelect.Text)] := 'Button';
  if cbBtnHome.Text <> '0' then
    GPIO_Occupied[StrToInt(cbBtnHome.Text)] := True;
  if cbBtnHome.Text <> '0' then
    GPIO_Function[StrToInt(cbBtnHome.Text)] := 'Button';
  if cbBtnShortcut.Text <> '0' then
    GPIO_Occupied[StrToInt(cbBtnShortcut.Text)] := True;
  if cbBtnShortcut.Text <> '0' then
    GPIO_Function[StrToInt(cbBtnShortcut.Text)] := 'Button';

  if GPIO_Occupied[2] then sgGPIO.Cells[0, 1] := GPIO_Function[2];
  if GPIO_Occupied[3] then sgGPIO.Cells[0, 2] := GPIO_Function[3];
  if GPIO_Occupied[4] then sgGPIO.Cells[0, 3] := GPIO_Function[4];
  if GPIO_Occupied[17] then sgGPIO.Cells[0, 5] := GPIO_Function[17];
  if GPIO_Occupied[27] then sgGPIO.Cells[0, 6] := GPIO_Function[27];
  if GPIO_Occupied[22] then sgGPIO.Cells[0, 7] := GPIO_Function[22];
  if GPIO_Occupied[10] then sgGPIO.Cells[0, 9] := GPIO_Function[10];
  if GPIO_Occupied[9] then sgGPIO.Cells[0, 10] := GPIO_Function[9];
  if GPIO_Occupied[11] then sgGPIO.Cells[0, 11] := GPIO_Function[11];
  if GPIO_Occupied[5] then sgGPIO.Cells[0, 14] := GPIO_Function[5];
  if GPIO_Occupied[6] then sgGPIO.Cells[0, 15] := GPIO_Function[6];
  if GPIO_Occupied[13] then sgGPIO.Cells[0, 16] := GPIO_Function[13];
  if GPIO_Occupied[19] then sgGPIO.Cells[0, 17] := GPIO_Function[19];
  if GPIO_Occupied[26] then sgGPIO.Cells[0, 18] := GPIO_Function[26];
  if GPIO_Occupied[14] then sgGPIO.Cells[5, 3] := GPIO_Function[14];
  if GPIO_Occupied[15] then sgGPIO.Cells[5, 4] := GPIO_Function[15];
  if GPIO_Occupied[18] then sgGPIO.Cells[5, 5] := GPIO_Function[18];
  if GPIO_Occupied[23] then sgGPIO.Cells[5, 7] := GPIO_Function[23];
  if GPIO_Occupied[24] then sgGPIO.Cells[5, 8] := GPIO_Function[24];
  if GPIO_Occupied[25] then sgGPIO.Cells[5, 10] := GPIO_Function[25];
  if GPIO_Occupied[8] then sgGPIO.Cells[5, 11] := GPIO_Function[8];
  if GPIO_Occupied[7] then sgGPIO.Cells[5, 12] := GPIO_Function[7];
  if GPIO_Occupied[12] then sgGPIO.Cells[5, 15] := GPIO_Function[12];
  if GPIO_Occupied[16] then sgGPIO.Cells[5, 17] := GPIO_Function[16];
  if GPIO_Occupied[20] then sgGPIO.Cells[5, 18] := GPIO_Function[20];
  if GPIO_Occupied[21] then sgGPIO.Cells[5, 19] := GPIO_Function[21];

  slFreeGPIOs := TStringList.Create;
  slFreeGPIOs.Sorted := True;
  slFreeGPIOs.Duplicates := dupIgnore;
  slFreeGPIOs.Add('0');
  slButtons := TStringList.Create;
  slButtons.Sorted := True;
  slButtons.Duplicates := dupIgnore;
  slButtons.Add('0');
  for i := 2 to 27 do
    if GPIO_Occupied[i] = False then
    begin
      slFreeGPIOs.Add(IntToStr(i));
      slButtons.Add(IntToStr(i));
    end;
  for i := 2 to 27 do
  begin
    if GPIO_Function[i] = 'Button' then
      slButtons.Add(IntToStr(i));
  end;
  tmpItem := cbDisplayPinRW.Text;
  cbDisplayPinRW.Items.Clear;
  if slFreeGPIOs.IndexOf(tmpItem) = -1 then
    cbDisplayPinRW.Items.Add(tmpItem);
  cbDisplayPinRW.Items.AddStrings(slFreeGPIOs);
  cbDisplayPinRW.ItemIndex := cbDisplayPinRW.Items.IndexOf(tmpItem);

  tmpItem := cbDisplayPinRS.Text;
  cbDisplayPinRS.Items.Clear;
  if slFreeGPIOs.IndexOf(tmpItem) = -1 then
    cbDisplayPinRS.Items.Add(tmpItem);
  cbDisplayPinRS.Items.AddStrings(slFreeGPIOs);
  cbDisplayPinRS.ItemIndex := cbDisplayPinRS.Items.IndexOf(tmpItem);

  tmpItem := cbDisplayPinEN.Text;
  cbDisplayPinEN.Items.Clear;
  if slFreeGPIOs.IndexOf(tmpItem) = -1 then
    cbDisplayPinEN.Items.Add(tmpItem);
  cbDisplayPinEN.Items.AddStrings(slFreeGPIOs);
  cbDisplayPinEN.ItemIndex := cbDisplayPinEN.Items.IndexOf(tmpItem);

  tmpItem := cbDisplayPinD4.Text;
  cbDisplayPinD4.Items.Clear;
  if slFreeGPIOs.IndexOf(tmpItem) = -1 then
    cbDisplayPinD4.Items.Add(tmpItem);
  cbDisplayPinD4.Items.AddStrings(slFreeGPIOs);
  cbDisplayPinD4.ItemIndex := cbDisplayPinD4.Items.IndexOf(tmpItem);

  tmpItem := cbDisplayPinD5.Text;
  cbDisplayPinD5.Items.Clear;
  if slFreeGPIOs.IndexOf(tmpItem) = -1 then
    cbDisplayPinD5.Items.Add(tmpItem);
  cbDisplayPinD5.Items.AddStrings(slFreeGPIOs);
  cbDisplayPinD5.ItemIndex := cbDisplayPinD5.Items.IndexOf(tmpItem);

  tmpItem := cbDisplayPinD6.Text;
  cbDisplayPinD6.Items.Clear;
  if slFreeGPIOs.IndexOf(tmpItem) = -1 then
    cbDisplayPinD6.Items.Add(tmpItem);
  cbDisplayPinD6.Items.AddStrings(slFreeGPIOs);
  cbDisplayPinD6.ItemIndex := cbDisplayPinD6.Items.IndexOf(tmpItem);

  tmpItem := cbDisplayPinD7.Text;
  cbDisplayPinD7.Items.Clear;
  if slFreeGPIOs.IndexOf(tmpItem) = -1 then
    cbDisplayPinD7.Items.Add(tmpItem);
  cbDisplayPinD7.Items.AddStrings(slFreeGPIOs);
  cbDisplayPinD7.ItemIndex := cbDisplayPinD7.Items.IndexOf(tmpItem);

  tmpItem := cbEncoderClockPin.Text;
  cbEncoderClockPin.Items.Clear;
  if slFreeGPIOs.IndexOf(tmpItem) = -1 then
    cbEncoderClockPin.Items.Add(tmpItem);
  cbEncoderClockPin.Items.AddStrings(slFreeGPIOs);
  cbEncoderClockPin.ItemIndex := cbEncoderClockPin.Items.IndexOf(tmpItem);

  tmpItem := cbEncoderDataPin.Text;
  cbEncoderDataPin.Items.Clear;
  if slFreeGPIOs.IndexOf(tmpItem) = -1 then
    cbEncoderDataPin.Items.Add(tmpItem);
  cbEncoderDataPin.Items.AddStrings(slFreeGPIOs);
  cbEncoderDataPin.ItemIndex := cbEncoderDataPin.Items.IndexOf(tmpItem);

  //buttons
  tmpItem := cbBtnPrev.Text;
  cbBtnPrev.Items.Clear;
  if slButtons.IndexOf(tmpItem) = -1 then
    cbBtnPrev.Items.Add(tmpItem);
  cbBtnPrev.Items.AddStrings(slButtons);
  cbBtnPrev.ItemIndex := cbBtnPrev.Items.IndexOf(tmpItem);

  tmpItem := cbBtnNext.Text;
  cbBtnNext.Items.Clear;
  if slButtons.IndexOf(tmpItem) = -1 then
    cbBtnNext.Items.Add(tmpItem);
  cbBtnNext.Items.AddStrings(slButtons);
  cbBtnNext.ItemIndex := cbBtnNext.Items.IndexOf(tmpItem);

  tmpItem := cbBtnBack.Text;
  cbBtnBack.Items.Clear;
  if slButtons.IndexOf(tmpItem) = -1 then
    cbBtnBack.Items.Add(tmpItem);
  cbBtnBack.Items.AddStrings(slButtons);
  cbBtnBack.ItemIndex := cbBtnBack.Items.IndexOf(tmpItem);

  tmpItem := cbBtnSelect.Text;
  cbBtnSelect.Items.Clear;
  if slButtons.IndexOf(tmpItem) = -1 then
    cbBtnSelect.Items.Add(tmpItem);
  cbBtnSelect.Items.AddStrings(slButtons);
  cbBtnSelect.ItemIndex := cbBtnSelect.Items.IndexOf(tmpItem);

  tmpItem := cbBtnHome.Text;
  cbBtnHome.Items.Clear;
  if slButtons.IndexOf(tmpItem) = -1 then
    cbBtnHome.Items.Add(tmpItem);
  cbBtnHome.Items.AddStrings(slButtons);
  cbBtnHome.ItemIndex := cbBtnHome.Items.IndexOf(tmpItem);

  tmpItem := cbBtnShortcut.Text;
  cbBtnShortcut.Items.Clear;
  if slButtons.IndexOf(tmpItem) = -1 then
    cbBtnShortcut.Items.Add(tmpItem);
  cbBtnShortcut.Items.AddStrings(slButtons);
  cbBtnShortcut.ItemIndex := cbBtnShortcut.Items.IndexOf(tmpItem);

  slFreeGPIOs.Free;
  slButtons.Free;
end;

procedure TfrmMain.tbbtSendVoiceDumpClick(Sender: TObject);
var
  bankStream: TMemoryStream;
  err: PmError;
begin
  if FMidiOutInt <> -1 then
  begin
    try
      bankStream := TMemoryStream.Create;
      FSlotsDX.SysExBankToStream(bankStream);
      err := MidiOutput.SendSysEx(FMidiOutInt, bankStream);
      if (err = 0)
        {$IFNDEF WINDOWS}
        or (err = 1)
        {$ENDIF}
      then
      begin
        PopUp('Bank sent', 3);
      end
      else
        PopUp('Bank sending failed!' + #13 + 'Error message:' +
          #13 + Pm_GetErrorText(err), 3);
    finally
      bankStream.Free;
    end;
  end
  else
  begin
    ShowMessage('Please set-up the MIDI Output first');
    pcMain.ActivePage := tsSettings;
  end;
end;

procedure TfrmMain.SendSingleVoice(aCh, aVoiceNr: integer);
var
  voiceStream: TMemoryStream;
  tmpVoice: TDX7VoiceContainer;
  err: PmError;
begin
  if FMidiOutInt <> -1 then
  begin
    try
      voiceStream := TMemoryStream.Create;
      tmpVoice := TDX7VoiceContainer.Create;
      FSlotsDX.GetVoice(aVoiceNr, tmpVoice);
      tmpVoice.SysExVoiceToStream(aCh, voiceStream);
      err := MidiOutput.SendSysEx(FMidiOutInt, voiceStream);
      if (err = 0)
        {$IFNDEF WINDOWS}
        or (err = 1)
        {$ENDIF}
      then
      begin
        PopUp('Voice' + #13 + 'sent', 3);
      end
      else
        PopUp('Voice sending failed!' + #13 + 'Error message:' +
          #13 + Pm_GetErrorText(err), 3);
    finally
      voiceStream.Free;
      tmpVoice.Free;
    end;
  end
  else
  begin
    ShowMessage('Please set-up the MIDI Output first');
    pcMain.ActivePage := tsSettings;
  end;
end;

procedure TfrmMain.rbSoundDevOtherChange(Sender: TObject);
begin
  edSoundDevOther.Enabled := rbSoundDevOther.Checked;
end;

procedure TfrmMain.rbSoundDevPWMChange(Sender: TObject);
begin
  if rbSoundDevPWM.Checked then
  begin
    edSoundDevi2sAddr.Enabled := False;
    edSoundDevOther.Enabled := False;
    CalculateGPIO;
  end;
end;

procedure TfrmMain.seFontSizeChange(Sender: TObject);
begin
  frmMain.Font.Height := seFontSize.Value;
  frmMain.Invalidate;
end;

procedure TfrmMain.sgCategoriesDrawCell(Sender: TObject; aCol, aRow: integer;
  aRect: TRect; aState: TGridDrawState);
begin
  Unused(aRow, aRect, aState);
  if (aCol = 0) then with TStringGrid(Sender) do if (ControlCount > 0) then
        TStringCellEditor(Controls[0]).MaxLength := 32;
  if (aCol = 1) then with TStringGrid(Sender) do if (ControlCount > 0) then
        TStringCellEditor(Controls[0]).MaxLength := 256;
end;

procedure TfrmMain.sgDBAfterSelection(Sender: TObject; aCol, aRow: integer);
begin
  Unused(aCol);
  lastSelectedRow := aRow;
end;

procedure TfrmMain.sgDBBeforeSelection(Sender: TObject; aCol, aRow: integer);
var
  c: integer;
begin
  Unused(aCol);
  for c := 0 to 3 do
  begin
    compArray[c] := sgDB.Cells[c, aRow];
  end;
end;

procedure TfrmMain.sgDBDragOver(Sender, Source: TObject; X, Y: integer;
  State: TDragState; var Accept: boolean);
begin
  Unused(State, X, Y);
  if Source = sgDB then Accept := False;
end;

procedure TfrmMain.sgDBEditingDone(Sender: TObject);
var
  chg: boolean;
  c: integer;
begin
  chg := False;
  if lastSelectedRow <> -1 then
  begin
    for c := 0 to 3 do
      if compArray[c] <> sgDB.Cells[c, lastSelectedRow] then chg := True;
    if chg then compList.Add(IntToStr(lastSelectedRow));
  end;
end;

procedure TfrmMain.sgDBStartDrag(Sender: TObject; var DragObject: TDragObject);
var
  P: TPoint;
  PCol, PRow: longint;
begin
  Unused(DragObject);
  GetCursorPos(p);
  with sgDB do
  begin
    P := ScreenToClient(P);
    MouseToCell(P.x, P.y, PCol, PRow);
  end;
  if PRow <> -1 then
    dragItem := PRow;
end;

procedure TfrmMain.sgGPIODrawCell(Sender: TObject; aCol, aRow: integer;
  aRect: TRect; aState: TGridDrawState);
begin
  Unused(aState);
  if aRow <= 12 then
  begin
    sgGPIO.Canvas.Brush.Color := clWhite;
    sgGPIO.Canvas.FillRect(aRect);
    sgGPIO.Canvas.TextOut(aRect.Left + 2, aRect.Top + 2, sgGPIO.Cells[aCol, aRow]);
  end
  else
  begin
    sgGPIO.Canvas.Brush.Color := clGray;
    sgGPIO.Canvas.FillRect(aRect);
    sgGPIO.Canvas.TextOut(aRect.Left + 2, aRect.Top + 2, sgGPIO.Cells[aCol, aRow]);
  end;
end;

procedure TfrmMain.sgSDPerfFilesDblClick(Sender: TObject);
var
  path: string;
begin
  if (sgSDPerfFiles.RowCount > sgPerfDragItem) and (sgPerfDragItem <> 0) then
    if trim(sgSDPerfFiles.Cells[0, sgPerfDragItem]) <> '' then
    begin
      path := IncludeTrailingPathDelimiter(LastSDCardDir + 'performance') +
        sgSDPerfFiles.Cells[0, sgPerfDragItem] + '_' +
        sgSDPerfFiles.Cells[2, sgPerfDragItem];
      if FileExists(path) then
      begin
        LastPerfOpenDir := IncludeTrailingPathDelimiter(ExtractFileDir(path));
        LastPerf := path;
        OpenPerformance(path);
        pnHint.Visible := False;
        pcMain.ActivePage := tsPerformance;
        pcTGs.ActivePage := tsTG1_4;
      end;
    end;
end;

procedure TfrmMain.sgSDPerfFilesDragDrop(Sender, Source: TObject; X, Y: integer);
var
  DestCol, DestRow: integer;
  tempCell1, tempCell2: string;
begin
  Unused(Source);
  sgSDPerfFiles.MouseToCell(X, Y, DestCol, DestRow);
  tempCell1 := sgSDPerfFiles.Cells[0, DestRow];
  tempCell2 := sgSDPerfFiles.Cells[2, DestRow];
  sgSDPerfFiles.Cells[0, DestRow] := sgSDPerfFiles.Cells[0, sgPerfDragItem];
  sgSDPerfFiles.Cells[2, DestRow] := sgSDPerfFiles.Cells[2, sgPerfDragItem];
  sgSDPerfFiles.Cells[0, sgPerfDragItem] := tempCell1;
  sgSDPerfFiles.Cells[2, sgPerfDragItem] := tempCell2;
end;

procedure TfrmMain.sgSDPerfFilesDragOver(Sender, Source: TObject;
  X, Y: integer; State: TDragState; var Accept: boolean);
var
  CurrentCol, CurrentRow: integer;
begin
  Unused(State);
  sgSDPerfFiles.MouseToCell(X, Y, CurrentCol, CurrentRow);
  Accept := (Sender = Source) and (CurrentCol > 0) and (CurrentRow > 0);
end;

procedure TfrmMain.sgSDPerfFilesMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  SourceCol: integer;
begin
  Unused(Shift, Button);
  sgSDPerfFiles.MouseToCell(X, Y, SourceCol, sgPerfDragItem);
  if sgPerfDragItem > 0 then
    sgSDPerfFiles.BeginDrag(False, 4);
end;

procedure TfrmMain.sgSDSysExFilesDblClick(Sender: TObject);
var
  path: string;
  dmp: TMemoryStream;
  i, j: integer;
  nr: integer;
begin
  if (sgSDSysExFiles.RowCount > sgSyxDragItem) and (sgSyxDragItem <> 0) then
    if trim(sgSDSysExFiles.Cells[0, sgSyxDragItem]) <> '' then
    begin
      path := IncludeTrailingPathDelimiter(LastSDCardDir + 'sysex' +
        PathDelim + 'voice') + sgSDSysExFiles.Cells[0, sgSyxDragItem] +
        '_' + sgSDSysExFiles.Cells[2, sgSyxDragItem];
      if FileExists(path) then
      begin
        dmp := TMemoryStream.Create;
        dmp.LoadFromFile(path);
        i := 0;
        j := 0;
        if ContainsDX7BankDump(dmp, i, j) then
        begin
          FSlotsDX.LoadBankFromStream(dmp, j);
          for nr := 0 to 31 do
          begin
            TLabeledEdit(FindComponent(Format('edSlot%.2d', [nr + 1]))).Text :=
              FSlotsDX.GetVoiceName(nr + 1);
          end;
        end;
        dmp.Free;
        pcMain.ActivePage := tsLibrarian;
        pcBankPerformanceSlots.ActivePage := tsBankSlots;
      end;
    end;
end;

procedure TfrmMain.sgSDSysExFilesDragDrop(Sender, Source: TObject; X, Y: integer);
var
  DestCol, DestRow: integer;
  tempCell1, tempCell2: string;
begin
  Unused(Source);
  sgSDSysExFiles.MouseToCell(X, Y, DestCol, DestRow);
  tempCell1 := sgSDSysExFiles.Cells[0, DestRow];
  tempCell2 := sgSDSysExFiles.Cells[2, DestRow];
  sgSDSysExFiles.Cells[0, DestRow] := sgSDSysExFiles.Cells[0, sgSyxDragItem];
  sgSDSysExFiles.Cells[2, DestRow] := sgSDSysExFiles.Cells[2, sgSyxDragItem];
  sgSDSysExFiles.Cells[0, sgSyxDragItem] := tempCell1;
  sgSDSysExFiles.Cells[2, sgSyxDragItem] := tempCell2;
end;

procedure TfrmMain.sgSDSysExFilesDragOver(Sender, Source: TObject;
  X, Y: integer; State: TDragState; var Accept: boolean);
var
  CurrentCol, CurrentRow: integer;
begin
  Unused(State);
  sgSDSysExFiles.MouseToCell(X, Y, CurrentCol, CurrentRow);
  Accept := (Sender = Source) and (CurrentCol > 0) and (CurrentRow > 0);
end;

procedure TfrmMain.sgSDSysExFilesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  SourceCol: integer;
begin
  Unused(Button, Shift);
  sgSDSysExFiles.MouseToCell(X, Y, SourceCol, sgSyxDragItem);
  if sgSyxDragItem > 0 then
    sgSDSysExFiles.BeginDrag(False, 4);
end;

procedure TfrmMain.sgSDSysExFilesValidateEntry(Sender: TObject;
  aCol, aRow: integer; const OldValue: string; var NewValue: string);
var
  i: integer;
begin
  for i := 1 to sgSDSysExFiles.RowCount - 1 do
  begin
    if (aCol = 1) and (aRow <> i) then
      if sgSDSysExFiles.Cells[1, i] = NewValue then
      begin
        PopUp('Conflict', 2);
        NewValue := OldValue;
      end;
  end;
end;

procedure TfrmMain.slSliderChange(Sender: TObject);
var
  pt: TPoint;
  ctrl: TControl;
begin
  pt := ScreenToClient(Mouse.CursorPos);
  ctrl := ControlAtPos(pt, [capfRecursive, capfAllowWinControls]);
  if Assigned(ctrl) then
  begin
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

    if ctrl.Parent = pnHint then Exit;
    pnHint.Parent := ctrl.Parent;
    pnHint.Left := ctrl.Left + ctrl.Width - lbHint.Width;
    pnHint.Top := ctrl.Top + (ctrl.Height div 2) - (lbHint.Height div 2);
    pnHint.Visible := True;
  end;
end;

procedure TfrmMain.slSliderMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  Unused(Button, Shift);
  Unused(X, Y);
  pnHint.Visible := False;
end;

procedure TfrmMain.swMIDIThruEnableChange(Sender: TObject);
begin
  cbMIDIThruFrom.Enabled := swMIDIThruEnable.Checked;
  cbMIDIThruTo.Enabled := swMIDIThruEnable.Checked;
  if not cbMIDIThruFrom.Enabled then cbMIDIThruFrom.ItemIndex := -1;
  if not cbMIDIThruTo.Enabled then cbMIDIThruTo.ItemIndex := -1;
end;

procedure TfrmMain.tbbtCommitClick(Sender: TObject);
var
  i: integer;
  nr: integer;
  FName, FCategory, FOrigin, FId: string;
begin
  for i := 0 to compList.Count - 1 do
  begin
    nr := StrToInt(compList[i]);
    FName := sgDB.Cells[0, nr];
    FCategory := sgDB.Cells[1, nr];
    FOrigin := sgDB.Cells[2, nr];
    FId := sgDB.Cells[3, nr];
    myDBGridCommit(FId, FName, FCategory, FOrigin);
  end;
  compList.Clear;
end;

procedure TfrmMain.tbbtLoadPerformanceClick(Sender: TObject);
begin
  if OpenPerformanceDialog1.Execute then
  begin
    LastPerfOpenDir := IncludeTrailingPathDelimiter(
      ExtractFileDir(OpenPerformanceDialog1.FileName));
    LastPerf := OpenPerformanceDialog1.FileName;
    OpenPerformance(OpenPerformanceDialog1.FileName);
    pnHint.Visible := False;
  end;
end;

procedure TfrmMain.tbbtOpenINIFilesClick(Sender: TObject);
var
  ini: TMiniINIFile;
  tmpStr: string;
  tmpInt: integer;
  resWidth: string;
  resHeight: string;
begin
  if OpenMiniDexedINI.Execute then
  begin
    try
      ini := TMiniINIFile.Create;
      ini.LoadFromFile(OpenMiniDexedINI.FileName);
      mmINIComments.Lines.Clear;
      mmINIComments.Lines.Insert(0, ini.ReadString('CommentLine1', ''));
      mmINIComments.Lines.Insert(1, ini.ReadString('CommentLine2', ''));
      mmINIComments.Lines.Insert(2, ini.ReadString('CommentLine3', ''));
      mmINIComments.SelStart := 0;
      tmpStr := ini.ReadString('SoundDevice', 'pwm');
      edSoundDevi2sAddr.Enabled := False;
      edSoundDevOther.Enabled := False;
      case tmpStr of
        'pwm': rbSoundDevPWM.Checked := True;
        'i2s': begin
          rbSoundDevi2s.Checked := True;
          edSoundDevi2sAddr.Enabled := True;
          tmpStr := ini.ReadString('DACI2CAddress', '0');
          tmpInt := 0;
          if pos('0x', tmpStr) > 0 then tmpInt := Hex2Dec(ReplaceStr(tmpStr, '0x', '$'))
          else
            tmpInt := StrToInt(tmpStr);
          edSoundDevi2sAddr.Text := IntToStr(tmpInt);
        end;
        'hdmi': rbSoundDevHDMI.Checked := True;
        else
        begin
          rbSoundDevOther.Checked := True;
          edSoundDevOther.Enabled := True;
        end;
      end;
      cbSoundDevSampleRate.ItemIndex :=
        cbSoundDevSampleRate.Items.IndexOf(ini.ReadString('SampleRate', '48000'));
      tmpStr := ini.ReadString('ChunkSize', '');
      if tmpStr = '' then cbSoundDevChunkSize.ItemIndex := 0
      else
        cbSoundDevChunkSize.ItemIndex := cbSoundDevChunkSize.Items.IndexOf(tmpStr);
      swSoundDevSwapCh.Checked := boolean(ini.ReadInteger('ChannelsSwapped', 0) and 1);

      edMIDIBaudRate.Text := ini.ReadString('MIDIBaudRate', '31250');
      tmpStr := ini.ReadString('MIDIThru', '');
      swMIDIThruEnable.Checked := tmpStr <> '';
      if swMIDIThruEnable.Checked then
      begin
        cbMIDIThruFrom.Enabled := True;
        cbMIDIThruTo.Enabled := True;
        cbMIDIThruFrom.ItemIndex :=
          cbMIDIThruFrom.Items.IndexOf(copy(tmpStr, 0, pos(',', tmpStr) - 1));
        cbMIDIThruTo.ItemIndex :=
          cbMIDIThruTo.Items.IndexOf(copy(tmpStr, pos(',', tmpStr) + 1, Length(tmpStr)));
      end
      else
      begin
        cbMIDIThruFrom.Enabled := False;
        cbMIDIThruTo.Enabled := False;
        cbMIDIThruFrom.ItemIndex := -1;
        cbMIDIThruTo.ItemIndex := -1;
      end;
      swMIDIProgChange.Checked :=
        boolean(ini.ReadInteger('MIDIRXProgramChange', 1) and 1);
      rbDisplayNone.Checked := boolean(ini.ReadInteger('LCDEnabled', 0) and 0);
      tmpStr := ini.ReadString('LCDI2CAddress', '0');
      tmpInt := 0;
      if pos('0x', tmpStr) > 0 then tmpInt := Hex2Dec(ReplaceStr(tmpStr, '0x', '$'))
      else
        tmpInt := StrToInt(tmpStr);
      if (tmpInt = 0) and not rbDisplayNone.Checked then
      begin
        rbDisplayDiscrete.Checked := True;
        cbDisplayPinRW.Enabled := True;
        cbDisplayPinRS.Enabled := True;
        cbDisplayPinEN.Enabled := True;
        cbDisplayPinD4.Enabled := True;
        cbDisplayPinD5.Enabled := True;
        cbDisplayPinD6.Enabled := True;
        cbDisplayPinD7.Enabled := True;
        cbDisplayPinRW.ItemIndex :=
          cbDisplayPinRW.Items.IndexOf(ini.ReadString('LCDPinReadWrite', '0'));
        cbDisplayPinRS.ItemIndex :=
          cbDisplayPinRS.Items.IndexOf(ini.ReadString('LCDPinRegisterSelect', '4'));
        cbDisplayPinEN.ItemIndex :=
          cbDisplayPinEN.Items.IndexOf(ini.ReadString('LCDPinEnable', '17'));
        cbDisplayPinD4.ItemIndex :=
          cbDisplayPinD4.Items.IndexOf(ini.ReadString('LCDPinData4', '22'));
        cbDisplayPinD5.ItemIndex :=
          cbDisplayPinD5.Items.IndexOf(ini.ReadString('LCDPinData5', '23'));
        cbDisplayPinD6.ItemIndex :=
          cbDisplayPinD6.Items.IndexOf(ini.ReadString('LCDPinData6', '24'));
        cbDisplayPinD7.ItemIndex :=
          cbDisplayPinD7.Items.IndexOf(ini.ReadString('LCDPinData7', '25'));
        edDisplayi2sAddr.Text := '0';
        edDisplayi2sAddr.Enabled := False;
        edDisplayi2sCols.Enabled := True;
        edDisplayi2sCols.Text := ini.ReadString('LCDColumns', '16');
        edDisplayi2sRows.Enabled := True;
        edDisplayi2sRows.Text := ini.ReadString('LCDRows', '2');
        cbDisplayResolution.Enabled := False;
      end;
      if (tmpInt <> 0) and not rbDisplayNone.Checked then
      begin
        rbDisplayi2cHD44780.Checked := True;
        edDisplayi2sAddr.Enabled := True;
        edDisplayi2sAddr.Text := IntToStr(tmpInt);
        edDisplayi2sCols.Enabled := True;
        edDisplayi2sCols.Text := ini.ReadString('LCDColumns', '16');
        edDisplayi2sRows.Enabled := True;
        edDisplayi2sRows.Text := ini.ReadString('LCDRows', '2');
        cbDisplayPinRW.Enabled := False;
        cbDisplayPinRS.Enabled := False;
        cbDisplayPinEN.Enabled := False;
        cbDisplayPinD4.Enabled := False;
        cbDisplayPinD5.Enabled := False;
        cbDisplayPinD6.Enabled := False;
        cbDisplayPinD7.Enabled := False;
        cbDisplayResolution.Enabled := False;
      end;
      tmpStr := ini.ReadString('SSD1306LCDI2CAddress', '0');
      tmpInt := 0;
      if pos('0x', tmpStr) > 0 then tmpInt := Hex2Dec(ReplaceStr(tmpStr, '0x', '$'))
      else
        tmpInt := StrToInt(tmpStr);
      if tmpInt <> 0 then
      begin
        resWidth := ini.ReadString('SSD1306LCDWidth', '128');
        resHeight := ini.ReadString('SSD1306LCDHeight', '32');
        cbDisplayResolution.ItemIndex :=
          cbDisplayResolution.Items.IndexOf(resWidth + 'x' + resHeight);
        cbDisplayResolutionChange(Self);
      end;
      rbEncoderNone.Checked := boolean(ini.ReadInteger('EncoderEnabled', 1) and 0);
      rbEncoderDiscrete.Checked := boolean(ini.ReadInteger('EncoderEnabled', 1) and 1);
      if rbEncoderNone.Checked then
      begin
        cbEncoderClockPin.Enabled := False;
        cbEncoderDataPin.Enabled := False;
      end;
      if rbEncoderDiscrete.Checked then
      begin
        cbEncoderClockPin.Enabled := True;
        cbEncoderDataPin.Enabled := True;
        cbEncoderClockPin.ItemIndex :=
          cbEncoderClockPin.Items.IndexOf(ini.ReadString('EncoderPinClock', '10'));
        cbEncoderDataPin.ItemIndex :=
          cbEncoderDataPin.Items.IndexOf(ini.ReadString('EncoderPinData', '9'));
      end;
      cbBtnPrev.ItemIndex :=
        cbBtnPrev.Items.IndexOf(ini.ReadString('ButtonPinPrev', '0'));
      cbBtnActionPrev.ItemIndex :=
        cbBtnActionPrev.Items.IndexOf(ini.ReadString('ButtonActionPrev', ''));
      cbBtnNext.ItemIndex :=
        cbBtnNext.Items.IndexOf(ini.ReadString('ButtonPinNext', '0'));
      cbBtnActionNext.ItemIndex :=
        cbBtnActionNext.Items.IndexOf(ini.ReadString('ButtonActionNext', ''));
      cbBtnBack.ItemIndex :=
        cbBtnBack.Items.IndexOf(ini.ReadString('ButtonPinBack', '11'));
      cbBtnActionBack.ItemIndex :=
        cbBtnActionBack.Items.IndexOf(ini.ReadString('ButtonActionBack', 'longpress'));

      cbBtnSelect.ItemIndex :=
        cbBtnSelect.Items.IndexOf(ini.ReadString('ButtonPinSelect', '11'));
      cbBtnActionSelect.ItemIndex :=
        cbBtnActionSelect.Items.IndexOf(ini.ReadString('ButtonActionSelect', 'click'));
      cbBtnHome.ItemIndex :=
        cbBtnHome.Items.IndexOf(ini.ReadString('ButtonPinHome', '11'));
      cbBtnActionHome.ItemIndex :=
        cbBtnActionHome.Items.IndexOf(ini.ReadString('ButtonActionHome',
        'doubleclick'));
      cbBtnShortcut.ItemIndex :=
        cbBtnShortcut.Items.IndexOf(ini.ReadString('ButtonPinShortcut', '11'));

      edBtnDblClickTOut.Text := ini.ReadString('DoubleClickTimeout', '400');
      edBtnLngPressTOut.Text := ini.ReadString('LongPressTimeout', '400');

      swDbgMIDIDump.Checked := boolean(ini.ReadInteger('MIDIDumpEnabled', 0) and 1);
      swDbgProfile.Checked := boolean(ini.ReadInteger('ProfileEnabled', 0) and 1);
      swPerfSelToLoad.Checked :=
        boolean(ini.ReadInteger('PerformanceSelectToLoad', 1) and 1);
      CalculateGPIO;
    finally
      ini.Free;
    end;
  end;
end;

procedure TfrmMain.tbbtRefreshClick(Sender: TObject);
begin
  myDBGridRefresh;
end;

procedure TfrmMain.tbbtSaveBankClick(Sender: TObject);
begin
  if SaveBankDialog1.Execute then
  begin
    FSlotsDX.SaveBankToSysExFile(SaveBankDialog1.FileName);
    LastSysExSaveDir := IncludeTrailingPathDelimiter(
      ExtractFileDir(SaveBankDialog1.FileName));
  end;
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
    TLabeledEdit(FindComponent(Format('edSlot%.2d', [i]))).Text :=
      FSlotsDX.GetVoiceName(i);
  end;
end;

procedure TfrmMain.tbbtSaveINIFilesClick(Sender: TObject);
var
  ini: TMiniINIFile;
  resWidth: string;
  resHeight: string;
begin
  if SaveMiniDexedINI.Execute then
  begin
    try
      ini := TMiniINIFile.Create;
      ini.InitMiniDexedINI;
      if mmINIComments.Lines.Count > 0 then
        ini.WriteString('CommentLine1', mmINIComments.Lines[0]);
      if mmINIComments.Lines.Count > 1 then
        ini.WriteString('CommentLine2', mmINIComments.Lines[1]);
      if mmINIComments.Lines.Count > 2 then
        ini.WriteString('CommentLine3', mmINIComments.Lines[2]);
      if rbSoundDevPWM.Checked then ini.WriteString('SoundDevice', 'pwm');
      if rbSoundDevi2s.Checked then
      begin
        ini.WriteString('SoundDevice', 'i2s');
        ini.WriteString('DACI2CAddress', StrToCHex(edSoundDevi2sAddr.Text));
      end;
      if rbSoundDevHDMI.Checked then ini.WriteString('SoundDevice', 'hdmi');
      if rbSoundDevOther.Checked then
        ini.WriteString('SoundDevice', edSoundDevOther.Text);
      ini.WriteString('SampleRate', cbSoundDevSampleRate.Text);
      if cbSoundDevChunkSize.ItemIndex <> 0 then
      begin
        ini.Uncomment('#ChunkSize');
        ini.WriteString('ChunkSize', cbSoundDevChunkSize.Text);
      end
      else
      begin
        if ini.NameExists('ChunkSize') then ini.Comment('ChunkSize');
      end;
      ini.WriteInteger('ChannelsSwapped', integer(swSoundDevSwapCh.Checked));
      ini.WriteString('MIDIBaudRate', edMIDIBaudRate.Text);
      ini.WriteInteger('MIDIRXProgramChange', integer(swMIDIProgChange.Checked));
      if swMIDIThruEnable.Checked then
      begin
        if not ini.NameExists('MIDIThru') then
        begin
          if ini.NameExists('#MIDIThru') then ini.Uncomment('#MIDIThru');
        end;
        if ini.NameExists('MIDIThru') then
          ini.WriteString('MIDIThru', cbMIDIThruFrom.Text + ',' + cbMIDIThruTo.Text);
      end
      else
      begin
        if ini.NameExists('MIDIThru') then ini.Comment('MIDIThru');
      end;
      //display
      if rbDisplayNone.Checked then ini.WriteString('LCDEnabled', '0');
      if rbDisplayi2cHD44780.Checked then
      begin
        ini.WriteString('LCDEnabled', '1');
        ini.WriteString('LCDI2CAddress', StrToCHex(edDisplayi2sAddr.Text));
        ini.WriteString('LCDColumns', edDisplayi2sCols.Text);
        ini.WriteString('LCDRows', edDisplayi2sRows.Text);
      end;
      if rbDisplayi2cSSD1306.Checked then
      begin
        resWidth := copy(cbDisplayResolution.Text, 1, 3);
        resHeight := copy(cbDisplayResolution.Text, 5, 2);
        ini.WriteString('LCDEnabled', '1');
        ini.WriteString('SSD1306LCDI2CAddress', StrToCHex(edDisplayi2sAddr.Text));
        ini.WriteString('SSD1306LCDWidth', resWidth);
        ini.WriteString('SSD1306LCDHeight', resHeight);
        ini.WriteString('LCDColumns', edDisplayi2sCols.Text);
        ini.WriteString('LCDRows', edDisplayi2sRows.Text);
      end;
      if rbDisplayDiscrete.Checked then
      begin
        ini.WriteString('LCDEnabled', '1');
        ini.WriteString('LCDI2CAddress', StrToCHex('0'));
        ini.WriteString('LCDPinReadWrite', cbDisplayPinRW.Text);
        ini.WriteString('LCDPinRegisterSelect', cbDisplayPinRS.Text);
        ini.WriteString('LCDPinEnable', cbDisplayPinEN.Text);
        ini.WriteString('LCDPinData4', cbDisplayPinD4.Text);
        ini.WriteString('LCDPinData5', cbDisplayPinD5.Text);
        ini.WriteString('LCDPinData6', cbDisplayPinD6.Text);
        ini.WriteString('LCDPinData7', cbDisplayPinD7.Text);
        ini.WriteString('LCDColumns', edDisplayi2sCols.Text);
        ini.WriteString('LCDRows', edDisplayi2sRows.Text);
      end;
      //encoder
      if rbEncoderNone.Checked then ini.WriteInteger('EncoderEnabled', 0);
      if rbEncoderDiscrete.Checked then
      begin
        ini.WriteInteger('EncoderEnabled', 1);
        ini.WriteString('EncoderPinClock', cbEncoderClockPin.Text);
        ini.WriteString('EncoderPinData', cbEncoderDataPin.Text);
      end;
      //buttons
      ini.WriteString('ButtonPinPrev', cbBtnPrev.Text);
      ini.WriteString('ButtonActionPrev', cbBtnActionPrev.Text);
      ini.WriteString('ButtonPinNext', cbBtnNext.Text);
      ini.WriteString('ButtonActionNext', cbBtnActionNext.Text);
      ini.WriteString('ButtonPinBack', cbBtnBack.Text);
      ini.WriteString('ButtonActionBack', cbBtnActionBack.Text);
      ini.WriteString('ButtonPinSelect', cbBtnSelect.Text);
      ini.WriteString('ButtonActionSelect', cbBtnActionSelect.Text);
      ini.WriteString('ButtonPinHome', cbBtnHome.Text);
      ini.WriteString('ButtonActionHome', cbBtnActionHome.Text);
      ini.WriteString('ButtonPinShortcut', cbBtnShortcut.Text);
      ini.WriteString('DoubleClickTimeout', edBtnDblClickTOut.Text);
      ini.WriteString('LongPressTimeout', edBtnLngPressTOut.Text);
      //debug
      ini.WriteInteger('MIDIDumpEnabled', integer(swDbgMIDIDump.Checked));
      ini.WriteInteger('ProfileEnabled', integer(swDbgProfile.Checked));
      ini.WriteInteger('PerformanceSelectToLoad', integer(swPerfSelToLoad.Checked));

      ini.SaveToFile(SaveMiniDexedINI.FileName);
    finally
      ini.Free;
    end;
  end;
end;

procedure TfrmMain.tbbtSavePerformanceClick(Sender: TObject);
var
  ini: TMiniINIFile;
  hexstream: TMemoryStream;
  hexstring: string;
begin
  SavePerformanceDialog1.InitialDir := LastPerfSaveDir;
  SavePerformanceDialog1.FileName := edPerfName.Text + '.ini';
  if SavePerformanceDialog1.Execute then
  begin
    LastPerfSaveDir := IncludeTrailingPathDelimiter(
      ExtractFileDir(SavePerformanceDialog1.FileName));
    LastPerf := SavePerformanceDialog1.FileName;
    ini := TMiniINIFile.Create;
    ini.InitPerformance(False);
    hexstream := TMemoryStream.Create;

    //MiniDexedCC-specific
    ini.WriteString('Name', edPerfName.Text);
    ini.WriteString('Category', cbPerfCategory.Text);
    ini.WriteString('Origin', edPerfOrigin.Text);

    //Standard
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
    FPerfSlotsDX[1].Save_VCED_ToStream(hexstream);
    hexstring := StreamToVCEDHex(hexstream);
    ini.WriteString('VoiceData1', hexstring);
    ini.WriteInteger('MonoMode1', byte(swMonoMode1.Checked));
    ini.WriteInteger('ModulationWheelRange1', trunc(slModWhRange1.Position));
    ini.WriteInteger('ModulationWheelTarget1',
      (byte(swModEG1.Checked) shl 2) + (byte(swModA1.Checked) shl 1) +
      byte(swModP1.Checked));
    ini.WriteInteger('FootControlRange1', trunc(slFootCtrlRange1.Position));
    ini.WriteInteger('FootControlTarget1',
      (byte(swFootEG1.Checked) shl 2) + (byte(swFootA1.Checked) shl 1) +
      byte(swFootP1.Checked));
    ini.WriteInteger('BreathControlRange1', trunc(slBreathCtrlRange1.Position));
    ini.WriteInteger('BreathControlTarget1',
      (byte(swBreathEG1.Checked) shl 2) + (byte(swBreathA1.Checked) shl 1) +
      byte(swBreathP1.Checked));
    ini.WriteInteger('AfterTouchRange1', trunc(slAfterTouchRange1.Position));
    ini.WriteInteger('AfterTouchTarget1',
      (byte(swAfterTouchEG1.Checked) shl 2) + (byte(swAfterTouchA1.Checked) shl 1) +
      byte(swAfterTouchP1.Checked));

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
    FPerfSlotsDX[2].Save_VCED_ToStream(hexstream);
    hexstring := StreamToVCEDHex(hexstream);
    ini.WriteString('VoiceData2', hexstring);
    ini.WriteInteger('MonoMode2', byte(swMonoMode2.Checked));
    ini.WriteInteger('ModulationWheelRange2', trunc(slModWhRange2.Position));
    ini.WriteInteger('ModulationWheelTarget2',
      (byte(swModEG2.Checked) shl 2) + (byte(swModA2.Checked) shl 1) +
      byte(swModP2.Checked));
    ini.WriteInteger('FootControlRange2', trunc(slFootCtrlRange2.Position));
    ini.WriteInteger('FootControlTarget2',
      (byte(swFootEG2.Checked) shl 2) + (byte(swFootA2.Checked) shl 1) +
      byte(swFootP2.Checked));
    ini.WriteInteger('BreathControlRange2', trunc(slBreathCtrlRange2.Position));
    ini.WriteInteger('BreathControlTarget2',
      (byte(swBreathEG2.Checked) shl 2) + (byte(swBreathA2.Checked) shl 1) +
      byte(swBreathP2.Checked));
    ini.WriteInteger('AfterTouchRange2', trunc(slAfterTouchRange2.Position));
    ini.WriteInteger('AfterTouchTarget2',
      (byte(swAfterTouchEG2.Checked) shl 2) + (byte(swAfterTouchA2.Checked) shl 1) +
      byte(swAfterTouchP2.Checked));

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
    FPerfSlotsDX[3].Save_VCED_ToStream(hexstream);
    hexstring := StreamToVCEDHex(hexstream);
    ini.WriteString('VoiceData3', hexstring);
    ini.WriteInteger('MonoMode3', byte(swMonoMode3.Checked));
    ini.WriteInteger('ModulationWheelRange3', trunc(slModWhRange3.Position));
    ini.WriteInteger('ModulationWheelTarget3',
      (byte(swModEG3.Checked) shl 2) + (byte(swModA3.Checked) shl 1) +
      byte(swModP3.Checked));
    ini.WriteInteger('FootControlRange3', trunc(slFootCtrlRange3.Position));
    ini.WriteInteger('FootControlTarget3',
      (byte(swFootEG3.Checked) shl 2) + (byte(swFootA3.Checked) shl 1) +
      byte(swFootP3.Checked));
    ini.WriteInteger('BreathControlRange3', trunc(slBreathCtrlRange3.Position));
    ini.WriteInteger('BreathControlTarget3',
      (byte(swBreathEG3.Checked) shl 2) + (byte(swBreathA3.Checked) shl 1) +
      byte(swBreathP3.Checked));
    ini.WriteInteger('AfterTouchRange3', trunc(slAfterTouchRange3.Position));
    ini.WriteInteger('AfterTouchTarget3',
      (byte(swAfterTouchEG3.Checked) shl 2) + (byte(swAfterTouchA3.Checked) shl 1) +
      byte(swAfterTouchP3.Checked));

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
    FPerfSlotsDX[4].Save_VCED_ToStream(hexstream);
    hexstring := StreamToVCEDHex(hexstream);
    ini.WriteString('VoiceData4', hexstring);
    ini.WriteInteger('MonoMode4', byte(swMonoMode4.Checked));
    ini.WriteInteger('ModulationWheelRange4', trunc(slModWhRange4.Position));
    ini.WriteInteger('ModulationWheelTarget4',
      (byte(swModEG4.Checked) shl 2) + (byte(swModA4.Checked) shl 1) +
      byte(swModP4.Checked));
    ini.WriteInteger('FootControlRange4', trunc(slFootCtrlRange4.Position));
    ini.WriteInteger('FootControlTarget4',
      (byte(swFootEG4.Checked) shl 2) + (byte(swFootA4.Checked) shl 1) +
      byte(swFootP4.Checked));
    ini.WriteInteger('BreathControlRange4', trunc(slBreathCtrlRange4.Position));
    ini.WriteInteger('BreathControlTarget4',
      (byte(swBreathEG4.Checked) shl 2) + (byte(swBreathA4.Checked) shl 1) +
      byte(swBreathP4.Checked));
    ini.WriteInteger('AfterTouchRange4', trunc(slAfterTouchRange4.Position));
    ini.WriteInteger('AfterTouchTarget4',
      (byte(swAfterTouchEG4.Checked) shl 2) + (byte(swAfterTouchA4.Checked) shl 1) +
      byte(swAfterTouchP4.Checked));

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
    FPerfSlotsDX[5].Save_VCED_ToStream(hexstream);
    hexstring := StreamToVCEDHex(hexstream);
    ini.WriteString('VoiceData5', hexstring);
    ini.WriteInteger('MonoMode5', byte(swMonoMode5.Checked));
    ini.WriteInteger('ModulationWheelRange5', trunc(slModWhRange5.Position));
    ini.WriteInteger('ModulationWheelTarget5',
      (byte(swModEG5.Checked) shl 2) + (byte(swModA5.Checked) shl 1) +
      byte(swModP5.Checked));
    ini.WriteInteger('FootControlRange5', trunc(slFootCtrlRange5.Position));
    ini.WriteInteger('FootControlTarget5',
      (byte(swFootEG5.Checked) shl 2) + (byte(swFootA5.Checked) shl 1) +
      byte(swFootP5.Checked));
    ini.WriteInteger('BreathControlRange5', trunc(slBreathCtrlRange5.Position));
    ini.WriteInteger('BreathControlTarget5',
      (byte(swBreathEG5.Checked) shl 2) + (byte(swBreathA5.Checked) shl 1) +
      byte(swBreathP5.Checked));
    ini.WriteInteger('AfterTouchRange5', trunc(slAfterTouchRange5.Position));
    ini.WriteInteger('AfterTouchTarget5',
      (byte(swAfterTouchEG5.Checked) shl 2) + (byte(swAfterTouchA5.Checked) shl 1) +
      byte(swAfterTouchP5.Checked));

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
    FPerfSlotsDX[6].Save_VCED_ToStream(hexstream);
    hexstring := StreamToVCEDHex(hexstream);
    ini.WriteString('VoiceData6', hexstring);
    ini.WriteInteger('MonoMode6', byte(swMonoMode6.Checked));
    ini.WriteInteger('ModulationWheelRange6', trunc(slModWhRange6.Position));
    ini.WriteInteger('ModulationWheelTarget6',
      (byte(swModEG6.Checked) shl 2) + (byte(swModA6.Checked) shl 1) +
      byte(swModP6.Checked));
    ini.WriteInteger('FootControlRange6', trunc(slFootCtrlRange6.Position));
    ini.WriteInteger('FootControlTarget6',
      (byte(swFootEG6.Checked) shl 2) + (byte(swFootA6.Checked) shl 1) +
      byte(swFootP6.Checked));
    ini.WriteInteger('BreathControlRange6', trunc(slBreathCtrlRange6.Position));
    ini.WriteInteger('BreathControlTarget6',
      (byte(swBreathEG6.Checked) shl 2) + (byte(swBreathA6.Checked) shl 1) +
      byte(swBreathP6.Checked));
    ini.WriteInteger('AfterTouchRange6', trunc(slAfterTouchRange6.Position));
    ini.WriteInteger('AfterTouchTarget6',
      (byte(swAfterTouchEG6.Checked) shl 2) + (byte(swAfterTouchA6.Checked) shl 1) +
      byte(swAfterTouchP6.Checked));

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
    FPerfSlotsDX[7].Save_VCED_ToStream(hexstream);
    hexstring := StreamToVCEDHex(hexstream);
    ini.WriteString('VoiceData7', hexstring);
    ini.WriteInteger('MonoMode7', byte(swMonoMode7.Checked));
    ini.WriteInteger('ModulationWheelRange7', trunc(slModWhRange7.Position));
    ini.WriteInteger('ModulationWheelTarget7',
      (byte(swModEG7.Checked) shl 2) + (byte(swModA7.Checked) shl 1) +
      byte(swModP7.Checked));
    ini.WriteInteger('FootControlRange7', trunc(slFootCtrlRange7.Position));
    ini.WriteInteger('FootControlTarget7',
      (byte(swFootEG7.Checked) shl 2) + (byte(swFootA7.Checked) shl 1) +
      byte(swFootP7.Checked));
    ini.WriteInteger('BreathControlRange7', trunc(slBreathCtrlRange7.Position));
    ini.WriteInteger('BreathControlTarget7',
      (byte(swBreathEG7.Checked) shl 2) + (byte(swBreathA7.Checked) shl 1) +
      byte(swBreathP7.Checked));
    ini.WriteInteger('AfterTouchRange7', trunc(slAfterTouchRange7.Position));
    ini.WriteInteger('AfterTouchTarget7',
      (byte(swAfterTouchEG7.Checked) shl 2) + (byte(swAfterTouchA7.Checked) shl 1) +
      byte(swAfterTouchP7.Checked));

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
    FPerfSlotsDX[8].Save_VCED_ToStream(hexstream);
    hexstring := StreamToVCEDHex(hexstream);
    ini.WriteString('VoiceData8', hexstring);
    ini.WriteInteger('MonoMode8', byte(swMonoMode8.Checked));
    ini.WriteInteger('ModulationWheelRange8', trunc(slModWhRange8.Position));
    ini.WriteInteger('ModulationWheelTarget8',
      (byte(swModEG8.Checked) shl 2) + (byte(swModA8.Checked) shl 1) +
      byte(swModP8.Checked));
    ini.WriteInteger('FootControlRange8', trunc(slFootCtrlRange8.Position));
    ini.WriteInteger('FootControlTarget8',
      (byte(swFootEG8.Checked) shl 2) + (byte(swFootA8.Checked) shl 1) +
      byte(swFootP8.Checked));
    ini.WriteInteger('BreathControlRange8', trunc(slBreathCtrlRange8.Position));
    ini.WriteInteger('BreathControlTarget8',
      (byte(swBreathEG8.Checked) shl 2) + (byte(swBreathA8.Checked) shl 1) +
      byte(swBreathP8.Checked));
    ini.WriteInteger('AfterTouchRange8', trunc(slAfterTouchRange8.Position));
    ini.WriteInteger('AfterTouchTarget8',
      (byte(swAfterTouchEG8.Checked) shl 2) + (byte(swAfterTouchA8.Checked) shl 1) +
      byte(swAfterTouchP8.Checked));

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
