﻿inherited framePedidoVenda: TframePedidoVenda
  inherited pnTitulo: TPanel
    inherited lbTitulo: TLabel
      Width = 54
      Caption = 'Pedido'
      ExplicitWidth = 54
    end
  end
  inherited pnCentral: TPanel
    ExplicitLeft = 152
    ExplicitTop = 32
    inherited pnCadastro: TPanel
      inherited pnBotoesForm: TPanel
        Top = 472
        Height = 89
        Align = alBottom
        BorderStyle = bsSingle
        ExplicitTop = 472
        ExplicitHeight = 89
        DesignSize = (
          1065
          85)
        object Label3: TLabel [0]
          Left = 13
          Top = 9
          Width = 56
          Height = 32
          Caption = 'Total:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -24
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object lbTotalPedido: TLabel [1]
          Left = 85
          Top = 9
          Width = 44
          Height = 32
          Caption = '0,00'
          Font.Charset = ANSI_CHARSET
          Font.Color = 4210816
          Font.Height = -24
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        inherited pn_Confirma: TPanel
          Top = 9
          ExplicitTop = 9
        end
        inherited pn_Cancela: TPanel
          Top = 9
          ExplicitTop = 9
        end
        inherited pn_Exclui: TPanel
          Top = 9
          ExplicitTop = 9
        end
      end
      object pnCabecalho: TPanel
        Left = 1
        Top = 1
        Width = 1069
        Height = 117
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
        StyleName = 'Windows'
        object Label1: TLabel
          Left = 156
          Top = 9
          Width = 46
          Height = 20
          Caption = 'Cliente'
        end
        object Label2: TLabel
          Left = 815
          Top = 9
          Width = 90
          Height = 20
          Caption = 'Data Emiss'#227'o'
        end
        object edtCliente: TSearchBox
          Left = 156
          Top = 33
          Width = 653
          Height = 28
          TabOrder = 0
          OnInvokeSearch = edtClienteInvokeSearch
        end
        object edtNumeroPedido: TLabeledEdit
          Left = 16
          Top = 33
          Width = 134
          Height = 28
          Color = clWhite
          EditLabel.Width = 70
          EditLabel.Height = 20
          EditLabel.Caption = 'N'#186'. Pedido'
          EditLabel.Color = clBlack
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = clBlack
          EditLabel.Font.Height = -15
          EditLabel.Font.Name = 'Segoe UI'
          EditLabel.Font.Style = []
          EditLabel.ParentColor = False
          EditLabel.ParentFont = False
          TabOrder = 1
          Text = ''
        end
        object edtDataEmissao: TDateTimePicker
          Left = 815
          Top = 33
          Width = 125
          Height = 28
          Date = 45026.000000000000000000
          Time = 0.331974918983178200
          TabOrder = 2
        end
      end
      object pbDadosPedido: TPanel
        AlignWithMargins = True
        Left = 4
        Top = 121
        Width = 1063
        Height = 348
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object DBGrid1: TDBGrid
          Left = 0
          Top = 26
          Width = 1063
          Height = 322
          Align = alClient
          BorderStyle = bsNone
          DataSource = dsItens
          DrawingStyle = gdsClassic
          FixedColor = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          Options = [dgTitles, dgColLines, dgRowSelect, dgTitleClick, dgTitleHotTrack]
          ParentFont = False
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = -13
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDrawColumnCell = gridPesquisaDrawColumnCell
          Columns = <
            item
              Expanded = False
              FieldName = 'codigoproduto'
              Title.Caption = 'C'#243'digo do Produto'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'descricao'
              Title.Caption = 'Descri'#231#227'o'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'quantidade'
              Title.Caption = 'Qauntidade'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'vlrunitario'
              Title.Caption = 'Valor Unit'#225'rio'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'vlrtotal'
              Title.Caption = 'Valor Total'
              Visible = True
            end>
        end
        object pnTituloItens: TPanel
          Left = 0
          Top = 0
          Width = 1063
          Height = 26
          Align = alTop
          BevelOuter = bvNone
          Caption = #205'tens do Pedido'
          Color = 12615680
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
          DesignSize = (
            1063
            26)
          object pnIncluirMinisterio: TPanel
            Left = 13
            Top = 2
            Width = 101
            Height = 21
            Anchors = [akLeft]
            BevelOuter = bvNone
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
            object btn_incluirItem: TSpeedButton
              Left = 0
              Top = 0
              Width = 101
              Height = 21
              Align = alClient
              Caption = 'Incluir '#205'tem'
              ImageName = ' '
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -13
              Font.Name = 'Segoe UI Semibold'
              Font.Style = []
              ParentFont = False
              OnClick = btn_incluirItemClick
              ExplicitTop = 1
              ExplicitWidth = 68
              ExplicitHeight = 22
            end
          end
          object pnRemoverItem: TPanel
            Left = 132
            Top = 2
            Width = 101
            Height = 21
            Anchors = [akLeft]
            BevelOuter = bvNone
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
            TabOrder = 1
            object btn_RemoverItem: TSpeedButton
              Left = 0
              Top = 0
              Width = 101
              Height = 21
              Align = alClient
              Caption = 'Remover '#205'tem'
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -13
              Font.Name = 'Segoe UI Semibold'
              Font.Style = []
              ParentFont = False
              OnClick = btn_RemoverItemClick
              ExplicitWidth = 65
              ExplicitHeight = 24
            end
          end
        end
      end
      object pnConsultaCliente: TPanel
        Left = 157
        Top = 64
        Width = 753
        Height = 282
        Caption = 'pnConsultaCliente'
        TabOrder = 3
        Visible = False
        object pnTituloConsultaCliente: TPanel
          Left = 1
          Top = 1
          Width = 751
          Height = 26
          Align = alTop
          BevelOuter = bvNone
          Caption = 'CONSULTA DE CLIENTES'
          Color = 12615680
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
        end
        object pnRodapeConsultaCliente: TPanel
          Left = 1
          Top = 233
          Width = 751
          Height = 48
          Align = alBottom
          BevelOuter = bvNone
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
          ExplicitTop = 200
          DesignSize = (
            751
            48)
          object pnButtonAplicarCliente: TPanel
            Left = 253
            Top = 12
            Width = 101
            Height = 31
            Anchors = [akLeft]
            BevelOuter = bvNone
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
            object btn_AplicarCliente: TSpeedButton
              Left = 0
              Top = 0
              Width = 101
              Height = 31
              Align = alClient
              Caption = 'Aplicar'
              ImageName = ' '
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -13
              Font.Name = 'Segoe UI Semibold'
              Font.Style = []
              ParentFont = False
              OnClick = btn_AplicarClienteClick
              ExplicitTop = 1
              ExplicitWidth = 68
              ExplicitHeight = 22
            end
          end
          object pnButtonCancelCliente: TPanel
            Left = 372
            Top = 12
            Width = 101
            Height = 31
            Anchors = [akLeft]
            BevelOuter = bvNone
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
            TabOrder = 1
            object btn_CancelCliente: TSpeedButton
              Left = 0
              Top = 0
              Width = 101
              Height = 31
              Align = alClient
              Caption = 'Cancelar'
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -13
              Font.Name = 'Segoe UI Semibold'
              Font.Style = []
              ParentFont = False
              OnClick = btn_CancelClienteClick
              ExplicitWidth = 65
              ExplicitHeight = 24
            end
          end
        end
        object DBGItens: TDBGrid
          Left = 1
          Top = 27
          Width = 751
          Height = 206
          Align = alClient
          BorderStyle = bsNone
          DataSource = dsConsultaCliente
          DrawingStyle = gdsClassic
          FixedColor = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          Options = [dgTitles, dgColLines, dgRowSelect, dgTitleClick, dgTitleHotTrack]
          ParentFont = False
          TabOrder = 2
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = -13
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDrawColumnCell = gridPesquisaDrawColumnCell
          Columns = <
            item
              Expanded = False
              FieldName = 'codigo'
              Title.Caption = 'C'#243'digo'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'nome'
              Title.Caption = 'Nome'
              Width = 347
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'cidade'
              Title.Caption = 'Cidade'
              Width = 255
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'uf'
              Title.Caption = 'UF'
              Visible = True
            end>
        end
      end
      object pnInserirItens: TPanel
        Left = 184
        Top = 21
        Width = 753
        Height = 282
        Caption = #39
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        Visible = False
        object pnTituloInserirProduto: TPanel
          Left = 1
          Top = 1
          Width = 751
          Height = 26
          Align = alTop
          BevelOuter = bvNone
          Caption = 'INCLUIR '#205'TEM NO PEDIDO'
          Color = 12615680
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 5
          ExplicitTop = 0
        end
        object Panel3: TPanel
          Left = 1
          Top = 233
          Width = 751
          Height = 48
          Align = alBottom
          BevelOuter = bvNone
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 6
          DesignSize = (
            751
            48)
          object pnbuttonAplicarItem: TPanel
            Left = 253
            Top = 12
            Width = 101
            Height = 31
            Anchors = [akLeft]
            BevelOuter = bvNone
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
            object btn_AplicarItem: TSpeedButton
              Left = 0
              Top = 0
              Width = 101
              Height = 31
              Align = alClient
              Caption = 'Aplicar'
              ImageName = ' '
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -13
              Font.Name = 'Segoe UI Semibold'
              Font.Style = []
              ParentFont = False
              OnClick = btn_AplicarItemClick
              ExplicitTop = 1
              ExplicitWidth = 68
              ExplicitHeight = 22
            end
          end
          object pnbuttonCancelItem: TPanel
            Left = 372
            Top = 12
            Width = 101
            Height = 31
            Anchors = [akLeft]
            BevelOuter = bvNone
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
            TabOrder = 1
            object btn_CancelItem: TSpeedButton
              Left = 0
              Top = 0
              Width = 101
              Height = 31
              Align = alClient
              Caption = 'Cancelar'
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -13
              Font.Name = 'Segoe UI Semibold'
              Font.Style = []
              ParentFont = False
              OnClick = btn_CancelItemClick
              ExplicitWidth = 65
              ExplicitHeight = 24
            end
          end
        end
        object edtCodigoProduto: TLabeledEdit
          Left = 32
          Top = 89
          Width = 134
          Height = 28
          Color = clWhite
          EditLabel.Width = 128
          EditLabel.Height = 20
          EditLabel.Caption = 'C'#243'digo do Produto'
          EditLabel.Color = clBlack
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = clBlack
          EditLabel.Font.Height = -15
          EditLabel.Font.Name = 'Segoe UI'
          EditLabel.Font.Style = []
          EditLabel.ParentColor = False
          EditLabel.ParentFont = False
          TabOrder = 0
          Text = ''
          OnKeyPress = edtCodigoProdutoKeyPress
        end
        object edtDescricao: TLabeledEdit
          Left = 171
          Top = 89
          Width = 403
          Height = 28
          Color = clWhite
          EditLabel.Width = 65
          EditLabel.Height = 20
          EditLabel.Caption = 'Descri'#231#227'o'
          EditLabel.Color = clBlack
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = clBlack
          EditLabel.Font.Height = -15
          EditLabel.Font.Name = 'Segoe UI'
          EditLabel.Font.Style = []
          EditLabel.ParentColor = False
          EditLabel.ParentFont = False
          ReadOnly = True
          TabOrder = 1
          Text = ''
        end
        object edtValorUnit: TLabeledEdit
          Left = 580
          Top = 89
          Width = 131
          Height = 29
          Color = clWhite
          EditLabel.Width = 128
          EditLabel.Height = 20
          EditLabel.Caption = 'C'#243'digo do Produto'
          EditLabel.Color = clBlack
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = clBlack
          EditLabel.Font.Height = -15
          EditLabel.Font.Name = 'Segoe UI'
          EditLabel.Font.Style = []
          EditLabel.ParentColor = False
          EditLabel.ParentFont = False
          ReadOnly = True
          TabOrder = 2
          Text = ''
        end
        object edtQuantidade: TLabeledEdit
          Left = 32
          Top = 159
          Width = 134
          Height = 29
          Color = clWhite
          EditLabel.Width = 78
          EditLabel.Height = 20
          EditLabel.Caption = 'Quantidade'
          EditLabel.Color = clBlack
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = clBlack
          EditLabel.Font.Height = -15
          EditLabel.Font.Name = 'Segoe UI'
          EditLabel.Font.Style = []
          EditLabel.ParentColor = False
          EditLabel.ParentFont = False
          TabOrder = 3
          Text = ''
          OnExit = edtQuantidadeExit
          OnKeyPress = edtQuantidadeKeyPress
        end
        object edtValorTotal: TLabeledEdit
          Left = 171
          Top = 159
          Width = 134
          Height = 29
          Color = clWhite
          EditLabel.Width = 71
          EditLabel.Height = 20
          EditLabel.Caption = 'Valor Total'
          EditLabel.Color = clBlack
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = clBlack
          EditLabel.Font.Height = -15
          EditLabel.Font.Name = 'Segoe UI'
          EditLabel.Font.Style = []
          EditLabel.ParentColor = False
          EditLabel.ParentFont = False
          TabOrder = 4
          Text = ''
          OnKeyPress = edtValorTotalKeyPress
        end
      end
    end
    inherited pnConsulta: TPanel
      inherited pn_imprimirRel: TPanel [0]
      end
      inherited pn_Importar: TPanel [1]
      end
      inherited gridPesquisa: TDBGrid [2]
        DataSource = dsConsulta
        Columns = <
          item
            Expanded = False
            FieldName = 'numeropedido'
            Title.Caption = 'N'#186' do Pedido'
            Width = 88
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'dataemissao'
            Title.Caption = 'Data de Emiss'#227'o'
            Width = 113
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CLIENTE'
            Title.Caption = 'Cliente'
            Width = 456
            Visible = True
          end
          item
            Alignment = taLeftJustify
            Expanded = False
            FieldName = 'valortotal'
            Title.Alignment = taRightJustify
            Title.Caption = 'Valor Total'
            Width = 122
            Visible = True
          end>
      end
      inherited pn_IncluirNovo: TPanel [3]
        inherited btIncluir: TSpeedButton
          Caption = 'Incluir Pedido'
        end
      end
      inherited pnResultado: TPanel [4]
      end
      inherited fraPesquisa: TfraPesquisa [5]
        Height = 34
        ExplicitHeight = 34
        inherited pnFiltros: TPanel
          Height = 3
          ExplicitHeight = 3
          inherited lbPeríodo1: TLabel
            Top = 84
            Width = 54
            Caption = 'Emiss'#227'o'
            ExplicitTop = 84
            ExplicitWidth = 54
          end
          inherited dtPeriodoIni: TDateTimePicker
            Top = 81
            ExplicitTop = 81
          end
          inherited dtPeriodoFim: TDateTimePicker
            Top = 81
            ExplicitTop = 81
          end
          inherited pn_PesqFiltro: TPanel
            Left = 512
            Top = -86
            ExplicitLeft = 512
            ExplicitTop = -86
            inherited brPesqFiltro: TSpeedButton
              ExplicitTop = 200
            end
          end
          inherited edtValor1: TLabeledEdit
            Top = 36
            EditLabel.Width = 90
            EditLabel.Caption = 'Nome do Cliente'
            EditLabel.ExplicitTop = 18
            EditLabel.ExplicitWidth = 90
            TextHint = 'INFORME NOME DO CLIENTE'
            ExplicitTop = 36
          end
          inherited edtValor2: TLabeledEdit
            Top = 202
            EditLabel.ExplicitTop = 184
            Visible = False
            ExplicitTop = 202
          end
          inherited edtValor3: TLabeledEdit
            Top = 247
            EditLabel.ExplicitTop = 229
            Visible = False
            ExplicitTop = 247
          end
          inherited rgFiltro: TRadioGroup
            Top = 270
            Visible = False
            ExplicitTop = 270
          end
        end
      end
    end
  end
  inherited dsConsulta: TDataSource
    DataSet = FDConsulta
    Left = 411
    Top = 307
  end
  inherited FDConsulta: TFDQuery
    Connection = Connection.FDConnection
    SQL.Strings = (
      
        'select p.numeropedido, p.dataemissao, p.codigocliente, p.valorto' +
        'tal, c.nome, (CONVERT(c.codigo,char)||'#39' - '#39'||c.nome) as CLIENTE'
      'from pedido_dados_gerais p'
      'left outer join clientes c on(c.codigo = p.codigocliente)'
      'order by p.dataemissao ')
    Left = 479
    Top = 367
    object FDConsultanumeropedido: TIntegerField
      DisplayWidth = 15
      FieldName = 'numeropedido'
      Origin = 'numeropedido'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDConsultadataemissao: TStringField
      FieldName = 'dataemissao'
      Origin = 'dataemissao'
      Required = True
      Size = 30
    end
    object FDConsultacodigocliente: TIntegerField
      FieldName = 'codigocliente'
      Origin = 'codigocliente'
      Required = True
    end
    object FDConsultavalortotal: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valortotal'
      Origin = 'valortotal'
      Precision = 15
      Size = 2
    end
    object FDConsultanome: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome'
      Origin = 'nome'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object FDConsultaCLIENTE: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'CLIENTE'
      Origin = 'CLIENTE'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object dsItens: TDataSource
    DataSet = FDMemTableItens
    Left = 611
    Top = 251
  end
  object FDMemTableItens: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 715
    Top = 227
    object FDMemTable1numeropedido: TIntegerField
      FieldName = 'numeropedido'
      Origin = 'numeropedido'
      Required = True
    end
    object FDMemTable1codigoproduto: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'codigoproduto'
      Origin = 'codigoproduto'
    end
    object FDMemTable1quantidade: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'quantidade'
      Origin = 'quantidade'
      DisplayFormat = ',0.000'
      EditFormat = '0.000'
      Precision = 15
      Size = 3
    end
    object FDMemTable1vlrunitario: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'vlrunitario'
      Origin = 'vlrunitario'
      DisplayFormat = ',0.00'
      EditFormat = '0.00'
      Precision = 15
      Size = 2
    end
    object FDMemTable1vlrtotal: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'vlrtotal'
      Origin = 'vlrtotal'
      DisplayFormat = ',0.00'
      EditFormat = '0.00'
      Precision = 15
      Size = 2
    end
    object FDMemTable1descricao: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'descricao'
      Origin = 'descricao'
      ProviderFlags = []
      Size = 30
    end
  end
  object dsConsultaCliente: TDataSource
    DataSet = FDPesquisaCliente
    Left = 259
    Top = 267
  end
  object FDPesquisaCliente: TFDQuery
    Connection = Connection.FDConnection
    SQL.Strings = (
      'select * from clientes'
      'order by nome')
    Left = 295
    Top = 359
    object FDPesquisaClientecodigo: TFDAutoIncField
      FieldName = 'codigo'
      Origin = 'codigo'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object FDPesquisaClientenome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 30
    end
    object FDPesquisaClientecidade: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'cidade'
      Origin = 'cidade'
      Size = 50
    end
    object FDPesquisaClienteuf: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'uf'
      Origin = 'uf'
      FixedChar = True
      Size = 2
    end
  end
end