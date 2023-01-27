{
 *****************************************************************************
  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************

 Author: Boban Spasic

}
//ToDo - open for more
//implement new minidexed.ini loading and saving
// TX802/816 class
// FM Heaven import
// FM7 import

unit untMain;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  {$IFDEF WINDOWS}
  Messages,
  {$ENDIF}
  SysUtils, StrUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, Grids, Spin, atshapeline, ECSlider, ECSwitch, ECEditBtns, ECLink,
  Types, LCLIntf, AdvLed, LazFileUtils, LCLType, LazUTF8
  {$IFDEF WINDOWS}
  ,MIDI, untUnPortMIDI
  {$ENDIF}
  {$IFDEF UNIX}
  ,untLinuxMIDI, PortMidi
  {$ENDIF}
  , untSQLProxy, untUtils, untCCBank, untCCVoice, untDX7Voice,
  untDX7IISupplement, untTX7Function, untDXUtils, untMiniINI, untPopUp,
  untDX7View, untDX7IIView, untTX7View, untMDXView, untMDXSupplement,
  untMDXPerformance, untPerfSelDlg;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    alMDX_01: TAdvLed;
    alDXII_10: TAdvLed;
    alDXII_11: TAdvLed;
    alDXII_12: TAdvLed;
    alDXII_13: TAdvLed;
    alDXII_14: TAdvLed;
    alDXII_15: TAdvLed;
    alDXII_16: TAdvLed;
    alDXII_17: TAdvLed;
    alDXII_18: TAdvLed;
    alDXII_19: TAdvLed;
    alDXII_20: TAdvLed;
    alDXII_21: TAdvLed;
    alDXII_22: TAdvLed;
    alDXII_23: TAdvLed;
    alDXII_24: TAdvLed;
    alDXII_25: TAdvLed;
    alDXII_26: TAdvLed;
    alDXII_27: TAdvLed;
    alDXII_28: TAdvLed;
    alDXII_29: TAdvLed;
    alDXII_30: TAdvLed;
    alDXII_31: TAdvLed;
    alDXII_01: TAdvLed;
    alDXII_02: TAdvLed;
    alDXII_03: TAdvLed;
    alDXII_04: TAdvLed;
    alDXII_05: TAdvLed;
    alDXII_06: TAdvLed;
    alDXII_07: TAdvLed;
    alDXII_08: TAdvLed;
    alDXII_09: TAdvLed;
    alMDX_02: TAdvLed;
    alMDX_03: TAdvLed;
    alMDX_04: TAdvLed;
    alMDX_05: TAdvLed;
    alMDX_06: TAdvLed;
    alMDX_07: TAdvLed;
    alMDX_08: TAdvLed;
    alTX7_10: TAdvLed;
    alTX7_11: TAdvLed;
    alTX7_12: TAdvLed;
    alTX7_13: TAdvLed;
    alTX7_14: TAdvLed;
    alTX7_15: TAdvLed;
    alTX7_16: TAdvLed;
    alTX7_17: TAdvLed;
    alTX7_18: TAdvLed;
    alTX7_19: TAdvLed;
    alTX7_20: TAdvLed;
    alTX7_21: TAdvLed;
    alTX7_22: TAdvLed;
    alTX7_23: TAdvLed;
    alTX7_24: TAdvLed;
    alTX7_25: TAdvLed;
    alTX7_26: TAdvLed;
    alTX7_27: TAdvLed;
    alTX7_28: TAdvLed;
    alTX7_29: TAdvLed;
    alTX7_30: TAdvLed;
    alTX7_31: TAdvLed;
    alTX7_32: TAdvLed;
    alDXII_32: TAdvLed;
    alTX7_01: TAdvLed;
    alTX7_02: TAdvLed;
    alTX7_03: TAdvLed;
    alTX7_04: TAdvLed;
    alTX7_05: TAdvLed;
    alTX7_06: TAdvLed;
    alTX7_07: TAdvLed;
    alTX7_08: TAdvLed;
    alTX7_09: TAdvLed;
    btSelectDir: TECSpeedBtnPlus;
    btSelSDCard: TECSpeedBtnPlus;
    btCatLoad: TButton;
    btCatSave: TButton;
    btDeleteVoiceDB: TButton;
    btDeleteCategoryDB: TButton;
    btSDCardRenameVoices: TButton;
    btSDCardRenamePerformances: TButton;
    btLoadPerfToEditor: TButton;
    cbAutoPreview: TCheckBox;
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
    cbMIDIBtnChannel: TComboBox;
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
    cgSanitize: TCheckGroup;
    edBtnDblClickTOut: TLabeledEdit;
    edBtnLngPressTOut: TLabeledEdit;
    edbtSelSDCard: TECEditBtn;
    edbtSelSysExDir: TECEditBtn;
    edDisplayi2sAddr: TLabeledEdit;
    edDisplayi2sCols: TLabeledEdit;
    edMIDIButBack: TLabeledEdit;
    edMIDIButHome: TLabeledEdit;
    edMIDIButSel: TLabeledEdit;
    edMIDIButPrev: TLabeledEdit;
    edDisplayi2sRows: TLabeledEdit;
    edMIDIButNext: TLabeledEdit;
    lbMIDIBtnChannel: TLabel;
    lbMIDIIgnAllNotesOff: TLabel;
    lbMIDIButtons: TLabel;
    lbLCDMirror: TLabel;
    lbLCD: TLabel;
    lbLCDRotate: TLabel;
    lbMIDIAutoDump: TLabel;
    lbTestbed: TLabel;
    lbPopUpDur: TLabel;
    mmResultSamples: TMemo;
    mmTestSamples: TMemo;
    pnMIDIButtons: TPanel;
    pnTestbed: TPanel;
    rbMIDIButOff: TRadioButton;
    rbMIDIButOn: TRadioButton;
    ShapeLine10: TShapeLine;
    swLCDMirror: TECSwitch;
    swLCDRotate: TECSwitch;
    swMIDIIgnAllNotesOff: TECSwitch;
    swMIDIAutoDump: TECSwitch;
    tbpnPreview: TPanel;
    sePopUpDur: TSpinEdit;
    tbrbSearchName: TRadioButton;
    tbrbSearchOrigin: TRadioButton;
    tbSearch: TEdit;
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
    lbCredits1: TLabel;
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
    lnkCredits1: TECLink;
    lnkCredits2: TECLink;
    lnkCredits3: TECLink;
    mmINIComments: TMemo;
    mmLog: TMemo;
    mmLogSettings: TMemo;
    OpenMiniDexedINI: TOpenDialog;
    lbHint: TLabel;
    OpenPerformanceDialog1: TOpenDialog;
    tbpnSearch: TPanel;
    pnCredits: TPanel;
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
    pnPGeneral: TPanel;
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
    tbSeparator4: TToolButton;
    tbbtSavePerfToDB: TToolButton;
    tbbtLoadPerfFromDB: TToolButton;
    tbbtDelPerfFromDB: TToolButton;
    tbSeparator5: TToolButton;
    tbbtDelVoice: TToolButton;
    tbSeparator6: TToolButton;
    tbbtSanitize: TToolButton;
    tsFiles: TTabSheet;
    tsDatabase: TTabSheet;
    tbBank: TToolBar;
    tbbtLoadPerformance: TToolButton;
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
    procedure alDXIIClick(Sender: TObject);
    procedure alMDXClick(Sender: TObject);
    procedure alTX7Click(Sender: TObject);
    procedure btCatLoadClick(Sender: TObject);
    procedure btCatSaveClick(Sender: TObject);
    procedure btDeleteCategoryDBClick(Sender: TObject);
    procedure btDeleteVoiceDBClick(Sender: TObject);
    procedure btLoadPerfToEditorClick(Sender: TObject);
    procedure btSDCardRenamePerformancesClick(Sender: TObject);
    procedure btSDCardRenameVoicesClick(Sender: TObject);
    procedure btSelectDirClick(Sender: TObject);
    procedure cbDisplayEncoderChange(Sender: TObject);
    procedure cbDisplayResolutionChange(Sender: TObject);
    procedure cbMidiInChange(Sender: TObject);
    procedure cbMidiOutChange(Sender: TObject);
    procedure btSelSDCardClick(Sender: TObject);
    procedure cgSanitizeItemClick(Sender: TObject; Index: integer);
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
    procedure lbFilesDblClick(Sender: TObject);
    procedure lbFilesStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure lbVoicesStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure lnkCreditsClick(Sender: TObject);
    procedure pnSlotClick(Sender: TObject);
    procedure rbDisplayDiscreteChange(Sender: TObject);
    procedure rbDisplayi2cHD44780Change(Sender: TObject);
    procedure rbDisplayi2cSSD1306Change(Sender: TObject);
    procedure rbEncoderDiscreteChange(Sender: TObject);
    procedure rbMIDIButOnChange(Sender: TObject);
    procedure rbSoundDevHDMIChange(Sender: TObject);
    procedure rbSoundDevi2sChange(Sender: TObject);
    procedure rbSoundDevOtherChange(Sender: TObject);
    procedure rbSoundDevPWMChange(Sender: TObject);
    procedure seFontSizeChange(Sender: TObject);
    procedure sePopUpDurChange(Sender: TObject);
    procedure sgCategoriesDrawCell(Sender: TObject; aCol, aRow: integer;
      aRect: TRect; aState: TGridDrawState);
    procedure sgDBAfterSelection(Sender: TObject; aCol, aRow: integer);
    procedure sgDBBeforeSelection(Sender: TObject; aCol, aRow: integer);
    procedure sgDBClick(Sender: TObject);
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
    procedure tbbtDelPerfFromDBClick(Sender: TObject);
    procedure tbbtDelVoiceClick(Sender: TObject);
    procedure tbbtLoadPerfFromDBClick(Sender: TObject);
    procedure tbbtLoadPerformanceClick(Sender: TObject);
    procedure tbbtOpenINIFilesClick(Sender: TObject);
    procedure tbbtRefreshClick(Sender: TObject);
    procedure tbbtSanitizeClick(Sender: TObject);
    procedure tbbtSaveBankClick(Sender: TObject);
    procedure RefreshSlots;
    procedure tbbtSaveINIFilesClick(Sender: TObject);
    procedure tbbtSavePerformanceClick(Sender: TObject);
    procedure CalculateGPIO;
    procedure tbbtSavePerfToDBClick(Sender: TObject);
    procedure tbbtSendVoiceDumpClick(Sender: TObject);
    procedure SendSingleVoice(aCh, aVoiceNr: integer);
    procedure LoadLastStateBank;
    procedure FillFilesList(aFolder: string);
    procedure OpenSysEx(aName: string);
    procedure LoadPerformance(aName: string);
    procedure tbExtractPerfVoicesToDBClick(Sender: TObject);
    procedure tbSearchKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure tbStoreToDBClick(Sender: TObject);
    procedure LoadSDCard(dir: string);
    procedure PerfToGUI;
    procedure GUIToPerf;
    procedure SendSimpleMelody(aCh: integer);
    function SanitizeNames(tmp: string): string;

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
  dragItem:    integer;
  sgSyxDragItem: integer;
  sgPerfDragItem: integer;
  FTmpCCBank:  TCCBankContainer;
  //FSupplBankDXII: TDX7IISupplBankContainer;
  //FFunctBankTX7: TTX7FunctBankContainer;
  FSlotsDX:    TCCBankContainer;
  FPerfSlotsDX: array [1..8] of TCCVoiceContainer;
  FPerformance: TMDXPerformanceContainer;
  FMidiIn:     string;
  FMidiInInt:  integer;
  FMidiOut:    string;
  FMidiOutInt: integer;
  FMidiIsActive: boolean;
  frmMain:     TfrmMain;
  LastSysExOpenDir: string;
  LastSysExSaveDir: string;
  LastSysEx:   string;
  LastPerfOpenDir: string;
  LastPerfSaveDir: string;
  LastPerf:    string;
  LastSDCardDir: string;
  FUpdatingForm: boolean;
  HD44780Addr: string;
  SSD1306Addr: string;
  DBName:      string;
  HomeDir:     string;
  //AppDir: string;
  SDCardSysExFiles: TStringList;
  SDCardPerfFiles: TStringList;
  compArray:   array [0..3] of string;
  compList:    TStringList;
  LastSelectedRow: integer;
  SQLProxy:    TSQLProxy;
  LastClickedFile: integer;
  PopUpDuration: integer;

