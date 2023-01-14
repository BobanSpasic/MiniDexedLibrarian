{
 *****************************************************************************
  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************

 Author: Boban Spasic

}

unit untMDXPerformance;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, untDX7Voice, untMDXSupplement, untMiniINI, untParConst,
  LazFileUtils, StrUtils, HlpHashFactory;

type
  TMDXTG = record
    BankNumberMSB: byte;
    BankNumberLSB: byte;
    VoiceNumber: byte;
    MIDIChannel: byte;
    VoiceData: TDX7_VCED_Dump;
    SupplData: TMDX_PCEDx_Params;
  end;

  TMDXGeneral = record
    Name: array [0..31] of char;
    Category: array [0..31] of char;
    Origin: array [0..255] of char;
    Version: byte;
  end;

  TMDXEffects = record
    CompressorEnable: byte;
    //plate reverb
    ReverbEnable: byte;
    ReverbSize: byte;
    ReverbHighDamp: byte;
    ReverbLowDamp: byte;
    ReverbLowPass: byte;
    ReverbDiffusion: byte;
    ReverbLevel: byte;
    //tube
    TubeEnable: byte;
    TubeOverdrive: byte;
    TubeLevel: byte;
    //chorus
    ChorusEnable: byte;
    ChorusRate: byte;
    ChorusDepth: byte;
    ChorusLevel: byte;
    //flanger
    FlangerEnable: byte;
    FlangerRate: byte;
    FlangerDepth: byte;
    FlangerFeedback: byte;
    FlangerLevel: byte;
    //orbitone
    OrbitoneEnable: byte;
    OrbitoneRate: byte;
    OrbitoneDepth: byte;
    OrbitoneLevel: byte;
    //phaser
    PhaserEnable: byte;
    PhaserRate: byte;
    PhaserDepth: byte;
    PhaserFeedback: byte;
    PhaserNbStages: byte;
    PhaserLevel: byte;
    //Delay
    DelayEnable: byte;
    DelayLeft: byte;
    DelayRight: byte;
    DelayLevel: byte;
    DelayFeedback: byte;
    //shimmer reverb
    ShimmerEnable: byte;
    ShimmerGain: byte;
    ShimmerTime: byte;
    ShimmerDiffusion: byte;
    ShimmerLowPass: byte;
    ShimmerLevel: byte;
  end;

  TMDX_PCEDx = record
    General: TMDXGeneral;
    TG: array [1..8] of TMDXTG;
    Eff: TMDXEffects;
  end;

type
  TMDXPerformanceContainer = class(TPersistent)
  private
    FDX7_Params: TDX7_VCED_Params;
  public
    FMDX_Params: TMDX_PCEDx;

    constructor Create;
    destructor Destroy; override;

    procedure InitPerformance;
    function LoadPerformanceFromStream(var aStream: TMemoryStream): boolean;
    function SavePerformanceToStream(var aStream: TMemoryStream): boolean;
    procedure LoadPerformanceFromFile(aName: string);
    procedure SavePerformanceToFile(aName: string; aComments: boolean);
    procedure LoadVoiceToTG(aNr: integer; aVCED: TDX7_VCED_Dump);
    procedure LoadPCEDxToTG(aNr: integer; aPCEDx: TMDX_PCEDx_Params);
    function GetTGVoiceName(aNr: integer): string;
    function GetTGVoiceData(aNr: integer): TDX7_VCED_Params;
    function GetTGPCEDxData(aNr: integer): TMDX_PCEDx_Params;
    function CalculateTGHash(aNr: integer): string;
  end;

implementation

constructor TMDXPerformanceContainer.Create;
begin
  inherited;
end;

destructor TMDXPerformanceContainer.Destroy;
begin
  inherited;
end;

procedure TMDXPerformanceContainer.InitPerformance;
var
  i: integer;
begin
  with FMDX_Params.General do
  begin
    Name := 'INIT_PERFORMANCE';
    Category := 'Default';
    Origin := '_new';
    Version := 1;
  end;
  for i := 1 to 8 do
  begin
    with FMDX_Params.TG[i] do
    begin
      BankNumberMSB := 0;
      BankNumberLSB := 0;
      VoiceNumber := 1;
      MIDIChannel := 255;
      GetDefinedValues(DX7, fInit, VoiceData);
      GetDefinedValues(MDX, fInit, SupplData.params);
    end;
  end;
  with FMDX_Params.Eff do
  begin
    CompressorEnable := 1;
    ReverbEnable := 1;
    ReverbSize := 70;
    ReverbHighDamp := 50;
    ReverbLowDamp := 50;
    ReverbLowPass := 30;
    ReverbDiffusion := 65;
    ReverbLevel := 80;
  end;
