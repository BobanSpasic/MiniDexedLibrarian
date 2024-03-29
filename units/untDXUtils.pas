{
 *****************************************************************************
  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************

 Author: Boban Spasic

 Unit description:
 This unit implements the detection/recognition of DX-Series SysEx Messages.
 Sequencer and some other (for me less important) headers are not implemented.
 Not all the MSB/LSB Data could be found in Yamaha's documentation. I've got some
 of them by inspecting various SysEx dumps.
}

unit untDXUtils;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, StrUtils, SysUtils, LazFileUtils;

type
  TDXSysExHeader = record
    f0: byte;
    id: byte;  // $43 or d67 = Yamaha
    sc: byte;  // s = sub-status, c = channel  0sssnnnn
    {
    s=0 - voice/suppl./perf. dump
    s=1 - direct single parameter change
    s=2 - dump request
    }
    f: byte;
    {
    f=0 - single_voice DX7
    f=1 - single_function TX7
    f=2 - bulk_function TX7
    f=3 - single_voice DX11/TX81z/V50/DX21
    f=4 - bulk_voice DX11/TX81z/V50/DX21
    f=5 - single_supplement DX7II
    f=6 - bulk_supplement DX7II
    f=7 -
    f=8 -
    f=9 - bulk_voice DX7
    f=7E - see TDXSysExUniversalDump
    }
    msb: byte; // MSB packet size
    lsb: byte; // LSB packet size
    {
    MSB/LSB=155 - single_voice DX7        expanded VCED
    MSB/LSB=93 - single_voice V50/DX21    expanded VCED
    MSB/LSB=49 - single_supplement DX7II  expanded ACED
    MSB/LSB=1120 - bulk_supplement DX7II  packed AMEM
    MSB/LSB=4096 - bulk_voice DX7         packed VMEM
    MSB/LSB=4096 - bulk_voice V50/DX21    packed VMEM
    }
  end;

  TDXSysExUniversalDump = record
    f0: byte;
    id: byte;  // $43 / #67 = Yamaha
    sc: byte;  // s = 0, c = channel  0sssnnnn
    f: byte;   // f=7E
    classification: array[0..3] of char; // LM _ _
    data_format: array [0..5] of char;
    // classification and data_format can repeat more than once in the dump
    { underscores are spaces
    DX7II
    LM__8973PE    61 byte   DX7II Performance Edit Buffer                     1x
    LM__8973PM  1642 byte   DX7II Packed 32 Performance                       1x
    LM__8973S_   112 byte   DX7II System Set-up                               1x
    LM__MCRYE_   266 byte   Micro Tuning Edit Buffer                          1x
    LM__MCRYMx   266 byte   Micro Tuning with Memory #x=(0,1)                 2x
    LM__MCRYC_   266 byte   Micro Tuning Cartridge                           64x
    LM__FKSYE_   502 byte   Fractional Scaling Edit Buffer                    1x
    LM__FKSYC_   502 byte   Fractional Scaling in Cartridge with Memory #    32x
    V50/DX11/TX81z
    LM__8976AE    33 byte   ACED    TX81Z
    LM__8023AE    20 byte   ACED2   DX11
    LM__8073AE    30 byte   ACED3   V50
    LM__8976PE   120 byte   PCED    DX11
    LM__8073PE    43 byte   PCED2   V50
    LM__8976PM  2442 byte   PMEM    DX11
    LM__8073PM   810 byte   PMEM2   V50
    LM__8976Sx    xx byte   System
    LM__MCRTE0    34 byte   Micro Tuning Edit Buffer OCT
    LM__MCRTE1   274 byte   Micro Tuning Edit Buffer FULL
    LM__8023S0    26 byte   System
    LM__8073S0    42 byte   System
    }
  end;

function ContainsDX7VoiceDump(dmp: TMemoryStream;
  var StartPos, StartDmp: integer): boolean;
function ContainsDX7IISupplementDump(dmp: TMemoryStream;
  var StartPos, StartDmp: integer): boolean;
function ContainsTX7FunctionDump(dmp: TMemoryStream;
  var StartPos, StartDmp: integer): boolean;
function ContainsDX7BankDump(dmp: TMemoryStream;
  var StartPos, StartDmp: integer): boolean;
