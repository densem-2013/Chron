unit DBThreadUnit;

interface

uses
  Contnrs, Variants, Classes, ADODB, DB, Windows, Forms, ActiveX, ComObj, SysUtils, Dialogs, AboutUnit, dOPCComn, GlobalsUnit, dOpcCom;

type

  TDBThread = class(TThread)
  private
    { Private declarations }
    ADO1: TADOConnection;
    InsertProc: TADOStoredProc;
    TagQuery: TADOQuery;
    GroupQuery: TADOQuery;
    InsertBuffer: array of THistoryItem;
    InsertBufferCount: integer;
    FConnectionString: string;
    FDBInitialized: boolean;
    procedure InsertProcInit;
    procedure SyncPushTag;
    procedure SyncPushGroup;
    procedure SyncDBGetTagsComplete;
    procedure SyncDBPopTag;
    procedure InsertProcExec;
    function ConvertTypeId(CanonicalType: integer): TPropertyType;
    procedure ADO1Disconnect(Connection: TADOConnection;    var EventStatus: TEventStatus);
    procedure GetTags;
    procedure GetGroups;
  protected
    procedure Execute; override;
  public
    property ConnectionString: string read FConnectionString write FConnectionString;
    property DBInitialized: boolean write FDBInitialized;
  end;
var
  TagName: string;
  TagType: integer;
  PropertyId: integer;
  PropertyGroupId: integer;
  GroupName: string;
  RefreshInterval: integer;
  OpcServer: string;
implementation
uses  MainUnit;


procedure TDBThread.Execute;
begin
//  dOPCInitSecurity;

  ChroniclerLogger.Log(PChar('DB Thread: Starting  '));


  CoInitialize(nil);

  SetLength(InsertBuffer,1000); //!!
  InsertBufferCount:= 0;
  ADO1:= TADOConnection.Create(nil);
  ADO1.ConnectionString:=FConnectionString;
  ADO1.OnDisconnect:= ADO1Disconnect;

  ChroniclerLogger.Log(PChar('DB Thread: Connecting:  '));

  repeat
  try
    ADO1.Connected:=true;
  except

      on E:exception do
    begin
        ChroniclerLogger.Log(PChar('DB Thread: Error:  '+E.Message));
      sleep(1000);

    end;
  end;
  until ADO1.Connected;
  InsertProcInit;

  if (not FDBInitialized) then
  begin
    GetGroups;
    GetTags;
  end;
  ChroniclerLogger.DBIntitialized;


  while not Terminated do
  begin
    Synchronize(SyncDBPopTag);
    sleep(1);
    if (InsertBufferCount>0) and (ADO1.Connected) then
    begin
      sleep(1);
      InsertProcExec;
    end;
    try
      if not (ADO1.Connected) then
      try

        ChroniclerLogger.Log('DB Thread: Reopening connection');

        ADO1.Close;
        ADO1.Free;
        ADO1:= TADOConnection.Create(nil);
        ADO1.ConnectionString:=FConnectionString;
        ADO1.OnDisconnect:= ADO1Disconnect;
        ADO1.Connected:=true;
        InsertProc.Connection:=ADO1;
      except
        on E:exception do
        ChroniclerLogger.Log(Pchar('ADO connection failed: '+E.Message));
      end;
    except
        on E:exception do
        begin
          ChroniclerLogger.Log(Pchar('ADO connection fatal error: '+E.Message));
          Self.Terminate;
        end;
    end;
  end;
  ChroniclerLogger.Log('DB Thread: terminated');
  ADO1.Close;

end;

// Import property items from DB


procedure TDBThread.GetTags;

begin

  ChroniclerLogger.Log(PChar('DB Thread: Reading Tags  '));


  if ADO1.Connected then
  begin
    TagQuery:= TADOQuery.Create(ADO1);
    TagQuery.Connection:=ADO1;
    TagQuery.SQL.Add('  SELECT property_id as PropertyID,           '+
                     '  tag_name as TagName,                        '+
                     '  collection_source_id  as PropertyGroupId    '+
                     '  FROM property                               '+
                     '  WHERE collection_source_id is not null      '+
                     '  order by collection_source_id, property_id  ');
    TagQuery.Open;
    While not TagQuery.Eof do
    begin
      TagName:= TagQuery.FieldValues['TagName'];
      TagType:= 2;//TagQuery.FieldValues['TagType'];
      PropertyId:= TagQuery.FieldValues['PropertyId'];
      PropertyGroupId:= TagQuery.FieldValues['PropertyGroupId'];
      Synchronize(SyncPushTag);
      TagQuery.Next;

      ChroniclerLogger.Log(PChar('DB Thread: Tag:  '+TagName));

    end;
    SyncDBGetTagsComplete;
  end;
end;

procedure TDBThread.GetGroups;

