unit untDX7SysExDefs;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  TDX7SysExs = class(TPersistent)
  private
    FDX7SysExs: TStringList;
  public
    constructor Create;
    destructor Destroy; override;
    function GetSysExForParameterName(aParamName: string): string;
  end;

implementation

constructor TDX7SysExs.Create;
begin
  inherited;
  FDX7SysExs := TStringList.Create;
  {Status   $F0
  ID   $43
  Sub-status + channel  0sss nnnn  10   Sub-status (s=1) & channel number (n=0; ch 1)
  Parameter Group   0ggg gghh
  Parameter Number   0ppp pppp
  Value
  EOX   $F7

  DX7 Mark 2
  $F0
  $43
  $10 = 0sss nnn; s=0 - single voice send
                  s=1 - CC
                  s=2 - dump request
                  nnn - MIDI Channel
  $00 = $00 - Voice (parameters 0-127)
        $01 - Voice (parameters 0-28)
        $18 - supplement   (parameters 0-73)
        $19 - performance  (parameters 0-52)
        $18, $7E - Microtuning parameter change (parameter 126)
        $18, $7F - Fractional scaling parameter change (parameter 127)

  $12 = parameter
  $vv = value
  $F7}

  // group g=0 h=0
  FDX7SysExs.Add('OP6_EG_RATE_1= ');
  FDX7SysExs.Add('OP6_EG_RATE_2= ');
  FDX7SysExs.Add('OP6_EG_RATE_3= ');
  FDX7SysExs.Add('OP6_EG_RATE_4= ');
  FDX7SysExs.Add('OP6_EG_LEVEL_1= ');
  FDX7SysExs.Add('OP6_EG_LEVEL_2= ');
  FDX7SysExs.Add('OP6_EG_LEVEL_3= ');
  FDX7SysExs.Add('OP6_EG_LEVEL_4= ');
  FDX7SysExs.Add('OP6_KBD_LEV_SCL_BRK_PT= ');
  FDX7SysExs.Add('OP6_KBD_LEV_SCL_LFT_DEPTH= ');
  FDX7SysExs.Add('OP6_KBD_LEV_SCL_RHT_DEPTH= ');
  FDX7SysExs.Add('OP6_KBD_LEV_SCL_LFT_CURVE= ');
  FDX7SysExs.Add('OP6_KBD_LEV_SCL_RHT_CURVE ');
  FDX7SysExs.Add('OP6_KBD_RATE_SCALING= ');
  FDX7SysExs.Add('OP6_AMP_MOD_SENSITIVITY= ');
  FDX7SysExs.Add('OP6_KEY_VEL_SENSITIVITY= ');
  FDX7SysExs.Add('OP6_OPERATOR_OUTPUT_LEVEL= ');
  FDX7SysExs.Add('OP6_OSC_MODE= ');
  FDX7SysExs.Add('OP6_OSC_FREQ_COARSE= ');
  FDX7SysExs.Add('OP6_OSC_FREQ_FINE= ');
  FDX7SysExs.Add('OP6_OSC_DETUNE= ');
  FDX7SysExs.Add('OP5_EG_RATE_1= ');
  FDX7SysExs.Add('OP5_EG_RATE_2= ');
  FDX7SysExs.Add('OP5_EG_RATE_3= ');
  FDX7SysExs.Add('OP5_EG_RATE_4= ');
  FDX7SysExs.Add('OP5_EG_LEVEL_1= ');
  FDX7SysExs.Add('OP5_EG_LEVEL_2= ');
  FDX7SysExs.Add('OP5_EG_LEVEL_3= ');
  FDX7SysExs.Add('OP5_EG_LEVEL_4= ');
  FDX7SysExs.Add('OP5_KBD_LEV_SCL_BRK_PT= ');
  FDX7SysExs.Add('OP5_KBD_LEV_SCL_LFT_DEPTH= ');
  FDX7SysExs.Add('OP5_KBD_LEV_SCL_RHT_DEPTH= ');
  FDX7SysExs.Add('OP5_KBD_LEV_SCL_LFT_CURVE= ');
  FDX7SysExs.Add('OP5_KBD_LEV_SCL_RHT_CURVE= ');
  FDX7SysExs.Add('OP5_KBD_RATE_SCALING= ');
  FDX7SysExs.Add('OP5_AMP_MOD_SENSITIVITY= ');
  FDX7SysExs.Add('OP5_KEY_VEL_SENSITIVITY= ');
  FDX7SysExs.Add('OP5_OPERATOR_OUTPUT_LEVEL= ');
  FDX7SysExs.Add('OP5_OSC_MODE= ');
  FDX7SysExs.Add('OP5_OSC_FREQ_COARSE= ');
  FDX7SysExs.Add('OP5_OSC_FREQ_FINE= ');
  FDX7SysExs.Add('OP5_OSC_DETUNE= ');
  FDX7SysExs.Add('OP4_EG_RATE_1= ');
  FDX7SysExs.Add('OP4_EG_RATE_2= ');
  FDX7SysExs.Add('OP4_EG_RATE_3= ');
  FDX7SysExs.Add('OP4_EG_RATE_4= ');
  FDX7SysExs.Add('OP4_EG_LEVEL_1= ');
  FDX7SysExs.Add('OP4_EG_LEVEL_2= ');
  FDX7SysExs.Add('OP4_EG_LEVEL_3= ');
  FDX7SysExs.Add('OP4_EG_LEVEL_4= ');
  FDX7SysExs.Add('OP4_KBD_LEV_SCL_BRK_PT= ');
  FDX7SysExs.Add('OP4_KBD_LEV_SCL_LFT_DEPTH= ');
  FDX7SysExs.Add('OP4_KBD_LEV_SCL_RHT_DEPTH= ');
  FDX7SysExs.Add('OP4_KBD_LEV_SCL_LFT_CURVE= ');
  FDX7SysExs.Add('OP4_KBD_LEV_SCL_RHT_CURVE= ');
  FDX7SysExs.Add('OP4_KBD_RATE_SCALING= ');
  FDX7SysExs.Add('OP4_AMP_MOD_SENSITIVITY= ');
  FDX7SysExs.Add('OP4_KEY_VEL_SENSITIVITY= ');
  FDX7SysExs.Add('OP4_OPERATOR_OUTPUT_LEVEL= ');
  FDX7SysExs.Add('OP4_OSC_MODE= ');
  FDX7SysExs.Add('OP4_OSC_FREQ_COARSE= ');
  FDX7SysExs.Add('OP4_OSC_FREQ_FINE= ');
  FDX7SysExs.Add('OP4_OSC_DETUNE= ');
  FDX7SysExs.Add('OP3_EG_RATE_1= ');
  FDX7SysExs.Add('OP3_EG_RATE_2= ');
  FDX7SysExs.Add('OP3_EG_RATE_3= ');
  FDX7SysExs.Add('OP3_EG_RATE_4= ');
  FDX7SysExs.Add('OP3_EG_LEVEL_1= ');
  FDX7SysExs.Add('OP3_EG_LEVEL_2= ');
  FDX7SysExs.Add('OP3_EG_LEVEL_3= ');
  FDX7SysExs.Add('OP3_EG_LEVEL_4= ');
  FDX7SysExs.Add('OP3_KBD_LEV_SCL_BRK_PT= ');
  FDX7SysExs.Add('OP3_KBD_LEV_SCL_LFT_DEPTH= ');
  FDX7SysExs.Add('OP3_KBD_LEV_SCL_RHT_DEPTH= ');
  FDX7SysExs.Add('OP3_KBD_LEV_SCL_LFT_CURVE= ');
  FDX7SysExs.Add('OP3_KBD_LEV_SCL_RHT_CURVE= ');
  FDX7SysExs.Add('OP3_KBD_RATE_SCALING= ');
  FDX7SysExs.Add('OP3_AMP_MOD_SENSITIVITY= ');
  FDX7SysExs.Add('OP3_KEY_VEL_SENSITIVITY= ');
  FDX7SysExs.Add('OP3_OPERATOR_OUTPUT_LEVEL= ');
  FDX7SysExs.Add('OP3_OSC_MODE= ');
  FDX7SysExs.Add('OP3_OSC_FREQ_COARSE= ');
  FDX7SysExs.Add('OP3_OSC_FREQ_FINE= ');
  FDX7SysExs.Add('OP3_OSC_DETUNE= ');
  FDX7SysExs.Add('OP2_EG_RATE_1= ');
  FDX7SysExs.Add('OP2_EG_RATE_2= ');
  FDX7SysExs.Add('OP2_EG_RATE_3= ');
  FDX7SysExs.Add('OP2_EG_RATE_4= ');
  FDX7SysExs.Add('OP2_EG_LEVEL_1= ');
  FDX7SysExs.Add('OP2_EG_LEVEL_2= ');
  FDX7SysExs.Add('OP2_EG_LEVEL_3= ');
  FDX7SysExs.Add('OP2_EG_LEVEL_4= ');
  FDX7SysExs.Add('OP2_KBD_LEV_SCL_BRK_PT= ');
  FDX7SysExs.Add('OP2_KBD_LEV_SCL_LFT_DEPTH= ');
  FDX7SysExs.Add('OP2_KBD_LEV_SCL_RHT_DEPTH= ');
  FDX7SysExs.Add('OP2_KBD_LEV_SCL_LFT_CURVE= ');
  FDX7SysExs.Add('OP2_KBD_LEV_SCL_RHT_CURVE= ');
  FDX7SysExs.Add('OP2_KBD_RATE_SCALING= ');
  FDX7SysExs.Add('OP2_AMP_MOD_SENSITIVITY= ');
  FDX7SysExs.Add('OP2_KEY_VEL_SENSITIVITY= ');
  FDX7SysExs.Add('OP2_OPERATOR_OUTPUT_LEVEL= ');
  FDX7SysExs.Add('OP2_OSC_MODE= ');
  FDX7SysExs.Add('OP2_OSC_FREQ_COARSE= ');
  FDX7SysExs.Add('OP2_OSC_FREQ_FINE= ');
  FDX7SysExs.Add('OP2_OSC_DETUNE= ');
  FDX7SysExs.Add('OP1_EG_RATE_1= ');
  FDX7SysExs.Add('OP1_EG_RATE_2= ');
  FDX7SysExs.Add('OP1_EG_RATE_3= ');
  FDX7SysExs.Add('OP1_EG_RATE_4= ');
  FDX7SysExs.Add('OP1_EG_LEVEL_1= ');
  FDX7SysExs.Add('OP1_EG_LEVEL_2= ');
  FDX7SysExs.Add('OP1_EG_LEVEL_3= ');
  FDX7SysExs.Add('OP1_EG_LEVEL_4= ');
  FDX7SysExs.Add('OP1_KBD_LEV_SCL_BRK_PT= ');
  FDX7SysExs.Add('OP1_KBD_LEV_SCL_LFT_DEPTH= ');
  FDX7SysExs.Add('OP1_KBD_LEV_SCL_RHT_DEPTH= ');
  FDX7SysExs.Add('OP1_KBD_LEV_SCL_LFT_CURVE= ');
  FDX7SysExs.Add('OP1_KBD_LEV_SCL_RHT_CURVE= ');
  FDX7SysExs.Add('OP1_KBD_RATE_SCALING= ');
  FDX7SysExs.Add('OP1_AMP_MOD_SENSITIVITY= ');
  FDX7SysExs.Add('OP1_KEY_VEL_SENSITIVITY= ');
  FDX7SysExs.Add('OP1_OPERATOR_OUTPUT_LEVEL= ');
  FDX7SysExs.Add('OP1_OSC_MODE= ');
  FDX7SysExs.Add('OP1_OSC_FREQ_COARSE= ');
  FDX7SysExs.Add('OP1_OSC_FREQ_FINE= ');
  FDX7SysExs.Add('OP1_OSC_DETUNE= ');
  //group g=0 h=1
  FDX7SysExs.Add('PITCH_EG_RATE_1= ');
  FDX7SysExs.Add('PITCH_EG_RATE_2= ');
  FDX7SysExs.Add('PITCH_EG_RATE_3= ');
  FDX7SysExs.Add('PITCH_EG_RATE_4= ');
  FDX7SysExs.Add('PITCH_EG_LEVEL_1= ');
  FDX7SysExs.Add('PITCH_EG_LEVEL_2= ');
  FDX7SysExs.Add('PITCH_EG_LEVEL_3= ');
  FDX7SysExs.Add('PITCH_EG_LEVEL_4= ');
  FDX7SysExs.Add('ALGORITHM= ');
  FDX7SysExs.Add('FEEDBACK= ');
  FDX7SysExs.Add('OSCILLATOR_SYNC= ');
  FDX7SysExs.Add('LFO_SPEED= ');
  FDX7SysExs.Add('LFO_DELAY= ');
  FDX7SysExs.Add('LFO_PITCH_MOD_DEPTH= ');
  FDX7SysExs.Add('LFO_AMP_MOD_DEPTH= ');
  FDX7SysExs.Add('LFO_SYNC= ');
  FDX7SysExs.Add('LFO_WAVEFORM= ');
  FDX7SysExs.Add('PITCH_MOD_SENSITIVITY= ');
  FDX7SysExs.Add('TRANSPOSE= ');
  FDX7SysExs.Add('VOICE_NAME_CHAR_1= ');
  FDX7SysExs.Add('VOICE_NAME_CHAR_2= ');
  FDX7SysExs.Add('VOICE_NAME_CHAR_3= ');
  FDX7SysExs.Add('VOICE_NAME_CHAR_4= ');
  FDX7SysExs.Add('VOICE_NAME_CHAR_5= ');
  FDX7SysExs.Add('VOICE_NAME_CHAR_6= ');
  FDX7SysExs.Add('VOICE_NAME_CHAR_7= ');
  FDX7SysExs.Add('VOICE_NAME_CHAR_8= ');
  FDX7SysExs.Add('VOICE_NAME_CHAR_9= ');
  FDX7SysExs.Add('VOICE_NAME_CHAR_10= ');
  FDX7SysExs.Add('OPERATOR_ON_OFF= ');
  //group g=1 h=0     - DX performance
  FDX7SysExs.Add('SOURCE_SELECT= ');       // 1-16
  FDX7SysExs.Add('POLY_MONO= ');           // 0-1
  FDX7SysExs.Add('PITCH_BANG_RANGE= ');    // 0-12
  FDX7SysExs.Add('PITCH_BANG_STEP= ');     // 0-12
  FDX7SysExs.Add('PORTAMENTO_TIME= ');     // 0-99
  FDX7SysExs.Add('PORTAMENTO_GLISSANDO= ');// 0-1
  FDX7SysExs.Add('PORTAMENTO_MODE= ');     // 0-1 - 0=retain 1=follow
  FDX7SysExs.Add('MOD_WHELL_SENS= ');      // 0-15
  FDX7SysExs.Add('MOD_WHELL_ASSIGN= ');    // 0-7  Bit0=pitch, Bit1=amplitude Bit2=EG bias
  FDX7SysExs.Add('FOOT_CTRL_SENS= ');      // 0-15
  FDX7SysExs.Add('FOOT_CTRL_ASSIGN= ');    // 0-7  Bit0=pitch, Bit1=amplitude Bit2=EG bias
  FDX7SysExs.Add('AFTER_TOUCH_SENS= ');    // 0-15
  FDX7SysExs.Add('AFTER_TOUCH_ASSIGN= ');  // 0-7  Bit0=pitch, Bit1=amplitude Bit2=EG bias
  FDX7SysExs.Add('BREATH_CTRL_SENS= ');    // 0-15
  FDX7SysExs.Add('BREATH_CTRL_ASSIGN= ');  // 0-7  Bit0=pitch, Bit1=amplitude Bit2=EG bias
  FDX7SysExs.Add('OUTPUT_ATTENUATION= ');  // 0-7
  FDX7SysExs.Add('MASTER_TUNING= ');       // 0-127    64=concert tuning

end;

destructor TDX7SysExs.Destroy;
begin
  FDX7SysExs.Free;
  inherited;
end;

function TDX7SysExs.GetSysExForParameterName(aParamName: string): string;
begin
  Result := FDX7SysExs.Values[aParamName];
end;

end.