function ContainsDX7IISupplBankDump(dmp: TMemoryStream;
  var StartPos, StartDmp: integer): boolean;
function ContainsTX7FunctBankDump(dmp: TMemoryStream;
  var StartPos, StartDmp: integer): boolean;
function ContainsDXData(dmp: TMemoryStream; var StartPos: integer;
  const Report: TStrings): boolean;

function Printable(c: char): char;
function VCEDHexToStream(aHex: string; var aStream: TMemoryStream): boolean;
function StreamToVCEDHex(var aStream: TMemoryStream): string;

function RepairDX7SysEx(aFileName: string; var aFeedback: string): boolean;

implementation

operator in (const AByte: byte; const AArray: array of byte): boolean; inline;
var
  Item: byte;
begin
  for Item in AArray do
    if Item = AByte then
      Exit(True);

  Result := False;
end;

function ContainsDX7VoiceDump(dmp: TMemoryStream;
  var StartPos, StartDmp: integer): boolean;
var
  dummy: byte;
begin
  if StartPos <= dmp.Size then
  begin
    dmp.Position := StartPos;
    StartPos := -1;
    while (StartPos = -1) and (dmp.Position < dmp.Size) do
      if dmp.ReadByte = $F0 then                  // $F0 - SysEx
        StartPos := dmp.Position - 1;
    if StartPos <> -1 then
    begin
      dummy := dmp.ReadByte;
      if not (dummy = $43) then StartPos := -1;     // $43 - Yamaha
      dummy := dmp.ReadByte;                        // sub-status + channel number
      dummy := dmp.ReadByte;
      if not (dummy = $00) then StartPos := -1;     // $00 - 1 Voice dump
      dummy := dmp.ReadByte;
      if not (dummy = $01) then StartPos := -1;     // byte count MS
      dummy := dmp.ReadByte;
      if not (dummy = $1B) then StartPos := -1;     // byte count LS
    end;
    if StartPos <> -1 then
    begin
      Result := True;
      StartDmp := StartPos + 6;
    end
    else
    begin
      Result := False;
      StartDmp := -1;
    end;
  end
  else
  begin
    StartPos := -1;
    Result := False;
  end;
end;

function ContainsDX7IISupplementDump(dmp: TMemoryStream;
  var StartPos, StartDmp: integer): boolean;
var
  dummy: byte;
begin
  if StartPos <= dmp.Size then
  begin
    dmp.Position := StartPos;
    StartPos := -1;
    while (StartPos = -1) and (dmp.Position < dmp.Size) do
      if dmp.ReadByte = $F0 then                  // $F0 - SysEx
        StartPos := dmp.Position - 1;
    if StartPos <> -1 then
    begin
      dummy := dmp.ReadByte;
      if not (dummy = $43) then StartPos := -1;     // $43 - Yamaha
      dummy := dmp.ReadByte;                        // sub-status + channel number
      dummy := dmp.ReadByte;
      if not (dummy = $05) then StartPos := -1;     // $05 - 1 ACED
      dummy := dmp.ReadByte;
      if not (dummy = $00) then StartPos := -1;     // byte count MS
      dummy := dmp.ReadByte;
      if not (dummy = $23) then StartPos := -1;     // byte count LS
    end;
    if StartPos <> -1 then
    begin
      Result := True;
      StartDmp := StartPos + 6;
    end
    else
    begin
      Result := False;
      StartDmp := -1;
    end;
  end
  else
  begin
    StartPos := -1;
    Result := False;
  end;
end;

function ContainsTX7FunctionDump(dmp: TMemoryStream;
  var StartPos, StartDmp: integer): boolean;
var
  dummy: byte;
begin
  if StartPos <= dmp.Size then
  begin
    dmp.Position := StartPos;
    StartPos := -1;
    while (StartPos = -1) and (dmp.Position < dmp.Size) do
      if dmp.ReadByte = $F0 then                  // $F0 - SysEx
        StartPos := dmp.Position - 1;
    if StartPos <> -1 then
    begin
      dummy := dmp.ReadByte;
      if not (dummy = $43) then StartPos := -1;     // $43 - Yamaha
      dummy := dmp.ReadByte;                        // sub-status + channel number
      dummy := dmp.ReadByte;
      if not (dummy = $01) then StartPos := -1;     // $01 - 1 PCED
      dummy := dmp.ReadByte;
      if not (dummy = $00) then StartPos := -1;     // byte count MS
      dummy := dmp.ReadByte;
      if not (dummy = $23) then StartPos := -1;     // byte count LS
    end;
    if StartPos <> -1 then
    begin
      Result := True;
      StartDmp := StartPos + 6;
    end
    else
    begin
      Result := False;
      StartDmp := -1;
    end;
  end
  else
  begin
    StartPos := -1;
    Result := False;
  end;