implementation

{$R *.lfm}

{$IFDEF WINDOWS}
//uses JWAwindows;
{$ENDIF}

{ TfrmMain }

procedure TfrmMain.tbExtractPerfVoicesToDBClick(Sender: TObject);
var
  voiceStream: TMemoryStream;
  extraStream: TMemoryStream;
  i: integer;
  version: integer;
  FName, FCat, FOrigin, FHash: string;
begin
  GUIToPerf;
  for i := 1 to 8 do
  begin
    try
      voiceStream := TMemoryStream.Create;
      extraStream := TMemoryStream.Create;
      version := 3; //PCEDx
      voiceStream.WriteBuffer(FPerformance.FMDX_Params.TG[i].VoiceData,
        SizeOf(FPerformance.FMDX_Params.TG[i].VoiceData));
      extraStream.WriteBuffer(FPerformance.FMDX_Params.TG[i].SupplData,
        SizeOf(FPerformance.FMDX_Params.TG[i].SupplData));
      FName := FPerformance.GetTGVoiceName(i);
      FCat := FPerformance.FMDX_Params.General.Category;
      FOrigin := FPerformance.FMDX_Params.General.Origin;
      FHash := FPerformance.CalculateTGHash(i);
      SQLProxy.AddBinVoice(FHash, FName, FCat, FOrigin, version,
        voiceStream, extraStream);

    finally
      voiceStream.Free;
      extraStream.Free;
    end;
  end;
  PopUp('Done!', PopUpDuration);
end;

procedure TfrmMain.tbSearchKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  Unused(Shift);
  if Key = VK_RETURN then tbbtRefresh.Click;
end;

procedure TfrmMain.tbStoreToDBClick(Sender: TObject);
var
  voiceStream: TMemoryStream;
  tmpVoice: TDX7VoiceContainer;
  extraStream: TMemoryStream;
  tmpSuppl: TDX7IISupplementContainer;
  tmpFunct: TTX7FunctionContainer;
  version: integer; // 0 - no_extras, 1 - ACED, 2 - PCED
  i: integer;
