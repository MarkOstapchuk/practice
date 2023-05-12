object infoStudentForm: TinfoStudentForm
  Left = 0
  Top = 0
  Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1089#1090#1091#1076#1077#1085#1090#1077
  ClientHeight = 316
  ClientWidth = 607
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LastNameLabel: TLabel
    Left = 171
    Top = 43
    Width = 48
    Height = 13
    Caption = #1060#1072#1084#1080#1083#1080#1103':'
  end
  object FirstNameLabel: TLabel
    Left = 171
    Top = 83
    Width = 23
    Height = 13
    Caption = #1048#1084#1103':'
  end
  object MiddleNameLabel: TLabel
    Left = 171
    Top = 123
    Width = 53
    Height = 13
    Caption = #1054#1090#1095#1077#1089#1090#1074#1086':'
  end
  object GroupLabel: TLabel
    Left = 171
    Top = 160
    Width = 36
    Height = 13
    Caption = #1043#1088#1091#1087#1087#1072
  end
  object DeleteBtn: TButton
    Left = 171
    Top = 216
    Width = 103
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 0
    OnClick = DeleteBtnClick
  end
  object EditBtn: TButton
    Left = 330
    Top = 216
    Width = 108
    Height = 25
    Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
    TabOrder = 1
    OnClick = EditBtnClick
  end
  object SaveBtn: TButton
    Left = 325
    Top = 216
    Width = 113
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 2
    Visible = False
    OnClick = SaveBtnClick
  end
  object CancelBtn: TButton
    Left = 171
    Top = 216
    Width = 103
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 3
    Visible = False
    OnClick = CancelBtnClick
  end
  object FirstNameEdit: TEdit
    Left = 293
    Top = 80
    Width = 145
    Height = 21
    Enabled = False
    MaxLength = 30
    TabOrder = 4
    TextHint = #1048#1084#1103
    OnChange = FirstNameEditChange
    OnKeyPress = CheckLetterPress
  end
  object LastNameEdit: TEdit
    Left = 293
    Top = 40
    Width = 145
    Height = 21
    Enabled = False
    MaxLength = 30
    TabOrder = 5
    TextHint = #1060#1072#1084#1080#1083#1080#1103
    OnKeyPress = CheckLetterPress
  end
  object MiddleNameEdit: TEdit
    Left = 293
    Top = 120
    Width = 145
    Height = 21
    Enabled = False
    MaxLength = 30
    TabOrder = 6
    TextHint = #1054#1090#1095#1077#1089#1090#1074#1086
    OnKeyPress = CheckLetterPress
  end
  object GroupsCmb: TComboBox
    Left = 293
    Top = 157
    Width = 145
    Height = 21
    Style = csDropDownList
    TabOrder = 7
  end
  object GroupEdit: TEdit
    Left = 293
    Top = 157
    Width = 145
    Height = 21
    Enabled = False
    TabOrder = 8
  end
end
