unit OPCThreadUnit;

interface

uses
  Windows, Dialogs, Classes, dOPC, ActiveX, dOPCComn, dOPCIntf, dOPCCom,  SysUtils, GlobalsUnit;

type
  TOPCThread = class(TThread)
  private
    OPCServer: TdOPCServer;
    TempTagValue: variant;
    TempTagId: integer;
    TempTagTimestamp: TDateTime;
    TempTagType: integer;
    TempTagQuality: integer;
    FServerName: string;
    FServerId: string;
    FHostName: string;
    { Private declarations }
    procedure GetTags;
    procedure OPCServerDatachange(Sender: TObject;  ItemList: TdOPCItemList);
    procedure OPCServerOnConnect(Sender: TObject);
    procedure OPCServerOnDisconnect(Sender: TObject);
    procedure OPCServerOnTimeout(Sender: TObject);
    procedure OPCServerOnError(Sender : TObject; Errorstring: string; var RaiseException : boolean);
    procedure SyncOPCPushTag;
  protected
    procedure Execute; override;
  public
    property ServerName: string  read FServerName write FServerName;
    property ServerId: string  read FServerId write FServerId;
    property HostName: string read FHostName write FHostName;
  end;

implementation
uses  MainUnit;

procedure TOPCThread.Execute;
begin
  dOPCInitSecurity;
//  CoInitialize(nil);
//  coInitializeSecurity(nil);
//  dOPCInitSecurity;

  ChroniclerLogger.Log(PChar('OPC Thread('+Self.FServerId+'): Starting. '));

  OPCServer:= TdOPCServer.Create(nil);
  OPCServer.ServerName:=FServerName;
  OPCServer.ComputerName:=FHostName;
  OPCServer.KeepAlive:= 1000;
//  OPCServer.OPCGroupDefault.IsActive:= true;

  OPCServer.OnDatachange:= OPCServerDataChange;
  OPCServer.OnConnect:= OPCServerOnConnect;
  OPCServer.OnDisconnect:= OPCServerOnDisconnect;
  OPCServer.OnError:= OPCServerOnError;
//  OPCServer.OnTimeout:= OPCServerOnTimeout;
  OPCServer.Protocol:= coCOM;
//  OPCServer.Active:= true;

  ChroniclerLogger.Log(PChar('OPC Thread('+Self.FServerId+'): '+FServerName));
  ChroniclerLogger.Log(PChar('OPC Thread('+Self.FServerId+'): '+FHostName));


  while  (not Terminated) do
  begin
    sleep(1);
    try
      ProcessdOPCMessages;
    except

       ChroniclerLogger.Log(PChar('OPC Thread('+Self.FServerId+'): Exception. '));


    end;
    try
      if not OPCServer.Active then OPCServer.Active:= true;
    except
      on E: exception do
      begin

        ChroniclerLogger.Log(PChar('OPC Thread: Connection error. '+e.message));

        sleep(1000);
      end;
    end;
  end;
  //
  OPCServer.Disconnect;

  ChroniclerLogger.Log(PChar('OPC Thread('+Self.FServerId+'): Terminated. '));


end;

procedure TOPCThread.OPCServerOnError(Sender : TObject; Errorstring: string; var RaiseException : boolean);
begin

  ChroniclerLogger.Log(PChar('OPC Thread('+Self.FServerId+'): Error. '+Errorstring));

//ff
end;

procedure TOPCThread.OPCServerOnConnect(Sender: TObject);
begin

  ChroniclerLogger.Log(PChar('OPC Thread('+Self.FServerId+'): Connected. '));

  GetTags;
end;

procedure TOPCThread.OPCServerOnDisconnect(Sender: TObject);
begin

  ChroniclerLogger.Log(PChar('OPC Thread('+Self.FServerId+'): Disconnected. '));

end;

procedure TOPCThread.OPCServerOnTimeout(Sender: TObject);
begin

  ChroniclerLogger.Log(PChar('OPC Thread('+Self.FServerId+'): Timeout. '));

end;


procedure TOPCThread.GetTags;
var
  OPCGroup: TdOPCGroup;
  i, j : integer;
  P: PTHistoryItem;
  OPCItem: TdOPCItem;
begin
//  OPCServer.Browser.Browse(True);

  ChroniclerLogger.Log(PChar('OPC Thread('+Self.FServerId+'): Creating groups. '));

  OPCServer.OPCGroups.Clear;
  dOPCUseExceptionOnAddItems:= true;

  for i:= 0 to ChroniclerLogger.GroupList.Count-1 do
  if PTGroupItem(ChroniclerLogger.GroupList.Items[i]).OPCServer = FServerId then
  begin
    OPCGroup:= OPCServer.OPCGroups.Add(PTGroupItem(ChroniclerLogger.GroupList.Items[i]).GroupName);

    ChroniclerLogger.Log(PChar('OPC Thread('+Self.FServerId+'): Group: '+OPCGroup.Name));

    OPCGroup.UpdateRate:= PTGroupItem(ChroniclerLogger.GroupList.Items[i]).RefreshInterval;
    OPCGroup.Tag:= PTGroupItem(ChroniclerLogger.GroupList.Items[i]).PropertyGroupId;
    OPCGroup.IsActive:= true;
    OPCServer.BatchMode:= true;
    with ChroniclerLogger do
    for j:= 0 to TagList.Count-1 do
    if PTHistoryItem(TagList.Items[j]).PropertyGroupId=OPCGroup.Tag then
    begin
      P:= TagList.Items[j];
      P.TagQuality:= OPC_QUALITY_GOOD;
      P.TagTimestamp:=-1;
      OPCItem:= OPCGroup.OPCItems.AddItem(P.TagName);
      OPCItem.Tag:=j;

      ChroniclerLogger.Log(PChar('OPC Thread('+Self.FServerId+'): Tag:   '+P.TagName));

    end;
    try
      OPCGroup.OPCItems.OPCAddAllItems;
    except
    //!!!

      on E:exception do
      ChroniclerLogger.Log(PChar('OPC Thread('+Self.FServerId+'): Exception:   '+E.Message));

    end;
    OPCServer.BatchMode:= false;

    ChroniclerLogger.Log(PChar('OPC Thread('+Self.FServerId+'): Tags added'));

  end;
end;


procedure TOPCThread.OPCServerDatachange(Sender: TObject;
  ItemList: TdOPCItemList);
var
  i : integer;
  OPCItem: TdOPCItem;
begin


  ChroniclerLogger.Log(PChar('OPC Thread('+Self.FServerId+'): DataChange  '));

  For i:=0 to ItemList.Count-1 do
  begin
    OPCItem:=ItemList.Items[i];
    TempTagValue:= OPCItem.Value;
    TempTagType:= OPCItem.CanonicalDatatype;
    TempTagId:= OPCItem.Tag;
    TempTagTimestamp:= OPCItem.TimeStamp;
    TempTagQuality:= OPCItem.Quality;
//    if OPCItem.ItemID='Positions_trend_number' then
//      sleep(0);
    Synchronize(SyncOPCPushTag);
  end;

end;

procedure TOPCThread.SyncOPCPushTag;
begin
  ChroniclerLogger.OPCPushTag(TempTagValue, TempTagType, TempTagId,
    TempTagTimestamp, TempTagQuality);

end;

end.
