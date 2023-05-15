object addGroupForm: TaddGroupForm
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
  ClientHeight = 340
  ClientWidth = 616
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupEdit: TEdit
    Left = 232
    Top = 64
    Width = 171
    Height = 21
    MaxLength = 6
    NumbersOnly = True
    TabOrder = 0
    TextHint = #1053#1086#1084#1077#1088' '#1075#1088#1091#1087#1087#1099
    OnChange = GroupEditChange
  end
  object YearEdit: TEdit
    Left = 232
    Top = 112
    Width = 171
    Height = 21
    Hint = #1075#1086#1076' '#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1103
    MaxLength = 4
    NumbersOnly = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    TextHint = #1043#1086#1076' '#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1103
    OnChange = GroupEditChange
  end
  object CodeEdit: TMaskEdit
    Left = 232
    Top = 168
    Width = 171
    Height = 21
    EditMask = '0\-00\ 00\ 00;1;_'
    MaxLength = 10
    TabOrder = 2
    Text = ' -        '
    OnChange = GroupEditChange
  end
  object cancelBtn: TButton
    Left = 232
    Top = 216
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 3
    OnClick = cancelBtnClick
  end
  object confirmBtn: TButton
    Left = 328
    Top = 216
    Width = 75
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 4
    OnClick = confirmBtnClick
  end
end