begin
  if ADO1.Connected then
  begin


    ChroniclerLogger.Log(PChar('DB Thread: Reading groups  '));


    GroupQuery:= TADOQuery.Create(ADO1);
    GroupQuery.Connection:=ADO1;
    GroupQuery.SQL.Add('SELECT collection_source_id as PropertyGroupID,  '+
      ' source_group_name as GroupName,                                   '+
      ' source_refresh_interval as RefreshInterval,                       '+
      ' source_server_id as OPCServer                                     '+
      ' FROM property_collection_source                                   '+
      ' where source_is_active=1                                          '+
      ' order by source_server_id, collection_source_id                   ');
    GroupQuery.Open;
    While not GroupQuery.Eof do
    begin
      OPCServer:= GroupQuery.FieldValues['OPCServer'];
      GroupName:= GroupQuery.FieldValues['GroupName'];
      RefreshInterval:= GroupQuery.FieldValues['RefreshInterval'];
      PropertyGroupId:= GroupQuery.FieldValues['PropertyGroupId'];
      Synchronize(SyncPushGroup);
      GroupQuery.Next;

      ChroniclerLogger.Log(PChar('DB Thread: Group: '+ GroupName));


    end;
  end;
end;

procedure TDBThread.ADO1Disconnect(Connection: TADOConnection;
  var EventStatus: TEventStatus);
begin

  ChroniclerLogger.Log('DB Thread: ADO disconnected');

end;


procedure TDBThread.SyncPushTag;
begin
  ChroniclerLogger.DBPushTag(TagName, TagType, PropertyId, PropertyGroupId);
end;

procedure TDBThread.SyncPushGroup;
begin
  ChroniclerLogger.DBPushGroup(OPCServer, PropertyGroupId, GroupName, RefreshInterval);
end;

procedure TDBThread.SyncDBGetTagsComplete;
begin
  ChroniclerLogger.DBGetTagsComplete;
end;


procedure TDBThread.SyncDBPopTag;
var
  Item: THistoryItem;
begin
//
  while (ChroniclerLogger.InsertQueueCount>0) and
     (InsertBufferCount<10) do
  begin
    ChroniclerLogger.DBPopTag(Item);
    InsertBuffer[InsertBufferCount]:= Item;
    Inc(InsertBufferCount);
  end;
end;



procedure TDBThread.InsertProcInit;
begin
  InsertProc:= TADOStoredProc.Create(nil);
  InsertProc.Connection:= ADO1;
  InsertProc.ProcedureName:='FN_PROPERTY_UPDATE2';
  with InsertProc.Parameters.AddParameter do
  begin
    DataType := ftInteger;
    Direction := pdInput;
    Name:= 'I_PROPERTY_ID';
    Value := 1;
  end;
  with InsertProc.Parameters.AddParameter do
  begin
    DataType := ftString;
//    DataType := ftDateTime;

    Direction := pdInput;
    Name:= 'I_START_DATE';
    Value := NULL;
  end;
  with InsertProc.Parameters.AddParameter do
  begin
    DataType := ftString;
//    DataType := ftDateTime;

    Direction := pdInput;
    Name:= 'I_FINISH_DATE';
    Value := NULL;
  end;
{  with InsertProc.Parameters.AddParameter do
  begin
    DataType := ftInteger;
    Direction := pdInput;
    Name:= 'I_PROPERTY_TYPE_ID';
    Value := 2;
  end;
}
  with InsertProc.Parameters.AddParameter do
  begin
    DataType := ftString;
    Direction := pdInput;
    Name:= 'I_OLD_STRING_VALUE';
    Value := NULL;
  end;
  with InsertProc.Parameters.AddParameter do
  begin
    DataType := ftString;

    Direction := pdInput;
    Name:= 'I_NEW_STRING_VALUE';
    Value := NULL;
  end;
  with InsertProc.Parameters.AddParameter do
  begin
    DataType := ftInteger;
    Direction := pdInput;
    Name:= 'I_OLD_INTEGER_VALUE';
    Value := NULL;
  end;
  with InsertProc.Parameters.AddParameter do
  begin
    DataType := ftInteger;
    Direction := pdInput;
    Name:= 'I_NEW_INTEGER_VALUE';
    Value := NULL;
  end;
  with InsertProc.Parameters.AddParameter do
  begin
    DataType := ftInteger;
    Direction := pdInput;
    Name:= 'I_OLD_BOOLEAN_VALUE';
    Value := NULL;
  end;
  with InsertProc.Parameters.AddParameter do
  begin
    DataType := ftInteger;
    Direction := pdInput;
    Name:= 'I_NEW_BOOLEAN_VALUE';
    Value := NULL;
  end;
  with InsertProc.Parameters.AddParameter do
  begin
    DataType := ftFloat;
    Direction := pdInput;
    Name:= 'I_OLD_DOUBLE_VALUE';
    Value := NULL;
  end;
  with InsertProc.Parameters.AddParameter do
  begin
    DataType := ftFloat;
    Direction := pdInput;
    Name:= 'I_NEW_DOUBLE_VALUE';
    Value := NULL;
  end;
  with InsertProc.Parameters.AddParameter do
  begin
    DataType := ftString;
