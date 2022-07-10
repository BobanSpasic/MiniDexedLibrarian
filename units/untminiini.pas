unit untMiniINI;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, StrUtils;

type
  TNotes = array[0..127] of string;

type
  TMiniINIFile = class(TPersistent)
  private
    FMiniINI: TStringList;
  public
    constructor Create;
    destructor Destroy; override;
    function LoadFromFile(aFile: string): boolean;
    function SaveToFile(aFile: string): boolean;
    function ReadInteger(aName: string; aDefault: integer): integer;
    function ReadString(aName: string; aDefault: string): string;
    procedure WriteInteger(aName: string; aVal: integer);
    procedure WriteString(aName, aVal: string);
    procedure InitPerformance;
    procedure InitMiniDexedINI;
    procedure Comment(aName: string);
    procedure Uncomment(aName: string);
    function NameExists(aName: string): boolean;

  end;

const
  FNotes: TNotes = ('C-2', 'C#-2', 'D-2', 'D#-2', 'E-2', 'F-2', 'F#-2',
    'G-2', 'G#-2', 'A-2', 'B-2', 'H-2',
    'C-1', 'C#-1', 'D-1', 'D#-1', 'E-1', 'F-1',
    'F#-1', 'G-1', 'G#-1', 'A-1', 'B-1', 'H-1',
    'C0', 'C#0', 'D0', 'D#0', 'E0', 'F0', 'F#0',
    'G0', 'G#0', 'A0', 'B0', 'H0',
    'C1', 'C#1', 'D1', 'D#1', 'E1', 'F1', 'F#1',
    'G1', 'G#1', 'A1', 'B1', 'H1',
    'C2', 'C#2', 'D2', 'D#2', 'E2', 'F2', 'F#2',
    'G2', 'G#2', 'A2', 'B2', 'H2',
    'C3', 'C#3', 'D3', 'D#3', 'E3', 'F3', 'F#3',
    'G3', 'G#3', 'A3', 'B3', 'H3',
    'C4', 'C#4', 'D4', 'D#4', 'E4', 'F4', 'F#4',
    'G4', 'G#4', 'A4', 'B4', 'H4',
    'C5', 'C#5', 'D5', 'D#5', 'E5', 'F5', 'F#5',
    'G5', 'G#5', 'A5', 'B5', 'H5',
    'C6', 'C#6', 'D6', 'D#6', 'E6', 'F6', 'F#6',
    'G6', 'G#6', 'A6', 'B6', 'H6',
    'C7', 'C#7', 'D7', 'D#7', 'E7', 'F7', 'F#7',
    'G7', 'G#7', 'A7', 'B7', 'H7',
    'C8', 'C#8', 'D8', 'D#8', 'E8', 'F8', 'F#8', 'G8');

function GetNoteName(aValue: integer): string;
function StrToCHex(aVal: string): string;

implementation

function GetNoteName(aValue: integer): string;
begin
  if (aValue >= 0) and (aValue < 128) then
    Result := FNotes[aValue]
  else
    Result := 'UNK';
end;

function StrToCHex(aVal: string): string;
var
  tmpInt: integer;
begin
  if TryStrToInt(aVal, tmpInt) then
    Result := IntToHex(tmpInt, 2)
  else
    Result := '0'; //wrong, but...
  if pos('$', Result) > 0 then Result := ReplaceStr(Result, '$', '0x')
  else
    Result := '0x' + Result;
end;

constructor TMiniINIFile.Create;
begin
  inherited;
  FMiniINI := TStringList.Create;
end;

destructor TMiniINIFile.Destroy;
begin
  if Assigned(FMiniINI) then FMiniINI.Free;
  inherited;
end;

function TMiniINIFile.LoadFromFile(aFile: string): boolean;
begin
  Result := False;
  try
    FMiniINI.LoadFromFile(aFile);
    Result := True;
  except
    on e: Exception do Result := False;
  end;
end;

function TMiniINIFile.SaveToFile(aFile: string): boolean;
begin
  Result := False;
  try
    FMiniINI.SaveToFile(aFile);
    Result := True;
  except
    on e: Exception do Result := False;
  end;
end;

function TMiniINIFile.ReadInteger(aName: string; aDefault: integer): integer;
var
  tmp: string;
