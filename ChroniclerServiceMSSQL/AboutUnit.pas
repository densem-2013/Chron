unit AboutUnit;

 interface
 uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ShellApi, Buttons, StdCtrls, ExtCtrls, jpeg;
 const WM_MIDASICON = WM_USER + 1;
 type
  TAboutForm = class(TForm)

    PopupMenu: TPopupMenu;
    miClose: TMenuItem;
    miProperties: TMenuItem;
    Config1: TMenuItem;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Timer1: TTimer;
    Image1: TImage;
    LogMemo: TMemo;
    procedure Config1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure miPropertiesClick(Sender: TObject);
    procedure miCloseClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Label11Click(Sender: TObject);
    procedure AddLog(LogStr: PChar);
  private
    FIconData: TNotifyIconData;
    FClosing: boolean;
    procedure AddIcon;
    procedure DeleteIcon;
    procedure WMMIDASIcon(var Message: TMessage); message WM_MIDASICON;
  protected
  public
  end;
 var
  AboutForm: TAboutForm;
  FromService: boolean;
  IsInstalling: boolean;
 implementation
 {$R *.dfm}

uses MainUnit, OPCThreadUnit;

procedure TAboutForm.AddLog(LogStr: PChar);
begin
     LogMemo.Lines.Add(LogStr);

end;

procedure TAboutForm.AddIcon;
begin
  with FIconData do
  begin
    cbSize := SizeOf(FIconData);
    Wnd:=Handle;
    uID:=$DEDB;
    uFlags:=NIF_MESSAGE or NIF_ICON or NIF_TIP;
    hIcon:=Forms.Application.Icon.Handle;
    uCallbackMessage:=WM_MIDASICON;
    StrCopy(szTip, PChar('Chronicler 1.0'));
  end;
  Shell_NotifyIcon(NIM_Add, @FIconData);
end;

procedure TAboutForm.DeleteIcon;
begin
  Shell_NotifyIcon(NIM_DELETE, @FIconData);
end;

procedure TAboutForm.WMMIDASIcon(var Message: TMessage);
var
  pt: TPoint;
begin
  case Message.LParam of
    WM_RBUTTONUP:
      begin
//        if not Visible then
        begin
          SetForegroundWindow(Handle);
          GetCursorPos(pt);
          PopupMenu.Popup(pt.x, pt.y);
        end
//        else
//          SetForegroundWindow(Handle);
      end;
   WM_LBUTTONDBLCLK:
     if Visible then
       SetForegroundWindow(Handle)
     else
       miPropertiesClick(nil);
  end;
end;



procedure TAboutForm.FormCreate(Sender: TObject);
begin
  if FromService then
  begin
    miClose.Visible:=false;
  //  N1.Visible:=false;
  end;
  AddIcon;
  FClosing:=false;
end;

procedure TAboutForm.FormDestroy(Sender: TObject);
begin
 DeleteIcon;
end;

procedure TAboutForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  if FClosing then
    Action:=caFree
//  else
//    Action:=caHide;
end;


procedure TAboutForm.SpeedButton1Click(Sender: TObject);
var
  Command: array[0..255] of Char;
begin
  StrLFmt(Command, SizeOf(Command) - 1, 'JumpID("","%s")', ['ID_CONT']);
//  WinHelp(Handle, PChar(ExtractFilePath(ParamStr(0))+'CHRONICLER.HLP'), HELP_CONTENTS, Longint(@Command));
end;

procedure TAboutForm.miCloseClick(Sender: TObject);
begin
 FClosing:=true;
 Close;
end;

procedure TAboutForm.miPropertiesClick(Sender: TObject);
begin
 ShowModal;
 DeleteIcon;
 AddIcon;
end;

procedure TAboutForm.Config1Click(Sender: TObject);
type
  TGetDesignerInterface = procedure; SafeCall;
var
  GetFunc: TGetDesignerInterface;
  DllHandle: THandle;
const
  DllName = 'MySrvCnf.cpl';
  FuncName = 'EditConfiguration';
begin
 { DllHandle:=LoadLibrary(PChar(DllName));
  if DllHandle < 32 then
    raise Exception.Create('Not found "'+DllName+'" !');
  GetFunc:=GetProcAddress(DllHandle, PChar(FuncName));
  if not Assigned(GetFunc) then
  begin
    FreeLibrary(DllHandle);
    raise Exception.Create('Not fount function "'+FuncName+'"');
  end;
  try
    GetFunc;
  finally
    FreeLibrary(DllHandle);
  end;}
end;

procedure TAboutForm.Timer1Timer(Sender: TObject);
begin
  Label11.Caption:='Insert queue: '+ IntToStr(ChroniclerLogger.InsertQueueCount);
  Label9.Caption:='Total inserts: '+ IntToStr(ChroniclerLogger.TotalInserts);
end;

procedure TAboutForm.Label11Click(Sender: TObject);
begin
//  ChroniclerLogger.OPCThread.Destroy;
end;

end.
