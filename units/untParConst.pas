{
 *****************************************************************************
  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************

 Author: Boban Spasic

 Unit description:
 DX-related constants used by other units
}

//ToDo - FXRack min, max, init values
unit untParConst;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Math;

type
  TValMatrix  = (fMin, fMax, fInit);
  TTypeMatrix = (DX7, DX7II, TX7, MDX);

const
  DX7_VCED_NAMES: array [0..155, 0..1] of string = (
    ('OP6_EG_rate_1', 'OP6_R1'),
    ('OP6_EG_rate_2', 'OP6_R2'),
    ('OP6_EG_rate_3', 'OP6_R3'),
    ('OP6_EG_rate_4', 'OP6_R4'),
    ('OP6_EG_level_1', 'OP6_L1'),
    ('OP6_EG_level_2', 'OP6_L2'),
    ('OP6_EG_level_3', 'OP6_L3'),
    ('OP6_EG_level_4', 'OP6_L4'),
    ('OP6_KBD_LEV_SCL_BRK_PT', 'OP6_BP'),
    ('OP6_KBD_LEV_SCL_LFT_DEPTH', 'OP6_LD'),
    ('OP6_KBD_LEV_SCL_RHT_DEPTH', 'OP6_RD'),
    ('OP6_KBD_LEV_SCL_LFT_CURVE', 'OP6_LC'),
    ('OP6_KBD_LEV_SCL_RHT_CURVE', 'OP6_RC'),
    ('OP6_KBD_RATE_SCALING', 'OP6_RS'),
    ('OP6_AMP_MOD_SENSITIVITY', 'OP6_AMS'),
    ('OP6_KEY_VEL_SENSITIVITY', 'OP6_TS'),
    ('OP6_OPERATOR_OUTPUT_LEVEL', 'OP6_TL'),
    ('OP6_OSC_MODE', 'OP6_PM'),
    ('OP6_OSC_FREQ_COARSE', 'OP6_PC'),
    ('OP6_OSC_FREQ_FINE', 'OP6_PF'),
    ('OP6_OSC_DETUNE', 'OP6_PD'),
    ('OP5_EG_rate_1', 'OP5_R1'),
    ('OP5_EG_rate_2', 'OP5_R2'),
    ('OP5_EG_rate_3', 'OP5_R3'),
    ('OP5_EG_rate_4', 'OP5_R4'),
    ('OP5_EG_level_1', 'OP5_L1'),
    ('OP5_EG_level_2', 'OP5_L2'),
    ('OP5_EG_level_3', 'OP5_L3'),
    ('OP5_EG_level_4', 'OP5_L4'),
    ('OP5_KBD_LEV_SCL_BRK_PT', 'OP5_BP'),
    ('OP5_KBD_LEV_SCL_LFT_DEPTH', 'OP5_LD'),
    ('OP5_KBD_LEV_SCL_RHT_DEPTH', 'OP5_RD'),
    ('OP5_KBD_LEV_SCL_LFT_CURVE', 'OP5_LC'),
    ('OP5_KBD_LEV_SCL_RHT_CURVE', 'OP5_RC'),
    ('OP5_KBD_RATE_SCALING', 'OP5_RS'),
    ('OP5_AMP_MOD_SENSITIVITY', 'OP5_AMS'),
    ('OP5_KEY_VEL_SENSITIVITY', 'OP5_TS'),
    ('OP5_OPERATOR_OUTPUT_LEVEL', 'OP5_TL'),
    ('OP5_OSC_MODE', 'OP5_PM'),
    ('OP5_OSC_FREQ_COARSE', 'OP5_PC'),
    ('OP5_OSC_FREQ_FINE', 'OP5_PF'),
    ('OP5_OSC_DETUNE', 'OP5_PD'),
    ('OP4_EG_rate_1', 'OP4_R1'),
    ('OP4_EG_rate_2', 'OP4_R2'),
    ('OP4_EG_rate_3', 'OP4_R3'),
    ('OP4_EG_rate_4', 'OP4_R4'),
    ('OP4_EG_level_1', 'OP4_L1'),
    ('OP4_EG_level_2', 'OP4_L2'),
    ('OP4_EG_level_3', 'OP4_L3'),
    ('OP4_EG_level_4', 'OP4_L4'),
    ('OP4_KBD_LEV_SCL_BRK_PT', 'OP4_BP'),
    ('OP4_KBD_LEV_SCL_LFT_DEPTH', 'OP4_LD'),
    ('OP4_KBD_LEV_SCL_RHT_DEPTH', 'OP4_RD'),
    ('OP4_KBD_LEV_SCL_LFT_CURVE', 'OP4_LC'),
    ('OP4_KBD_LEV_SCL_RHT_CURVE', 'OP4_RC'),
    ('OP4_KBD_RATE_SCALING', 'OP4_RS'),
    ('OP4_AMP_MOD_SENSITIVITY', 'OP4_AMS'),
    ('OP4_KEY_VEL_SENSITIVITY', 'OP4_TS'),
    ('OP4_OPERATOR_OUTPUT_LEVEL', 'OP4_TL'),
    ('OP4_OSC_MODE', 'OP4_PM'),
    ('OP4_OSC_FREQ_COARSE', 'OP4_PC'),
    ('OP4_OSC_FREQ_FINE', 'OP4_PF'),
    ('OP4_OSC_DETUNE', 'OP4_PD'),
    ('OP3_EG_rate_1', 'OP3_R1'),
    ('OP3_EG_rate_2', 'OP3_R2'),
    ('OP3_EG_rate_3', 'OP3_R3'),
    ('OP3_EG_rate_4', 'OP3_R4'),
    ('OP3_EG_level_1', 'OP3_L1'),
    ('OP3_EG_level_2', 'OP3_L2'),
    ('OP3_EG_level_3', 'OP3_L3'),
    ('OP3_EG_level_4', 'OP3_L4'),
    ('OP3_KBD_LEV_SCL_BRK_PT', 'OP3_BP'),
    ('OP3_KBD_LEV_SCL_LFT_DEPTH', 'OP3_LD'),
    ('OP3_KBD_LEV_SCL_RHT_DEPTH', 'OP3_RD'),
    ('OP3_KBD_LEV_SCL_LFT_CURVE', 'OP3_LC'),
    ('OP3_KBD_LEV_SCL_RHT_CURVE', 'OP3_RC'),
    ('OP3_KBD_RATE_SCALING', 'OP3_RS'),
    ('OP3_AMP_MOD_SENSITIVITY', 'OP3_AMS'),
    ('OP3_KEY_VEL_SENSITIVITY', 'OP3_TS'),
    ('OP3_OPERATOR_OUTPUT_LEVEL', 'OP3_TL'),
    ('OP3_OSC_MODE', 'OP3_PM'),
    ('OP3_OSC_FREQ_COARSE', 'OP3_PC'),
    ('OP3_OSC_FREQ_FINE', 'OP3_PF'),
    ('OP3_OSC_DETUNE', 'OP3_PD'),
    ('OP2_EG_rate_1', 'OP2_R1'),
    ('OP2_EG_rate_2', 'OP2_R2'),
    ('OP2_EG_rate_3', 'OP2_R3'),
    ('OP2_EG_rate_4', 'OP2_R4'),
    ('OP2_EG_level_1', 'OP2_L1'),
    ('OP2_EG_level_2', 'OP2_L2'),
    ('OP2_EG_level_3', 'OP2_L3'),
    ('OP2_EG_level_4', 'OP2_L4'),
    ('OP2_KBD_LEV_SCL_BRK_PT', 'OP2_BP'),
    ('OP2_KBD_LEV_SCL_LFT_DEPTH', 'OP2_LD'),
    ('OP2_KBD_LEV_SCL_RHT_DEPTH', 'OP2_RD'),
    ('OP2_KBD_LEV_SCL_LFT_CURVE', 'OP2_LC'),
    ('OP2_KBD_LEV_SCL_RHT_CURVE', 'OP2_RC'),
    ('OP2_KBD_RATE_SCALING', 'OP2_RS'),
    ('OP2_AMP_MOD_SENSITIVITY', 'OP2_AMS'),
    ('OP2_KEY_VEL_SENSITIVITY', 'OP2_TS'),
    ('OP2_OPERATOR_OUTPUT_LEVEL', 'OP2_TL'),
    ('OP2_OSC_MODE', 'OP2_PM'),
    ('OP2_OSC_FREQ_COARSE', 'OP2_PC'),
    ('OP2_OSC_FREQ_FINE', 'OP2_PF'),
    ('OP2_OSC_DETUNE', 'OP2_PD'),
    ('OP1_EG_rate_1', 'OP1_R1'),
    ('OP1_EG_rate_2', 'OP1_R2'),
    ('OP1_EG_rate_3', 'OP1_R3'),
    ('OP1_EG_rate_4', 'OP1_R4'),
    ('OP1_EG_level_1', 'OP1_L1'),
    ('OP1_EG_level_2', 'OP1_L2'),
    ('OP1_EG_level_3', 'OP1_L3'),
    ('OP1_EG_level_4', 'OP1_L4'),
    ('OP1_KBD_LEV_SCL_BRK_PT', 'OP1_BP'),
    ('OP1_KBD_LEV_SCL_LFT_DEPTH', 'OP1_LD'),
    ('OP1_KBD_LEV_SCL_RHT_DEPTH', 'OP1_RD'),
    ('OP1_KBD_LEV_SCL_LFT_CURVE', 'OP1_LC'),
    ('OP1_KBD_LEV_SCL_RHT_CURVE', 'OP1_RC'),
    ('OP1_KBD_RATE_SCALING', 'OP1_RS'),
    ('OP1_AMP_MOD_SENSITIVITY', 'OP1_AMS'),
    ('OP1_KEY_VEL_SENSITIVITY', 'OP1_TS'),
    ('OP1_OPERATOR_OUTPUT_LEVEL', 'OP1_TL'),
    ('OP1_OSC_MODE', 'OP1_PM'),
    ('OP1_OSC_FREQ_COARSE', 'OP1_PC'),
    ('OP1_OSC_FREQ_FINE', 'OP1_PF'),
    ('OP1_OSC_DETUNE', 'OP1_PD'),
    ('PITCH_EG_RATE_1', 'PR1'),
    ('PITCH_EG_RATE_2', 'PR2'),
    ('PITCH_EG_RATE_3', 'PR3'),
    ('PITCH_EG_RATE_4', 'PR4'),
    ('PITCH_EG_LEVEL_1', 'PL1'),
    ('PITCH_EG_LEVEL_2', 'PL2'),
    ('PITCH_EG_LEVEL_3', 'PL3'),
    ('PITCH_EG_LEVEL_4', 'PL4'),
    ('ALGORITHM', 'ALS'),
    ('FEEDBACK', 'FBL'),
    ('OSCILLATOR_SYNC', 'OPI'),
    ('LFO_SPEED', 'LFS'),
    ('LFO_DELAY', 'LFD'),
    ('LFO_PITCH_MOD_DEPTH', 'LPMD'),
    ('LFO_AMP_MOD_DEPTH', 'LAMD'),
    ('LFO_SYNC', 'LFKS'),
    ('LFO_WAVEFORM', 'LFW'),
    ('PITCH_MOD_SENSITIVITY', 'LPMS'),
    ('TRANSPOSE', 'TRNP'),
    ('VOICE_NAME_CHAR_1', 'VNAM1'),
    ('VOICE_NAME_CHAR_2', 'VNAM2'),
    ('VOICE_NAME_CHAR_3', 'VNAM3'),
    ('VOICE_NAME_CHAR_4', 'VNAM4'),
    ('VOICE_NAME_CHAR_5', 'VNAM5'),
    ('VOICE_NAME_CHAR_6', 'VNAM6'),
    ('VOICE_NAME_CHAR_7', 'VNAM7'),
    ('VOICE_NAME_CHAR_8', 'VNAM8'),
    ('VOICE_NAME_CHAR_9', 'VNAM9'),
    ('VOICE_NAME_CHAR_10', 'VNAM10'),
    ('OPERATOR_ON_OFF', 'OPE')
    );

  DX7_VCED_MIN_MAX_INT: array [0..155, 0..2] of byte = (
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 00),
    (0, 99, 39),
    (0, 99, 0),
    (0, 99, 0),
    (0, 3, 0),
    (0, 3, 0),
    (0, 7, 0),
    (0, 3, 0),
    (0, 7, 0),
    (0, 99, 0),
    (0, 1, 0),
    (0, 31, 1),
    (0, 99, 0),
    (0, 14, 7),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 00),
    (0, 99, 39),
    (0, 99, 0),
    (0, 99, 0),
    (0, 3, 0),
    (0, 3, 0),
    (0, 7, 0),
    (0, 3, 0),
    (0, 7, 0),
    (0, 99, 0),
    (0, 1, 0),
    (0, 31, 1),
    (0, 99, 0),
    (0, 14, 7),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 00),
    (0, 99, 39),
    (0, 99, 0),
    (0, 99, 0),
    (0, 3, 0),
    (0, 3, 0),
    (0, 7, 0),
    (0, 3, 0),
    (0, 7, 0),
    (0, 99, 0),
    (0, 1, 0),
    (0, 31, 1),
    (0, 99, 0),
    (0, 14, 7),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 00),
    (0, 99, 39),
    (0, 99, 0),
    (0, 99, 0),
    (0, 3, 0),
    (0, 3, 0),
    (0, 7, 0),
    (0, 3, 0),
    (0, 7, 0),
    (0, 99, 0),
    (0, 1, 0),
    (0, 31, 1),
    (0, 99, 0),
    (0, 14, 7),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 00),
    (0, 99, 39),
    (0, 99, 0),
    (0, 99, 0),
    (0, 3, 0),
    (0, 3, 0),
    (0, 7, 0),
    (0, 3, 0),
    (0, 7, 0),
    (0, 99, 0),
    (0, 1, 0),
    (0, 31, 1),
    (0, 99, 0),
    (0, 14, 7),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 00),
    (0, 99, 39),
    (0, 99, 0),
    (0, 99, 0),
    (0, 3, 0),
    (0, 3, 0),
    (0, 7, 0),
    (0, 3, 0),
    (0, 7, 0),
    (0, 99, 99),
    (0, 1, 0),
    (0, 31, 1),
    (0, 99, 0),
    (0, 14, 7),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 99),
    (0, 99, 50),
    (0, 99, 50),
    (0, 99, 50),
    (0, 99, 50),
    (0, 31, 0),
    (0, 7, 0),
    (0, 1, 1),
    (0, 99, 35),
    (0, 99, 0),
    (0, 99, 0),
    (0, 99, 0),
    (0, 1, 1),
    (0, 5, 0),
    (0, 7, 3),
    (0, 48, 24),
    (0, 127, 73),
    (0, 127, 78),
    (0, 127, 73),
    (0, 127, 84),
    (0, 127, 32),
    (0, 127, 86),
    (0, 127, 79),
    (0, 127, 73),
    (0, 127, 67),
    (0, 127, 69),
    (0, 63, 63)
    );

  DX7II_ACED_NAMES: array [0..73, 0..1] of string = (
    ('OP6_Scaling_mode', 'OP6_SCM'),
    ('OP5_Scaling_mode', 'OP5_SCM'),
    ('OP4_Scaling_mode', 'OP4_SCM'),
    ('OP3_Scaling_mode', 'OP3_SCM'),
    ('OP2_Scaling_mode', 'OP2_SCM'),
    ('OP1_Scaling_mode', 'OP1_SCM'),
    ('OP6_AM_Sensitivity', 'OP6_AMS'),
    ('OP5_AM_Sensitivity', 'OP5_AMS'),
    ('OP4_AM_Sensitivity', 'OP4_AMS'),
    ('OP3_AM_Sensitivity', 'OP3_AMS'),
    ('OP2_AM_Sensitivity', 'OP2_AMS'),
    ('OP1_AM_Sensitivity', 'OP1_AMS'),
    ('Pitch_EG_Range', 'PEGR'),
    ('LFO_Key_Trigger', 'LTRG'),
    ('Pitch_EG_by_velocity', 'VPSW'),
    ('PMOD', 'PMOD'),
    ('Pitch_Bend_Range', 'PBR'),
    ('Pitch_Bend_Step', 'PBS'),
    ('Pitch_Bend_Mode', 'PBM'),
    ('Random_Pitch_Fluct', 'RNDP'),
    ('Portamento_Mode', 'PORM'),
    ('Portamento_Step', 'PQNT'),
    ('Portamento_Time', 'POS'),
    ('ModWhell_Pitch_Mod_Range', 'MWPM'),
    ('ModWhell_Ampl_Mod_Range', 'MWAM'),
    ('ModWhell_EG_Bias_Range', 'MWEB'),
    ('FootCtr_Pitch_Mod_Range', 'FC1PM'),
    ('FootCtr_Ampl_Mod_Range', 'FC1AM'),
    ('FootCtr_EG_Bias_Range', 'FC1EB'),
    ('FootCtr_Volume_Mod_Range', 'FC1VL'),
    ('BrthCtr_Pitch_Mod_Range', 'BCPM'),
    ('BrthCtr_Ampl_Mod_Range', 'BCAM'),
    ('BrthCtr_EG_Bias_Range', 'BCEB'),
    ('BrthCtr_Pitch_Bias_Range', 'BCPB'),
    ('AftrTch_Pitch_Mod_Range', 'ATPM'),
    ('AftrTch_Ampl_Mod_Range', 'ATAM'),
    ('AftrTch_EG_Bias_Range', 'ATEB'),
    ('AftrTch_Pitch_Bias_Range', 'ATPB'),
    ('Pitch_EG_Rate_Scaling_Depth', 'PGRS'),
    ('Reserved_39', 'RES39'),
    ('Reserved_40', 'RES40'),
    ('Reserved_41', 'RES41'),
    ('Reserved_42', 'RES42'),
    ('Reserved_43', 'RES43'),
    ('Reserved_44', 'RES44'),
    ('Reserved_45', 'RES45'),
    ('Reserved_46', 'RES46'),
    ('Reserved_47', 'RES47'),
    ('Reserved_48', 'RES48'),
    ('Reserved_49', 'RES49'),
    ('Reserved_50', 'RES50'),
    ('Reserved_51', 'RES51'),
    ('Reserved_52', 'RES52'),
    ('Reserved_53', 'RES53'),
    ('Reserved_54', 'RES54'),
    ('Reserved_55', 'RES55'),
    ('Reserved_56', 'RES56'),
    ('Reserved_57', 'RES57'),
    ('Reserved_58', 'RES58'),
    ('Reserved_59', 'RES59'),
    ('Reserved_60', 'RES60'),
    ('Reserved_61', 'RES61'),
    ('Reserved_62', 'RES62'),
    ('Reserved_63', 'RES63'),
    ('FootCtr2_Pitch_Mod_Range', 'FC2PM'),
    ('FootCtr2_Ampl_Mod_Range', 'FC2AM'),
    ('FootCtr2_EG_Bias_Range', 'FC2EB'),
    ('FootCtr2_Volume_Mod_Range', 'FC2VL'),
    ('MIDICtr_Pitch_Mod_Range', 'MCPM'),
    ('MIDICtr_Ampl_Mod_Range', 'MCAM'),
    ('MIDICtr_EG_Bias_Range', 'MCEB'),
    ('MIDICtr_Volume_Mod_Range', 'MCVL'),
    ('Unison_Detune_Depth', 'UDTN'),
    ('FootCtr1_as_CS1', 'FCCS1')
    );

  DX7II_ACED_MIN_MAX_INT: array [0..73, 0..2] of byte = (
    (0, 1, 0),
    (0, 1, 0),
    (0, 1, 0),
    (0, 1, 0),
    (0, 1, 0),
    (0, 1, 0),
    (0, 7, 0),
    (0, 7, 0),
    (0, 7, 0),
    (0, 7, 0),
    (0, 7, 0),
    (0, 7, 0),
    (0, 3, 0),
    (0, 1, 0),
    (0, 1, 0),
    (0, 3, 0),
    (0, 12, 2),
    (0, 12, 0),
    (0, 2, 0),
    (0, 7, 0),
    (0, 1, 0),
    (0, 12, 0),
    (0, 99, 0),
    (0, 99, 0),
    (0, 99, 0),
    (0, 99, 0),
    (0, 99, 0),
    (0, 99, 0),
    (0, 99, 0),
    (0, 99, 0),
    (0, 99, 0),
    (0, 99, 0),
    (0, 99, 0),
    (0, 100, 50),
    (0, 99, 0),
    (0, 99, 0),
    (0, 99, 0),
    (0, 100, 50),
    (0, 7, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 99, 0),
    (0, 99, 0),
    (0, 99, 0),
    (0, 99, 0),
    (0, 99, 0),
    (0, 99, 0),
    (0, 99, 0),
    (0, 99, 0),
    (0, 7, 0),
    (0, 1, 0)
    );

  TX7_PCED_NAMES: array [0..93, 0..1] of string = (
    ('A_Not_Used_0', 'A_NOUS'),
    ('A_Not_Used_1', 'A_NOUS'),
    ('A_PolyMono', 'A_P/M'),
    ('A_PitchBendRange', 'A_PBR'),
    ('A_PitchBendStep', 'A_PBS'),
    ('A_PortamentoTime', 'A_PTIM'),
    ('A_PortaGlissando', 'A_POGL'),
    ('A_PortamentoMode', 'A_PORM'),
    ('A_Not_Used_8', 'A_NOUS'),
    ('A_ModWheelSens', 'A_MWS'),
    ('A_ModWheelAssign', 'A_MWA'),
    ('A_FootCtrlSens', 'A_FCS'),
    ('A_FootCtrlAssign', 'A_FCA'),
    ('A_AfterTouchSens', 'A_ATS'),
    ('A_AfterTouchAssign', 'A_ATA'),
    ('A_BrthCtrlSens', 'A_BCS'),
    ('A_BrthCtrlAssign', 'A_BCA'),
    ('A_Not_Used_17', 'A_NOUS'),
    ('A_Not_Used_18', 'A_NOUS'),
    ('A_Not_Used_19', 'A_NOUS'),
    ('A_Not_Used_20', 'A_NOUS'),
    ('A_Not_Used_21', 'A_NOUS'),
    ('A_Not_Used_22', 'A_NOUS'),
    ('A_Not_Used_23', 'A_NOUS'),
    ('A_Not_Used_24', 'A_NOUS'),
    ('A_Not_Used_25', 'A_NOUS'),
    ('A_VoiceAttn', 'A_ATN'),
    ('A_Not_Used_27', 'A_NOUS'),
    ('A_Not_Used_28', 'A_NOUS'),
    ('A_Not_Used_29', 'A_NOUS'),
    ('B_Not_Used_0', 'B_NOUS'),
    ('B_Not_Used_1', 'B_NOUS'),
    ('B_PolyMono', 'B_P/M'),
    ('B_PitchBendRange', 'B_PBR'),
    ('B_PitchBendStep', 'B_PBS'),
    ('B_PortamentoTime', 'B_PTIM'),
    ('B_PortaGlissando', 'B_POGL'),
    ('B_PortamentoMode', 'B_PORM'),
    ('B_Not_Used_8', 'B_NOUS'),
    ('B_ModWheelSens', 'B_MWS'),
    ('B_ModWheelAssign', 'B_MWA'),
    ('B_FootCtrlSens', 'B_FCS'),
    ('B_FootCtrlAssign', 'B_FCA'),
    ('B_AfterTouchSens', 'B_ATS'),
    ('B_AfterTouchAssign', 'B_ATA'),
    ('B_BrthCtrlSens', 'B_BCS'),
    ('B_BrthCtrlAssign', 'B_BCA'),
    ('B_Not_Used_17', 'B_NOUS'),
    ('B_Not_Used_18', 'B_NOUS'),
    ('B_Not_Used_19', 'B_NOUS'),
    ('B_Not_Used_20', 'B_NOUS'),
    ('B_Not_Used_21', 'B_NOUS'),
    ('B_Not_Used_22', 'B_NOUS'),
    ('B_Not_Used_23', 'B_NOUS'),
    ('B_Not_Used_24', 'B_NOUS'),
    ('B_Not_Used_25', 'B_NOUS'),
    ('B_VoiceAttn', 'B_ATN'),
    ('B_Not_Used_27', 'B_NOUS'),
    ('B_Not_Used_28', 'B_NOUS'),
    ('B_Not_Used_29', 'B_NOUS'),
    ('G_Not_Used_60', 'NOUS'),
    ('G_VoiceMemSelFlag', 'VMS'),
    ('G_Not_Used_62', 'NOUS'),
    ('G_Not_Used_63', 'NOUS'),
    ('G_PerfName01', 'PNAM1'),
    ('G_PerfName02', 'PNAM2'),
    ('G_PerfName03', 'PNAM3'),
    ('G_PerfName04', 'PNAM4'),
    ('G_PerfName05', 'PNAM5'),
    ('G_PerfName06', 'PNAM6'),
    ('G_PerfName07', 'PNAM7'),
    ('G_PerfName08', 'PNAM8'),
    ('G_PerfName09', 'PNAM9'),
    ('G_PerfName10', 'PNAM10'),
    ('G_PerfName11', 'PNAM11'),
    ('G_PerfName12', 'PNAM12'),
    ('G_PerfName13', 'PNAM13'),
    ('G_PerfName14', 'PNAM14'),
    ('G_PerfName15', 'PNAM15'),
    ('G_PerfName16', 'PNAM16'),
    ('G_PerfName17', 'PNAM17'),
    ('G_PerfName18', 'PNAM18'),
    ('G_PerfName19', 'PNAM19'),
    ('G_PerfName20', 'PNAM20'),
    ('G_PerfName21', 'PNAM21'),
    ('G_PerfName22', 'PNAM22'),
    ('G_PerfName23', 'PNAM23'),
    ('G_PerfName24', 'PNAM24'),
    ('G_PerfName25', 'PNAM25'),
    ('G_PerfName26', 'PNAM26'),
    ('G_PerfName27', 'PNAM27'),
    ('G_PerfName28', 'PNAM28'),
    ('G_PerfName29', 'PNAM29'),
    ('G_PerfName30', 'PNAM30')
    );

  TX7_PCED_MIN_MAX_INT: array [0..93, 0..2] of byte = (
    (0, 127, 0),
    (0, 127, 1),
    (0, 1, 0),
    (0, 12, 7),
    (0, 12, 0),
    (0, 99, 0),
    (0, 1, 0),
    (0, 1, 0),
    (0, 127, 0),
    (0, 15, 8),
    (0, 7, 0),
    (0, 15, 8),
    (0, 7, 0),
    (0, 15, 8),
    (0, 7, 0),
    (0, 15, 15),
    (0, 7, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 7, 7),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 1),
    (0, 1, 0),
    (0, 12, 7),
    (0, 12, 0),
    (0, 99, 0),
    (0, 1, 0),
    (0, 1, 0),
    (0, 127, 0),
    (0, 15, 8),
    (0, 7, 0),
    (0, 15, 8),
    (0, 7, 0),
    (0, 15, 8),
    (0, 7, 0),
    (0, 15, 15),
    (0, 7, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 7, 7),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 1, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 32),
    (0, 127, 89),
    (0, 127, 65),
    (0, 127, 77),
    (0, 127, 65),
    (0, 127, 72),
    (0, 127, 65),
    (0, 127, 32),
    (0, 127, 32),
    (0, 127, 84),
    (0, 127, 88),
    (0, 127, 55),
    (0, 127, 32),
    (0, 127, 32),
    (0, 127, 70),
    (0, 127, 85),
    (0, 127, 78),
    (0, 127, 67),
    (0, 127, 84),
    (0, 127, 73),
    (0, 127, 79),
    (0, 127, 78),
    (0, 127, 32),
    (0, 127, 32),
    (0, 127, 68),
    (0, 127, 65),
    (0, 127, 84),
    (0, 127, 65),
    (0, 127, 32),
    (0, 127, 32)
    );

  MDX_PCEDx_NAMES: array [0..52, 0..1] of string = (
    ('Volume', 'VOL'),
    ('Pan', 'PAN'),
    ('DetuneSGN', 'DTS'),
    ('DetuneVAL', 'DTV'),
    ('Cutoff', 'COF'),
    ('Resonance', 'RES'),
    ('NoteLimitLow', 'NLL'),
    ('NoteLimitHigh', 'NLH'),
    ('NoteShift', 'NSH'),
    ('PitchBendRange', 'PBR'),
    ('PitchBendStep', 'PBS'),
    ('PortamentoMode', 'PORM'),
    ('PortamentoGlissando', 'POGL'),
    ('PortamentoTime', 'PTIM'),
    ('MonoMode', 'MONO'),
    ('ModulationWheelRange', 'MWR'),
    ('ModulationWheelTarget', 'MWA'),
    ('FootControlRange', 'FCR'),
    ('FootControlTarget', 'FCA'),
    ('BreathControlRange', 'BCR'),
    ('BreathControlTarget', 'BCA'),
    ('AftertouchRange', 'ATR'),
    ('AftertouchTarget', 'ATA'),
    ('VelocityLimitLow', 'VLL'),
    ('VelocityLimitHigh', 'VLH'),
    ('FX1Send', 'FX1S'),
    ('FX2Send', 'FX2S'),
    ('FX3Send', 'FX3S'),
    ('FX4Send', 'FX4S'),
    ('FX5Send', 'FX5S'),
    ('FX6Send', 'FX6S'),
    ('FX7Send', 'FX7S'),
    ('FX8Send', 'FX8S'),
    ('Res_01', 'RES'),
    ('Res_02', 'RES'),
    ('Res_03', 'RES'),
    ('Res_04', 'RES'),
    ('Res_05', 'RES'),
    ('Res_06', 'RES'),
    ('Res_07', 'RES'),
    ('Res_08', 'RES'),
    ('Res_09', 'RES'),
    ('Res_10', 'RES'),
    ('Res_11', 'RES'),
    ('Res_12', 'RES'),
    ('Res_13', 'RES'),
    ('Res_14', 'RES'),
    ('Res_15', 'RES'),
    ('Res_16', 'RES'),
    ('Res_17', 'RES'),
    ('Res_18', 'RES'),
    ('Res_19', 'RES'),
    ('Res_20', 'RES')
    );

  MDX_PCEDx_MIN_MAX_INT: array [0..52, 0..2] of byte = (
    (0, 127, 100),
    (0, 127, 64),
    (0, 1, 0),
    (0, 99, 0),
    (0, 99, 99),
    (0, 99, 0),
    (0, 127, 0),
    (0, 127, 127),
    (0, 48, 24),
    (0, 12, 2),
    (0, 12, 0),
    (0, 1, 0),
    (0, 1, 0),
    (0, 99, 0),
    (0, 1, 0),
    (0, 99, 99),
    (0, 7, 1),
    (0, 99, 99),
    (0, 7, 0),
    (0, 99, 99),
    (0, 7, 0),
    (0, 99, 99),
    (0, 7, 0),
    (0, 127, 0),
    (0, 127, 127),
    (0, 99, 0),
    (0, 99, 0),
    (0, 99, 0),
    (0, 99, 0),
    (0, 99, 0),
    (0, 99, 0),
    (0, 99, 0),
    (0, 99, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0),
    (0, 127, 0)
    );

  //DX7II
  transSCMD: array[0..1] of string = ('Normal', 'Fraction');
  transPEGR: array[0..3] of string = ('8va', '4va', '1va', '1/2va');
  transLTRG: array[0..1] of string = ('Single', 'Multi');
  transPMOD: array[0..3] of string =
    ('Polyphonic', 'Monophonic', 'Unison Poly', 'Unison Mono');
  transPBM: array[0..3] of string = ('Normal', 'Low', 'High', 'Key On');
  transPORM: array[0..1] of string = ('Retain / Fingered', 'Follow / Fulltime');
  transRPF: array[0..7] of string =
    ('Off', '5c', '11c', '17c', '23c', '29c', '35c', '41c');
  transBCPB: integer = -50;
  transATPB: integer = -50;

  //TX7
  //transPORM: array[0..1] of string = ('Retain', 'Follow');
  transASGN: array[0..7] of string =
    ('-/-/-', '-/-/P', '-/A/-', '-/A/P', 'EG/-/-', 'EG/-/P', 'EG/A/-', 'EG/A/P');

  //DX7
  transSCL: array[0..3] of string = ('-LIN', '-EXP', '+EXP', '+LIN');
  transOSC: array[0..1] of string = ('Ratio', 'Fixed');
  transDTN: integer = -7;
  transTRNP: integer = -24;
  transLFW: array[0..5] of string =
    ('Triangle', 'Saw Down', 'Saw Up', 'Square', 'Sine', 'S/Hold');

  //MDX
  transMONO: array[0..1] of string = ('Poly', 'Mono');
  transPOGL: array[0..1] of string = ('Discrete', 'Glide');
  transNSH: integer = -24;
  transPAN: integer = -64;