end;

function ContainsDX7BankDump(dmp: TMemoryStream;
  var StartPos, StartDmp: integer): boolean;
var
  dummy: byte;
begin
  if StartPos <= dmp.Size then
  begin
    dmp.Position := StartPos;
    StartPos := -1;
    while (StartPos = -1) and (dmp.Position < dmp.Size - 6) do
    begin
      dummy := dmp.ReadByte;
      if dummy = $F0 then                           // $F0 - SysEx
      begin
        StartPos := dmp.Position - 1;
        dummy := dmp.ReadByte;
        if not (dummy = $43) then StartPos := -1;     // $43 - Yamaha
        dummy := dmp.ReadByte;                        // sub-status + channel number
        dummy := dmp.ReadByte;
        if not (dummy = $09) then StartPos := -1;     // $09 - 32 Voice dump
        dummy := dmp.ReadByte;
        if not (dummy = $20) then StartPos := -1;     // byte count MS
        dummy := dmp.ReadByte;
        if not (dummy = $00) then StartPos := -1;     // byte count LS
      end;
    end;
    if StartPos <> -1 then
      if (dmp.Size - StartPos) < 4104 then
        StartPos := -1;  //file too short

    if StartPos <> -1 then
    begin
      Result := True;
      StartDmp := StartPos + 6;
    end
    else
    begin
      Result := False;
      StartDmp := -1;
    end;
  end
  else
  begin
    StartPos := -1;
    Result := False;
  end;
end;

function ContainsDX7IISupplBankDump(dmp: TMemoryStream;
  var StartPos, StartDmp: integer): boolean;
var
  dummy: byte;
begin
  if StartPos <= dmp.Size then
  begin
    dmp.Position := StartPos;
    StartPos := -1;
    while (StartPos = -1) and (dmp.Position < dmp.Size - 6) do
    begin
      dummy := dmp.ReadByte;
      if dummy = $F0 then                             // $F0 - SysEx
      begin
        StartPos := dmp.Position - 1;
        dummy := dmp.ReadByte;
        if not (dummy = $43) then StartPos := -1;     // $43 - Yamaha
        dummy := dmp.ReadByte;                        // sub-status + channel number
        dummy := dmp.ReadByte;
        if not (dummy = $06) then StartPos := -1;     // $06 - 32 AMEM dump
        dummy := dmp.ReadByte;
        if not (dummy = $08) then StartPos := -1;     // byte count MS
        dummy := dmp.ReadByte;
        if not (dummy = $60) then StartPos := -1;     // byte count LS
      end;
    end;
    if StartPos <> -1 then
      if (dmp.Size - StartPos) < 1120 then
        StartPos := -1;  //file too short

    if StartPos <> -1 then
    begin
      Result := True;
      StartDmp := StartPos + 6;
    end
    else
    begin
      Result := False;
      StartDmp := -1;
    end;
  end
  else
  begin
    StartPos := -1;
    Result := False;
  end;
end;

function ContainsTX7FunctBankDump(dmp: TMemoryStream;
  var StartPos, StartDmp: integer): boolean;
var
  dummy: byte;
