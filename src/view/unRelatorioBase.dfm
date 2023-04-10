object frmRelatorioBase: TfrmRelatorioBase
  Left = 0
  Top = 0
  Caption = 'frmRelatorioBase'
  ClientHeight = 689
  ClientWidth = 908
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object RLReport1: TRLReport
    Left = 64
    Top = 40
    Width = 794
    Height = 1123
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 83
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 121
      Width = 718
      Height = 16
    end
    object RLBand3: TRLBand
      Left = 38
      Top = 137
      Width = 718
      Height = 16
    end
  end
  object DataSource1: TDataSource
    Left = 160
    Top = 328
  end
end
