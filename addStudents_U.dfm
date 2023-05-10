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
    Left = 248
    Top = 88
    Width = 121
    Height = 21
    TabOrder = 1
    OnEnter = FirstNameEditEnter
    OnExit = FirstNameEditExit
    OnKeyPress = CheckLetterPress
  end
  object LastNameEdit: TEdit
    Left = 248
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 0
    OnEnter = LastNameEditEnter
    OnExit = LastNameEditExit
    OnKeyPress = CheckLetterPress
  end
  object MiddleNameEdit: TEdit
    Left = 248
    Top = 128
    Width = 121
    Height = 21
    TabOrder = 2
    OnEnter = MiddleNameEditEnter
    OnExit = MiddleNameEditExit
    OnKeyPress = CheckLetterPress
  end
  object GroupEdit: TEdit
    Left = 248
    Top = 176
    Width = 121
    Height = 21
    MaxLength = 6
    NumbersOnly = True
    TabOrder = 3
    OnEnter = GroupEditEnter
    OnExit = GroupEditExit
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
    Left = 248
    Top = 258
    Width = 121
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 5
    OnClick = confirmBtnClick
  end
end
