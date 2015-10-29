unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  DBThreadUnit, Contnrs, OPCThreadUnit,  ActiveX, ComObj, xmldom, XMLIntf,
  msxmldom, XMLDoc, Variants, dOPCIntf, GlobalsUnit, dOpcCom, AboutUnit;


type
  TChroniclerLogger = class(TService)
    XMLConfig: TXMLDocument;
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceDestroy(Sender: TObject);

  private
    InsertQueue: TQueue;
    DBThread: TDBThread;
    FDBInitialized: Boolean;
    FDBConnectionString: string;
    { Private declarations }
  public
    TotalInserts: integer;
    TagList: TList;
    GroupList: TList;
    OPCThreads: TList;
    OPCThread: TOPCThread;
    function GetServiceController: TServiceController; override;
    procedure DBPushTag(TagName: string; TagType: integer; PropertyId: integer;
      PropertyGroupId: integer);
    procedure DBPushGroup(OPCServer: string; PropertyGroupId: integer; GroupName: string; RefreshInterval: integer);
    procedure DBGetTagsComplete;
    procedure OPCPushTag(TagValue: variant; TagType: integer; TagId: integer;
               TagTimestamp: TDatetime; TagQuality: integer);
    function DBPopTag(var Item:THistoryItem): integer;
    function DBPeekTag(var Item:THistoryItem): integer;
    function InsertQueueCount: integer;
    procedure Log(LogStr: PChar);
    procedure DBThreadTerminated(Sender: TObject);
    procedure DBIntitialized(); //called by DBThread when all config information obtained from DB
    { Public declarations }
  end;

var
  ChroniclerLogger: TChroniclerLogger;

implementation

{$R *.DFM}
//uses AboutUnit;

procedure TChroniclerLogger.Log(LogStr: PChar);
begin
     OutputDebugString(LogStr);
     if (not AboutUnit.FromService) and (AboutForm<>nil) then 
          AboutForm.AddLog(LogStr);
end;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  ChroniclerLogger.Controller(CtrlCode);
end;

function TChroniclerLogger.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TChroniclerLogger.DBThreadTerminated(Sender: TObject);
begin
  ChroniclerLogger.Log(PChar('Main Thread: DBThread stopped'));
  DBThread:=TDBThread.Create(True);
  DBThread.ConnectionString:= FDBConnectionString;
  DBThread.DBInitialized:=FDBInitialized;
  sleep(1000);
  DBThread.OnTerminate:=DBThreadTerminated;
  DBThread.Resume;
end;

procedure TChroniclerLogger.DBIntitialized(); //called by DBThread when all config information obtained from DB
begin
     FDBInitialized:= true;
end;

procedure TChroniclerLogger.ServiceCreate(Sender: TObject);
var
//  GroupNode,
  ConfigNode,
//  GroupsNode,   TagNode,
  DBNode, OPCNode: IXMLNode;
  i, j: integer;
  PGroup: PTGroupItem;
//  PTag: PTHistoryItem;
begin
  if AboutUnit.IsInstalling then exit;
  dOPCInitSecurity;

  ChroniclerLogger.Log(PChar('Main Thread: Starting'));


  CoInitialize(nil);
  TagList:= TList.Create;
  GroupList:= TList.Create;

  InsertQueue:= TQueue.Create;
  DBThread:=TDBThread.Create(True);

  OPCThreads:= TList.Create;

  ChroniclerLogger.Log(PChar('Main Thread: Reading config'));


  XMLConfig.FileName:= Extractfilepath(Paramstr(0))+'config.xml';
try
  XMLConfig.Active:= true;
  ConfigNode:= XMLConfig.ChildNodes.FindNode('config');
  DBNode:= ConfigNode.ChildNodes.FindNode('database');
  FDBConnectionString:= DBNode.ChildValues['connectionString'];
  DBThread.ConnectionString:= FDBConnectionString;
  OPCNode:= ConfigNode.ChildNodes.FindNode('OPC');
  OPCNode.ChildNodes.First;
  for i:= 0 to OPCNode.ChildNodes.Count - 1 do
  with OPCNode.ChildNodes[i] do
    if ChildValues['isActive']='1' then
    begin

     ChroniclerLogger.Log(PChar('Main Thread: Reading config: OPC: '+string(ChildValues['hostName']) ));

     OPCThread:=TOPCThread.Create(True);
     OPCThread.ServerId:=  ChildValues['serverId'];
     OPCThread.ServerName:= ChildValues['serverName'];
     OPCThread.HostName:= ChildValues['hostName'];
     OPCThreads.Add(OPCThread);
    end;

  ChroniclerLogger.Log(PChar('Main Thread: Configuration complete'));

except
  on E: exception do
  begin
    ChroniclerLogger.Log(PChar('Main Thread: Config error: '+E.Message));
    if   not   AboutUnit.FromService then ShowMessage('Config file error !');
    Halt;
  end;