end;

function TMDXPerformanceContainer.LoadPerformanceFromStream(
  var aStream: TMemoryStream): boolean;
var
  i, j: integer;
begin
  Result := False;
  if Assigned(aStream) then
  begin
    aStream.Position := 0;
    with FMDX_Params.General do
    begin
      for i := 0 to 31 do
        Name[i] := char(aStream.ReadByte);
      for i := 0 to 31 do
        Category[i] := char(aStream.ReadByte);
      for i := 0 to 255 do
        Origin[i] := char(aStream.ReadByte);
      Version := aStream.ReadByte;
    end;
    for i := 1 to 8 do
    begin
      with FMDX_Params.TG[i] do
      begin
        BankNumberMSB := aStream.ReadByte;
        BankNumberLSB := aStream.ReadByte;
        VoiceNumber := aStream.ReadByte;
        MIDIChannel := aStream.ReadByte;
        for j := 0 to 155 do
          VoiceData[j] := aStream.ReadByte;
        for j := 0 to 52 do
          FMDX_Params.TG[i].SupplData.params[j] := aStream.ReadByte;
      end;
    end;
    with FMDX_Params.Eff do
    begin
      CompressorEnable := aStream.ReadByte;
      ReverbEnable := aStream.ReadByte;
      ReverbSize := aStream.ReadByte;
      ReverbHighDamp := aStream.ReadByte;
      ReverbLowDamp := aStream.ReadByte;
      ReverbLowPass := aStream.ReadByte;
      ReverbDiffusion := aStream.ReadByte;
      ReverbLevel := aStream.ReadByte;
    end;
    Result := True;
  end;
end;

function TMDXPerformanceContainer.SavePerformanceToStream(
  var aStream: TMemoryStream): boolean;
var
  i, j: integer;
begin
  Result := False;
  if Assigned(aStream) then
  begin
    aStream.Position := 0;
    with FMDX_Params.General do
    begin
      for i := 0 to 31 do
        aStream.WriteByte(Ord(Name[i]));
      for i := 0 to 31 do
        aStream.WriteByte(Ord(Category[i]));
      for i := 0 to 255 do
        aStream.WriteByte(Ord(Origin[i]));
      aStream.WriteByte(Version);
    end;
    for i := 1 to 8 do
    begin
      with FMDX_Params.TG[i] do
      begin
        aStream.WriteByte(BankNumberMSB);
        aStream.WriteByte(BankNumberLSB);
        aStream.WriteByte(VoiceNumber);
        aStream.WriteByte(MIDIChannel);
        for j := 0 to 155 do
          aStream.WriteByte(VoiceData[j]);
        for j := 0 to 52 do
          aStream.WriteByte(FMDX_Params.TG[i].SupplData.params[j]);
      end;
    end;
    with FMDX_Params.Eff do
    begin
      aStream.WriteByte(CompressorEnable);
      aStream.WriteByte(ReverbEnable);
      aStream.WriteByte(ReverbSize);
      aStream.WriteByte(ReverbHighDamp);
      aStream.WriteByte(ReverbLowDamp);
      aStream.WriteByte(ReverbLowPass);
      aStream.WriteByte(ReverbDiffusion);
      aStream.WriteByte(ReverbLevel);
    end;
    Result := True;
  end;
end;

procedure TMDXPerformanceContainer.LoadPerformanceFromFile(aName: string);
var
  ini: TMiniINIFile;
  hexstring: string;
  hexchar: string;
  chkStr: string;
  sName: string;
  sCategory: string;
  sOrigin: string;
  iVersion: integer;
  iCount: integer;
  sCount: string;
  i: integer;
