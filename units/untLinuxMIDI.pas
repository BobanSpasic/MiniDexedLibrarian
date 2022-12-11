unit untLinuxMIDI;

interface

{$IFDEF FPC}
  {$H+} // use long strings
{$ENDIF}

uses
  Classes, portmidi, SysUtils;

type
  EMidiDevices = Exception;

type
  TMidiDevices = class
  private
    FDevices: TStringList;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Open(const aDeviceIndex: integer): PmError; virtual; abstract;
    procedure Close(const aDeviceIndex: integer); virtual; abstract;
    procedure CloseAll;
    function IsOpen(ADeviceIndex: integer): boolean;
    property Devices: TStringList read FDevices;
  end;

type
  TMidiInput = class(TMidiDevices)
  private
    FInDevice: array of integer;
  public
    function Open(const aDeviceIndex: integer): PmError; override;
    procedure Close(const aDeviceIndex: integer); override;
    constructor Create; override;
  end;

type
  TMidiOutput = class(TMidiDevices)
  private
    FOutDevice: array of integer;
  public
    function Open(const aDeviceIndex: integer): PmError; override;
    procedure Close(const aDeviceIndex: integer); override;
    constructor Create; override;
    function SendSysEx(const aDeviceIndex: integer;
      const aStream: TMemoryStream): PmError;
  end;

function SysExStreamToStr(const aStream: TMemoryStream): ansistring;
function SysExStreamToByteStr(const aStream: TMemoryStream): ansistring;
procedure StrToSysExStream(const aString: ansistring; const aStream: TMemoryStream);

function MidiInput: TMidiInput;
function MidiOutput: TMidiOutput;

implementation

var
  gMidiInput: TMidiInput;
  gMidiOutput: TMidiOutput;

function MidiInput: TMidiInput;
begin
  if not Assigned(gMidiInput) then gMidiInput := TMidiInput.Create;
  Result := gMidiInput;
end;

function MidiOutput: TMidiOutput;
begin
  if not Assigned(gMidiOutput) then gMidiOutput := TMidiOutput.Create;
  Result := gMidiOutput;
end;

{ ***** TMidiDevices ********************************************************* }
constructor TMidiDevices.Create;
begin
  FDevices := TStringList.Create;
end;

destructor TMidiDevices.Destroy;
begin
  FreeAndNil(FDevices);
  inherited;
end;

procedure TMidiDevices.CloseAll;
var
  i: integer;
begin
  for i := 0 to FDevices.Count - 1 do Close(i);
end;

function TMidiDevices.IsOpen(ADeviceIndex: integer): boolean;
var
  info: PPmDeviceInfo;
begin
  info := Pm_GetDeviceInfo(ADeviceIndex);
  Result := info^.opened <> 0;
end;

{ ***** TMidiInput ********************************************************** }
constructor TMidiInput.Create;
var
  info: PPmDeviceInfo;
  i: integer;