begin
  if StartPos <= dmp.Size then
  begin
    dmp.Position := StartPos;
    StartPos := -1;
    while (StartPos = -1) and (dmp.Position < dmp.Size - 6) do
    begin
      dummy := dmp.ReadByte;
      if dummy = $F0 then                             // $F0 - SysEx
      begin
        StartPos := dmp.Position - 1;
        dummy := dmp.ReadByte;
        if not (dummy = $43) then StartPos := -1;     // $43 - Yamaha
        dummy := dmp.ReadByte;                        // sub-status + channel number
        dummy := dmp.ReadByte;
        if not (dummy = $02) then StartPos := -1;     // $02 - 32 PMEM dump
        dummy := dmp.ReadByte;
        if not (dummy = $20) then StartPos := -1;     // byte count MS
        dummy := dmp.ReadByte;
        if not (dummy = $00) then StartPos := -1;     // byte count LS
      end;
    end;
    if StartPos <> -1 then
      if (dmp.Size - StartPos) < 4104 then
        StartPos := -1;  //file too short

    if StartPos <> -1 then
    begin
      Result := True;
      StartDmp := StartPos + 6;
    end
    else
    begin
      Result := False;
      StartDmp := -1;
    end;
  end
  else
  begin
    StartPos := -1;
    Result := False;
  end;
end;

function ContainsDXData(dmp: TMemoryStream; var StartPos: integer;
  const Report: TStrings): boolean;
var
  strStream: TStringStream;
  rHeader: TDXSysExHeader;
  fValues: array [0..9] of byte = ($00, $01, $02, $03, $04, $05, $06, $09, $0A, $7E);
  tmpPosition: int64;
  tmpList: TStringList;
begin
  Result := False;
  if StartPos <= dmp.Size then
  begin
    dmp.Position := StartPos;
    StartPos := -1;
    while dmp.Position < dmp.Size - 1 do
    begin
      rHeader.f0 := 0;
      rHeader.id := 0;
      rHeader.f := $FF;
      tmpList := TStringList.Create;
      tmpList.Sorted := True;
      tmpList.Duplicates := dupIgnore;
      while dmp.Position < dmp.Size do
      begin
        if dmp.Position = dmp.Size - 1 then break;
        if dmp.ReadByte = $F0 then      // $F0 - SysEx
        begin
          StartPos := dmp.Position - 1;
          rHeader.f0 := $F0;
          if rHeader.f0 = $F0 then
          begin
            if dmp.Position = dmp.Size - 1 then break;
            rHeader.id := dmp.ReadByte;     // $43 - Yamaha
            if dmp.Position = dmp.Size - 1 then break;
            rHeader.sc := dmp.ReadByte;     // sub-status + channel number
            if dmp.Position = dmp.Size - 1 then break;
            rHeader.f := dmp.ReadByte;
          end;
          if (rHeader.f0 = $F0) and (rHeader.id = $43) and (rHeader.f in fValues) then
          begin
            if rHeader.f = $00 then tmpList.Add('DX7/DX9 Voice - VCED');
            if rHeader.f = $01 then tmpList.Add('TX7/TX816 Performance - PCED');
            if rHeader.f = $02 then tmpList.Add('TX7/TX816 Performance Bank - PMEM');
            if rHeader.f = $03 then tmpList.Add('DX11/TX81z/V50/DX21 Voice - VCED');
            if rHeader.f = $04 then tmpList.Add('DX11/TX81z/V50/DX21 Voice Bank - VMEM');
            if rHeader.f = $05 then tmpList.Add('DX7II Voice Supplement - ACED');
            if rHeader.f = $06 then tmpList.Add('DX7II Voice Bank Supplement - AMEM');
            if rHeader.f = $09 then tmpList.Add('DX7/DX9 Voice Bank - VMEM');
            if rHeader.f = $0A then tmpList.Add('Sequencer Bulk Dump');
            if rHeader.f = $7E then
            begin
              tmpPosition := dmp.Position;
              //dmp.Position := dmp.Position ;
              strStream := TStringStream.Create();
              //dmp.Position := 0;
              strStream.CopyFrom(dmp, dmp.Size - dmp.Position);

              if PosEx('LM  8973PE', strStream.DataString, 1) > 0 then
                tmpList.Add('DX7II Performance - PCED');
              if PosEx('LM  8973PM', strStream.DataString, 1) > 0 then
                tmpList.Add('DX7II Performance Bank - PMEM');
              if PosEx('LM  8973S ', strStream.DataString, 1) > 0 then
                tmpList.Add('DX7II System Set-up');
              if PosEx('LM  MCRYE ', strStream.DataString, 1) > 0 then
                tmpList.Add('DX7II Micro Tuning Edit Buffer');
              if PosEx('LM  MCRYM', strStream.DataString, 1) > 0 then
                tmpList.Add('DX7II Micro Tuning with Memory #');
              if PosEx('LM  MCRYC ', strStream.DataString, 1) > 0 then
                tmpList.Add('DX7II Micro Tuning Cartridge');
              if PosEx('LM  FKSYE ', strStream.DataString, 1) > 0 then
                tmpList.Add('DX7II Fractional Scaling Edit Buffer');
              if PosEx('LM  FKSYC ', strStream.DataString, 1) > 0 then
                tmpList.Add('DX7II Fractional Scaling in Cartridge with Memory #');
              if PosEx('LM  8976AE', strStream.DataString, 1) > 0 then
                tmpList.Add('TX81Z Supplement - ACED');
              if PosEx('LM  8023AE', strStream.DataString, 1) > 0 then
                tmpList.Add('DX11 Supplement - ACED2');
              if PosEx('LM  8073AE', strStream.DataString, 1) > 0 then
                tmpList.Add('V50 Supplement - ACED3');
              if PosEx('LM  8976PE', strStream.DataString, 1) > 0 then
                tmpList.Add('DX11 Performance - PCED');
              if PosEx('LM  8073PE', strStream.DataString, 1) > 0 then
                tmpList.Add('V50 Performance - PCED2');
              if PosEx('LM  8976PM', strStream.DataString, 1) > 0 then
                tmpList.Add('DX11 Performance Bank - PMEM');
              if PosEx('LM  8073PM', strStream.DataString, 1) > 0 then
                tmpList.Add('V50 Performance Bank - PMEM2');
              if PosEx('LM  8976S', strStream.DataString, 1) > 0 then
                tmpList.Add('DX11 System - SYSx');
              if PosEx('LM  MCRTE0', strStream.DataString, 1) > 0 then
                tmpList.Add('Micro Tuning Edit Buffer - OCT');
              if PosEx('LM  MCRTE1', strStream.DataString, 1) > 0 then
                tmpList.Add('Micro Tuning Edit Buffer - FULL');
              if PosEx('LM  8023S0', strStream.DataString, 1) > 0 then
                tmpList.Add('DX11 System Set-up - SYS2');
              if PosEx('LM  8073S0', strStream.DataString, 1) > 0 then
                tmpList.Add('V50 System Set-up - SYS3');
              if PosEx('LM  8952PM', strStream.DataString, 1) > 0 then
                tmpList.Add('TX802 Performances - PMEM');
              strStream.Free;
              dmp.Position := tmpPosition;
            end;
            case rHeader.f of
              $09: begin
                if dmp.Size - StartPos < 4104 then
                begin
                  Result := False;
                  tmpList.Add('Data size less than 4104 bytes');
                end
                else
                  Result := True;
              end;
              $01: begin

              end
              else
                Result := True;
            end;
          end;
        end;
      end;
      Report.Add(tmpList.Text);
      tmpList.Free;
    end;
  end
  else
  begin
    StartPos := -1;
    Result := False;
  end;
