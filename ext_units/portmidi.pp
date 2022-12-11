unit PortMidi;

//{$mode objfpc}{$H+}
{$MODE FPC}
{$CALLING CDECL}
{$MACRO ON}

{
  PortMidi bindings for FreePascal
  Latest version available at: http://sourceforge.net/apps/trac/humus/
  
  Copyright (c) 2010 HuMuS Project
  Maintained by Roland Schaefer

  PortMidi Portable Real-Time MIDI Library
  Latest version available at: http://sourceforge.net/apps/trac/humus/

  Permission is hereby granted, free of charge, to any person obtaining
  a copy of this software and associated documentation files
  (the "Software"), to deal in the Software without restriction,
  including without limitation the rights to use, copy, modify, merge,
  publish, distribute, sublicense, and/or sell copies of the Software,
  and to permit persons to whom the Software is furnished to do so,
  subject to the following conditions:

  The above copyright notice and this permission notice shall be
  included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
  ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

  The text above constitutes the entire PortMidi license; however, 
  the PortMusic community also makes the following non-binding requests:

  Any person wishing to distribute modifications to the Software is
  requested to send the modifications to the original developer so that
  they can be incorporated into the canonical version. It is also
  requested that these non-binding requests be included along with the 
  license above.
}



interface


uses
  CTypes;


{$DEFINE EXTERNALSPEC := external 'portmidi' name}

{$IFDEF LINKOBJECT}
  {$LINKLIB portmidi.o}
{$ENDIF}



const
  PM_DEFAULT_SYSEX_BUFFER_SIZE : CInt = CInt(1024);

type
  PmError = CInt;

const
  pmNoError           : PmError = 0;
  pmNoData            : PmError = 0;
  pmGotData           : PmError = 1;
  pmHostError         : PmError = -10000;
  pmInvalidDeviceId   : PmError = -9999;
  pmInsufficientMemory: PmError = -9998;
  pmBufferTooSmall    : PmError = -9997;
  pmBufferOverflow    : PmError = -9996;
  pmBadPtr            : PmError = -9995;
  pmBadData           : PmError = -9994;
  pmInternalError     : PmError = -9993;
  pmBufferMaxSize     : PmError = -9992;


function Pm_Initialize : PmError;
  external 'portmidi' name 'Pm_Initialize';

function Pm_Terminate : PmError;
  external 'portmidi' name 'Pm_Terminate';

type
  PortMidiStream = Pointer;
  PPortMidiStream = ^PortMidiStream;

function Pm_HasHostError(stream : PortMidiStream) : CInt;
  external 'portmidi' name 'Pm_HasHostError';

function Pm_GetErrorText(errnum : PmError) : PChar;
  external 'portmidi' name 'Pm_GetErrorText';


procedure Pm_GetHostErrorText(msg : PChar; Len : CUInt);
  external 'portmidi' name 'Pm_GetHostErrorText';

const
  HDRLENGTH             = 50;
  PM_HOST_ERROR_MSG_LEN = 256;

type
  PmDeviceID = CInt;

const
  pmNoDevice  = -1;

type
  PMDeviceInfo = record
    structVersion : CInt;
    interf : PChar;
    name : PChar;
    input : CInt;
    output : CInt;
    opened : CInt;
  end;
  PPMDeviceInfo = ^PMDeviceInfo;

function Pm_CountDevices : CInt;
  external 'portmidi' name 'Pm_CountDevices';

function Pm_GetDefaultInputDeviceID : PmDeviceID;
  external 'portmidi' name 'Pm_GetDefaultInputDeviceID';

function Pm_GetDefaultOutputDeviceID : PmDeviceID;
  external 'portmidi' name 'Pm_GetDefaultOutputDeviceID';

type
  PmTimestamp = CInt32;

type
  PmTimeProcPtr = function(time_info : Pointer) : PmTimestamp;

function PmBefore(t1, t2 : PmTimestamp) : Boolean; inline;

function Pm_GetDeviceInfo(id : PmDeviceID) : PPmDeviceInfo;
  external 'portmidi' name 'Pm_GetDeviceInfo';

function Pm_OpenInput(stream : PPortMidiStream;
  inputDevice : PmDeviceID;
  inputDriverInfo : Pointer;
  bufferSize : CInt32;
  time_proc : PmTimeProcPtr;
  time_info : Pointer ) : PmError;
  external 'portmidi' name 'Pm_OpenInput';

function Pm_OpenOutput(stream : PPortMidiStream;
  outputDevice : PmDeviceID;
  outputDriverInfo : Pointer;
  bufferSize : CInt32;
  time_proc : PmTimeProcPtr;
  time_info : Pointer;
  latency : CInt32 ) : PmError;
  external 'portmidi' name 'Pm_OpenOutput';