begin
  inherited;
  SetLength(FInDevice, 0);
  for i := 0 to Pm_CountDevices - 1 do
  begin
    info := Pm_GetDeviceInfo(i);
    if info <> nil then
      if info^.input <> 0 then
      begin
        FDevices.Add(IntToStr(i) + #9 + info^.Name + #9 + info^.interf);
        SetLength(FInDevice, length(FInDevice) + 1);
        FInDevice[length(FInDevice) - 1] := i;
      end;
  end;
end;

function TMidiInput.Open(const aDeviceIndex: integer): PmError;
var
  stream: PortMidiStream;
begin
  Result := Pm_OpenInput(@stream, FInDevice[aDeviceIndex], nil, 16, nil, nil);
  if (Result = 0) or (Result = 1) then
    FDevices.Objects[aDeviceIndex] := TObject(stream);
end;

procedure TMidiInput.Close(const aDeviceIndex: integer);
begin
  if FDevices.Objects[aDeviceIndex] <> nil then
  begin
    Pm_Close(FDevices.Objects[aDeviceIndex]);
    FDevices.Objects[aDeviceIndex] := nil;
  end;
end;

{ ***** TMidiOutput ********************************************************* }
constructor TMidiOutput.Create;
var
  info: PPmDeviceInfo;
  i: integer;
begin
  inherited;
  SetLength(FOutDevice, 0);
  for i := 0 to Pm_CountDevices - 1 do
  begin
    info := Pm_GetDeviceInfo(i);
    if info <> nil then
      if info^.output <> 0 then
      begin
        FDevices.Add(IntToStr(i) + #9 + info^.Name + #9 + info^.interf);
        SetLength(FOutDevice, length(FOutDevice) + 1);
        FOutDevice[length(FOutDevice) - 1] := i;
      end;
  end;
end;

function TMidiOutput.Open(const aDeviceIndex: integer): PmError;
var
  stream: PortMidiStream;
begin
  Result := Pm_OpenOutput(@stream, FOutDevice[aDeviceIndex], nil, 16, nil, nil, 0);
  if (Result = 0) or (Result = 1) then
    FDevices.Objects[aDeviceIndex] := TObject(stream);
end;

procedure TMidiOutput.Close(const aDeviceIndex: integer);
begin
  if FDevices.Objects[aDeviceIndex] <> nil then
  begin
    Pm_Close(FDevices.Objects[aDeviceIndex]);
    FDevices.Objects[aDeviceIndex] := nil;
  end;
end;

function TMidiOutput.SendSysEx(const aDeviceIndex: integer;
  const aStream: TMemoryStream): PmError;
var
  buffer: array of byte;
begin
  if FDevices.Objects[aDeviceIndex] <> nil then
  begin
    aStream.Position := 0;
    SetLength(buffer, aStream.Size + 1);
    aStream.Read(buffer[0], aStream.Size);
    Result := Pm_WriteSysEx(FDevices.Objects[aDeviceIndex], 0, PChar(buffer));
  end;
end;


{ ***** Helper Functions ***************************************************** }
function SysExStreamToStr(const aStream: TMemoryStream): ansistring;
var
  i: integer;
begin
  Result := '';
  aStream.Position := 0;
  for i := 0 to aStream.Size - 1 do
    Result := Result + Format('%.2x ', [byte(pansichar(aStream.Memory)[i])]);
end;

function SysExStreamToByteStr(const aStream: TMemoryStream): ansistring;
var
  i: integer;
begin
  Result := '';
  aStream.Position := 0;
  for i := 0 to aStream.Size - 1 do
    Result := Result + Format('%.2x', [byte(pansichar(aStream.Memory)[i])]);
end;

procedure StrToSysExStream(const aString: ansistring; const aStream: TMemoryStream);
const
  cHex: ansistring = '123456789ABCDEF';
var
  lStr: ansistring;
  i: integer;
  L: integer;
begin
  // check on errors  - added by BREAKOUTBOX 2009-07-30
  L := length(aString);
  if not (L mod 2 = 0) // as HEX every byte must be two AnsiChars long, for example '0F'
  then raise EMidiDevices.Create('SysEx string corrupted')
  else if l < 10  // shortest System Exclusive Message = 5 bytes = 10 hex AnsiChars
  then raise EMidiDevices.Create('SysEx string too short');

  lStr := StringReplace(AnsiUpperCase(aString), ' ', '', [rfReplaceAll]);
  aStream.Size := Length(lStr) div 2; // ' - 1' removed by BREAKOUTBOX 2009-07-15
  aStream.Position := 0;

  for i := 1 to aStream.Size do
    pansichar(aStream.Memory)[i - 1] :=
      ansichar(AnsiPos(lStr[i * 2 - 1], cHex) shl 4 + AnsiPos(lStr[i * 2], cHex));
end;


initialization
  Pm_Initialize;
  gMidiInput := nil;
  gMidiOutput := nil;

finalization
  FreeAndNil(gMidiInput);
  FreeAndNil(gMidiOutput);
  Pm_Terminate;
end.
