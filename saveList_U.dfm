object SaveListForm: TSaveListForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1089#1087#1080#1089#1086#1082
  ClientHeight = 298
  ClientWidth = 564
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object RadioGroup: TRadioGroup
    Left = 160
    Top = 64
    Width = 233
    Height = 105
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1089#1087#1080#1089#1086#1082':'
    Items.Strings = (
      #1057#1087#1080#1089#1086#1082' '#1089#1090#1091#1076#1077#1085#1090#1086#1074' '#1085#1072' '#1086#1090#1095#1080#1089#1083#1077#1085#1080#1077
      #1057#1087#1080#1089#1086#1082' '#1089#1090#1091#1076#1077#1085#1090#1086#1074'-'#1079#1072#1076#1086#1083#1078#1085#1080#1082#1086#1074)
    TabOrder = 0
    OnClick = RadioGroupClick
  end
  object SaveBtn: TButton
    Left = 232
    Top = 190
    Width = 75
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Enabled = False
    TabOrder = 1
    OnClick = SaveBtnClick
  end
end
