{
 *****************************************************************************
  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************

 Author: Boban Spasic

 Unit description:
 Implement functions found in portmidi.pas, but missing in midi.pas
 Less IFDEFs in untMain.
}

unit untUnPortMIDI;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, ctypes, SysUtils;

type
  PmError = CInt;

function Pm_GetErrorText(errnum: PmError): string;

implementation

function Pm_GetErrorText(errnum: PmError): string;
begin
  case errnum of
    0: Result := 'MMSYSERR_NOERROR';
    1: Result := 'MMSYSERR_ERROR';
    2: Result := 'MMSYSERR_BADDEVICEID';
    3: Result := 'MMSYSERR_NOTENABLED';
    4: Result := 'MMSYSERR_ALLOCATED';
    5: Result := 'MMSYSERR_INVALHANDLE';
    6: Result := 'MMSYSERR_NODRIVER';
    7: Result := 'MMSYSERR_NOMEM';
    8: Result := 'MMSYSERR_NOTSUPPORTED';
    9: Result := 'MMSYSERR_BADERRNUM';
    10: Result := 'MMSYSERR_INVALFLAG';
    11: Result := 'MMSYSERR_INVALPARAM';
    12: Result := 'MMSYSERR_HANDLEBUSY';
    13: Result := 'MMSYSERR_INVALIDALIAS';
    14: Result := 'MMSYSERR_BADDB';
    15: Result := 'MMSYSERR_KEYNOTFOUND';
    16: Result := 'MMSYSERR_READERROR';
    17: Result := 'MMSYSERR_WRITEERROR';
    18: Result := 'MMSYSERR_DELETEERROR';
    19: Result := 'MMSYSERR_VALNOTFOUND';
    20: Result := 'MMSYSERR_NODRIVERCB';
    32: Result := 'WAVERR_BADFORMAT';
    33: Result := 'WAVERR_STILLPLAYING';
    34: Result := 'WAVERR_UNPREPARED';
    -10001: Result := 'Internal: Device not assigned';
    -10002: Result := 'Internal: Device in use';
    else
      Result := 'Unknown MMSYSERR';
  end;
end;

end.
