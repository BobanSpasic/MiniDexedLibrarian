program prMiniDexedCC;

{$mode objfpc}{$H+}

uses
 {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
 {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Forms,
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
  untDX7IISupplBank;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Title:='MiniDexed Control Center';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