begin
  tmp := FMiniINI.Values[aName];
  if tmp = '' then Result := aDefault
  else
  if (not TryStrToInt(trim(tmp), Result) = True) then Result := aDefault;
end;

function TMiniINIFile.ReadString(aName: string; aDefault: string): string;
var
  tmp: string;
begin
  tmp := FMiniINI.Values[aName];
  if tmp = '' then Result := trim(aDefault)
  else
    Result := trim(tmp);
end;

procedure TMiniINIFile.WriteInteger(aName: string; aVal: integer);
begin
  FMiniINI.Values[aName] := IntToStr(aVal);
end;

procedure TMiniINIFile.WriteString(aName, aVal: string);
begin
  FMiniINI.Values[aName] := trim(aVal);
end;

procedure TMiniINIFile.Comment(aName: string);
begin
  if FMiniINI.IndexOfName('#' + aName) <> -1 then
    FMiniINI.Delete(FMiniINI.IndexOfName('#' + aName));  //delete old commented line
  FMiniINI.Insert(FMiniINI.IndexOfName(aName), '#' +
    FMiniINI[FMiniINI.IndexOfName(aName)]);
  //insert new commented line
  FMiniINI.Delete(FMiniINI.IndexOfName(aName)); //delete uncommented line
end;

procedure TMiniINIFile.Uncomment(aName: string);
var
  tmpStr: string;
begin
  tmpStr := copy(aName, 2, length(aName));
  if FMiniINI.IndexOfName(tmpStr) <> -1 then
    FMiniINI.Delete(FMiniINI.IndexOfName(tmpStr));  //delete old uncommented line
  FMiniINI.Insert(FMiniINI.IndexOfName(aName), tmpStr + '=');
  //insert new uncommented line
  FMiniINI.Values[tmpStr] := FMiniINI.Values[aName]; //copy value
  FMiniINI.Delete(FMiniINI.IndexOfName(aName)); //delete commented line
end;

function TMiniINIFile.NameExists(aName: string): boolean;
begin
  Result := FMiniINI.IndexOfName(aName) <> -1;
end;