end;
{  GroupsNode:= ConfigNode.ChildNodes.FindNode('groups');
  for i:=0 to GroupsNode.ChildNodes.Count-1 do
  begin
    GroupNode:= GroupsNode.ChildNodes[i];
    New(PGroup);
    PGroup.GroupName:= GroupNode.Attributes['name'];
    PGroup.RefreshInterval:= GroupNode.Attributes['refreshInterval'];
    GroupList.Add(PGroup);
    for j:= 0 to GroupNode.ChildNodes.Count-1 do
    begin
      TagNode:= GroupNode.ChildNodes[j];
      ShowMessage(TagNode.Attributes['propertyId']);
      New(PTag);
      PTag.TagName:= TagNode.NodeValue;
      PTag.TagType:= TagNode.Attributes['propertyType'];
      PTag.PorpertyId:= TagNode.Attributes['propertyId'];
      PTag.TagValue:= null;
      PTag.GroupId:= i;
      TagList.Add(PTag);

    end;

  end;
}
  DBThread.OnTerminate:=DBThreadTerminated;
  DBThread.Resume;

end;

procedure TChroniclerLogger.DBPushTag(TagName: string; TagType: integer; PropertyId: integer;
      PropertyGroupId: integer);
var
  HistoryItem: PTHistoryItem;

begin
  new(HistoryItem);
  HistoryItem.TagName:=TagName;
  HistoryItem.PorpertyId:=PropertyId;
  HistoryItem.TagType:=TagType;
  HistoryItem.TagQuality:=OPC_QUALITY_GOOD;
  HistoryItem.TagOldValue:=null;
  HistoryItem.TagTimestamp:=-1;
  HistoryItem.PropertyGroupId:= PropertyGroupId;
  TagList.Add(HistoryItem);
end;

procedure TChroniclerLogger.DBPushGroup(OPCServer: string; PropertyGroupId: integer; GroupName: string; RefreshInterval: integer);
var
  GroupItem: PTGroupItem;

begin
  new(GroupItem);
  GroupItem.OPCServer:= OPCServer;
  GroupItem.GroupName:=GroupName;
  GroupItem.RefreshInterval:=RefreshInterval;
  GroupItem.PropertyGroupId:= PropertyGroupId;
  GroupList.Add(GroupItem);
end;

procedure TChroniclerLogger.DBGetTagsComplete;
var
  i: integer;
begin
  for i:=0 to OPCThreads.Count - 1 do
    TOPCThread(OPCThreads[i]).Resume;
end;

procedure TChroniclerLogger.OPCPushTag(TagValue: variant; TagType: integer; TagId: integer;
     TagTimestamp: TDatetime; TagQuality: integer);
var
  PInsert: PTHistoryItem;
  PTagList: PTHistoryItem;
begin
  PTagList:= TagList.Items[TagId];
  If PTagList.TagQuality=OPC_QUALITY_GOOD then
  begin
    TotalInserts:= TotalInserts+1;
    new(PInsert);
    PInsert.TagValue:=TagValue;
    PInsert.TagOldValue:=PTagList.TagValue;
    PInsert.PorpertyId:=PTagList.PorpertyId;
    PInsert.TagType:=TagType;
    PInsert.TagTimestamp:= TagTimestamp;
    PInsert.TagStartTimestamp:= PTagList.TagTimestamp;
    if pInsert.TagStartTimestamp=-1 then
      PInsert.TagStartTimestamp:= TagTimestamp;

    InsertQueue.Push(PInsert);
  end;
  PTagList.TagValue:=TagValue;
  PTagList.TagQuality:= TagQuality;
  PTagList.TagTimestamp:= TagTimestamp;
end;

function TChroniclerLogger.DBPopTag(var Item:THistoryItem): integer;
var
  P: PTHistoryItem;
  QueueCount: integer;
begin
  QueueCount:= InsertQueue.Count;
  if QueueCount>0 then
  begin
    P:= InsertQueue.Pop();
    Item:=P^;
    Dispose(P);
  end;
  Result:= QueueCount;
end;

function TChroniclerLogger.DBPeekTag(var Item:THistoryItem): integer;
var
  P: PTHistoryItem;
  QueueCount: integer;
begin
  QueueCount:= InsertQueue.Count;
  if QueueCount>0 then
  begin
    P:= InsertQueue.Peek();
    Item:=P^;
  end;
  Result:= QueueCount;
end;


function TChroniclerLogger.InsertQueueCount: Integer;
begin
  Result:= InsertQueue.Count;
end;


procedure TChroniclerLogger.ServiceDestroy(Sender: TObject);
begin
  if assigned(OPCThread) then
    OPCThread.Terminate;
  if assigned(DBThread) then
    DBThread.Terminate;
end;

end.
