program ChroniclerService;

{%File 'config.xml'}

uses
  SvcMgr,
  Forms,
  SysUtils,
  Windows,
  Types,
  WinSvc,
  MainUnit in 'MainUnit.pas' {ChroniclerLogger: TService},
  AboutUnit in 'AboutUnit.pas' {AboutForm},
  DBThreadUnit in 'DBThreadUnit.pas',
  OPCThreadUnit in 'OPCThreadUnit.pas',
  GlobalsUnit in 'GlobalsUnit.pas';

{$R *.RES}
{$DEFINE DEBUG}

function IsInstalling: Boolean;
begin
  Result:=FindCmdLineSwitch('INSTALL',['-','\','/'], True) or
    FindCmdLineSwitch('UNINSTALL',['-','\','/'], True);
end;


function IsStartService: Boolean;
var
  Mgr, Svc: Integer;
  UserName, ServiceStartName: string;
  Config: Pointer;
  Size: DWORD;
begin
  Result:=not FindCmdLineSwitch('APPLICATION',['-','\','/'], True);
  exit;

(*
  Result:=False;
  Mgr:=OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  if Mgr <> 0 then
  begin
    Svc:=OpenService(Mgr, PChar('ChroniclerLogger'), SERVICE_ALL_ACCESS);
    Result:=Svc <> 0;
    if Result then
    begin
      QueryServiceConfig(Svc, nil, 0, Size);
      Config:=AllocMem(Size);
      try
        QueryServiceConfig(Svc, Config, Size, Size);
        ServiceStartName:=PQueryServiceConfig(Config)^.lpServiceStartName;
{$IFDEF DEBUG}
        OutputDebugString(PChar('Chronicler: ServiceStartName:'+ ServiceStartName));
{$ENDIF}
        if CompareText(ServiceStartName, 'LocalSystem') = 0 then
        ServiceStartName:='SYSTEM';
      finally
        Dispose(Config);
      end;
      CloseServiceHandle(Svc);
    end;
    CloseServiceHandle(Mgr);
  end;
  if Result then
  begin
    Size:=256;
    SetLength(UserName, Size);
    GetUserName(PChar(UserName), Size);
    SetLength(UserName, StrLen(PChar(UserName)));
{$IFDEF DEBUG}
    OutputDebugString(PChar('Chronicler: UserName:'+ UserName));
{$ENDIF}
    Result:=CompareText(UserName, ServiceStartName) = 0;
//    Result:=True;
  end;
*)
end;



begin
  if IsInstalling or IsStartService  then
  begin
{$IFDEF DEBUG}
    OutputDebugString(PChar('Chronicler: Starting as service'));

{$ENDIF}
    //run as service
    SvcMgr.Application.Initialize;
    AboutUnit.FromService:=true;
    AboutUnit.IsInstalling:= IsInstalling;
    SvcMgr.Application.Title := 'Chronicler 1.0';
    SvcMgr.Application.CreateForm(TChroniclerLogger, ChroniclerLogger);
  SvcMgr.Application.Run;

  end
  else
  begin
{$IFDEF DEBUG}
    OutputDebugString(PChar('Chronicler: Starting as application'));
{$ENDIF}
    //run as application
    Forms.Application.ShowMainForm:=False;
    Forms.Application.Initialize;
    AboutUnit.FromService:=false;
    Forms.Application.CreateForm(TAboutForm, AboutForm);
    Forms.Application.CreateForm(TChroniclerLogger, ChroniclerLogger);
    Forms.Application.Run;
  end;
end.