end;

function Printable(c: char): char;
begin
  if (Ord(c) > 31) and (Ord(c) < 127) then Result := c
  else
    Result := #32;
end;

function VCEDHexToStream(aHex: string; var aStream: TMemoryStream): boolean;
var
  s: string;
  partS: string;
  buffer: array [0..156] of byte;
  i: integer;
begin
  try
    s := ReplaceStr(aHex, ' ', '');
    aStream.Clear;
    for i := 0 to 155 do
    begin
      partS := '$' + Copy(s, i * 2 + 1, 2);
      buffer[i] := byte(Hex2Dec(partS));
      aStream.WriteByte(buffer[i]);
    end;
    Result := True;
  except
    on e: Exception do Result := False;
  end;
end;

function StreamToVCEDHex(var aStream: TMemoryStream): string;
var
  i: integer;
begin
  Result := '';
  aStream.Position := 0;
  for i := 0 to aStream.Size - 1 do
  begin
    Result := Result + IntToHex(aStream.ReadByte, 2) + ' ';
  end;
  Result := ReplaceStr(Result, '$', '');
  Result := Trim(Result);
end;

function RepairDX7SysEx(aFileName: string; var aFeedback: string): boolean;
var
  msToRepair: TMemoryStream;
  msRepaired: TMemoryStream;
  sNameRepaired: string;
  sNameRepaired2: string;
  sDirRepaired: string;
  checksum: integer;
  bChk: byte;
  i, j: integer;
