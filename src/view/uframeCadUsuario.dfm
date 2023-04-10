inherited frameCadUsuario: TframeCadUsuario
  inherited pnTitulo: TPanel
    inherited lbTitulo: TLabel
      Width = 153
      Caption = 'Cadastro de Usu'#225'rio'
      ExplicitWidth = 153
    end
    inherited btnClose: TSpeedButton
      Left = 1060
      Top = 5
      ExplicitLeft = 1060
      ExplicitTop = 5
    end
  end
  inherited pnCentral: TPanel
    inherited pnConsulta: TPanel [0]
      inherited gridPesquisa: TDBGrid
        DataSource = dsConsulta
        Columns = <
          item
            Expanded = False
            FieldName = 'codigo'
            Title.Caption = 'C'#243'digo'
            Width = 83
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'login'
            Title.Caption = 'Login'
            Width = 355
            Visible = True
          end>
      end
      inherited fraPesquisa: TfraPesquisa
        inherited btConf: TSpeedButton
          Enabled = False
        end
      end
      inherited pn_Importar: TPanel
        Left = 234
        Visible = True
        ExplicitLeft = 234
      end
      inherited pn_imprimirRel: TPanel
        Left = 126
        Visible = True
        ExplicitLeft = 126
      end
    end
    inherited pnCadastro: TPanel [1]
      object edtCodigo: TMaskEdit
        Left = 40
        Top = 58
        Width = 121
        Height = 23
        TabOrder = 1
        Text = 'edtCodigo'
      end
      object edtNome: TSearchBox
        Left = 40
        Top = 116
        Width = 425
        Height = 23
        TabOrder = 2
        Text = 'edtNome'
      end
    end
  end
  inherited dsConsulta: TDataSource
    DataSet = FDConsulta
  end
  inherited FDConsulta: TFDQuery
    Connection = Connection.FDConnection
    SQL.Strings = (
      ' SELECT codigo, login, senha  FROM Funcionarios  '
      ' ORDER BY login')
    object FDConsultacodigo: TFDAutoIncField
      FieldName = 'codigo'
      Origin = 'codigo'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDConsultalogin: TStringField
      FieldName = 'login'
      Origin = 'login'
      Required = True
      Size = 30
    end
    object FDConsultasenha: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'senha'
      Origin = 'senha'
      Size = 50
    end
  end
end
