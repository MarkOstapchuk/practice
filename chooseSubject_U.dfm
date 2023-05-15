object chooseSubjectForm: TchooseSubjectForm
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1076#1080#1089#1094#1080#1087#1083#1080#1085#1091
  ClientHeight = 177
  ClientWidth = 515
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
  object Label1: TLabel
    Left = 200
    Top = 32
    Width = 113
    Height = 13
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1076#1080#1089#1094#1080#1087#1083#1080#1085#1091
  end
  object SubjectsCmb: TComboBox
    Left = 138
    Top = 79
    Width = 231
    Height = 21
    Style = csDropDownList
    TabOrder = 0
  end
  object confirmBtn: TButton
    Left = 200
    Top = 120
    Width = 97
    Height = 25
    Caption = #1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100
    TabOrder = 1
    OnClick = confirmBtnClick
  end
end