function Freq_Ratio(coarse, fine: byte): float;
function Freq_Fixed(coarse, fine: byte): float;
function Nr2Note(Nr: byte): string;
function Nr2NoteMDX(Nr: byte): string;
function GetDefinedValues(T: TTypeMatrix; V: TValMatrix;
  var Ret: array of byte): boolean;

implementation

function Freq_Ratio(coarse, fine: byte): float;
var
  f: float;
begin
  f := max(0.5, float(coarse));
  f := f + (f * fine / 100);
  Result := f;
end;

function Freq_Fixed(coarse, fine: byte): float;
var
  f: float;
  a: float;
begin
  a := power(9.722, 1 / 99);
  f := power(a, fine);
  f := power(10, coarse mod 4) * f;
  Result := f;
end;

function Nr2Note(Nr: byte): string;
begin
  Result := Nr2NoteMDX(Nr + 21);
end;

function Nr2NoteMDX(Nr: byte): string;
const
  scl: array[0..11] of string =
    ('C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B');
var
  n, i: integer;
begin
  n := Nr mod 12;
  i := Nr div 12;
  Result := scl[n] + IntToStr(i - 2);
end;

function GetDefinedValues(T: TTypeMatrix; V: TValMatrix;
  var Ret: array of byte): boolean;
var
  i: integer;
