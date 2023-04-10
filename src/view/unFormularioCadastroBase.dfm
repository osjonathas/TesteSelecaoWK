inherited frmFormularioCadastroBase: TfrmFormularioCadastroBase
  Caption = 'frmFormularioCadastroBase'
  Color = 16709097
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  TextHeight = 13
  inherited pnTitulo: TPanel
    Height = 27
    ExplicitHeight = 27
    DesignSize = (
      986
      27)
    inherited lbTitulo: TLabel
      Top = 1
      Width = 187
      Caption = 'Formul'#225'rio Cadatro Base'
      ExplicitTop = 1
      ExplicitWidth = 187
    end
    inherited lbSubTituloForm: TLabel
      Width = 94
      Caption = 'LESSON ONE'
      ExplicitWidth = 94
    end
  end
  inherited pnCentral: TPanel
    Top = 27
    Height = 637
    ExplicitTop = 27
    ExplicitHeight = 637
    inherited pnInterno: TPanel
      Width = 956
      Height = 607
      Align = alClient
      ExplicitWidth = 956
      ExplicitHeight = 607
      object pnConsulta: TPanel
        Left = 0
        Top = 0
        Width = 956
        Height = 607
        Align = alClient
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        StyleName = 'Windows'
        object gridPesquisa: TDBGrid
          Left = 1
          Top = 136
          Width = 954
          Height = 470
          Align = alBottom
          Anchors = [akLeft, akTop, akRight, akBottom]
          DrawingStyle = gdsClassic
          FixedColor = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          Options = [dgTitles, dgColLines, dgRowSelect, dgTitleClick, dgTitleHotTrack]
          ParentFont = False
          TabOrder = 1
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = -13
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDrawColumnCell = gridPesquisaDrawColumnCell
          OnDblClick = gridPesquisaDblClick
        end
        object pn_IncluirNovo: TPanel
          Left = 16
          Top = 68
          Width = 100
          Height = 32
          Color = 12615680
          DoubleBuffered = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentBackground = False
          ParentDoubleBuffered = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
          TabOrder = 0
          object btIncluir: TSpeedButton
            Left = 1
            Top = 1
            Width = 98
            Height = 30
            Align = alClient
            Caption = 'Incluir Novo'
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -13
            Font.Name = 'Segoe UI Semibold'
            Font.Style = []
            ParentFont = False
            OnClick = btIncluirClick
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 95
            ExplicitHeight = 19
          end
        end
        object pnResultado: TPanel
          Left = 1
          Top = 113
          Width = 954
          Height = 23
          Align = alBottom
          BevelOuter = bvNone
          Caption = 'Resultado'
          Color = 12615680
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 2
        end
        inline fraPesquisa: TfraPesquisa
          Left = 17
          Top = 23
          Width = 707
          Height = 31
          VertScrollBar.Style = ssFlat
          VertScrollBar.Tracking = True
          VertScrollBar.Visible = False
          AutoScroll = True
          Color = clWhite
          ParentBackground = False
          ParentColor = False
          TabOrder = 3
          StyleName = 'Windows'
          ExplicitLeft = 17
          ExplicitTop = 23
          ExplicitWidth = 707
          ExplicitHeight = 31
          inherited Shape1: TShape
            Width = 707
            ExplicitWidth = 707
          end
          inherited btConf: TSpeedButton
            Left = 631
            ExplicitLeft = 631
          end
          inherited btPesq: TSpeedButton
            Left = 670
            ExplicitLeft = 670
          end
          inherited edtValor: TEdit
            Width = 557
            ExplicitWidth = 557
          end
          inherited pnFiltros: TPanel
            Width = 707
            Height = 49
            ExplicitWidth = 707
            ExplicitHeight = 49
            inherited pn_PesqFiltro: TPanel
              Left = 575
              Top = 4
              ExplicitLeft = 575
              ExplicitTop = 4
            end
            inherited edtValor1: TLabeledEdit
              EditLabel.Height = 13
              EditLabel.ExplicitLeft = 21
              EditLabel.ExplicitTop = 2
              EditLabel.ExplicitHeight = 13
            end
            inherited edtValor2: TLabeledEdit
              EditLabel.Height = 13
              EditLabel.ExplicitLeft = 21
              EditLabel.ExplicitTop = 50
              EditLabel.ExplicitHeight = 13
            end
            inherited edtValor3: TLabeledEdit
              EditLabel.Height = 13
              EditLabel.ExplicitLeft = 21
              EditLabel.ExplicitTop = 95
              EditLabel.ExplicitHeight = 13
            end
          end
        end
      end
      object pnCadastro: TPanel
        Left = 0
        Top = 0
        Width = 956
        Height = 607
        Align = alClient
        Color = clWhite
        ParentBackground = False
        TabOrder = 1
        StyleName = 'Windows'
        object pnBotoesForm: TPanel
          Left = 1
          Top = 1
          Width = 954
          Height = 41
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          DesignSize = (
            954
            41)
          object pn_Confirma: TPanel
            Left = 835
            Top = 4
            Width = 105
            Height = 32
            Color = 6010624
            DoubleBuffered = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentBackground = False
            ParentDoubleBuffered = False
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
            TabOrder = 0
            object btConfirma: TSpeedButton
              Left = 1
              Top = 1
              Width = 103
              Height = 30
              Align = alClient
              Caption = 'Confirmar'
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -13
              Font.Name = 'Segoe UI Semibold'
              Font.Style = []
              ParentFont = False
              OnClick = btConfirmaClick
              ExplicitLeft = 9
            end
          end
          object pn_Cancela: TPanel
            Left = 724
            Top = 4
            Width = 105
            Height = 32
            Anchors = [akLeft]
            Color = clSilver
            DoubleBuffered = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentBackground = False
            ParentDoubleBuffered = False
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
            TabOrder = 1
            object btCancela: TSpeedButton
              Left = 1
              Top = 1
              Width = 103
              Height = 30
              Align = alClient
              Caption = 'Cancelar'
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -13
              Font.Name = 'Segoe UI Semibold'
              Font.Style = []
              ParentFont = False
              OnClick = btCancelaClick
              ExplicitLeft = 2
              ExplicitTop = 6
            end
          end
          object pn_Exclui: TPanel
            Left = 613
            Top = 4
            Width = 105
            Height = 32
            Color = clRed
            DoubleBuffered = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentBackground = False
            ParentDoubleBuffered = False
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
            TabOrder = 2
            object btExclui: TSpeedButton
              Left = 1
              Top = 1
              Width = 103
              Height = 30
              Align = alClient
              Caption = 'Excluir'
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -13
              Font.Name = 'Segoe UI Semibold'
              Font.Style = []
              ParentFont = False
              ExplicitLeft = 2
              ExplicitTop = 2
            end
          end
        end
      end
    end
  end
  object dsConsulta: TDataSource
    Left = 379
    Top = 331
  end
  object FDConsulta: TFDQuery
    Left = 463
    Top = 319
  end
end
