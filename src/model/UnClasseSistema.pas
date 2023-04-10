unit UnClasseSistema;

interface
uses StrUtils,SysUtils, DateUtils, System.Variants, System.Classes, Winapi.Windows, IdBaseComponent, IdComponent, IdIPWatch;

type

  TSistema = class
  private
    FChaveSistema,
    FControleMaquina,
    FFuncionarioLogado,
    FNomeFuncionarioLogado,
    FDiretorioPadrao,
    FEmpresaLogada,
    FNomeEmpresaLogada,
    pVersao            : string;

//    FConfig            : TConfig;
    FPathArqIni,

    FNomeServidor,
    FIPServidor,
    FNomeBanco,
    FLoginBanco,
    FSenhaBAnco          : String;

    FGrupoAcesso: string;
    FIdiomaBanco: String;

    FAno: word;
    FAnoAnterior: word;
    FDataAtual: TDateTime;
    FHoraAgora: TTime;
    FMes: word;
    procedure CarregarArqIni;
  public
    Constructor Create;
    procedure SetFuncionarioLogado(aFuncionario,aNomeFuncionario, aGrupoAcesso: String);
    procedure SetEmpresaLogada(aCodigoEmpresa, aNomeEmpresa: String);
    function CapturarVersaoExe: string;
    procedure AtualizarParametrosData;
    property ChaveSistema : String read FChaveSistema;
    property ControleMaquina : String read FControleMaquina;
    property DiretorioPadrao : string read FDiretorioPadrao;
    property CodigoFuncionarioLogado : string read FFuncionarioLogado;
    property NomeFuncionarioLogado : string read FNomeFuncionarioLogado;
    property CodigoEmpresaLogada : string read FEmpresaLogada;
    property NomeEmpresaLogada : string read FNomeEmpresaLogada;
    property PathArquivoIni : string read FPathArqIni;
    property GrupoAcesso : string read FGrupoAcesso;
    property Versao  : String read pVersao;

    property IPServidor  : String read FIPServidor;
    property IdiomaBanco  : String read FIdiomaBanco;
    property NomeServidor  : String read FNomeServidor;
    property LoginBanco  : String read FLoginBanco;
    property SenhaBAnco : String read FSenhaBAnco;
    property NomeBanco : String read FNomeBanco;

    property AnoAtual : word read FAno;
    property AnoAnterior : word read FAnoAnterior;
    property MesAtual : word read FMes;
    property DataAtual : TDateTime read FDataAtual;
    property HoraAgora : TTime read FHoraAgora;

  end;



implementation
{ TSistema }

uses KrUtil, model.connection;

procedure TSistema.AtualizarParametrosData;
begin
  FAno               := YearOf(Date);
  FMes               := MonthOf(Date);
  FAnoAnterior       := YearOf(Date) - 1;
  FDataAtual         := Date;
  //FDataHoraServidor  := ServerDateTime('192.168.0.251');
  FHoraAgora         := StrToTime(FormatDateTime('hh:mm:ss', Now));
end;

function TSistema.CapturarVersaoExe: string;
var VerInfoSize: DWORD;
    VerInfo: Pointer;
    VerValueSize: DWORD;
    VerValue: PVSFixedFileInfo;
    Dummy: DWORD;
    aVersao : string;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(ParamStr(0)), 0,VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue),VerValueSize);

  with VerValue^ do
  begin
    aVersao := IntToStr(dwFileVersionMS shr 16);
    aVersao := aVersao + '.' + IntToStr(dwFileVersionMS and $FFFF);
    aVersao := aVersao + '.' + IntToStr(dwFileVersionLS shr 16);
//    aVersao := aVersao + '.' + IntToStr(dwFileVersionLS and $FFFF);
  end;
  Result   := aVersao;
  FreeMem(VerInfo, VerInfoSize);
end;

procedure TSistema.CarregarArqIni;
begin
  FPathArqIni      := FDiretorioPadrao+'\Config.ini';
//  pPathArquivoIni  := FPathArqIni;
  FNomeServidor    := LerArquivoIni('CONEXAO','Servidor');
  FIPServidor      := LerArquivoIni('CONEXAO','IPServidor');
  FNomeBanco       := LerArquivoIni('CONEXAO','Banco');
  FLoginBanco      := LerArquivoIni('CONEXAO','Login');
  FSenhaBAnco      := LerArquivoIni('CONEXAO','Senha');
  FIdiomaBanco     := LerArquivoIni('CONEXAO','IdiomaBanco');
end;

constructor TSistema.Create;
begin
  FDiretorioPadrao := GetCurrentDir;
  CarregarArqIni;
  pVersao := CapturarVersaoExe;
  AtualizarParametrosData;
end;

procedure TSistema.SetEmpresaLogada(aCodigoEmpresa, aNomeEmpresa: String);
begin
  FEmpresaLogada     := Trim(aCodigoEmpresa);
  FNomeEmpresaLogada := Trim(aNomeEmpresa);
end;

procedure TSistema.SetFuncionarioLogado(aFuncionario, aNomeFuncionario, aGrupoAcesso: String);
begin
  FFuncionarioLogado     := Trim(aFuncionario);
  FNomeFuncionarioLogado := Trim(aNomeFuncionario);
  FGrupoAcesso           := Trim(aGrupoAcesso);
end;

end.