begin
  for i := 1 to 32 do
  begin
    try
      voiceStream := TMemoryStream.Create;
      tmpVoice := TDX7VoiceContainer.Create;
      extraStream := TMemoryStream.Create;
      tmpSuppl := TDX7IISupplementContainer.Create;
      tmpFunct := TTX7FunctionContainer.Create;

      FSlotsDX.CGetVoice(i, tmpVoice);
      tmpVoice.Save_VCED_ToStream(voiceStream);
      version := 0;
      if FSlotsDX.HasSuppl(i) then
      begin
        FSlotsDX.CGetSupplement(i, tmpSuppl);
        tmpSuppl.Save_ACED_ToStream(extraStream);
        version := 1;
      end;
      if FSlotsDX.HasFunct(i) then
      begin
        FSlotsDX.CGetFunction(i, tmpFunct);
        tmpFunct.Save_PCED_ToStream(extraStream);
        version := 2;
      end;

      SQLProxy.AddBinVoice(tmpVoice.CalculateHash, tmpVoice.GetVoiceName,
        cbVoicesCategory.Text, edVoicesOrigin.Text, version,
        voiceStream, extraStream);

      {SQLProxy.AddVoice(tmpVoice.CalculateHash, tmpVoice.GetVoiceName,
        cbVoicesCategory.Text, SysExStreamToStr(voiceStream),
        SysExStreamToStr(supplStream), edVoicesOrigin.Text);  }

    finally
      voiceStream.Free;
      tmpVoice.Free;
      extraStream.Free;
      tmpSuppl.Free;
      tmpFunct.Free;
    end;
  end;
  PopUp('Done!', PopUpDuration);
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
      mmTestSamples.Append( IntToStr( Msg.wParamhi) +' '
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
  Unused(aDeviceIndex, aStream);
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
    lbVoices.Clear;
    mmLog.Lines.Clear;
    edbtSelSysExDir.Text := SelectSysExDirectoryDialog1.FileName;
    LastSysExOpenDir := IncludeTrailingPathDelimiter(
      SelectSysExDirectoryDialog1.FileName);
    FillFilesList(SelectSysExDirectoryDialog1.FileName);
  end;
end;

procedure TfrmMain.alDXIIClick(Sender: TObject);
var
  ms: TMemoryStream;
  tmpSuppl: TDX7IISupplementContainer;
begin
  frmDX7IIView.Show;
  ms := TMemoryStream.Create;
  tmpSuppl := TDX7IISupplementContainer.Create;
  FSlotsDX.CGetSupplement((Sender as TAdvLed).Tag, tmpSuppl);
  tmpSuppl.Save_ACED_ToStream(ms);
  frmDX7IIView.ViewDX7II(ms);
  ms.Free;
  tmpSuppl.Free;
end;

procedure TfrmMain.alMDXClick(Sender: TObject);
var
  ms: TMemoryStream;
begin
  frmMDXView.Show;
  ms := TMemoryStream.Create;
  FPerfSlotsDX[(Sender as TAdvLed).Tag].Save_PCEDx_ToStream(ms);
  frmMDXView.ViewMDX(ms);
  ms.Free;
end;

procedure TfrmMain.alTX7Click(Sender: TObject);
var
  ms: TMemoryStream;
  tmpFunct: TTX7FunctionContainer;
begin
  frmTX7View.Show;
  ms := TMemoryStream.Create;
  tmpFunct := TTX7FunctionContainer.Create;
  FSlotsDX.CGetFunction((Sender as TAdvLed).Tag, tmpFunct);
  tmpFunct.Save_PCED_ToStream(ms);
  frmTX7View.ViewTX7(ms);
  ms.Free;
  tmpFunct.Free;
end;

procedure TfrmMain.btCatLoadClick(Sender: TObject);
begin
  SQLProxy.LoadCategories(sgCategories);
end;

procedure TfrmMain.btCatSaveClick(Sender: TObject);
begin
  SQLProxy.SaveCategories(sgCategories);
  SQLProxy.GUIUpdateCategoryLists(sgDB, cbPerfCategory, cbVoicesCategory);
end;

procedure TfrmMain.btDeleteCategoryDBClick(Sender: TObject);
begin
  if MessageDlg('Confirm deletion of Category database',
    'This operation is not reversible.' + #13#10 + 'Are you sure?',
    mtWarning, mbYesNo, 0) = mrYes then
  begin
    SQLProxy.CleanTable('CATEGORY');
    SQLProxy.Vacuum;
  end;
end;

procedure TfrmMain.btDeleteVoiceDBClick(Sender: TObject);
begin
  if MessageDlg('Confirm deletion of Voices database',
    'This operation is not reversible.' + #13#10 + 'Are you sure?',
    mtWarning, mbYesNo, 0) = mrYes then
  begin
    SQLProxy.CleanTable('BIN_VOICES');
    SQLProxy.Vacuum;
  end;
end;

procedure TfrmMain.btLoadPerfToEditorClick(Sender: TObject);
var
  i: integer;
begin
  pnHint.Visible := False;
  for i := 1 to 8 do
  begin
    FPerformance.LoadVoiceToTG(i, FPerfSlotsDX[i].Get_VCED_Params.params);
    FPerformance.LoadPCEDxToTG(i, FPerfSlotsDX[i].Get_PCEDx_Params);
  end;
  PerfToGUI;
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
  PopUp('Done!', PopUpDuration);
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
  PopUp('Done!', PopUpDuration);
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
  {$IFDEF UNIX}
    SelectSDCardDirectoryDialog1.InitialDir:='/mnt/';
  {$ENDIF}
  if SelectSDCardDirectoryDialog1.Execute then
  begin
    if FileExists(IncludeTrailingPathDelimiter(SelectSDCardDirectoryDialog1.FileName) +
      'minidexed.ini') then
      LoadSDCard(SelectSDCardDirectoryDialog1.FileName)
    else
      PopUp('Not a MiniDexed SDCard', PopUpDuration);
  end;
end;

function TfrmMain.SanitizeNames(tmp: string): string;
var
  i: integer;
begin
  for i := 1 to 10 do
  begin
    if cgSanitize.Checked[1] then
      if UTF8pos(UTF8copy(tmp, 1, 1), ('*°/\<>^?~#+-!$%&()[]`.,')) > 0 then
        tmp := UTF8copy(tmp, 2, UTF8Length(tmp) - 1);
    if cgSanitize.Checked[2] then
      if UTF8pos(UTF8copy(tmp, UTF8Length(tmp), 1),
        ('*°/\<>^?~#+-!$%&()[]`.,')) > 0 then
        tmp := UTF8copy(tmp, 1, UTF8Length(tmp) - 1);
    if cgSanitize.Checked[3] then
    begin
      tmp := ReplaceStr(tmp, '{', '');
      tmp := ReplaceStr(tmp, '}', '');
    end;
    if cgSanitize.Checked[4] then
    begin
      tmp := ReplaceStr(tmp, '''', ' ');
    end;
    if cgSanitize.Checked[5] then
    begin
      tmp := ReplaceStr(tmp, '"', ' ');
    end;
    if cgSanitize.Checked[6] then
    begin
      while pos('  ', tmp) > 0 do
        tmp := ReplaceStr(tmp, '  ', ' ');
    end;
    if cgSanitize.Checked[0] then tmp := Trim(tmp);
  end;
  tmp := AddCharR(' ', tmp, 10);
  Result := tmp;
end;

procedure TfrmMain.cgSanitizeItemClick(Sender: TObject; Index: integer);
var
  i: integer;
  tmp: string;
begin
  Unused(Index);
  mmResultSamples.Lines.Clear;

  for i := 0 to mmTestSamples.Lines.Count - 1 do
  begin
    tmp := SanitizeNames(mmTestSamples.Lines[i]);
    mmResultSamples.Lines.Add(tmp);
  end;
end;

procedure TfrmMain.edPSlotDragDrop(Sender, Source: TObject; X, Y: integer);
var
  dmp: TMemoryStream;
  spl: TMemoryStream;
  tmpVoice: TDX7VoiceContainer;
  tmpSuppl: TDX7IISupplementContainer;
  tmpFunct: TTX7FunctionContainer;
  tmpMDX: TMDXSupplementContainer;
  version: integer;
begin
  Unused(X, Y);
  if Source = lbVoices then
  begin
    if (lbVoices.ItemIndex = -1) or (lbFiles.ItemIndex = -1) then Exit;

    tmpVoice := TDX7VoiceContainer.Create;
    FTmpCCBank.CGetVoice(lbVoices.ItemIndex + 1, tmpVoice);
    FPerfSlotsDX[(Sender as TLabeledEdit).Tag].Set_VMEM_Params(
      tmpVoice.Get_VMEM_Params);
    tmpVoice.Free;

    TAdvLed(FindComponent(Format('alMDX_%.2d',
      [(Sender as TLabeledEdit).Tag]))).State := lsOff;
    TAdvLed(FindComponent(Format('alMDX_%.2d',
      [(Sender as TLabeledEdit).Tag]))).State := lsDisabled;

    FPerfSlotsDX[(Sender as TLabeledEdit).Tag].InitSuppl;
    FPerfSlotsDX[(Sender as TLabeledEdit).Tag].InitFunct;
    FPerfSlotsDX[(Sender as TLabeledEdit).Tag].InitPCEDx;

    if FTmpCCBank.HasSuppl(lbVoices.ItemIndex + 1) then
    begin
      tmpSuppl := TDX7IISupplementContainer.Create;
      FTmpCCBank.CGetSupplement(lbVoices.ItemIndex + 1, tmpSuppl);
      FPerfSlotsDX[(Sender as TLabeledEdit).Tag].Set_AMEM_Params(
        tmpSuppl.Get_AMEM_Params);
      FPerfSlotsDX[(Sender as TLabeledEdit).Tag].LoadDX7IIACEDtoPCEDx(tmpSuppl);
      TAdvLed(FindComponent(Format('alMDX_%.2d',
        [(Sender as TLabeledEdit).Tag]))).State := lsOn;
      tmpSuppl.Free;
    end;

    if FTmpCCBank.HasFunct(lbVoices.ItemIndex + 1) then
    begin
      tmpFunct := TTX7FunctionContainer.Create;
      FTmpCCBank.CGetFunction(lbVoices.ItemIndex + 1, tmpFunct);
      FPerfSlotsDX[(Sender as TLabeledEdit).Tag].Set_PMEM_Params(
        tmpFunct.Get_PMEM_Params);
      FPerfSlotsDX[(Sender as TLabeledEdit).Tag].LoadTX7PCEDtoPCEDx(tmpFunct);
      TAdvLed(FindComponent(Format('alMDX_%.2d',
        [(Sender as TLabeledEdit).Tag]))).State := lsOn;
      tmpFunct.Free;
    end;

    RefreshSlots;
  end;
  if Source = sgDB then
  begin
    dmp := TMemoryStream.Create;
    spl := TMemoryStream.Create;
    version := 0;
    SQLProxy.GetBinVoice(sgDB.Cells[3, dragItem], version, dmp, spl);
    tmpVoice := TDX7VoiceContainer.Create;
    tmpVoice.Load_VCED_FromStream(dmp, 0);
    if FPerfSlotsDX[(Sender as TLabeledEdit).Tag].Set_VMEM_Params(
      tmpVoice.Get_VMEM_Params) then
    begin
      if version = 0 then
      begin
        TAdvLed(FindComponent(Format('alMDX_%.2d',
          [(Sender as TLabeledEdit).Tag]))).State := lsOff;
        TAdvLed(FindComponent(Format('alMDX_%.2d',
          [(Sender as TLabeledEdit).Tag]))).State := lsDisabled;
        FPerfSlotsDX[(Sender as TLabeledEdit).Tag].HasMDXSuppl := False;
      end;

      if version = 1 then
      begin
        tmpSuppl := TDX7IISupplementContainer.Create;
        tmpSuppl.Load_ACED_FromStream(spl, 0);
        FPerfSlotsDX[(Sender as TLabeledEdit).Tag].Set_AMEM_Params(
          tmpSuppl.Get_AMEM_Params);
        FPerfSlotsDX[(Sender as TLabeledEdit).Tag].LoadDX7IIACEDtoPCEDx(tmpSuppl);
        TAdvLed(FindComponent(Format('alMDX_%.2d',
          [(Sender as TLabeledEdit).Tag]))).State := lsOn;
        tmpSuppl.Free;
        FPerfSlotsDX[(Sender as TLabeledEdit).Tag].HasMDXSuppl := True;
      end;

      if version = 2 then
      begin
        tmpFunct := TTX7FunctionContainer.Create;
        tmpFunct.Load_PCED_FromStream(spl, 0);
        FPerfSlotsDX[(Sender as TLabeledEdit).Tag].Set_PMEM_Params(
          tmpFunct.Get_PMEM_Params);
        FPerfSlotsDX[(Sender as TLabeledEdit).Tag].LoadTX7PCEDtoPCEDx(tmpFunct);
        TAdvLed(FindComponent(Format('alMDX_%.2d',
          [(Sender as TLabeledEdit).Tag]))).State := lsOn;
        tmpFunct.Free;
        FPerfSlotsDX[(Sender as TLabeledEdit).Tag].HasMDXSuppl := True;
      end;

      if version = 3 then
      begin
        tmpMDX := TMDXSupplementContainer.Create;
        tmpMDX.Load_PCEDx_FromStream(spl, 0);
        FPerfSlotsDX[(Sender as TLabeledEdit).Tag].Set_PCEDx_Params(
          tmpMDX.Get_PCEDx_Params);
        TAdvLed(FindComponent(Format('alMDX_%.2d',
          [(Sender as TLabeledEdit).Tag]))).State := lsOn;
        tmpMDX.Free;
        FPerfSlotsDX[(Sender as TLabeledEdit).Tag].HasMDXSuppl := True;
      end;
    end;
    tmpVoice.Free;
    dmp.Free;
    spl.Free;
    RefreshSlots;
  end;
end;

procedure TfrmMain.edPSlotDragOver(Sender, Source: TObject; X, Y: integer;
  State: TDragState; var Accept: boolean);
begin
  Unused(Source, State);
  Unused(X, Y);
  if (Sender = lbVoices) and (dragItem <> -1) then Accept := True;
  if (Sender = sgDB) and (dragItem <> -1) then Accept := True;
end;

procedure TfrmMain.edSlotDblClick(Sender: TObject);
begin
  SendSingleVoice(cbLibMIDIChannel.ItemIndex + 1, (Sender as TLabeledEdit).Tag);
  (Sender as TLabeledEdit).SelLength := 0;
  Self.ActiveControl := nil;
end;

procedure TfrmMain.edSlotDragDrop(Sender, Source: TObject; X, Y: integer);
var
  dmp: TMemoryStream;
  spl: TMemoryStream;
  i: integer;
  tmpVoice: TDX7VoiceContainer;
  tmpSuppl: TDX7IISupplementContainer;
  tmpFunct: TTX7FunctionContainer;
  version: integer;
begin
  Unused(X, Y);
  if Source = lbFiles then
  begin
    if lbFiles.ItemIndex = -1 then exit;
    dmp := TMemoryStream.Create;
    dmp.Clear;
    FTmpCCBank.CSaveVoiceBankToStream(dmp);
    FSlotsDX.CLoadVoiceBankFromStream(dmp, 0);
    for i := 1 to 32 do
    begin
      TLabeledEdit(FindComponent(Format('edSlot%.2d', [i]))).Text :=
        FSlotsDX.CGetVoiceName(i);
    end;

    for i := 1 to 32 do
    begin
      TAdvLed(FindComponent(Format('alDXII_%.2d', [i]))).State := lsOff;
      TAdvLed(FindComponent(Format('alTX7_%.2d', [i]))).State := lsOff;
      TAdvLed(FindComponent(Format('alDXII_%.2d', [i]))).State := lsDisabled;
      TAdvLed(FindComponent(Format('alTX7_%.2d', [i]))).State := lsDisabled;
    end;

    if FTmpCCBank.HasGlobalSuppl then
    begin
      dmp.Clear;
      dmp.Size := 0;
      FTmpCCBank.CSaveSupplBankToStream(dmp);
      FSlotsDX.CLoadSupplBankFromStream(dmp, 0);
      for i := 1 to 32 do
      begin
        if FSlotsDX.HasSuppl(i) then
          TAdvLed(FindComponent(Format('alDXII_%.2d', [i]))).State := lsOn;
      end;
    end
    else
      FSlotsDX.CInitSuppl;

    if FTmpCCBank.HasGlobalFunct then
    begin
      dmp.Clear;
      dmp.Size := 0;
      FTmpCCBank.CSaveFunctBankToStream(dmp);
      FSlotsDX.CLoadFunctBankFromStream(dmp, 0);
      for i := 1 to 32 do
      begin
        if FSlotsDX.HasFunct(i) then
          TAdvLed(FindComponent(Format('alTX7_%.2d', [i]))).State := lsOn;
      end;
    end
    else
      FSlotsDX.CInitFunct;
    dmp.Free;
  end;
  if Source = lbVoices then
  begin
    if (lbVoices.ItemIndex = -1) or (lbFiles.ItemIndex = -1) then Exit;

    tmpVoice := TDX7VoiceContainer.Create;
    tmpVoice.InitVoice;
    FTmpCCBank.CGetVoice(lbVoices.ItemIndex + 1, tmpVoice);
    FSlotsDX.CSetVoice((Sender as TLabeledEdit).Tag, tmpVoice);
    (Sender as TLabeledEdit).Text :=
      FSlotsDX.CGetVoiceName((Sender as TLabeledEdit).Tag);
    tmpVoice.Free;

    TAdvLed(FindComponent(Format('alTX7_%.2d',
      [(Sender as TLabeledEdit).Tag]))).State := lsOff;
    TAdvLed(FindComponent(Format('alTX7_%.2d',
      [(Sender as TLabeledEdit).Tag]))).State := lsDisabled;
    TAdvLed(FindComponent(Format('alDXII_%.2d',
      [(Sender as TLabeledEdit).Tag]))).State := lsOff;
    TAdvLed(FindComponent(Format('alDXII_%.2d',
      [(Sender as TLabeledEdit).Tag]))).State := lsDisabled;

    FSlotsDX.SetHasSuppl((Sender as TLabeledEdit).Tag, False);
    FSlotsDX.SetHasFunct((Sender as TLabeledEdit).Tag, False);
    FSlotsDX.CInitFunct;
    FSlotsDX.CInitSuppl;

    if FTmpCCBank.HasSuppl(lbVoices.ItemIndex + 1) then
    begin
      tmpSuppl := TDX7IISupplementContainer.Create;
      FTmpCCBank.CGetSupplement(lbVoices.ItemIndex + 1, tmpSuppl);
      FSlotsDX.CSetSupplement((Sender as TLabeledEdit).Tag, tmpSuppl);
      FSlotsDX.SetHasSuppl((Sender as TLabeledEdit).Tag, True);
      if FSlotsDX.HasSuppl((Sender as TLabeledEdit).Tag) then
        TAdvLed(FindComponent(Format('alDXII_%.2d',
          [(Sender as TLabeledEdit).Tag]))).State := lsOn;
      tmpSuppl.Free;
    end;

    if FTmpCCBank.HasFunct(lbVoices.ItemIndex + 1) then
    begin
      tmpFunct := TTX7FunctionContainer.Create;
      FTmpCCBank.CGetFunction(lbVoices.ItemIndex + 1, tmpFunct);
      FSlotsDX.CSetFunction((Sender as TLabeledEdit).Tag, tmpFunct);
      FSlotsDX.SetHasFunct((Sender as TLabeledEdit).Tag, True);
      if FSlotsDX.HasFunct((Sender as TLabeledEdit).Tag) then
        TAdvLed(FindComponent(Format('alTX7_%.2d',
          [(Sender as TLabeledEdit).Tag]))).State := lsOn;
      tmpFunct.Free;
    end;
  end;
  if Source = sgDB then
  begin
    dmp := TMemoryStream.Create;
    spl := TMemoryStream.Create;
    version := 0;
    SQLProxy.GetBinVoice(sgDB.Cells[3, dragItem], version, dmp, spl);
    tmpVoice := TDX7VoiceContainer.Create;
    tmpVoice.Load_VCED_FromStream(dmp, 0);
    if FSlotsDX.CSetVoice((Sender as TLabeledEdit).Tag, tmpVoice) then
    begin
      (Sender as TLabeledEdit).Text :=
        FSlotsDX.CGetVoiceName((Sender as TLabeledEdit).Tag);
      TAdvLed(FindComponent(Format('alTX7_%.2d',
        [(Sender as TLabeledEdit).Tag]))).State := lsOff;
      TAdvLed(FindComponent(Format('alTX7_%.2d',
        [(Sender as TLabeledEdit).Tag]))).State := lsDisabled;
      TAdvLed(FindComponent(Format('alDXII_%.2d',
        [(Sender as TLabeledEdit).Tag]))).State := lsOff;
      TAdvLed(FindComponent(Format('alDXII_%.2d',
        [(Sender as TLabeledEdit).Tag]))).State := lsDisabled;

      if version = 0 then
      begin
        FSlotsDX.SetHasSuppl((Sender as TLabeledEdit).Tag, False);
        FSlotsDX.SetHasFunct((Sender as TLabeledEdit).Tag, False);
      end;

      if version = 1 then
      begin
        tmpSuppl := TDX7IISupplementContainer.Create;
        tmpSuppl.Load_ACED_FromStream(spl, 0);
        FSlotsDX.CSetSupplement((Sender as TLabeledEdit).Tag, tmpSuppl);
        TAdvLed(FindComponent(Format('alDXII_%.2d',
          [(Sender as TLabeledEdit).Tag]))).State := lsOn;
        tmpSuppl.Free;
        FSlotsDX.SetHasSuppl((Sender as TLabeledEdit).Tag, True);
      end;

      if version = 2 then
      begin
        tmpFunct := TTX7FunctionContainer.Create;
        tmpFunct.Load_PCED_FromStream(spl, 0);
        FSlotsDX.CSetFunction((Sender as TLabeledEdit).Tag, tmpFunct);
        TAdvLed(FindComponent(Format('alTX7_%.2d',
          [(Sender as TLabeledEdit).Tag]))).State := lsOn;
        tmpFunct.Free;
        FSlotsDX.SetHasFunct((Sender as TLabeledEdit).Tag, True);
      end;
    end;
    tmpVoice.Free;
    dmp.Free;
    spl.Free;
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
  FTmpCCBank.Free;
  FSlotsDX.Free;
  FPerformance.Free;

  for i := 1 to 8 do
  begin
    FPerfSlotsDX[i].Free;
  end;

  SQLProxy.Free;

  SDCardSysExFiles.Free;
  SDCardPerfFiles.Free;

  compList.Free;
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
    if cbVoicesCategory.ItemIndex <> -1 then
      ini.WriteString('VoiceCategory', cbVoicesCategory.Text);
    ini.WriteString('VoiceOrigin', edVoicesOrigin.Text);
    ini.WriteString('LastSysExOpenDir', LastSysExOpenDir);
    ini.WriteString('LastSysExSaveDir', LastSysExSaveDir);
    ini.WriteString('LastSysEx', LastSysEx);
    ini.WriteString('LastPerfOpenDir', LastPerfOpenDir);
    ini.WriteString('LastPerfSaveDir', LastPerfSaveDir);
    ini.WriteString('LastPerf', LastPerf);
    ini.WriteString('LastSDCardDir', LastSDCardDir);
    ini.WriteInteger('FontSize', frmMain.Font.Height);
    ini.WriteInteger('PopUpDuration', PopUpDuration);
    ini.SaveToFile(HomeDir + 'settings.ini');
    FSlotsDX.CSaveBankToSysExFile(HomeDir + 'lastState.syx');
  finally
    ini.Free;
  end;

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
  frmMain.FormStyle := fsNormal;
  //something in Lazarus changes the lfm file and puts fsStayOnTop
  HomeDir := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(GetUserDir) +
    'MiniDexedCC');
  if not DirectoryExists(HomeDir) then CreateDir(HomeDir);
  //AppDir := IncludeTrailingPathDelimiter(ExtractFileDir(Application.Params[0]));  //not working under *nix
  FTmpCCBank := TCCBankContainer.Create;
  FSlotsDX := TCCBankContainer.Create;
  FPerformance := TMDXPerformanceContainer.Create;


  for i := 0 to 31 do
  begin
    TLabeledEdit(FindComponent(Format('edSlot%.2d', [i + 1]))).Text :=
      FSlotsDX.CGetVoiceName(i + 1);
  end;

  for i := 1 to 8 do
  begin
    FPerfSlotsDX[i] := TCCVoiceContainer.Create;

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
  SQLProxy := TSQLProxy.Create;
  SQLProxy.DbFileName := DBName;
  SQLProxy.Connect;

  SQLProxy.CreateTables;
  SQLProxy.CreateDefaultCategories;

  //Load the DB values into the GUI components
  sgDB.RowCount := 1;
  SQLProxy.LoadCategories(sgCategories);
  SQLProxy.GUIUpdateCategoryLists(sgDB, cbPerfCategory, cbVoicesCategory);

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
  lastClickedFile := -1;

  try
    ini := TMiniINIFile.Create;
    ini.LoadFromFile(HomeDir + 'settings.ini');
    cbMIDIIn.ItemIndex := cbMidiIn.Items.IndexOf(ini.ReadString('MIDIInput', ''));
    if cbMidiIn.ItemIndex <> -1 then
    begin
      FMidiIn := cbMidiIn.Text;
      FMidiInInt := cbMidiIn.ItemIndex;
      try
        MidiInput.Open(FMidiInInt);
      except
        on e: Exception do PopUp('Could not open' + #13#10 + 'MIDI Input', 2);
      end;
      FMidiIsActive := True;
    end;
    cbMidiOut.ItemIndex := cbMidiOut.Items.IndexOf(ini.ReadString('MIDIOutput', ''));
    if cbMidiOut.ItemIndex <> -1 then
    begin
      FMidiOut := cbMidiOut.Text;
      FMidiOutInt := cbMidiOut.ItemIndex;
      try
        MidiOutput.Open(FMidiOutInt);
      except
        on e: Exception do PopUp('Could not open' + #13#10 + 'MIDI Output', 2);
      end;
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
    PopUpDuration := ini.ReadInteger('PopUpDuration', 2);
    sePopUpDur.Value := PopUpDuration;
    seFontSize.Value := frmMain.Font.Height;
    cbVoicesCategory.ItemIndex :=
      cbVoicesCategory.Items.IndexOf(ini.ReadString('VoiceCategory', 'Default'));
    edVoicesOrigin.Text := ini.ReadString('VoiceOrigin', 'Unknown');
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
      LoadPerformance(LastPerf);
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
  rbMIDIButOnChange(Self);
end;

procedure TfrmMain.LoadLastStateBank;
var
  dmp: TMemoryStream;
  i, j: integer;
  Itm: string;
  dmpPos: int64;
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
      FSlotsDX.CLoadVoiceBankFromStream(dmp, j);
      for i := 0 to 31 do
      begin
        TLabeledEdit(FindComponent(Format('edSlot%.2d', [i + 1]))).Text :=
          FSlotsDX.CGetVoiceName(i + 1);
      end;

      for i := 0 to 31 do
      begin
        TAdvLed(FindComponent(Format('alDXII_%.2d', [i + 1]))).State := lsOff;
        TAdvLed(FindComponent(Format('alTX7_%.2d', [i + 1]))).State := lsOff;
        TAdvLed(FindComponent(Format('alDXII_%.2d', [i + 1]))).State := lsDisabled;
        TAdvLed(FindComponent(Format('alTX7_%.2d', [i + 1]))).State := lsDisabled;
      end;

      dmpPos := dmp.Position;
      i := dmpPos;
      if ContainsDX7IISupplBankDump(dmp, i, j) then
      begin
        FSlotsDX.CLoadSupplBankFromStream(dmp, j);
        for i := 1 to 32 do
        begin
          if FSlotsDX.HasSuppl(i) then
            TAdvLed(FindComponent(Format('alDXII_%.2d', [i]))).State := lsOn;
        end;
      end;

      i := dmpPos;
      if ContainsTX7FunctBankDump(dmp, i, j) then
      begin
        FSlotsDX.CLoadFunctBankFromStream(dmp, j);
        for i := 1 to 32 do
        begin
          if FSlotsDX.HasFunct(i) then
            TAdvLed(FindComponent(Format('alTX7_%.2d', [i]))).State := lsOn;
        end;
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
  if lbFiles.ItemIndex <> -1 then
  begin
    lastClickedFile := lbFiles.ItemIndex;
    Itm := lbFiles.Items[lbFiles.ItemIndex];
    LastSysEx := itm;
    dbg := IncludeTrailingPathDelimiter(edbtSelSysExDir.Text) + Itm;
    lbVoices.Clear;
    mmLog.Lines.Clear;
    OpenSysEx(dbg);
    if (lastClickedFile <> -1) and ((lastClickedFile) < lbFiles.Items.Count) then
      lbFiles.ItemIndex := lastClickedFile;
  end;
end;

procedure TfrmMain.lbFilesDblClick(Sender: TObject);
var
  dbg: string;
  Itm: string;
  dmp: TMemoryStream;
  i: integer;
begin
  if lbFiles.ItemIndex <> -1 then
  begin
    lastClickedFile := lbFiles.ItemIndex;
    Itm := lbFiles.Items[lbFiles.ItemIndex];
    LastSysEx := itm;
    dbg := IncludeTrailingPathDelimiter(edbtSelSysExDir.Text) + Itm;
    lbVoices.Clear;
    mmLog.Lines.Clear;
    OpenSysEx(dbg);
    if (lastClickedFile <> -1) and ((lastClickedFile) < lbFiles.Items.Count) then
      lbFiles.ItemIndex := lastClickedFile;

    dmp := TMemoryStream.Create;
    dmp.Clear;
    FTmpCCBank.CSaveVoiceBankToStream(dmp);
    FSlotsDX.CLoadVoiceBankFromStream(dmp, 0);
    for i := 1 to 32 do
    begin
      TLabeledEdit(FindComponent(Format('edSlot%.2d', [i]))).Text :=
        FSlotsDX.CGetVoiceName(i);
    end;

    for i := 1 to 32 do
    begin
      TAdvLed(FindComponent(Format('alDXII_%.2d', [i]))).State := lsOff;
      TAdvLed(FindComponent(Format('alTX7_%.2d', [i]))).State := lsOff;
      TAdvLed(FindComponent(Format('alDXII_%.2d', [i]))).State := lsDisabled;
      TAdvLed(FindComponent(Format('alTX7_%.2d', [i]))).State := lsDisabled;
    end;

    if FTmpCCBank.HasGlobalSuppl then
    begin
      dmp.Clear;
      dmp.Size := 0;
      FTmpCCBank.CSaveSupplBankToStream(dmp);
      FSlotsDX.CLoadSupplBankFromStream(dmp, 0);
      for i := 1 to 32 do
      begin
        if FSlotsDX.HasSuppl(i) then
          TAdvLed(FindComponent(Format('alDXII_%.2d', [i]))).State := lsOn;
      end;
    end
    else
      FSlotsDX.CInitSuppl;

    if FTmpCCBank.HasGlobalFunct then
    begin
      dmp.Clear;
      dmp.Size := 0;
      FTmpCCBank.CSaveFunctBankToStream(dmp);
      FSlotsDX.CLoadFunctBankFromStream(dmp, 0);
      for i := 1 to 32 do
      begin
        if FSlotsDX.HasFunct(i) then
          TAdvLed(FindComponent(Format('alTX7_%.2d', [i]))).State := lsOn;
      end;
    end
    else
      FSlotsDX.CInitFunct;
    dmp.Free;
  end;
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

procedure TfrmMain.lnkCreditsClick(Sender: TObject);
begin
  OpenURL((Sender as TECLink).Hint);
end;

procedure TfrmMain.pnSlotClick(Sender: TObject);
var
  ms: TMemoryStream;
  tmpVoice: TDX7VoiceContainer;
begin
  frmDX7View.Show;
  ms := TMemoryStream.Create;
  tmpVoice := TDX7VoiceContainer.Create;
  FSlotsDX.CGetVoice((Sender as TPanel).Tag, tmpVoice);
  tmpVoice.Save_VCED_ToStream(ms);
  frmDX7View.ViewDX7(ms);
  ms.Free;
  tmpVoice.Free;
end;

procedure TfrmMain.LoadPerformance(aName: string);
var
  i: integer;
begin
  FPerformance.LoadPerformanceFromFile(aName);
  PerfToGUI;
  for i := 1 to 8 do
  begin
    FPerfSlotsDX[i].Set_VCED_Params(FPerformance.GetTGVoiceData(i));
    FPerfSlotsDX[i].Set_PCEDx_Params(FPerformance.GetTGPCEDxData(i));
    TAdvLed(FindComponent(Format('alMDX_%.2d', [i]))).State := lsOn;
  end;
  RefreshSlots;
end;

procedure TfrmMain.OpenSysEx(aName: string);
var
  dmp: TMemoryStream;
  i, j, k: integer;
  dxv: TDX7VoiceContainer;
  nr: integer;
  feedback: string;
begin
  if aName = '' then exit;
  if FileExists(aName) then
  begin
    dmp := TMemoryStream.Create;
    dmp.LoadFromFile(aName);
    mmLog.Lines.Clear;
    i := 0;
    j := 0;

    if ContainsDXData(dmp, i, mmLog.Lines) then
    begin
      if ContainsDX7VoiceDump(dmp, i, j) then
      begin
        lbVoices.Items.Clear;
        dxv := TDX7VoiceContainer.Create;
        dxv.Load_VCED_FromStream(dmp, j);
        FTmpCCBank.CInitVoices;
        FTmpCCBank.CSetVoice(1, dxv);
        lbVoices.Items.Add(FTmpCCBank.CGetVoiceName(1));
        dxv.Free;
      end
      else
      begin

        i := 0; //read from the begining of the stream again
        if ContainsDX7BankDump(dmp, i, j) then
        begin
          lbVoices.Items.Clear;
          FTmpCCBank.CLoadVoiceBankFromStream(dmp, j);
          for nr := 1 to 32 do
          begin
            lbVoices.Items.Add(FTmpCCBank.CGetVoiceName(nr));
          end;
          //k := dmp.Position;
          k := 0; // got files where AMEM comes before VMEM
          i := k;
          if ContainsDX7IISupplBankDump(dmp, i, j) then
            FTmpCCBank.CLoadSupplBankFromStream(dmp, j)
          else
            FTmpCCBank.CInitSuppl;
          //i := k;
          i := 0; // if PMEM is before VMEM in file
          if ContainsTX7FunctBankDump(dmp, i, j) then
            FTmpCCBank.CLoadFunctBankFromStream(dmp, j)
          else
            FTmpCCBank.CInitFunct;
        end
        else
        begin
          mmLog.Lines.Add('Not a valid DX7 Bank SysEx');
          feedback := '';
          if RepairDX7SysEx(aName, feedback) then
          begin
            FillFilesList(edbtSelSysExDir.Text);
            mmLog.Lines.Add(feedback);
            mmLog.Lines.Add('Reparation: It is maybe a DX7 VMEM file');
            Inc(lastClickedFile);
          end
          else
          begin
            mmLog.Lines.Add(feedback);
            mmLog.Lines.Add('Could not repair');
          end;
        end;
      end;
    end
    else
    begin
      //mmLog.Lines.Clear;
      mmLog.Lines.Add('Not a valid DX7 SysEx');
      feedback := '';
      if RepairDX7SysEx(aName, feedback) then
      begin
        FillFilesList(edbtSelSysExDir.Text);
        mmLog.Lines.Add(feedback);
        mmLog.Lines.Add('Reparation: It is maybe a DX7 VMEM file');
        Inc(lastClickedFile);
      end
      else
      begin
        mmLog.Lines.Add(feedback);
        mmLog.Lines.Add('Could not repair');
      end;
    end;
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

procedure TfrmMain.rbMIDIButOnChange(Sender: TObject);
begin
  if rbMIDIButOn.Checked then
  begin
    edMIDIButPrev.Enabled := True;
    edMIDIButNext.Enabled := True;
    edMIDIButBack.Enabled := True;
    edMIDIButSel.Enabled := True;
    edMIDIButHome.Enabled := True;
  end
  else
  begin
    edMIDIButPrev.Enabled := False;
    edMIDIButNext.Enabled := False;
    edMIDIButBack.Enabled := False;
    edMIDIButSel.Enabled := False;
    edMIDIButHome.Enabled := False;
  end;
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

procedure TfrmMain.tbbtSavePerfToDBClick(Sender: TObject);
var
  tmpStream: TMemoryStream;
  FName, FCategory, FOrigin: string;
  FVersion: integer;
  FHash: string;
begin
  GUIToPerf;
  tmpStream := TMemoryStream.Create;
  FHash := FPerformance.CalculateHash;
  FVersion := FPerformance.FMDX_Params.General.Version;
  FName := FPerformance.FMDX_Params.General.Name;
  FCategory := FPerformance.FMDX_Params.General.Category;
  FOrigin := FPerformance.FMDX_Params.General.Origin;
  FPerformance.SavePerformanceToStream(tmpStream);
  SQLProxy.AddPerformance(FHash, FVersion, FName, FCategory, FOrigin, tmpStream);
  tmpStream.Free;
  PopUp('Done!', PopUpDuration);
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
      FSlotsDX.CSysExBankToStream(cbLibMIDIChannel.ItemIndex + 1, bankStream);
      err := MidiOutput.SendSysEx(FMidiOutInt, bankStream);
      if (err = 0)
        {$IFNDEF WINDOWS}
        or (err = 1)
        {$ENDIF}
      then
      begin
        PopUp('Bank sent', PopUpDuration);
      end
      else
        PopUp('Bank sending failed!' + #13 + 'Error message:' +
          #13 + Pm_GetErrorText(err), PopUpDuration);
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
      FSlotsDX.CGetVoice(aVoiceNr, tmpVoice);
      tmpVoice.SysExVoiceToStream(aCh, voiceStream);
      err := MidiOutput.SendSysEx(FMidiOutInt, voiceStream);
      if (err = 0)
        {$IFNDEF WINDOWS}
        or (err = 1)
        {$ENDIF}
      then
      begin
        PopUp('Voice' + #13 + 'sent', PopUpDuration);
      end
      else
        PopUp('Voice sending failed!' + #13 + 'Error message:' +
          #13 + Pm_GetErrorText(err), PopUpDuration);
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

procedure TfrmMain.SendSimpleMelody(aCh: integer);
const
  notes: array [0..8] of integer = (24, 36, 48, 60, 72, 84, 96, 108, 120);
var
  i: integer;
begin
  if FMidiOutInt <> -1 then
  begin
    if aCh < 1 then aCh := 1;
    if aCh > 16 then aCh := 16;
    aCh := aCh - 1;
    for i := 0 to 8 do
    begin
      MidiOutput.Send(FMidiOutInt, 144 + aCh, notes[i], 100);
      sleep(200);
      MidiOutput.Send(FMidiOutInt, 128 + aCh, notes[i], 0);
      sleep(50);
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

procedure TfrmMain.sePopUpDurChange(Sender: TObject);
begin
  PopUpDuration := sePopUpDur.Value;
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
  lastSelectedRow := aRow;
  Unused(aCol);
end;

procedure TfrmMain.sgDBBeforeSelection(Sender: TObject; aCol, aRow: integer);
var
  c: integer;
begin
  Unused(aCol);
  for c := 0 to 3 do
  begin
    if aRow < sgDB.RowCount then
      //sometimes aRow is greater than the row count
      compArray[c] := sgDB.Cells[c, aRow];
  end;
end;

procedure TfrmMain.sgDBClick(Sender: TObject);
var
  ID: string;
  Row: integer;
  dmp: TMemoryStream;
  spl: TMemoryStream;
  voiceStream: TMemoryStream;
  tmpVoice: TDX7VoiceContainer;
  version: integer;
begin
  Row := sgDB.Row;
  if (cbAutoPreview.Checked) and (Row > 0) then
  begin
    try
      ID := sgDB.Cells[3, Row];
      dmp := TMemoryStream.Create;
      spl := TMemoryStream.Create;
      voiceStream := TMemoryStream.Create;
      version := 0;
      SQLProxy.GetBinVoice(ID, version, dmp, spl);
      tmpVoice := TDX7VoiceContainer.Create;
      tmpVoice.Load_VCED_FromStream(dmp, 0);
      tmpVoice.SysExVoiceToStream(cbLibMIDIChannel.ItemIndex + 1, voiceStream);
      MidiOutput.SendSysEx(FMidiOutInt, voiceStream);
      SendSimpleMelody(cbLibMIDIChannel.ItemIndex + 1);
    finally
      tmpVoice.Free;
      dmp.Free;
      spl.Free;
      voiceStream.Free;
    end;
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
  P := Default(TPoint);
  GetCursorPos(P);
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
        LoadPerformance(path);
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
          FSlotsDX.CLoadVoiceBankFromStream(dmp, j);
          for nr := 0 to 31 do
          begin
            TLabeledEdit(FindComponent(Format('edSlot%.2d', [nr + 1]))).Text :=
              FSlotsDX.CGetVoiceName(nr + 1);
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
        PopUp('Conflict', PopUpDuration);
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
    SQLProxy.Commit(FId, FName, FCategory, FOrigin);
  end;
  compList.Clear;
end;

procedure TfrmMain.tbbtDelPerfFromDBClick(Sender: TObject);
var
  FID: string;
  FName: string;
begin
  SQLProxy.GUIPerfSelGridRefresh(frmPerfSelDlg.sgPerfSel);
  frmPerfSelDlg.Caption := 'Delete performance from database';
  if frmPerfSelDlg.ShowModal = mrOk then
  begin
    FID := untPerfSelDlg.ID;
    FName := untPerfSelDlg.PerfName;
    if MessageDlg('Delete confirmation', 'Are you sure you want to delete' +
      #13#10 + FName + ' from database?', mtConfirmation, mbYesNo, 0) = mrYes then
      SQLProxy.DeletePerformance(FID);
  end;
end;

procedure TfrmMain.tbbtDelVoiceClick(Sender: TObject);
var
  FID, FName: string;
begin
  if sgDB.Row > 0 then
  begin
    FID := sgDB.Cells[3, sgDB.Row];
    FName := sgDB.Cells[0, sgDB.Row];
    if MessageDlg('Delete confirmation', 'Are you sure you want to delete' +
      #13#10 + FName + ' from database?', mtConfirmation, mbYesNo, 0) = mrYes then
    begin
      SQLProxy.DeleteVoice(FID);
      SQLProxy.GUIGridRefresh(sgDB);
      compList.Clear;
    end;
  end;
end;

procedure TfrmMain.tbbtLoadPerfFromDBClick(Sender: TObject);
var
  FName, FCategory, FOrigin, FID: string;
  FVersion: integer;
  FStream: TMemoryStream;
begin
  SQLProxy.GUIPerfSelGridRefresh(frmPerfSelDlg.sgPerfSel);
  frmPerfSelDlg.Caption := 'Load performance from database';
  if frmPerfSelDlg.ShowModal = mrOk then
  begin
    FID := untPerfSelDlg.ID;
    FVersion := 0;
    FName := '';
    FCategory := '';
    FOrigin := '';
    FStream := TMemoryStream.Create;
    SQLProxy.GetPerformance(FID, FVersion, FName, FCategory, FOrigin, FStream);
    FPerformance.LoadPerformanceFromStream(FStream);
    PerfToGUI;
    FStream.Free;
  end;
end;

procedure TfrmMain.tbbtLoadPerformanceClick(Sender: TObject);
begin
  if OpenPerformanceDialog1.Execute then
  begin
    LastPerfOpenDir := IncludeTrailingPathDelimiter(
      ExtractFileDir(OpenPerformanceDialog1.FileName));
    LastPerf := OpenPerformanceDialog1.FileName;
    LoadPerformance(OpenPerformanceDialog1.FileName);
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
      swMIDIIgnAllNotesOff.Checked :=
        boolean(ini.ReadInteger('IgnoreAllNotesOff', 1) and 1);
      swMIDIAutoDump.Checked :=
        boolean(ini.ReadInteger('MIDIAutoVoiceDumpOnPC', 1) and 1);
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
        swLCDMirror.Checked := boolean(ini.ReadInteger('SSD1306LCDMirror', 1) and 1);
        swLCDRotate.Checked := boolean(ini.ReadInteger('SSD1306LCDRotate', 1) and 1);
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

      rbMIDIButOn.Checked := boolean(ini.ReadInteger('MIDIButtonNotes', 1) and 1);
      cbMIDIBtnChannel.ItemIndex := ini.ReadInteger('MIDIButtonCh', 0);
      edMIDIButPrev.Text := ini.ReadString('MIDIButtonPrev', '0');
      edMIDIButNext.Text := ini.ReadString('MIDIButtonNext', '0');
      edMIDIButBack.Text := ini.ReadString('MIDIButtonBack', '0');
      edMIDIButSel.Text := ini.ReadString('MIDIButtonSelect', '0');
      edMIDIButHome.Text := ini.ReadString('MIDIButtonHome', '0');
      rbMIDIButOnChange(self);

      CalculateGPIO;
    finally
      ini.Free;
    end;
  end;
end;

procedure TfrmMain.tbbtRefreshClick(Sender: TObject);
var
  ft: integer;
  vc: integer;
begin
  if trim(tbSearch.Text) = '' then
    SQLProxy.GUIGridRefresh(sgDB)
  else
  begin
    ft := 0;
    if tbrbSearchName.Checked then ft := 1;
    if tbrbSearchOrigin.Checked then ft := 2;
    SQLProxy.GUIGridRefreshFiltered(sgDB, tbSearch.Text, ft);
  end;
  SQLProxy.GUIUpdateCategoryLists(sgDB, cbPerfCategory, cbVoicesCategory);
  vc := SQLProxy.GetVoiceCount;
  compList.Clear;
  PopUp('Total voices:' + #13#10 + IntToStr(vc), PopUpDuration);
end;

procedure TfrmMain.tbbtSanitizeClick(Sender: TObject);
var
  i: integer;
  c1, c2: string;
begin
  sgDB.BeginUpdate;
  for i := 1 to sgDB.RowCount - 1 do
  begin
    c1 := sgDB.Cells[0, i];
    c2 := SanitizeNames(c1);
    sgDB.Cells[0, i] := c2;
    if c1 <> c2 then compList.Add(IntToStr(i));
  end;
  sgDB.EndUpdate(True);
  PopUp('Done!', PopUpDuration);
end;

procedure TfrmMain.tbbtSaveBankClick(Sender: TObject);
begin
  if SaveBankDialog1.Execute then
  begin
    FSlotsDX.CSaveBankToSysExFile(SaveBankDialog1.FileName);
    LastSysExSaveDir := IncludeTrailingPathDelimiter(
      ExtractFileDir(SaveBankDialog1.FileName));
  end;
end;

procedure TfrmMain.RefreshSlots;
var
  i: integer;
begin
  edPSlot1.Text := FPerformance.GetTGVoiceName(1);
  edPSlot2.Text := FPerformance.GetTGVoiceName(2);
  edPSlot3.Text := FPerformance.GetTGVoiceName(3);
  edPSlot4.Text := FPerformance.GetTGVoiceName(4);
  edPSlot5.Text := FPerformance.GetTGVoiceName(5);
  edPSlot6.Text := FPerformance.GetTGVoiceName(6);
  edPSlot7.Text := FPerformance.GetTGVoiceName(7);
  edPSlot8.Text := FPerformance.GetTGVoiceName(8);
  edPSlot01.Text := FPerfSlotsDX[1].GetVoiceName;
  edPSlot02.Text := FPerfSlotsDX[2].GetVoiceName;
  edPSlot03.Text := FPerfSlotsDX[3].GetVoiceName;
  edPSlot04.Text := FPerfSlotsDX[4].GetVoiceName;
  edPSlot05.Text := FPerfSlotsDX[5].GetVoiceName;
  edPSlot06.Text := FPerfSlotsDX[6].GetVoiceName;
  edPSlot07.Text := FPerfSlotsDX[7].GetVoiceName;
  edPSlot08.Text := FPerfSlotsDX[8].GetVoiceName;
  for i := 1 to 32 do
  begin
    TLabeledEdit(FindComponent(Format('edSlot%.2d', [i]))).Text :=
      FSlotsDX.CGetVoiceName(i);
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
      ini.WriteInteger('IgnoreAllNotesOff', integer(swMIDIIgnAllNotesOff.Checked));
      ini.WriteInteger('MIDIAutoVoiceDumpOnPC', integer(swMIDIAutoDump.Checked));
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
        ini.WriteInteger('SSD1306LCDRotate', integer(swLCDRotate.Checked));
        ini.WriteInteger('SSD1306LCDMirror', integer(swLCDMirror.Checked));
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
      if rbMIDIButOn.Checked then
      begin
        ini.WriteInteger('MIDIButtonCh', cbMIDIBtnChannel.ItemIndex);
        ini.WriteInteger('MIDIButtonNotes', 1);
        ini.WriteString('MIDIButtonPrev', edMIDIButPrev.Text);
        ini.WriteString('MIDIButtonNext', edMIDIButNext.Text);
        ini.WriteString('MIDIButtonBack', edMIDIButBack.Text);
        ini.WriteString('MIDIButtonSelect', edMIDIButSel.Text);
        ini.WriteString('MIDIButtonHome', edMIDIButHome.Text);
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

procedure TfrmMain.GUIToPerf;
var
  i: integer;
  a: string;
  cat: string;
begin

  cat := cbPerfCategory.Text;
  if cbPerfCategory.Items.IndexOf(cat) = -1 then
  begin
    SQLProxy.LoadCategories(sgCategories);
    sgCategories.RowCount := sgCategories.RowCount + 1;
    sgCategories.Cells[0, sgCategories.RowCount - 1] := cat;
    sgCategories.Cells[1, sgCategories.RowCount - 1] :=
      'Added from ' + FPerformance.FMDX_Params.General.Name;
    SQLProxy.SaveCategories(sgCategories);
    SQLProxy.GUIUpdateCategoryLists(sgDB, cbPerfCategory, cbVoicesCategory);
  end;
  cbPerfCategory.ItemIndex := cbPerfCategory.Items.IndexOf(cat);

  FPerformance.FMDX_Params.General.Name := edPerfName.Text;
  FPerformance.FMDX_Params.General.Category := cbPerfCategory.Text;
  FPerformance.FMDX_Params.General.Origin := edPerfOrigin.Text;
  FPerformance.FMDX_Params.General.Version := 1;
  FPerformance.FMDX_Params.Eff.CompressorEnable := byte(swCompressorEnable.Checked);
  FPerformance.FMDX_Params.Eff.ReverbEnable := byte(swReverbEnable.Checked);
  FPerformance.FMDX_Params.Eff.ReverbSize := Trunc(slReverbSize.Position);
  FPerformance.FMDX_Params.Eff.ReverbHighDamp := Trunc(slReverbHighDamp.Position);
  FPerformance.FMDX_Params.Eff.ReverbLowDamp := Trunc(slReverbLowDamp.Position);
  FPerformance.FMDX_Params.Eff.ReverbLowPass := Trunc(slReverbLowPass.Position);
  FPerformance.FMDX_Params.Eff.ReverbDiffusion := Trunc(slReverbDiffusion.Position);
  FPerformance.FMDX_Params.Eff.ReverbLevel := Trunc(slReverbLevel.Position);

  for i := 1 to 8 do
  begin
    a := IntToStr(i);
    FPerformance.FMDX_Params.TG[i].MIDIChannel :=
      TComboBox(FindComponent('cbMidiCh' + a)).ItemIndex;
    FPerformance.FMDX_Params.TG[i].SupplData.Volume :=
      trunc(TECSlider(FindComponent('slVolume' + a)).Position);
    FPerformance.FMDX_Params.TG[i].SupplData.Pan :=
      trunc(TECSlider(FindComponent('slPan' + a)).Position);
    if TECSlider(FindComponent('slDetune' + a)).Position < 0 then
      FPerformance.FMDX_Params.TG[i].SupplData.DetuneSGN := 1
    else
      FPerformance.FMDX_Params.TG[i].SupplData.DetuneSGN := 0;
    FPerformance.FMDX_Params.TG[i].SupplData.DetuneVAL :=
      abs(trunc(TECSlider(FindComponent('slDetune' + a)).Position));
    FPerformance.FMDX_Params.TG[i].SupplData.Cutoff :=
      trunc(TECSlider(FindComponent('slCutoff' + a)).Position);
    FPerformance.FMDX_Params.TG[i].SupplData.Resonance :=
      trunc(TECSlider(FindComponent('slResonance' + a)).Position);
    FPerformance.FMDX_Params.TG[i].SupplData.NoteLimitLow :=
      trunc(TECSlider(FindComponent('slLoNote' + a)).Position);
    FPerformance.FMDX_Params.TG[i].SupplData.NoteLimitHigh :=
      trunc(TECSlider(FindComponent('slHiNote' + a)).Position);
    FPerformance.FMDX_Params.TG[i].SupplData.NoteShift :=
      trunc(TECSlider(FindComponent('slTranspose' + a)).Position);
    FPerformance.FMDX_Params.TG[i].SupplData.FX1Send :=
      trunc(TECSlider(FindComponent('slReverbSend' + a)).Position);
    FPerformance.FMDX_Params.TG[i].SupplData.PitchBendRange :=
      trunc(TECSlider(FindComponent('slPitchBendRange' + a)).Position);
    FPerformance.FMDX_Params.TG[i].SupplData.PitchBendStep :=
      trunc(TECSlider(FindComponent('slPitchBendStep' + a)).Position);
    FPerformance.FMDX_Params.TG[i].SupplData.PortamentoMode :=
      byte(TECSwitch(FindComponent('swPortaMode' + a)).Checked);
    FPerformance.FMDX_Params.TG[i].SupplData.PortamentoGlissando :=
      byte(TECSwitch(FindComponent('swPortaGlissando' + a)).Checked);
    FPerformance.FMDX_Params.TG[i].SupplData.PortamentoTime :=
      trunc(TECSlider(FindComponent('slPortaTime' + a)).Position);

    FPerformance.FMDX_Params.TG[i].SupplData.MonoMode :=
      byte(TECSwitch(FindComponent('swMonoMode' + a)).Checked);

    FPerformance.FMDX_Params.TG[i].SupplData.ModulationWheelRange :=
      trunc(TECSlider(FindComponent('slModWhRange' + a)).Position);
    FPerformance.FMDX_Params.TG[i].SupplData.ModulationWheelTarget :=
      (byte(TECSwitch(FindComponent('swModEG' + a)).Checked) shl 2) +
      (byte(TECSwitch(FindComponent('swModA' + a)).Checked) shl 1) +
      byte(TECSwitch(FindComponent('swModP' + a)).Checked);

    FPerformance.FMDX_Params.TG[i].SupplData.FootControlRange :=
      trunc(TECSlider(FindComponent('slFootCtrlRange' + a)).Position);
    FPerformance.FMDX_Params.TG[i].SupplData.FootControlTarget :=
      (byte(TECSwitch(FindComponent('swFootEG' + a)).Checked) shl 2) +
      (byte(TECSwitch(FindComponent('swFootA' + a)).Checked) shl 1) +
      byte(TECSwitch(FindComponent('swFootP' + a)).Checked);

    FPerformance.FMDX_Params.TG[i].SupplData.BreathControlRange :=
      trunc(TECSlider(FindComponent('slBreathCtrlRange' + a)).Position);
    FPerformance.FMDX_Params.TG[i].SupplData.BreathControlTarget :=
      (byte(TECSwitch(FindComponent('swBreathEG' + a)).Checked) shl 2) +
      (byte(TECSwitch(FindComponent('swBreathA' + a)).Checked) shl 1) +
      byte(TECSwitch(FindComponent('swBreathP' + a)).Checked);

    FPerformance.FMDX_Params.TG[i].SupplData.AftertouchRange :=
      trunc(TECSlider(FindComponent('slAfterTouchRange' + a)).Position);
    FPerformance.FMDX_Params.TG[i].SupplData.AftertouchTarget :=
      (byte(TECSwitch(FindComponent('swAfterTouchEG' + a)).Checked) shl 2) +
      (byte(TECSwitch(FindComponent('swAfterTouchA' + a)).Checked) shl 1) +
      byte(TECSwitch(FindComponent('swAfterTouchP' + a)).Checked);
  end;
end;

procedure TfrmMain.tbbtSavePerformanceClick(Sender: TObject);
begin
  SavePerformanceDialog1.InitialDir := LastPerfSaveDir;
  SavePerformanceDialog1.FileName := edPerfName.Text + '.ini';
  if SavePerformanceDialog1.Execute then
  begin
    LastPerfSaveDir := IncludeTrailingPathDelimiter(
      ExtractFileDir(SavePerformanceDialog1.FileName));
    LastPerf := SavePerformanceDialog1.FileName;
    GUIToPerf;
    FPerformance.SavePerformanceToFile(SavePerformanceDialog1.FileName, False);
  end;
end;

procedure TfrmMain.PerfToGUI;
var
  i: integer;
  dtn: integer;
  a: string;
  cat: string;
begin
  edPerfName.Text := FPerformance.FMDX_Params.General.Name;
  edPerfOrigin.Text := FPerformance.FMDX_Params.General.Origin;
  cat := FPerformance.FMDX_Params.General.Category;
  if cbPerfCategory.Items.IndexOf(cat) = -1 then
  begin
    SQLProxy.LoadCategories(sgCategories);
    sgCategories.RowCount := sgCategories.RowCount + 1;
    sgCategories.Cells[0, sgCategories.RowCount - 1] := cat;
    sgCategories.Cells[1, sgCategories.RowCount - 1] :=
      'Added from ' + FPerformance.FMDX_Params.General.Name;
    SQLProxy.SaveCategories(sgCategories);
    SQLProxy.GUIUpdateCategoryLists(sgDB, cbPerfCategory, cbVoicesCategory);
  end;
  cbPerfCategory.ItemIndex := cbPerfCategory.Items.IndexOf(cat);

  slReverbSize.Position := FPerformance.FMDX_Params.Eff.ReverbSize;
  slReverbHighDamp.Position := FPerformance.FMDX_Params.Eff.ReverbHighDamp;
  slReverbLowDamp.Position := FPerformance.FMDX_Params.Eff.ReverbLowDamp;
  swReverbEnable.Checked := FPerformance.FMDX_Params.Eff.ReverbEnable = 1;
  slReverbLowPass.Position := FPerformance.FMDX_Params.Eff.ReverbLowPass;
  slReverbDiffusion.Position := FPerformance.FMDX_Params.Eff.ReverbDiffusion;
  slReverbLevel.Position := FPerformance.FMDX_Params.Eff.ReverbLevel;
  swCompressorEnable.Checked := FPerformance.FMDX_Params.Eff.CompressorEnable = 1;

  for i := 1 to 8 do
  begin
    a := IntToStr(i);
    if FPerformance.FMDX_Params.TG[i].MIDIChannel > 16 then
      TComboBox(FindComponent('cbMidiCh' + a)).ItemIndex := 17
    else
      TComboBox(FindComponent('cbMidiCh' + a)).ItemIndex :=
        FPerformance.FMDX_Params.TG[i].MIDIChannel;
    TECSlider(FindComponent('slVolume' + a)).Position :=
      FPerformance.FMDX_Params.TG[i].SupplData.Volume;
    TECSlider(FindComponent('slPan' + a)).Position :=
      FPerformance.FMDX_Params.TG[i].SupplData.Pan;
    dtn := FPerformance.FMDX_Params.TG[i].SupplData.DetuneVAL;
    if FPerformance.FMDX_Params.TG[i].SupplData.DetuneSGN = 1 then dtn := -dtn;
    TECSlider(FindComponent('slDetune' + a)).Position := dtn;
    TECSlider(FindComponent('slCutoff' + a)).Position :=
      FPerformance.FMDX_Params.TG[i].SupplData.Cutoff;
    TECSlider(FindComponent('slResonance' + a)).Position :=
      FPerformance.FMDX_Params.TG[i].SupplData.Resonance;
    TECSlider(FindComponent('slLoNote' + a)).Position :=
      FPerformance.FMDX_Params.TG[i].SupplData.NoteLimitLow;
    TECSlider(FindComponent('slHiNote' + a)).Position :=
      FPerformance.FMDX_Params.TG[i].SupplData.NoteLimitHigh;
    TECSlider(FindComponent('slTranspose' + a)).Position :=
      FPerformance.FMDX_Params.TG[i].SupplData.NoteShift - 24;
    TECSlider(FindComponent('slReverbSend' + a)).Position :=
      FPerformance.FMDX_Params.TG[i].SupplData.FX1Send;
    TECSlider(FindComponent('slPitchBendRange' + a)).Position :=
      FPerformance.FMDX_Params.TG[i].SupplData.PitchBendRange;
    TECSlider(FindComponent('slPitchBendStep' + a)).Position :=
      FPerformance.FMDX_Params.TG[i].SupplData.PitchBendStep;
    TECSwitch(FindComponent('swPortaMode' + a)).Checked :=
      FPerformance.FMDX_Params.TG[i].SupplData.PortamentoMode = 1;
    TECSwitch(FindComponent('swPortaGlissando' + a)).Checked :=
      FPerformance.FMDX_Params.TG[i].SupplData.PortamentoGlissando = 1;
    TECSlider(FindComponent('slPortaTime' + a)).Position :=
      FPerformance.FMDX_Params.TG[i].SupplData.PortamentoTime;

    TECSwitch(FindComponent('swMonoMode' + a)).Checked :=
      FPerformance.FMDX_Params.TG[i].SupplData.MonoMode = 1;
    TECSlider(FindComponent('slModWhRange' + a)).Position :=
      FPerformance.FMDX_Params.TG[i].SupplData.ModulationWheelRange;
    TECSwitch(FindComponent('swModP' + a)).Checked :=
      FPerformance.FMDX_Params.TG[i].SupplData.ModulationWheelTarget and 1 = 1;
    TECSwitch(FindComponent('swModA' + a)).Checked :=
      FPerformance.FMDX_Params.TG[i].SupplData.ModulationWheelTarget and 2 = 2;
    TECSwitch(FindComponent('swModEG' + a)).Checked :=
      FPerformance.FMDX_Params.TG[i].SupplData.ModulationWheelTarget and 4 = 4;
    TECSlider(FindComponent('slFootCtrlRange' + a)).Position :=
      FPerformance.FMDX_Params.TG[i].SupplData.FootControlRange;
    TECSwitch(FindComponent('swFootP' + a)).Checked :=
      FPerformance.FMDX_Params.TG[i].SupplData.FootControlTarget and 1 = 1;
    TECSwitch(FindComponent('swFootA' + a)).Checked :=
      FPerformance.FMDX_Params.TG[i].SupplData.FootControlTarget and 2 = 2;
    TECSwitch(FindComponent('swFootEG' + a)).Checked :=
      FPerformance.FMDX_Params.TG[i].SupplData.FootControlTarget and 4 = 4;
    TECSlider(FindComponent('slBreathCtrlRange' + a)).Position :=
      FPerformance.FMDX_Params.TG[i].SupplData.BreathControlRange;
    TECSwitch(FindComponent('swBreathP' + a)).Checked :=
      FPerformance.FMDX_Params.TG[i].SupplData.BreathControlTarget and 1 = 1;
    TECSwitch(FindComponent('swBreathA' + a)).Checked :=
      FPerformance.FMDX_Params.TG[i].SupplData.BreathControlTarget and 2 = 2;
    TECSwitch(FindComponent('swBreathEG' + a)).Checked :=
      FPerformance.FMDX_Params.TG[i].SupplData.BreathControlTarget and 4 = 4;
    TECSlider(FindComponent('slAfterTouchRange' + a)).Position :=
      FPerformance.FMDX_Params.TG[i].SupplData.AftertouchRange;
    TECSwitch(FindComponent('swAfterTouchP' + a)).Checked :=
      FPerformance.FMDX_Params.TG[i].SupplData.AftertouchTarget and 1 = 1;
    TECSwitch(FindComponent('swAfterTouchA' + a)).Checked :=
      FPerformance.FMDX_Params.TG[i].SupplData.AftertouchTarget and 2 = 2;
    TECSwitch(FindComponent('swAfterTouchEG' + a)).Checked :=
      FPerformance.FMDX_Params.TG[i].SupplData.AftertouchTarget and 4 = 4;

    TLabeledEdit(FindComponent('edPSlot' + a)).Text := FPerformance.GetTGVoiceName(i);
  end;
end;

end.
