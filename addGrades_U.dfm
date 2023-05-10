object addGradesForm: TaddGradesForm
  Left = 494
  Top = 309
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1086#1094#1077#1085#1082#1080
  ClientHeight = 329
  ClientWidth = 605
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SubjectsCmb: TComboBox
    Left = 72
    Top = 40
    Width = 249
    Height = 21
    Style = csDropDownList
    DropDownCount = 12
    ItemIndex = 0
    TabOrder = 0
    Text = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1074#1086#1081'...'
    OnChange = SubjectsCmbChange
    Items.Strings = (
      #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1074#1086#1081'...')
  end
  object gradeEdit: TNumberBox
    Left = 376
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object GradesList: TListView
    Left = 72
    Top = 141
    Width = 473
    Height = 126
    Columns = <
      item
        Caption = #1044#1080#1089#1094#1080#1087#1083#1080#1085#1072
        MinWidth = 250
        Width = 300
      end
      item
        Caption = #1054#1090#1084#1077#1090#1082#1072
        Width = -2
        WidthType = (
          -2)
      end>
    TabOrder = 2
    ViewStyle = vsReport
  end
  object confirmBtn: TButton
    Left = 272
    Top = 94
    Width = 75
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Enabled = False
    TabOrder = 3
    OnClick = confirmBtnClick
  end
  object addSubjectEdit: TEdit
    Left = 72
    Top = 67
    Width = 249
    Height = 21
    TabOrder = 4
    OnChange = addSubjectEditChange
  end
  object saveBtn: TButton
    Left = 272
    Top = 273
    Width = 75
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 5
    OnClick = saveBtnClick
  end
end