begin
  Result := False;
  msToRepair := TMemoryStream.Create;
  msRepaired := TMemoryStream.Create;
  msToRepair.LoadFromFile(aFileName);
  sNameRepaired := ExtractFileName(aFileName);
  sNameRepaired := ExtractFileNameWithoutExt(sNameRepaired);
  sDirRepaired := IncludeTrailingPathDelimiter(ExtractFileDir(aFileName));
  sNameRepaired2 := sDirRepaired + sNameRepaired;
  sNameRepaired := sDirRepaired + sNameRepaired + '_DX7_repaired.syx';
  aFeedback := 'File size = ' + IntToStr(msToRepair.Size);

  //reparation
  //header-less file
  if msToRepair.Size = 4096 then
  begin
    try
      //write DX7 VMEM header
      msRepaired.WriteByte($F0);
      msRepaired.WriteByte($43);
      msRepaired.WriteByte($00);
      msRepaired.WriteByte($09);
      msRepaired.WriteByte($20);
      msRepaired.WriteByte($00);

      //copy data
      msRepaired.CopyFrom(msToRepair, 4096);

      //get checksum
      checksum := 0;
      i := 0;
      msToRepair.Position := 0;
      for i := 0 to msToRepair.Size - 1 do
        checksum := checksum + msToRepair.ReadByte;
      bChk := byte(((not (checksum and 255)) and 127) + 1);

      msRepaired.WriteByte(bChk);
      msRepaired.WriteByte($F7);
      Result := True;
    except
      on E: Exception do Result := False;
    end;
    if Result then msRepaired.SaveToFile(sNameRepaired);
  end;

  //file with missing checksum byte
  if msToRepair.Size = 4103 then
  begin
    try
      //copy data
      msRepaired.CopyFrom(msToRepair, 4102);

      //get checksum
      checksum := 0;
      i := 0;
      msToRepair.Position := 0;
      for i := 0 to msToRepair.Size - 1 do
        checksum := checksum + msToRepair.ReadByte;
      bChk := byte(((not (checksum and 255)) and 127) + 1);

      msRepaired.WriteByte(bChk);
      msRepaired.WriteByte($F7);
      Result := True;
    except
      on E: Exception do Result := False;
    end;
    if Result then msRepaired.SaveToFile(sNameRepaired);
  end;

  //32 VCEDs without header
  if msToRepair.Size = 4960 then
  begin
    msToRepair.Position := 0;
    for j := 1 to 32 do
    begin
      try
        msRepaired.Clear;
        msRepaired.Size := 0;
        //write DX7 VCED header
        msRepaired.WriteByte($F0);
        msRepaired.WriteByte($43);
        msRepaired.WriteByte($00);
        msRepaired.WriteByte($00);
        msRepaired.WriteByte($01);
        msRepaired.WriteByte($1B);

        //copy data
        msRepaired.CopyFrom(msToRepair, 155);

        //get checksum
        checksum := 0;
        msRepaired.Position := 6;
        while msRepaired.Position < (msRepaired.Size) do
          checksum := checksum + msRepaired.ReadByte;
        bChk := byte(((not (checksum and 255)) and 127) + 1);

        msRepaired.WriteByte(bChk);
        msRepaired.WriteByte($F7);
        Result := True;
      except
        on E: Exception do Result := False;
      end;
      if Result then msRepaired.SaveToFile(sNameRepaired2 + 'DX7_R' +
        IntToHex(j, 2) + '.syx');

    end;
  end;

  //Bad size MSB in header
  if msToRepair.Size = 4104 then
  begin
    try
      msToRepair.Position := 0;
      msRepaired.Clear;
      msRepaired.Size := 0;
      msRepaired.CopyFrom(msToRepair, 4);
      msRepaired.WriteByte($20);
      msToRepair.Position:=5;
      msRepaired.CopyFrom(msToRepair, 4099);
      Result := True;
    except
      on E: Exception do Result := False;
    end;
    if Result then msRepaired.SaveToFile(sNameRepaired);
  end;

  msToRepair.Free;
  msRepaired.Free;
end;

end.
