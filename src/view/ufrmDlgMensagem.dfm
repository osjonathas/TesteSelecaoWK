object fSC_FormMensagem: TfSC_FormMensagem
  Left = 327
  Top = 333
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Mensagem'
  ClientHeight = 125
  ClientWidth = 487
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 13
  object pnCentro: TPanel
    Left = 0
    Top = 0
    Width = 487
    Height = 125
    Align = alClient
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 84
    ExplicitWidth = 185
    ExplicitHeight = 41
    object Image2: TImage
      Left = 427
      Top = 26
      Width = 52
      Height = 42
      Center = True
      Proportional = True
    end
    object Label1: TLabel
      Left = 3
      Top = 26
      Width = 418
      Height = 42
      AutoSize = False
      Caption = 'lb_Mens'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object pgbMsg: TProgressBar
      Left = 24
      Top = 96
      Width = 417
      Height = 17
      TabOrder = 0
    end
  end
  object Timer: TTimer
    Left = 257
    Top = 32
  end
end