procedure TMiniINIFile.InitPerformance;
begin
  FMiniINI.Clear;
  FMiniINI.Add('#');
  FMiniINI.Add('#  performance.ini');
  FMiniINI.Add('#  edited/created with');
  FMiniINI.Add('#  MiniDexed Controle Center');
  FMiniINI.Add('#');
  FMiniINI.Add('#  https://github.com/BobanSpasic/MiniDexedLibrarian');
  FMiniINI.Add('#');
  FMiniINI.Add('');
  FMiniINI.Add('# TG#');
  FMiniINI.Add('#BankNumber#=0		# 0 .. 127');
  FMiniINI.Add('#VoiceNumber#=1		# 1 .. 32');
  FMiniINI.Add('#MIDIChannel#=1		# 1 .. 16, 0: off, >16: omni mode');
  FMiniINI.Add('#Volume#=100		# 0 .. 127');
  FMiniINI.Add('#Pan#=64		# 0 .. 127');
  FMiniINI.Add('#Detune#=0		# -99 .. 99');
  FMiniINI.Add('#Cutoff#=99		# 0 .. 99');
  FMiniINI.Add('#Resonance#=0		# 0 .. 99');
  FMiniINI.Add('#NoteLimitLow#=0	# 0 .. 127, C-2 .. G8');
  FMiniINI.Add('#NoteLimitHigh#=127	# 0 .. 127, C-2 .. G8');
  FMiniINI.Add('#NoteShift#=0		# -24 .. 24');
  FMiniINI.Add('#ReverbSend#=0		# 0 .. 99');
  FMiniINI.Add('#PitchBendRange#=2 # 0 .. 12');
  FMiniINI.Add('#PitchBendStep#=0 # 0 .. 12');
  FMiniINI.Add('#PortamentoMode#=0 # 0 .. 1');
  FMiniINI.Add('#PortamentoGlissando#=0 # 0 .. 1');
  FMiniINI.Add('#PortamentoTime#=0 # 0 .. 99');
  FMiniINI.Add(
    '#VoiceData#= # space separated hex numbers of 156 voice parameters. Example: 5F 1D 14 32 63 [....] 20 55');
  FMiniINI.Add('#MonoMode#=0 # 0-off .. 1-On');
  FMiniINI.Add('#ModulationWheelRange#=99 # 0..99');
  FMiniINI.Add('#ModulationWheelTarget#=1 # 0..7');
  FMiniINI.Add('#FootControlRange#=99 # 0..99');
  FMiniINI.Add('#FootControlTarget#=0 # 0..7');
  FMiniINI.Add('#BreathControlRange#=99 # 0..99');
  FMiniINI.Add('#BreathControlTarget#=0 # 0..7');
  FMiniINI.Add('#AftertouchRange#=99 # 0..99');
  FMiniINI.Add('#AftertouchTarget#=0 # 0..7');
  FMiniINI.Add('');
  FMiniINI.Add('# TG1');
  FMiniINI.Add('BankNumber1=0');
  FMiniINI.Add('VoiceNumber1=1');
  FMiniINI.Add('MIDIChannel1=255');
  FMiniINI.Add('Volume1=100');
  FMiniINI.Add('Pan1=0');
  FMiniINI.Add('Detune1=-11');
  FMiniINI.Add('Cutoff1=99');
  FMiniINI.Add('Resonance1=0');
  FMiniINI.Add('NoteLimitLow1=0');
  FMiniINI.Add('NoteLimitHigh1=127');
  FMiniINI.Add('NoteShift1=0');
  FMiniINI.Add('ReverbSend1=99');
  FMiniINI.Add('PitchBendRange1=2');
  FMiniINI.Add('PitchBendStep1=0');
  FMiniINI.Add('PortamentoMode1=0');
  FMiniINI.Add('PortamentoGlissando1=0');
  FMiniINI.Add('PortamentoTime1=0');
  FMiniINI.Add('VoiceData1=');
  FMiniINI.Add('MonoMode1=0');
  FMiniINI.Add('ModulationWheelRange1=99');
  FMiniINI.Add('ModulationWheelTarget1=1');
  FMiniINI.Add('FootControlRange1=99');
  FMiniINI.Add('FootControlTarget1=0');
  FMiniINI.Add('BreathControlRange1=99');
  FMiniINI.Add('BreathControlTarget1=0');
  FMiniINI.Add('AftertouchRange1=99');
  FMiniINI.Add('AftertouchTarget1=0');
  FMiniINI.Add('');
  FMiniINI.Add('# TG2');
  FMiniINI.Add('BankNumber2=0');
  FMiniINI.Add('VoiceNumber2=1');
  FMiniINI.Add('MIDIChannel2=255');
  FMiniINI.Add('Volume2=100');
  FMiniINI.Add('Pan2=0');
  FMiniINI.Add('Detune2=-11');
  FMiniINI.Add('Cutoff2=99');
  FMiniINI.Add('Resonance2=0');
  FMiniINI.Add('NoteLimitLow2=0');
  FMiniINI.Add('NoteLimitHigh2=127');
  FMiniINI.Add('NoteShift2=0');
  FMiniINI.Add('ReverbSend2=99');
  FMiniINI.Add('PitchBendRange2=2');
  FMiniINI.Add('PitchBendStep2=0');
  FMiniINI.Add('PortamentoMode2=0');
  FMiniINI.Add('PortamentoGlissando2=0');
  FMiniINI.Add('PortamentoTime2=0');
  FMiniINI.Add('VoiceData2=');
  FMiniINI.Add('MonoMode2=0');
  FMiniINI.Add('ModulationWheelRange2=99');
  FMiniINI.Add('ModulationWheelTarget2=1');
  FMiniINI.Add('FootControlRange2=99');
  FMiniINI.Add('FootControlTarget2=0');
  FMiniINI.Add('BreathControlRange2=99');
  FMiniINI.Add('BreathControlTarget2=0');
  FMiniINI.Add('AftertouchRange2=99');
  FMiniINI.Add('AftertouchTarget2=0');
  FMiniINI.Add('');
  FMiniINI.Add('# TG3');
  FMiniINI.Add('BankNumber3=0');
  FMiniINI.Add('VoiceNumber3=1');
  FMiniINI.Add('MIDIChannel3=255');
  FMiniINI.Add('Volume3=100');
  FMiniINI.Add('Pan3=0');
  FMiniINI.Add('Detune3=-11');
  FMiniINI.Add('Cutoff3=99');
  FMiniINI.Add('Resonance3=0');
  FMiniINI.Add('NoteLimitLow3=0');
  FMiniINI.Add('NoteLimitHigh3=127');
  FMiniINI.Add('NoteShift3=0');
  FMiniINI.Add('ReverbSend3=99');
  FMiniINI.Add('PitchBendRange3=2');
  FMiniINI.Add('PitchBendStep3=0');
  FMiniINI.Add('PortamentoMode3=0');
  FMiniINI.Add('PortamentoGlissando3=0');
  FMiniINI.Add('PortamentoTime3=0');
  FMiniINI.Add('VoiceData3=');
  FMiniINI.Add('MonoMode3=0');
  FMiniINI.Add('ModulationWheelRange3=99');
  FMiniINI.Add('ModulationWheelTarget3=1');
  FMiniINI.Add('FootControlRange3=99');
  FMiniINI.Add('FootControlTarget3=0');
  FMiniINI.Add('BreathControlRange3=99');
  FMiniINI.Add('BreathControlTarget3=0');
  FMiniINI.Add('AftertouchRange3=99');
  FMiniINI.Add('AftertouchTarget3=0');
  FMiniINI.Add('');
  FMiniINI.Add('# TG4');
  FMiniINI.Add('BankNumber4=0');
  FMiniINI.Add('VoiceNumber4=1');
  FMiniINI.Add('MIDIChannel4=255');
  FMiniINI.Add('Volume4=100');
  FMiniINI.Add('Pan4=0');
  FMiniINI.Add('Detune4=-11');
  FMiniINI.Add('Cutoff4=99');
  FMiniINI.Add('Resonance4=0');
  FMiniINI.Add('NoteLimitLow4=0');
  FMiniINI.Add('NoteLimitHigh4=127');
  FMiniINI.Add('NoteShift4=0');
  FMiniINI.Add('ReverbSend4=99');
  FMiniINI.Add('PitchBendRange4=2');
  FMiniINI.Add('PitchBendStep4=0');
  FMiniINI.Add('PortamentoMode4=0');
  FMiniINI.Add('PortamentoGlissando4=0');
  FMiniINI.Add('PortamentoTime4=0');
  FMiniINI.Add('VoiceData4=');
  FMiniINI.Add('MonoMode4=0');
  FMiniINI.Add('ModulationWheelRange4=99');
  FMiniINI.Add('ModulationWheelTarget4=1');
  FMiniINI.Add('FootControlRange4=99');
  FMiniINI.Add('FootControlTarget4=0');
  FMiniINI.Add('BreathControlRange4=99');
  FMiniINI.Add('BreathControlTarget4=0');
  FMiniINI.Add('AftertouchRange4=99');
  FMiniINI.Add('AftertouchTarget4=0');
  FMiniINI.Add('');
  FMiniINI.Add('# TG5');
  FMiniINI.Add('BankNumber5=0');
  FMiniINI.Add('VoiceNumber5=1');
  FMiniINI.Add('MIDIChannel5=255');
  FMiniINI.Add('Volume5=100');
  FMiniINI.Add('Pan5=0');
  FMiniINI.Add('Detune5=-11');
  FMiniINI.Add('Cutoff5=99');
  FMiniINI.Add('Resonance5=0');
  FMiniINI.Add('NoteLimitLow5=0');
  FMiniINI.Add('NoteLimitHigh5=127');
  FMiniINI.Add('NoteShift5=0');
  FMiniINI.Add('ReverbSend5=99');
  FMiniINI.Add('PitchBendRange5=2');
  FMiniINI.Add('PitchBendStep5=0');
  FMiniINI.Add('PortamentoMode5=0');
  FMiniINI.Add('PortamentoGlissando5=0');
  FMiniINI.Add('PortamentoTime5=0');
  FMiniINI.Add('VoiceData5=');
  FMiniINI.Add('MonoMode5=0');
  FMiniINI.Add('ModulationWheelRange5=99');
  FMiniINI.Add('ModulationWheelTarget5=1');
  FMiniINI.Add('FootControlRange5=99');
  FMiniINI.Add('FootControlTarget5=0');
  FMiniINI.Add('BreathControlRange5=99');
  FMiniINI.Add('BreathControlTarget5=0');
  FMiniINI.Add('AftertouchRange5=99');
  FMiniINI.Add('AftertouchTarget5=0');
  FMiniINI.Add('');
  FMiniINI.Add('# TG6');
  FMiniINI.Add('BankNumber6=0');
  FMiniINI.Add('VoiceNumber6=1');
  FMiniINI.Add('MIDIChannel6=255');
  FMiniINI.Add('Volume6=100');
  FMiniINI.Add('Pan6=0');
  FMiniINI.Add('Detune6=-11');
  FMiniINI.Add('Cutoff6=99');
  FMiniINI.Add('Resonance6=0');
  FMiniINI.Add('NoteLimitLow6=0');
  FMiniINI.Add('NoteLimitHigh6=127');
  FMiniINI.Add('NoteShift6=0');
  FMiniINI.Add('ReverbSend6=99');
  FMiniINI.Add('PitchBendRange6=2');
  FMiniINI.Add('PitchBendStep6=0');
  FMiniINI.Add('PortamentoMode6=0');
  FMiniINI.Add('PortamentoGlissando6=0');
  FMiniINI.Add('PortamentoTime6=0');
  FMiniINI.Add('VoiceData6=');
  FMiniINI.Add('MonoMode6=0');
  FMiniINI.Add('ModulationWheelRange6=99');
  FMiniINI.Add('ModulationWheelTarget6=1');
  FMiniINI.Add('FootControlRange6=99');
  FMiniINI.Add('FootControlTarget6=0');
  FMiniINI.Add('BreathControlRange6=99');
  FMiniINI.Add('BreathControlTarget6=0');
  FMiniINI.Add('AftertouchRange6=99');
  FMiniINI.Add('AftertouchTarget6=0');
  FMiniINI.Add('');
  FMiniINI.Add('# TG7');
  FMiniINI.Add('BankNumber7=0');
  FMiniINI.Add('VoiceNumber7=1');
  FMiniINI.Add('MIDIChannel7=255');
  FMiniINI.Add('Volume7=100');
  FMiniINI.Add('Pan7=0');
  FMiniINI.Add('Detune7=-11');
  FMiniINI.Add('Cutoff7=99');
  FMiniINI.Add('Resonance7=0');
  FMiniINI.Add('NoteLimitLow7=0');
  FMiniINI.Add('NoteLimitHigh7=127');
  FMiniINI.Add('NoteShift7=0');
  FMiniINI.Add('ReverbSend7=99');
  FMiniINI.Add('PitchBendRange7=2');
  FMiniINI.Add('PitchBendStep7=0');
  FMiniINI.Add('PortamentoMode7=0');
  FMiniINI.Add('PortamentoGlissando7=0');
  FMiniINI.Add('PortamentoTime7=0');
  FMiniINI.Add('VoiceData7=');
  FMiniINI.Add('MonoMode7=0');
  FMiniINI.Add('ModulationWheelRange7=99');
  FMiniINI.Add('ModulationWheelTarget7=1');
  FMiniINI.Add('FootControlRange7=99');
  FMiniINI.Add('FootControlTarget7=0');
  FMiniINI.Add('BreathControlRange7=99');
  FMiniINI.Add('BreathControlTarget7=0');
  FMiniINI.Add('AftertouchRange7=99');
  FMiniINI.Add('AftertouchTarget7=0');
  FMiniINI.Add('');
  FMiniINI.Add('# TG8');
  FMiniINI.Add('BankNumber8=0');
  FMiniINI.Add('VoiceNumber8=1');
  FMiniINI.Add('MIDIChannel8=255');
  FMiniINI.Add('Volume8=100');
  FMiniINI.Add('Pan8=0');
  FMiniINI.Add('Detune8=-11');
  FMiniINI.Add('Cutoff8=99');
  FMiniINI.Add('Resonance8=0');
  FMiniINI.Add('NoteLimitLow8=0');
  FMiniINI.Add('NoteLimitHigh8=127');
  FMiniINI.Add('NoteShift8=0');
  FMiniINI.Add('ReverbSend8=99');
  FMiniINI.Add('PitchBendRange8=2');
  FMiniINI.Add('PitchBendStep8=0');
  FMiniINI.Add('PortamentoMode8=0');
  FMiniINI.Add('PortamentoGlissando8=0');
  FMiniINI.Add('PortamentoTime8=0');
  FMiniINI.Add('VoiceData8=');
  FMiniINI.Add('MonoMode8=0');
  FMiniINI.Add('ModulationWheelRange8=99');
  FMiniINI.Add('ModulationWheelTarget8=1');
  FMiniINI.Add('FootControlRange8=99');
  FMiniINI.Add('FootControlTarget8=0');
  FMiniINI.Add('BreathControlRange8=99');
  FMiniINI.Add('BreathControlTarget8=0');
  FMiniINI.Add('AftertouchRange8=99');
  FMiniINI.Add('AftertouchTarget8=0');
  FMiniINI.Add('');
  FMiniINI.Add('# Effects');
  FMiniINI.Add('#CompressorEnable=1	# 0: off, 1: on');
  FMiniINI.Add('#ReverbEnable=1		# 0: off, 1: on');
  FMiniINI.Add('#ReverbSize=70		# 0 .. 99');
  FMiniINI.Add('#ReverbHighDamp=50	# 0 .. 99');
  FMiniINI.Add('#ReverbLowDamp=50	# 0 .. 99');
  FMiniINI.Add('#ReverbLowPass=30	# 0 .. 99');
  FMiniINI.Add('#ReverbDiffusion=65	# 0 .. 99');
  FMiniINI.Add('#ReverbLevel=80		# 0 .. 99');
  FMiniINI.Add('');
  FMiniINI.Add('# Effects');
  FMiniINI.Add('CompressorEnable=1');
  FMiniINI.Add('ReverbEnable=1');
  FMiniINI.Add('ReverbSize=70');
  FMiniINI.Add('ReverbHighDamp=50');
  FMiniINI.Add('ReverbLowDamp=50');
  FMiniINI.Add('ReverbLowPass=30');
  FMiniINI.Add('ReverbDiffusion=65');
  FMiniINI.Add('ReverbLevel=80');