begin
  Result := True;
  try
    case T of
      DX7: case V of
          fmin: begin
            for i := low(Ret) to high(Ret) do
              Ret[i] := DX7_VCED_MIN_MAX_INT[i][0];
          end;
          fmax: begin
            for i := low(Ret) to high(Ret) do
              Ret[i] := DX7_VCED_MIN_MAX_INT[i][1];
          end;
          finit: begin
            for i := low(Ret) to high(Ret) do
              Ret[i] := DX7_VCED_MIN_MAX_INT[i][2];
          end;
        end;
      DX7II: case V of
          fmin: begin
            for i := low(Ret) to high(Ret) do
              Ret[i] := DX7II_ACED_MIN_MAX_INT[i][0];
          end;
          fmax: begin
            for i := low(Ret) to high(Ret) do
              Ret[i] := DX7II_ACED_MIN_MAX_INT[i][1];
          end;
          finit: begin
            for i := low(Ret) to high(Ret) do
              Ret[i] := DX7II_ACED_MIN_MAX_INT[i][2];
          end;
        end;
      TX7: case V of
          fmin: begin
            for i := low(Ret) to high(Ret) do
              Ret[i] := TX7_PCED_MIN_MAX_INT[i][0];
          end;
          fmax: begin
            for i := low(Ret) to high(Ret) do
              Ret[i] := TX7_PCED_MIN_MAX_INT[i][1];
          end;
          finit: begin
            for i := low(Ret) to high(Ret) do
              Ret[i] := TX7_PCED_MIN_MAX_INT[i][2];
          end;
        end;
      MDX: case V of
          fmin: begin
            for i := low(Ret) to high(Ret) do
              Ret[i] := MDX_PCEDx_MIN_MAX_INT[i][0];
          end;
          fmax: begin
            for i := low(Ret) to high(Ret) do
              Ret[i] := MDX_PCEDx_MIN_MAX_INT[i][1];
          end;
          finit: begin
            for i := low(Ret) to high(Ret) do
              Ret[i] := MDX_PCEDx_MIN_MAX_INT[i][2];
          end;
        end;
    end;
  except
    on e: Exception do Result := False;
  end;
end;

end.