begin
  ini := TMiniINIFile.Create;
  ini.LoadFromFile(aName);

  //get the performance name from file name
  sName := ExtractFileNameWithoutExt(ExtractFileName(aName));
  chkStr := copy(sName, 0, 6);
  if StrToInt64Def(chkStr, -1) <> -1 then
    sName := copy(sName, 8, Length(sName) - 7);  //name contains 000xxx_
  if Length(sName) > 32 then
    SetLength(sName, 32);
  FMDX_Params.General.Name := sName; //name does not contain 000xxx

  //General
  //overwrite the name if contained in INI
  sName := ini.ReadString('Name', '');
  if sName <> '' then
  begin
    if Length(sName) > 32 then
      SetLength(sName, 32);
    FMDX_Params.General.Name := sName;
  end;

  sCategory := ini.ReadString('Category', '');
  if Length(sCategory) > 32 then
    SetLength(sCategory, 32);
  if sCategory <> '' then
    FMDX_Params.General.Category := sCategory
  else
    FMDX_Params.General.Category := 'Default';

  sOrigin := ini.ReadString('Origin', '');
  if Length(sOrigin) > 256 then
    SetLength(sOrigin, 256);
  if sOrigin <> '' then FMDX_Params.General.Origin := sOrigin
  else
    FMDX_Params.General.Origin := 'Unknown';

  iVersion := ini.ReadInteger('Version', 1);
  FMDX_Params.General.Version := iVersion;

  //TGs
  for iCount := 1 to 8 do
  begin
    sCount := IntToStr(iCount);
    //initialize because of the future parameters
    GetDefinedValues(MDX, fInit, FMDX_Params.TG[iCount].SupplData.params);
    FMDX_Params.TG[iCount].MIDIChannel :=
      ini.ReadInteger('MIDIChannel' + sCount, 1);
    FMDX_Params.TG[iCount].SupplData.Volume :=
      ini.ReadInteger('Volume' + sCount, 100);
    FMDX_Params.TG[iCount].SupplData.Pan :=
      ini.ReadInteger('Pan' + sCount, 0);
    FMDX_Params.TG[iCount].SupplData.DetuneVAL :=
      Abs(ini.ReadInteger('Detune' + sCount, 0));
    if ini.ReadInteger('Detune' + sCount, 0) < 0 then
      FMDX_Params.TG[iCount].SupplData.DetuneSGN := 1
    else
      FMDX_Params.TG[iCount].SupplData.DetuneSGN := 0;
    FMDX_Params.TG[iCount].SupplData.Cutoff :=
      ini.ReadInteger('Cutoff' + sCount, 99);
    FMDX_Params.TG[iCount].SupplData.Resonance :=
      ini.ReadInteger('Resonance' + sCount, 0);
    FMDX_Params.TG[iCount].SupplData.NoteLimitLow :=
      ini.ReadInteger('NoteLimitLow' + sCount, 0);
    FMDX_Params.TG[iCount].SupplData.NoteLimitHigh :=
      ini.ReadInteger('NoteLimitHigh' + sCount, 127);
    FMDX_Params.TG[iCount].SupplData.NoteShift :=
      ini.ReadInteger('NoteShift' + sCount, 0) + 24;
    FMDX_Params.TG[iCount].SupplData.FX1Send :=
      ini.ReadInteger('ReverbSend' + sCount, 0);
    FMDX_Params.TG[iCount].SupplData.PitchBendRange :=
      ini.ReadInteger('PitchBendRange' + sCount, 2);
    FMDX_Params.TG[iCount].SupplData.PitchBendStep :=
      ini.ReadInteger('PitchBendStep' + sCount, 0);
    FMDX_Params.TG[iCount].SupplData.PortamentoMode :=
      ini.ReadInteger('PortamentoMode' + sCount, 0);
    FMDX_Params.TG[iCount].SupplData.PortamentoGlissando :=
      ini.ReadInteger('PortamentoGlissando' + sCount, 0);
    FMDX_Params.TG[iCount].SupplData.PortamentoTime :=
      ini.ReadInteger('PortamentoTime' + sCount, 0);
    hexstring := ini.ReadString('VoiceData' + sCount, '');

    if hexstring <> '' then
    begin
      for i := 0 to 155 do
      begin
        hexchar := copy(hexstring, i * 3, 3);
        hexchar := trim(hexchar);
        FMDX_Params.TG[iCount].VoiceData[i] := byte(Hex2Dec(hexchar));
      end;
    end
    else
      GetDefinedValues(DX7, fInit, FMDX_Params.TG[iCount].VoiceData);

    FMDX_Params.TG[iCount].SupplData.MonoMode :=
      ini.ReadInteger('MonoMode' + sCount, 0);
    FMDX_Params.TG[iCount].SupplData.ModulationWheelRange :=
      ini.ReadInteger('ModulationWheelRange' + sCount, 99);
    FMDX_Params.TG[iCount].SupplData.ModulationWheelTarget :=
      ini.ReadInteger('ModulationWheelTarget' + sCount, 1);
    FMDX_Params.TG[iCount].SupplData.FootControlRange :=
      ini.ReadInteger('FootControlRange' + sCount, 99);
    FMDX_Params.TG[iCount].SupplData.FootControlTarget :=
      ini.ReadInteger('FootControlTarget' + sCount, 0);
    FMDX_Params.TG[iCount].SupplData.BreathControlRange :=
      ini.ReadInteger('BreathControlRange' + sCount, 99);
    FMDX_Params.TG[iCount].SupplData.BreathControlTarget :=
      ini.ReadInteger('BreathControlTarget' + sCount, 0);
    FMDX_Params.TG[iCount].SupplData.AftertouchRange :=
      ini.ReadInteger('AfterTouchRange' + sCount, 99);
    FMDX_Params.TG[iCount].SupplData.AftertouchTarget :=
      ini.ReadInteger('AfterTouchTarget' + sCount, 0);
  end;

  //Effects
  FMDX_Params.Eff.CompressorEnable :=
    ini.ReadInteger('CompressorEnable', 1);
  FMDX_Params.Eff.ReverbEnable :=
    ini.ReadInteger('ReverbEnable', 1);
  FMDX_Params.Eff.ReverbSize :=
    ini.ReadInteger('ReverbSize', 70);
  FMDX_Params.Eff.ReverbHighDamp :=
    ini.ReadInteger('ReverbHighDamp', 50);
  FMDX_Params.Eff.ReverbLowDamp :=
    ini.ReadInteger('ReverbLowDamp', 50);
  FMDX_Params.Eff.ReverbLowPass :=
    ini.ReadInteger('ReverbLowPass', 30);
  FMDX_Params.Eff.ReverbDiffusion :=
    ini.ReadInteger('ReverbDiffusion', 65);
  FMDX_Params.Eff.ReverbLevel :=
    ini.ReadInteger('ReverbLevel', 80);

  ini.Free;
