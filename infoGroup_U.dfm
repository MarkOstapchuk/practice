object infoGroupForm: TinfoGroupForm
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1075#1088#1091#1087#1087#1077
  ClientHeight = 241
  ClientWidth = 515
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
  object GroupLabel: TLabel
    Left = 115
    Top = 35
    Width = 75
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1075#1088#1091#1087#1087#1099':'
  end
  object YearLabel: TLabel
    Left = 115
    Top = 75
    Width = 91
    Height = 13
    Caption = #1043#1086#1076' '#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1103':'
  end
  object codeLabel: TLabel
    Left = 115
    Top = 112
    Width = 103
    Height = 13
    Caption = #1050#1086#1076' '#1089#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1080':'
  end
  object studentsCountLabel: TLabel
    Left = 115
    Top = 144
    Width = 91
    Height = 13
    Caption = #1063#1080#1089#1083#1086' '#1089#1090#1091#1076#1077#1085#1090#1086#1074':'
  end
  object StudentsCount: TLabel
    Left = 224
    Top = 144
    Width = 6
    Height = 13
    Caption = '0'
  end
  object GroupEdit: TEdit
    Left = 224
    Top = 32
    Width = 145
    Height = 21
    TabStop = False
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 6
    NumbersOnly = True
    ParentFont = False
    TabOrder = 0
  end
  object YearEdit: TEdit
    Left = 224
    Top = 72
    Width = 145
    Height = 21
    TabStop = False
    Enabled = False
    MaxLength = 4
    NumbersOnly = True
    TabOrder = 1
  end
  object CodeEdit: TMaskEdit
    Left = 224
    Top = 109
    Width = 145
    Height = 21
    TabStop = False
    Enabled = False
    EditMask = '0\-00\ 00\ 00;1;_'
    MaxLength = 10
    TabOrder = 2
    Text = ' -        '
  end
  object DeleteBtn: TButton
    Left = 115
    Top = 176
    Width = 103
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 3
    OnClick = DeleteBtnClick
  end
  object EditBtn: TButton
    Left = 261
    Top = 176
    Width = 108
    Height = 25
    Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
    TabOrder = 4
    OnClick = EditBtnClick
  end
  object SaveBtn: TButton
    Left = 261
    Top = 176
    Width = 113
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 5
    Visible = False
    OnClick = SaveBtnClick
  end
  object CancelBtn: TButton
    Left = 115
    Top = 176
    Width = 103
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 6
    Visible = False
    OnClick = CancelBtnClick
  end
end
