{
 *****************************************************************************
  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************

 Author: Boban Spasic

 Unit description:
 This unit implements the internal voice container used by Control Center.
 One voice container includes DX7 Voice, DX7II Supplement, TX7 Function and MDX Supplement.
 It can be eventually be extended to contain other structures.
 This way, one voice container contains original DX Data, and this data will be
 storen in DB in its "original" form, without loosing any parameters.
 So, nothing goes lost from the original SysEx.
 One will not find any SysEx containing both DX7II and TX7 data in the wild,
 thus just one of the corresponding data structures will contain some usefull data,
 and not the INIT parameters.
 At storing to the database, just one of the structures will be storen, either DXII Supplement
 or the TX7 Function, depending of the HasSuppl and HasFunct flags.
}

unit untCCVoice;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Math, untDX7Voice, untDX7IISupplement, untTX7Function,
  untMDXSupplement, untParConst;

type
  TCCVoice = record
    FVersion: integer;   //for future use
    FHasSuppl: boolean;
    FHasFunct: boolean;
    FHasMDXSuppl: boolean;
    DX7Voice: TDX7VoiceContainer;
    DX7IISuppl: TDX7IISupplementContainer;
    TX7Function: TTX7FunctionContainer;
    MDXSuppl: TMDXSupplementContainer;
  end;

type
  TCCVoiceContainer = class(TPersistent)
  private
    FCCVoice: TCCVoice;
    procedure SetHasSuppl(b: boolean);
    function GetHasSuppl: boolean;
    procedure SetHasFunct(b: boolean);
    function GetHasFunct: boolean;
    procedure SetHasMDXSuppl(b: boolean);
    function GetHasMDXSuppl: boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure InitVoice;
    procedure InitSuppl;
    procedure InitFunct;
    procedure InitPCEDx;
    function Set_VMEM_Params(aParams: TDX7_VMEM_Params): boolean;
    function Set_VCED_Params(aParams: TDX7_VCED_Params): boolean;
    function Set_AMEM_Params(aParams: TDX7II_AMEM_Params): boolean;
    function Set_PMEM_Params(aParams: TTX7_PMEM_Params): boolean;
    function Set_PCEDx_Params(aParams: TMDX_PCEDx_Params): boolean;
    function Get_VMEM_Params: TDX7_VMEM_Params;
    function Get_AMEM_Params: TDX7II_AMEM_Params;
    function Get_PMEM_Params: TTX7_PMEM_Params;
    function Get_PCEDx_Params: TMDX_PCEDx_Params;
    function Get_VCED_Params: TDX7_VCED_Params;
    procedure Load_VMEM_FromStream(var aStream: TMemoryStream; Position: integer);
    procedure Load_VCED_FromStream(var aStream: TMemoryStream; Position: integer);
    procedure Load_AMEM_FromStream(var aStream: TMemoryStream; Position: integer);
    procedure Load_ACED_FromStream(var aStream: TMemoryStream; Position: integer);
    procedure Load_PMEM_FromStream(var aStream: TMemoryStream; Position: integer);
    procedure Load_PCED_FromStream(var aStream: TMemoryStream; Position: integer);
    procedure Load_PCEDx_FromStream(var aStream: TMemoryStream; Position: integer);
    function Save_VMEM_ToStream(var aStream: TMemoryStream): boolean;
    function Save_VCED_ToStream(var aStream: TMemoryStream): boolean;
    function Save_AMEM_ToStream(var aStream: TMemoryStream): boolean;
    function Save_ACED_ToStream(var aStream: TMemoryStream): boolean;
    function Save_PMEM_ToStream(var aStream: TMemoryStream): boolean;
    function Save_PCED_ToStream(var aStream: TMemoryStream): boolean;
    function Save_PCEDx_ToStream(var aStream: TMemoryStream): boolean;
    function GetVoiceName: string;

    function GetChecksumPartV: integer;
    function GetChecksumPartA: integer;
    function GetChecksumPartP: integer;

    //import functions
    function LoadDX7IIACEDtoPCEDx(aACED: TDX7IISupplementContainer): boolean;
    function LoadTX7PCEDtoPCEDx(aPCED: TTX7FunctionContainer): boolean;

  published
    property HasSuppl: boolean read GetHasSuppl write SetHasSuppl;
    property HasFunct: boolean read GetHasFunct write SetHasFunct;
    property HasMDXSuppl: boolean read GetHasMDXSuppl write SetHasMDXSuppl;
  end;

implementation