end;

procedure TMDXPerformanceContainer.SavePerformanceToFile(aName: string;
  aComments: boolean);
var
  ini: TMiniINIFile;
  hexstring: string;
  hexchar: string;
  iCount: integer;
  sCount: string;
  i: integer;
  det: integer;
begin
  ini := TMiniINIFile.Create;
  ini.InitPerformance(aComments);
  //MiniDexedCC-specific
  ini.WriteString('Name',
    FMDX_Params.General.Name);
  ini.WriteString('Category',
    FMDX_Params.General.Category);
  ini.WriteString('Origin',
    FMDX_Params.General.Origin);
  ini.WriteInteger('Version',
    FMDX_Params.General.Version);

  //TGs
  for iCount := 1 to 8 do
  begin
    sCount := IntToStr(iCount);
    ini.WriteInteger('MIDIChannel' + sCount,
      FMDX_Params.TG[iCount].MIDIChannel);
    ini.WriteInteger('Volume' + sCount,
      FMDX_Params.TG[iCount].SupplData.Volume);
    ini.WriteInteger('Pan' + sCount,
      FMDX_Params.TG[iCount].SupplData.Pan);
    det := FMDX_Params.TG[iCount].SupplData.DetuneVAL;
    if FMDX_Params.TG[iCount].SupplData.DetuneSGN = 1 then det := -det;
    ini.WriteInteger('Detune' + sCount, det);
    ini.WriteInteger('Cutoff' + sCount,
      FMDX_Params.TG[iCount].SupplData.Cutoff);
    ini.WriteInteger('Resonance' + sCount,
      FMDX_Params.TG[iCount].SupplData.Resonance);
    ini.WriteInteger('NoteLimitLow' + sCount,
      FMDX_Params.TG[iCount].SupplData.NoteLimitLow);
    ini.WriteInteger('NoteLimitHigh' + sCount,
      FMDX_Params.TG[iCount].SupplData.NoteLimitHigh);
    ini.WriteInteger('NoteShift' + sCount,
      FMDX_Params.TG[iCount].SupplData.NoteShift);
    ini.WriteInteger('ReverbSend' + sCount,
      FMDX_Params.TG[iCount].SupplData.FX1Send);
    ini.WriteInteger('PitchBendRange' + sCount,
      FMDX_Params.TG[iCount].SupplData.PitchBendRange);
    ini.WriteInteger('PitchBendStep' + sCount,
      FMDX_Params.TG[iCount].SupplData.PitchBendStep);
    ini.WriteInteger('PortamentoMode' + sCount,
      FMDX_Params.TG[iCount].SupplData.PortamentoMode);
    ini.WriteInteger('PortamentoGlissando' + sCount,
      FMDX_Params.TG[iCount].SupplData.PortamentoGlissando);
    ini.WriteInteger('PortamentoTime' + sCount,
      FMDX_Params.TG[iCount].SupplData.PortamentoTime);

    hexstring := '';
    for i := 0 to 155 do
    begin
      hexchar := IntToHex(FMDX_Params.TG[iCount].VoiceData[i], 2);
      hexstring := hexstring + hexchar + ' ';
    end;
    ini.WriteString('VoiceData' + sCount, hexstring);

    ini.WriteInteger('MonoMode' + sCount,
      FMDX_Params.TG[iCount].SupplData.MonoMode);
    ini.WriteInteger('ModulationWheelRange' + sCount,
      FMDX_Params.TG[iCount].SupplData.ModulationWheelRange);
    ini.WriteInteger('ModulationWheelTarget' + sCount,
      FMDX_Params.TG[iCount].SupplData.ModulationWheelTarget);
    ini.WriteInteger('FootControlRange' + sCount,
      FMDX_Params.TG[iCount].SupplData.FootControlRange);
    ini.WriteInteger('FootControlTarget' + sCount,
      FMDX_Params.TG[iCount].SupplData.FootControlTarget);
    ini.WriteInteger('BreathControlRange' + sCount,
      FMDX_Params.TG[iCount].SupplData.BreathControlRange);
    ini.WriteInteger('BreathControlTarget' + sCount,
      FMDX_Params.TG[iCount].SupplData.BreathControlTarget);
    ini.WriteInteger('AfterTouchRange' + sCount,
      FMDX_Params.TG[iCount].SupplData.AftertouchRange);
    ini.WriteInteger('AfterTouchTarget' + sCount,
      FMDX_Params.TG[iCount].SupplData.AftertouchTarget);
  end;

  //Effects
  ini.WriteInteger('CompressorEnable',
    FMDX_Params.Eff.CompressorEnable);
  ini.WriteInteger('ReverbEnable',
    FMDX_Params.Eff.ReverbEnable);
  ini.WriteInteger('ReverbSize',
    FMDX_Params.Eff.ReverbSize);
  ini.WriteInteger('ReverbHighDamp',
    FMDX_Params.Eff.ReverbHighDamp);
  ini.WriteInteger('ReverbLowDamp',
    FMDX_Params.Eff.ReverbLowDamp);
  ini.WriteInteger('ReverbLowPass',
    FMDX_Params.Eff.ReverbLowPass);
  ini.WriteInteger('ReverbDiffusion',
    FMDX_Params.Eff.ReverbDiffusion);
  ini.WriteInteger('ReverbLevel',
    FMDX_Params.Eff.ReverbLevel);

  ini.SaveToFile(aName);
  ini.Free;
