unit untMiniINI;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

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
    procedure Init;
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

implementation

function GetNoteName(aValue: integer): string;
begin
  if (aValue >= 0) and (aValue < 128) then
    Result := FNotes[aValue]
  else
    Result := 'UNK';
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
  if (not TryStrToInt(tmp, Result) = True) then Result := aDefault;
end;

function TMiniINIFile.ReadString(aName: string; aDefault: string): string;
var
  tmp: string;
begin
  tmp := FMiniINI.Values[aName];
  if tmp = '' then Result := aDefault
  else
    Result := tmp;
end;

procedure TMiniINIFile.WriteInteger(aName: string; aVal: integer);
begin
  FMiniINI.Values[aName] := IntToStr(aVal);
end;

procedure TMiniINIFile.WriteString(aName, aVal: string);
begin
  FMiniINI.Values[aName] := aVal;
end;

procedure TMiniINIFile.Init;
begin
  FMiniINI.Clear;
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

end.
