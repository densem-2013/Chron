unit GlobalsUnit;
//{$DEFINE DEBUG}
interface
type
  TDBState = (dsNone, dsNotConnected, dsConnected, dsException);
  TOPCState = (osNone, osNotConnected, osConnected, osWorking);

  TPropertyType=(ptInteger=2, ptBoolean=3, ptDouble=4,ptString=1, ptDate=5);
  THistoryItem = record
    TagName: string;
    TagType: integer;
    TagTimestamp: TDateTime;
    TagStartTimestamp: TDateTime;
    TagValue: Variant;
    PorpertyId: Integer;
    TagQuality: integer;
    TagOldValue: Variant;
    PropertyGroupId: integer;
  end;
  TGroupItem = record
    OPCServer: string;
    PropertyGroupId: integer;
    GroupName: string;
    RefreshInterval: integer;
  end;
  PTHistoryItem = ^THistoryItem;
  PTGroupItem = ^TGroupItem;

implementation

end.
