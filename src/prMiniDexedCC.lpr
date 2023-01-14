program prMiniDexedCC;

{$mode objfpc}{$H+}

uses
 {$IFDEF UNIX}
  cthreads,
     {$ENDIF} {$IFDEF HASAMIGA}
  athreads,
     {$ENDIF}
  Forms,
  lazcontrols,
  Interfaces, // this includes the LCL widgetset
  untDX7Bank,
  untDX7Voice,
  untMain,
  untMiniINI,
  untPopUp,
  untUtils,
  untDX7SysExDefs,
  untDXUtils,
  untUnPortMIDI,
  untDX7IISupplement,
  untDX7IISupplBank,
  untMDXSupplement,
  untMDXPerformance,
  untTX7Function,
  untTX7FunctBank,
  untSysExUtils,
  untSQLProxy,
  untCCVoice,
  untCCBank,
  untDX7IIView,
  untTX7View,
  untParConst,
  untDX7View,
  untMDXView;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Title:='MiniDexed Control Center';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmDX7IIView, frmDX7IIView);
  Application.CreateForm(TfrmTX7View, frmTX7View);
  Application.CreateForm(TfrmDX7View, frmDX7View);
  Application.CreateForm(TfrmMDXView, frmMDXView);
  Application.Run;
end.