//    DataType := ftDateTime;

    Direction := pdInput;
    Name:= 'I_OLD_DATE_VALUE';
    Value := NULL;
  end;
  with InsertProc.Parameters.AddParameter do
  begin
    DataType := ftString;
//    DataType := ftDateTime;

    Direction := pdInput;
    Name:= 'I_NEW_DATE_VALUE';
    Value := NULL;
  end;
  InsertProc.Prepared:=true;
end;

procedure TDBThread.InsertProcExec;
var
  Item: THistoryItem;
  i,j: integer;

begin
  ADO1.BeginTrans;
  for i:= 0 to InsertBufferCount-1 do
  begin
    for j:=0 to InsertProc.Parameters.Count-1 do
      InsertProc.Parameters.Items[j].Value:=null;
    Item:= InsertBuffer[i];
    if item.PorpertyId=242
    then
    sleep(0);
    try

    
      ChroniclerLogger.Log(PChar('DB Thread: Updating property '+IntToStr(Item.PorpertyId)+ ' val='+String(Item.TagValue)));
    
    case  ConvertTypeId(Item.TagType) of
      ptInteger:
      begin
        InsertProc.Parameters.ParamByName('i_old_integer_value').Value:= Item.TagOldValue;
        InsertProc.Parameters.ParamByName('i_new_integer_value').Value:= Item.TagValue;
      end;
      ptString:
      begin
        InsertProc.Parameters.ParamByName('i_old_string_value').Value:= VarToAStr( Item.TagOldValue);
        InsertProc.Parameters.ParamByName('i_new_string_value').Value:= VarToAStr(Item.TagValue);
      end;
      ptBoolean:
      begin
        InsertProc.Parameters.ParamByName('i_old_boolean_value').Value:= abs(Integer(Item.TagOldValue));
        InsertProc.Parameters.ParamByName('i_new_boolean_value').Value:= abs(Integer(Item.TagValue));
      end;
      ptDouble:
      begin
        InsertProc.Parameters.ParamByName('i_old_double_value').Value:= Item.TagOldValue;
        InsertProc.Parameters.ParamByName('i_new_double_value').Value:= Item.TagValue;
      end;
      ptDate:
      begin
        InsertProc.Parameters.ParamByName('i_old_date_value').Value:= FormatDateTime('YYYY-MM-DD HH:NN:SS.ZZZ', Item.TagOldValue);
        InsertProc.Parameters.ParamByName('i_new_date_value').Value:= FormatDateTime('YYYY-MM-DD HH:NN:SS.ZZZ', Item.TagValue);
      end;
    end;
    except

      ChroniclerLogger.Log(pchar(Item.PorpertyId));

    end;
    InsertProc.Parameters.ParamByName('i_start_date').Value:= FormatDateTime('YYYY-MM-DD HH:NN:SS.ZZZ', Item.TagStartTimestamp);
    InsertProc.Parameters.ParamByName('i_finish_date').Value:= FormatDateTime('YYYY-MM-DD HH:NN:SS.ZZZ', Item.TagTimeStamp);
//    InsertProc.Parameters.ParamByName('i_property_type_id').Value:= ConvertTypeId(Item.TagType);
    InsertProc.Parameters.ParamByName('i_property_id').Value:= Item.PorpertyId;

    try
        InsertProc.ExecProc;
    except

      on E: exception do
      ChroniclerLogger.Log(PChar( E.message));

    end;  //try
  end; //for i
  try
    ADO1.CommitTrans;
    InsertBufferCount:=0;
  except
    on E: exception do
    begin

      ChroniclerLogger.Log(PChar('Close: '+E.Message));

      try
        ADO1.Cancel;
        ADO1.Close;


        ChroniclerLogger.Log('closed');

      except

        ChroniclerLogger.Log(PChar('Close: '+E.Message));


      end; //try2
    end;
  end;//try1
end;

function TDBThread.ConvertTypeId(CanonicalType: integer): TPropertyType;
begin
   case CanonicalType of
      //vt_empty
      //vt_null
      vt_i1,
      vt_ui1,
      vt_ui2,
      vt_ui4,
      vt_i8,
      vt_ui8,
      vt_i2,
      vt_i4: Result:= ptInteger;
      vt_decimal,
      vt_r4,
      vt_r8,
      vt_cy: Result:= ptDouble;
      vt_bool: Result:= ptBoolean;
      vt_date: Result:= ptDate;
      //vt_bstr
      //vt_dispatch
      //vt_error
      //vt_variant
      //vt_unknown
      //undefined
   else Result:= ptString;
   end;
end;


end.