constructor TCCVoiceContainer.Create;
begin
  inherited;
  FCCVoice.DX7Voice := TDX7VoiceContainer.Create;
  FCCVoice.DX7IISuppl := TDX7IISupplementContainer.Create;
  FCCVoice.TX7Function := TTX7FunctionContainer.Create;
  FCCVoice.MDXSuppl := TMDXSupplementContainer.Create;
  FCCVoice.FVersion := 1;
  FCCVoice.DX7Voice.InitVoice;
  FCCVoice.DX7IISuppl.InitSupplement;
  FCCVoice.TX7Function.InitFunction;
  FCCVoice.MDXSuppl.InitPCEDx;
end;

destructor TCCVoiceContainer.Destroy;
begin
  FCCVoice.DX7Voice.Free;
  FCCVoice.DX7IISuppl.Free;
  FCCVoice.TX7Function.Free;
  FCCVoice.MDXSuppl.Free;
  inherited;
end;

procedure TCCVoiceContainer.InitVoice;
begin
  FCCVoice.DX7Voice.InitVoice;
  FCCVoice.DX7IISuppl.InitSupplement;
  FCCVoice.TX7Function.InitFunction;
  FCCVoice.MDXSuppl.InitPCEDx;
end;

procedure TCCVoiceContainer.InitSuppl;
begin
  FCCVoice.DX7IISuppl.InitSupplement;
end;

procedure TCCVoiceContainer.InitFunct;
begin
  FCCVoice.TX7Function.InitFunction;
end;

procedure TCCVoiceContainer.InitPCEDx;
begin
  FCCVoice.MDXSuppl.InitPCEDx;
end;

function TCCVoiceContainer.Set_VMEM_Params(aParams: TDX7_VMEM_Params): boolean;
begin
  Result := FCCVoice.DX7Voice.Set_VMEM_Params(aParams);
  FCCVoice.FHasSuppl := False;
  FCCVoice.FHasFunct := False;
  FCCVoice.FHasMDXSuppl := False;
end;

function TCCVoiceContainer.Get_VMEM_Params: TDX7_VMEM_Params;
begin
  Result := FCCVoice.DX7Voice.Get_VMEM_Params;
end;

function TCCVoiceContainer.Set_AMEM_Params(aParams: TDX7II_AMEM_Params): boolean;
begin
  Result := FCCVoice.DX7IISuppl.Set_AMEM_Params(aParams);
  FCCVoice.FHasSuppl := True;
end;

function TCCVoiceContainer.Set_VCED_Params(aParams: TDX7_VCED_Params): boolean;
begin
  Result := FCCVoice.DX7Voice.Set_VCED_Params(aParams);
  FCCVoice.FHasSuppl := False;
  FCCVoice.FHasFunct := False;
  FCCVoice.FHasMDXSuppl := False;
end;

function TCCVoiceContainer.Get_AMEM_Params: TDX7II_AMEM_Params;
begin
  Result := FCCVoice.DX7IISuppl.Get_AMEM_Params;
end;

function TCCVoiceContainer.Set_PMEM_Params(aParams: TTX7_PMEM_Params): boolean;
begin
  Result := FCCVoice.TX7Function.Set_PMEM_Params(aParams);
  FCCVoice.FHasFunct := True;
end;

function TCCVoiceContainer.Get_PMEM_Params: TTX7_PMEM_Params;
begin
  Result := FCCVoice.TX7Function.Get_PMEM_Params;
end;

function TCCVoiceContainer.Set_PCEDx_Params(aParams: TMDX_PCEDx_Params): boolean;
begin
  Result := FCCVoice.MDXSuppl.Set_PCEDx_Params(aParams);
  FCCVoice.FHasMDXSuppl := True;
end;

function TCCVoiceContainer.Get_PCEDx_Params: TMDX_PCEDx_Params;
begin
  Result := FCCVoice.MDXSuppl.Get_PCEDx_Params;
end;

function TCCVoiceContainer.Get_VCED_Params: TDX7_VCED_Params;
begin
  Result := FCCVoice.DX7Voice.Get_VCED_Params;
end;

procedure TCCVoiceContainer.SetHasSuppl(b: boolean);
begin
  FCCVoice.FHasSuppl := b;
end;

function TCCVoiceContainer.GetHasSuppl: boolean;
begin
  Result := FCCVoice.FHasSuppl;
end;

procedure TCCVoiceContainer.SetHasFunct(b: boolean);
begin
  FCCVoice.FHasFunct := b;
end;

function TCCVoiceContainer.GetHasFunct: boolean;
begin
  Result := FCCVoice.FHasFunct;
end;

procedure TCCVoiceContainer.SetHasMDXSuppl(b: boolean);
begin
  FCCVoice.FHasMDXSuppl := b;
end;

function TCCVoiceContainer.GetHasMDXSuppl: boolean;
begin
  Result := FCCVoice.FHasMDXSuppl;
