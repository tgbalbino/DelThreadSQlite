program Project1;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {Form1},
  SingletonDB in 'SingletonDB.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
