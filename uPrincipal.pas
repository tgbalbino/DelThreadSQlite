unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    mmo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure Consulta1;
    procedure Consulta2;
    procedure Consulta3;
    procedure ExecInTask;
    procedure DebugLog(ALog: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses SingletonDB, FireDAC.Comp.Client, System.Threading;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Consulta1;
  Consulta2;
  Consulta3;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  ExecInTask;
end;

procedure TForm1.Consulta1;
var
  DB: TSingletonDB;
  Query: TFDQuery;
begin
  DebugLog('Consulta1');
  DB := TSingletonDB.GetInstance;
  try
    Query := DB.ExecuteQuery('SELECT * FROM Pessoa_2');
    try
   {   while not Query.Eof do
      begin
        // Process each row
        Query.Next;
      end; }
    finally
      Query.Free;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

  DebugLog('End Consulta1');
end;

procedure TForm1.Consulta2;
var
  DB: TSingletonDB;
  Query: TFDQuery;
begin
  DebugLog('Consulta2');
  DB := TSingletonDB.GetInstance;
  try
    Query := DB.ExecuteQuery('SELECT * FROM Pessoa_New');
    try
     { while not Query.Eof do
      begin
        // Process each row
        Query.Next;
      end;  }
    finally
      Query.Free;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

  DebugLog('End Consulta2');
end;

procedure TForm1.Consulta3;
var
  DB: TSingletonDB;
  Query: TFDQuery;
begin
  DebugLog('Consulta3');
  DB := TSingletonDB.GetInstance;
  try
    Query := DB.ExecuteQuery('select * From pessoa_new a  '
                             + ' inner join pessoa_2 b on b.id=a.id '
                             // + ' inner join pessoa_2 b2 on b2.id=a.id '
                             // + ' inner join pessoa_2 b3 on b3.id=a.id '
                             );
    try
     { while not Query.Eof do
      begin
        // Process each row
        Query.Next;
      end;  }
    finally
      Query.Free;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

  DebugLog('End Consulta3');
end;

procedure TForm1.DebugLog(ALog: string);
begin
  OutputDebugString(Pchar(ALog + ' - ' + FormatDateTime('hh:mm:ss:zzz',Now)));
end;

procedure TForm1.ExecInTask;
var
  Task1, Task2, Task3: ITask;
begin
  DebugLog('ExecInTask');
   // Create and start parallel tasks
  try
    Task1 := TTask.Create(procedure
    begin
      Consulta1;
    end);

    Task2 := TTask.Create(procedure
    begin
      Consulta2;
    end);

    Task3 := TTask.Create(procedure
    begin
      Consulta3;
    end);

    Task1.Start;
    Task2.Start;
    Task3.Start;

    // Wait for tasks to complete
    Task1.Wait;
    Task2.Wait;
    Task3.Wait;

    // Do something with results
    // For demonstration purposes, let's print the results
    DebugLog('Thread End');

  finally
    //Clean up
    //Query1.Free;
    //Query2.Free;
  end;
end;

end.

 // Calculate elapsed time in seconds and milliseconds
//  ElapsedSeconds := Stopwatch.ElapsedMilliseconds / 1000;