end;

procedure TCCVoiceContainer.Load_VMEM_FromStream(var aStream: TMemoryStream;
  Position: integer);
begin
  FCCVoice.DX7Voice.Load_VMEM_FromStream(aStream, Position);
  FCCVoice.FHasSuppl := False;
  FCCVoice.FHasFunct := False;
  FCCVoice.FHasMDXSuppl := False;
  FCCVoice.DX7IISuppl.InitSupplement;
  FCCVoice.TX7Function.InitFunction;
  FCCVoice.MDXSuppl.InitPCEDx;
end;

procedure TCCVoiceContainer.Load_VCED_FromStream(var aStream: TMemoryStream;
  Position: integer);
begin
  FCCVoice.DX7Voice.Load_VCED_FromStream(aStream, Position);
  FCCVoice.FHasSuppl := False;
  FCCVoice.FHasFunct := False;
  FCCVoice.FHasMDXSuppl := False;
  FCCVoice.DX7IISuppl.InitSupplement;
  FCCVoice.TX7Function.InitFunction;
  FCCVoice.MDXSuppl.InitPCEDx;
end;

procedure TCCVoiceContainer.Load_AMEM_FromStream(var aStream: TMemoryStream;
  Position: integer);
begin
  FCCVoice.DX7IISuppl.Load_AMEM_FromStream(aStream, Position);
  FCCVoice.FHasSuppl := True;
end;

procedure TCCVoiceContainer.Load_ACED_FromStream(var aStream: TMemoryStream;
  Position: integer);
begin
  FCCVoice.DX7IISuppl.Load_ACED_FromStream(aStream, Position);
  FCCVoice.FHasSuppl := True;
end;

procedure TCCVoiceContainer.Load_PMEM_FromStream(var aStream: TMemoryStream;
  Position: integer);
begin
  FCCVoice.TX7Function.Load_PMEM_FromStream(aStream, Position);
  FCCVoice.FHasFunct := True;
end;

procedure TCCVoiceContainer.Load_PCED_FromStream(var aStream: TMemoryStream;
  Position: integer);
begin
  FCCVoice.TX7Function.Load_PCED_FromStream(aStream, Position);
  FCCVoice.FHasFunct := True;
end;

procedure TCCVoiceContainer.Load_PCEDx_FromStream(var aStream: TMemoryStream;
  Position: integer);
begin
  FCCVoice.MDXSuppl.Load_PCEDx_FromStream(aStream, Position);
  FCCVoice.FHasMDXSuppl := True;
end;

function TCCVoiceContainer.Save_VMEM_ToStream(var aStream: TMemoryStream): boolean;
begin
  Result := FCCVoice.DX7Voice.Save_VMEM_ToStream(aStream);
end;

function TCCVoiceContainer.Save_VCED_ToStream(var aStream: TMemoryStream): boolean;
begin
  Result := FCCVoice.DX7Voice.Save_VCED_ToStream(aStream);
end;

function TCCVoiceContainer.Save_AMEM_ToStream(var aStream: TMemoryStream): boolean;
begin
  Result := FCCVoice.DX7IISuppl.Save_AMEM_ToStream(aStream);
end;

function TCCVoiceContainer.Save_ACED_ToStream(var aStream: TMemoryStream): boolean;
begin
  Result := FCCVoice.DX7IISuppl.Save_ACED_ToStream(aStream);
end;

function TCCVoiceContainer.Save_PMEM_ToStream(var aStream: TMemoryStream): boolean;
begin
  Result := FCCVoice.TX7Function.Save_PMEM_ToStream(aStream);
end;

function TCCVoiceContainer.Save_PCED_ToStream(var aStream: TMemoryStream): boolean;
begin
  Result := FCCVoice.TX7Function.Save_PCED_ToStream(aStream);
end;

function TCCVoiceContainer.Save_PCEDx_ToStream(var aStream: TMemoryStream): boolean;
begin
  Result := FCCVoice.MDXSuppl.Save_PCEDx_ToStream(aStream);
end;

function TCCVoiceContainer.GetVoiceName: string;
begin
  Result := FCCVoice.DX7Voice.GetVoiceName;
end;

function TCCVoiceContainer.LoadDX7IIACEDtoPCEDx(aACED:
  TDX7IISupplementContainer): boolean;
var
  par: TDX7II_ACED_Params;
  sup: TMDX_PCEDx_Params;
  bits: integer;
