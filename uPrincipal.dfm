object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Thread'
  ClientHeight = 231
  ClientWidth = 230
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
  object Button1: TButton
    Left = 0
    Top = 0
    Width = 230
    Height = 65
    Align = alTop
    Caption = 'No Thread'
    TabOrder = 0
    OnClick = Button1Click
    ExplicitWidth = 220
  end
  object Button2: TButton
    Left = 0
    Top = 65
    Width = 230
    Height = 65
    Align = alTop
    Caption = 'Thread'
    TabOrder = 1
    OnClick = Button2Click
    ExplicitWidth = 220
  end
  object mmo1: TMemo
    Left = 0
    Top = 136
    Width = 230
    Height = 95
    Align = alBottom
    TabOrder = 2
  end
end
