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
  OldCreateOrder = False
  OnCreate = FormCreate
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
    ColumnClick = False
    GridLines = True
    TabOrder = 0
    ViewStyle = vsReport
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
    TabOrder = 2
    Text = 'GroupsCmb'
  end
  object addNewGroupBtn: TButton
    Left = 40
    Top = 48
    Width = 137
    Height = 21
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1091#1102' '#1075#1088#1091#1087#1087#1091
    TabOrder = 3
  end
  object editStudentBtn: TButton
    Left = 160
    Top = 392
    Width = 98
    Height = 25
    Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
    TabOrder = 4
  end
  object deleteStudentBtn: TButton
    Left = 280
    Top = 392
    Width = 105
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 5
  end
  object searchStudentEdit: TEdit
    Left = 488
    Top = 394
    Width = 201
    Height = 21
    TabOrder = 6
    Text = #1060#1048#1054
  end
  object SearchStudentBtn: TButton
    Left = 710
    Top = 392
    Width = 75
    Height = 25
    Caption = #1055#1086#1080#1089#1082
    TabOrder = 7
  end
  object GroupInfoBtn: TButton
    Left = 416
    Top = 46
    Width = 137
    Height = 25
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1075#1088#1091#1087#1087#1077
    TabOrder = 8
  end
  object showStudentsGroupBtn: TButton
    Left = 600
    Top = 46
    Width = 185
    Height = 25
    Caption = #1057#1090#1091#1076#1077#1085#1090#1099' '#1101#1090#1086#1081' '#1075#1088#1091#1087#1087#1099'...'
    TabOrder = 9
  end
end
