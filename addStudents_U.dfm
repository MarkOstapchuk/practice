object addStudentsForm: TaddStudentsForm
  Left = 0
  Top = 0
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1090#1091#1076#1077#1085#1090#1072
  ClientHeight = 311
  ClientWidth = 583
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
  object FirstNameEdit: TEdit
    Left = 240
    Top = 88
    Width = 145
    Height = 21
    MaxLength = 30
    TabOrder = 1
    TextHint = #1048#1084#1103
    OnChange = EditChange
    OnKeyPress = CheckLetterPress
  end
  object LastNameEdit: TEdit
    Left = 240
    Top = 48
    Width = 145
    Height = 21
    MaxLength = 30
    TabOrder = 0
    TextHint = #1060#1072#1084#1080#1083#1080#1103
    OnChange = EditChange
    OnKeyPress = CheckLetterPress
  end
  object MiddleNameEdit: TEdit
    Left = 240
    Top = 128
    Width = 145
    Height = 21
    MaxLength = 30
    TabOrder = 2
    TextHint = #1054#1090#1095#1077#1089#1090#1074#1086
    OnChange = EditChange
    OnKeyPress = CheckLetterPress
  end
  object addGradesBtn: TButton
    Left = 248
    Top = 211
    Width = 121
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1086#1094#1077#1085#1082#1080
    TabOrder = 4
    OnClick = addGradesBtnClick
  end
  object confirmBtn: TButton
    Left = 328
    Top = 258
    Width = 121
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 5
    OnClick = confirmBtnClick
  end
  object GroupsCmb: TComboBox
    Left = 240
    Top = 168
    Width = 145
    Height = 21
    TabOrder = 3
    TextHint = #1043#1088#1091#1087#1087#1072
    OnChange = EditChange
  end
  object CancelBtn: TButton
    Left = 184
    Top = 258
    Width = 105
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 6
    OnClick = CancelBtnClick
  end
end
