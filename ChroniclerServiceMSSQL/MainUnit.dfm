object ChroniclerLogger: TChroniclerLogger
  OldCreateOrder = False
  OnCreate = ServiceCreate
  OnDestroy = ServiceDestroy
  DisplayName = 'Chronicler'
  Left = 261
  Top = 307
  Height = 128
  Width = 215
  object XMLConfig: TXMLDocument
    FileName = 'c:\chronicler_config.xml'
    NodeIndentStr = ' '
    Left = 32
    Top = 16
    DOMVendorDesc = 'MSXML'
  end
end
