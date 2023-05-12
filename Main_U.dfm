object App: TApp
  Left = 0
  Top = 0
  Caption = 'App'
  ClientHeight = 440
  ClientWidth = 820
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object StudentsList: TListView
    Left = 40
    Top = 88
    Width = 745
    Height = 282
    BorderStyle = bsNone
    Columns = <
      item
        Caption = #8470' '#1087'/'#1087
        MaxWidth = 60
        MinWidth = 60
        Width = 60
      end
      item
        Caption = #1060#1048#1054
        MinWidth = 250
        Width = 250
      end
      item
        AutoSize = True
        Caption = #1043#1088#1091#1087#1087#1072
        MaxWidth = 80
        MinWidth = 80
      end
      item
        Caption = #1057#1088#1077#1076#1085#1080#1081' '#1073#1072#1083#1083
        Width = -2
        WidthType = (
          -2)
      end>
    GridLines = True
    TabOrder = 0
    ViewStyle = vsReport
    OnChange = StudentsListChange
    OnColumnClick = StudentsListColumnClick
  end
  object addStudentBtn: TButton
    Left = 40
    Top = 392
    Width = 97
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 1
    OnClick = addStudentBtnClick
  end
  object GroupsCmb: TComboBox
    Left = 224
    Top = 48
    Width = 145
    Height = 21
    Style = csDropDownList
    TabOrder = 2
    TextHint = #1042#1099#1073#1086#1088' '#1075#1088#1091#1087#1087#1099
    OnChange = GroupsCmbChange
  end
  object addNewGroupBtn: TButton
    Left = 40
    Top = 48
    Width = 137
    Height = 21
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1091#1102' '#1075#1088#1091#1087#1087#1091
    TabOrder = 3
    OnClick = addNewGroupBtnClick
  end
  object studentInfoBtn: TButton
    Left = 168
    Top = 392
    Width = 105
    Height = 25
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
    Enabled = False
    TabOrder = 4
    OnClick = studentInfoBtnClick
  end
  object SearchStudentBtn: TButton
    Left = 720
    Top = 392
    Width = 65
    Height = 25
    Caption = #1055#1086#1080#1089#1082
    TabOrder = 5
    OnClick = SearchStudentBtnClick
  end
  object GroupInfoBtn: TButton
    Left = 384
    Top = 46
    Width = 129
    Height = 25
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1075#1088#1091#1087#1087#1077
    Enabled = False
    TabOrder = 6
    OnClick = GroupInfoBtnClick
  end
  object showStudentsGroupBtn: TButton
    Left = 519
    Top = 46
    Width = 137
    Height = 25
    Caption = #1057#1090#1091#1076#1077#1085#1090#1099' '#1101#1090#1086#1081' '#1075#1088#1091#1087#1087#1099'...'
    TabOrder = 7
    OnClick = showStudentsGroupBtnClick
  end
  object FirstNameEdit: TEdit
    Left = 496
    Top = 394
    Width = 106
    Height = 21
    MaxLength = 30
    TabOrder = 8
    TextHint = #1048#1084#1103
  end
  object LastNameEdit: TEdit
    Left = 384
    Top = 394
    Width = 106
    Height = 21
    MaxLength = 30
    TabOrder = 9
    TextHint = #1060#1072#1084#1080#1083#1080#1103
  end
  object MiddleNameEdit: TEdit
    Left = 608
    Top = 394
    Width = 106
    Height = 21
    MaxLength = 30
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    TextHint = #1054#1090#1095#1077#1089#1090#1074#1086
  end
  object showAllStudentsBtn: TButton
    Left = 679
    Top = 46
    Width = 106
    Height = 25
    Caption = #1042#1089#1077' '#1089#1090#1091#1076#1077#1085#1090#1099'...'
    TabOrder = 11
    OnClick = showAllStudentsBtnClick
  end
end