const
  PM_FILT_ACTIVE             = (1 shl $0E);
  PM_FILT_SYSEX              = (1 shl $00);
  PM_FILT_CLOCK              = (1 shl $08);
  PM_FILT_PLAY               = ((1 shl $0A) or (1 shl $0C)
                                or (1 shl $0B));
  PM_FILT_TICK               = (1 shl $09);
  PM_FILT_FD                 = (1 shl $0D);
  PM_FILT_UNDEFINED          = (1 shl $0D);
  PM_FILT_RESET              = (1 shl $0F);
  PM_FILT_REALTIME           = ((1 shl $0E)
                                or (1 shl $00) or (1 shl $08)
                                or ((1 shl $0A) or (1 shl $0C)
                                    or (1 shl $0B))
                                or (1 shl $0D)
                                or (1 shl $0F) or (1 shl $09));
  PM_FILT_NOTE               = ((1 shl $19) or (1 shl $18));
  PM_FILT_CHANNEL_AFTERTOUCH = (1 shl $1D);
  PM_FILT_POLY_AFTERTOUCH    = (1 shl $1A);
  PM_FILT_AFTERTOUCH         = ((1 shl $1D)
                                or (1 shl $1A));
  PM_FILT_PROGRAM            = (1 shl $1C);
  PM_FILT_CONTROL            = (1 shl $1B);
  PM_FILT_PITCHBEND          = (1 shl $1E);
  PM_FILT_MTC                = (1 shl $01);
  PM_FILT_SONG_POSITION      = (1 shl $02);
  PM_FILT_SONG_SELECT        = (1 shl $03);
  PM_FILT_TUNE               = (1 shl $06);
  PM_FILT_SYSTEMCOMMON       = ((1 shl $01) or (1 shl $02)
                                or (1 shl $03) or (1 shl $06));

function Pm_SetFilter(stream : PortMidiStream; filters : CInt32 ) : PmError;
  external 'portmidi' name 'Pm_SetFilte';

function Pm_Channel(channel : CInt) : CInt; inline;

function Pm_SetChannelMask(stream : PortMidiStream; mask : CInt) : PmError;
  external 'portmidi' name 'Pm_SetChannelMask';

function Pm_Abort(stream : PortMidiStream) : PmError;
  external 'portmidi' name 'Pm_Abort';

function Pm_Close(stream : PortMidiStream) : PmError;
  external 'portmidi' name 'Pm_Close';

function Pm_Synchronize(stream : PortMidiStream) : PmError;
  external 'portmidi' name 'Pm_Synchronize';

function Pm_Message(status, data1, data2 : CInt) : CInt; inline;

function Pm_MessageStatus(msg : CInt) : CInt; inline;

function Pm_MessageData1(msg : CInt) : CInt; inline;

function Pm_MessageData2(msg : CInt) : CInt; inline;

type
  PmMessage = CInt32;

type
  PmEvent = record
    message_ : PmMessage;
    timestamp : PmTimestamp;
  end;
  PPmEvent = ^PmEvent;

function Pm_Read(stream : PortMidiStream; buffer : PPmEvent; length : CInt32 ) : CInt;
  external 'portmidi' name 'Pm_Read';

function Pm_Poll(stream : PortMidiStream) : PmError;
  external 'portmidi' name 'Pm_Poll';

function Pm_Write(stream : PortMidiStream; buffer : PPmEvent;
  length : CInt32 ) : PmError;
  external 'portmidi' name 'Pm_Write';

function Pm_WriteShort(stream : PortMidiStream; when : PmTimestamp;
  msg : CInt32) : PmError;
  external 'portmidi' name 'Pm_WriteShort';

function Pm_WriteSysEx(stream : PortMidiStream; when : PmTimestamp;
  msg : PChar) : PmError;
  external 'portmidi' name 'Pm_WriteSysEx';


implementation



function PmBefore(t1, t2 : PmTimestamp) : Boolean; inline;
begin
  PmBefore := ((t1-t2) < 0);
end;


function Pm_Channel(channel : CInt) : CInt; inline;
begin
  Pm_Channel := (1 shl channel);
end;

function Pm_Message(status, data1, data2 : CInt) : CInt; inline;
begin
  Pm_Message := ((((data2) shl 16) and $FF0000)
    or (((data1) shl 8) and $FF00)
    or ((status) and $FF));
end;


function Pm_MessageStatus(msg : CInt) : CInt; inline;
begin
  Pm_MessageStatus := ((msg) and $FF);
end;


function Pm_MessageData1(msg : CInt) : CInt; inline;
begin
  Pm_MessageData1 := (((msg) shr 8) and $FF);
end;


function Pm_MessageData2(msg : CInt) : CInt; inline;
begin
  Pm_MessageData2 := (((msg) shr 16) and $FF);
end;


end.