end;

procedure TMiniINIFile.InitMiniDexedINI;
begin
  FMiniINI.Clear;
  FMiniINI.Add('#');
  FMiniINI.Add('#  minidexed.ini');
  FMiniINI.Add('#  edited/created with');
  FMiniINI.Add('#  MiniDexed Controle Center');
  FMiniINI.Add('#');
  FMiniINI.Add('#  https://github.com/BobanSpasic/MiniDexedLibrarian');
  FMiniINI.Add('#');
  FMiniINI.Add('');
  FMiniINI.Add('# Comments');
  FMiniINI.Add('CommentLine1=');
  FMiniINI.Add('CommentLine2=');
  FMiniINI.Add('CommentLine3=');
  FMiniINI.Add('');
  FMiniINI.Add('# Sound device');
  FMiniINI.Add('#SoundDevice=i2s, pwm, hdmi');
  FMiniINI.Add('SoundDevice=pwm');
  FMiniINI.Add('SampleRate=48000');
  FMiniINI.Add('#ChunkSize=256');
  FMiniINI.Add('DACI2CAddress=0');
  FMiniINI.Add('ChannelsSwapped=0');
  FMiniINI.Add('');
  FMiniINI.Add('# MIDI');
  FMiniINI.Add('MIDIBaudRate=31250');
  FMiniINI.Add('#MIDIThru=umidi1,ttyS1');
  FMiniINI.Add('MIDIRXProgramChange=1');
  FMiniINI.Add('');
  FMiniINI.Add('# HD44780 LCD');
  FMiniINI.Add('LCDEnabled=1');
  FMiniINI.Add('LCDPinEnable=17');
  FMiniINI.Add('LCDPinRegisterSelect=4');
  FMiniINI.Add('LCDPinReadWrite=0');
  FMiniINI.Add('LCDPinData4=22');
  FMiniINI.Add('LCDPinData5=23');
  FMiniINI.Add('LCDPinData6=24');
  FMiniINI.Add('LCDPinData7=25');
  FMiniINI.Add('LCDI2CAddress=0x00');
  FMiniINI.Add('');
  FMiniINI.Add('# KY-040 Rotary Encoder');
  FMiniINI.Add('EncoderEnabled=1');
  FMiniINI.Add('EncoderPinClock=10');
  FMiniINI.Add('EncoderPinData=9');
  FMiniINI.Add('EncoderPinSwitch=11');
  FMiniINI.Add('');
  FMiniINI.Add('# Debug');
  FMiniINI.Add('MIDIDumpEnabled=0');
  FMiniINI.Add('ProfileEnabled=0');
  FMiniINI.Add('');
  FMiniINI.Add('# Performance');
  FMiniINI.Add('PerformanceSelectToLoad=1');
end;

end.