begin
  Result := False;
  par := aACED.Get_ACED_Params;
  GetDefinedValues(MDX, finit, sup.params);
  sup.PitchBendRange := par.Pitch_Bend_Range;
  sup.PitchBendStep := par.Pitch_Bend_Step;
  sup.PortamentoMode := par.Portamento_Mode;
  if par.Portamento_Step > 0 then
    sup.PortamentoGlissando := 1
  else
    sup.PortamentoGlissando := 0;
  sup.PortamentoTime := par.Portamento_Time;
  sup.MonoMode := 0;
  sup.ModulationWheelRange :=
    MaxIntValue([par.ModWhell_Ampl_Mod_Range, par.ModWhell_Pitch_Mod_Range,
    par.ModWhell_EG_Bias_Range]);
  bits := 0;
  if par.ModWhell_Pitch_Mod_Range > 0 then bits := bits + 1;
  if par.ModWhell_Ampl_Mod_Range > 0 then bits := bits + 2;
  if par.ModWhell_EG_Bias_Range > 0 then bits := bits + 4;
  sup.ModulationWheelTarget := bits;
  sup.FootControlRange :=
    MaxIntValue([par.FootCtr_Ampl_Mod_Range, par.FootCtr_Pitch_Mod_Range,
    par.FootCtr_EG_Bias_Range]);
  bits := 0;
  if par.FootCtr_Pitch_Mod_Range > 0 then bits := bits + 1;
  if par.FootCtr_Ampl_Mod_Range > 0 then bits := bits + 2;
  if par.FootCtr_EG_Bias_Range > 0 then bits := bits + 4;
  sup.FootControlTarget := bits;
  sup.BreathControlRange :=
    MaxIntValue([par.BrthCtr_Ampl_Mod_Range, par.BrthCtr_Pitch_Mod_Range,
    par.BrthCtr_EG_Bias_Range]);
  bits := 0;
  if par.BrthCtr_Pitch_Mod_Range > 0 then bits := bits + 1;
  if par.BrthCtr_Ampl_Mod_Range > 0 then bits := bits + 2;
  if par.BrthCtr_EG_Bias_Range > 0 then bits := bits + 4;
  sup.BreathControlTarget := bits;
  sup.AftertouchRange :=
    MaxIntValue([par.AftrTch_Ampl_Mod_Range, par.AftrTch_Pitch_Mod_Range,
    par.AftrTch_EG_Bias_Range]);
  bits := 0;
  if par.AftrTch_Pitch_Mod_Range > 0 then bits := bits + 1;
  if par.AftrTch_Ampl_Mod_Range > 0 then bits := bits + 2;
  if par.AftrTch_EG_Bias_Range > 0 then bits := bits + 4;
  sup.AftertouchTarget := bits;
  Result := FCCVoice.MDXSuppl.Set_PCEDx_Params(sup);
end;

function TCCVoiceContainer.LoadTX7PCEDtoPCEDx(aPCED: TTX7FunctionContainer): boolean;
var
  par: TTX7_PCED_Params;
  sup: TMDX_PCEDx_Params;
begin
  Result := False;
  par := aPCED.Get_PCED_Params;
  GetDefinedValues(MDX, fInit, sup.params);
  sup.PitchBendRange := par.A_PitchBendRange;
  sup.PitchBendStep := par.A_PitchBendStep;
  sup.PortamentoMode := par.A_PortamentoMode;
  sup.PortamentoGlissando := par.A_PortaGlissando;
  sup.PortamentoTime := par.A_PortamentoTime;
  sup.MonoMode := par.A_PortamentoTime;
  sup.ModulationWheelRange := Floor(par.A_ModWheelSens * 6.6);
  sup.ModulationWheelTarget := par.A_ModWheelAssign;
  sup.FootControlRange := Floor(par.A_FootCtrlSens * 6.6);
  sup.FootControlTarget := par.A_FootCtrlAssign;
  sup.BreathControlRange := Floor(par.A_BrthCtrlSens * 6.6);
  sup.BreathControlTarget := par.A_BrthCtrlAssign;
  sup.AftertouchRange := Floor(par.A_AfterTouchSens * 6.6);
  sup.AftertouchTarget := par.A_AfterTouchAssign;
  sup.Volume := Ceil(par.A_VoiceAttn * 18.14);
  Result := FCCVoice.MDXSuppl.Set_PCEDx_Params(sup);
end;

function TCCVoiceContainer.GetChecksumPartV: integer;
begin
  Result := FCCVoice.DX7Voice.GetChecksumPart;
end;

function TCCVoiceContainer.GetChecksumPartA: integer;
begin
  Result := FCCVoice.DX7IISuppl.GetChecksumPart;
end;

function TCCVoiceContainer.GetChecksumPartP: integer;
begin
  Result := FCCVoice.TX7Function.GetChecksumPart;
end;

end.