end;

procedure TMDXPerformanceContainer.LoadVoiceToTG(aNr: integer; aVCED: TDX7_VCED_Dump);
begin
  FMDX_Params.TG[aNr].VoiceData := aVCED;
end;

procedure TMDXPerformanceContainer.LoadPCEDxToTG(aNr: integer; aPCEDx: TMDX_PCEDx_Params);
begin
  FMDX_Params.TG[aNr].SupplData := aPCEDx;
end;

function TMDXPerformanceContainer.GetTGVoiceName(aNr: integer): string;
var
  i: integer;
begin
  Result := '';
  for i := 145 to 154 do
    Result := Result + chr(FMDX_Params.TG[aNr].VoiceData[i]);
end;

function TMDXPerformanceContainer.GetTGVoiceData(aNr: integer): TDX7_VCED_Params;
begin
  FDX7_Params.params := FMDX_Params.TG[aNr].VoiceData;
  Result := FDX7_Params;
end;

function TMDXPerformanceContainer.GetTGPCEDxData(aNr: integer): TMDX_PCEDx_Params;
begin
  Result := FMDX_Params.TG[aNr].SupplData;
end;

function TMDXPerformanceContainer.CalculateTGHash(aNr: integer): string;
var
  aStream: TMemoryStream;
  i: integer;
begin
  aStream := TMemoryStream.Create;
  for i := low(FMDX_Params.TG[aNr].VoiceData) to high(FMDX_Params.TG[aNr].VoiceData) do
    aStream.WriteByte(FMDX_Params.TG[aNr].VoiceData[i]);
  for i := low(FMDX_Params.TG[aNr].SupplData.params) to high(FMDX_Params.TG[aNr].SupplData.params) do
    aStream.WriteByte(FMDX_Params.TG[aNr].SupplData.params[i]);
  aStream.Position := 0;
  Result := THashFactory.TCrypto.CreateSHA2_256().ComputeStream(aStream).ToString();
  aStream.Free;
end;

end.
