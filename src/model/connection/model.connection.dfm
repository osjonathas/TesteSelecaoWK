object Connection: TConnection
  Height = 480
  Width = 640
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=bancoselecaowk'
      'User_Name=root'
      'Password=masterkey'
      'DriverID=MySQL')
    Left = 64
    Top = 32
  end
  object FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink
    VendorHome = 'D:\Projetos\Publicos\TesteSelecaoWK\Win32\Debug'
    VendorLib = 'libmysql.dll'
    Left = 72
    Top = 136
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 208
    Top = 136
  end
  object FDQuery: TFDQuery
    Connection = FDConnection
    Left = 240
    Top = 32
  end
end
