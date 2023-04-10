unit uframeCadEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uframeCadastroBase, Data.DB, unfraPesquisa, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Mask, einterface.empresa, System.Win.ComObj;

type
  TframeCadEmpresa = class(TframeCadastroBase)
    edtCodigo: TLabeledEdit;
    edtDescricao: TLabeledEdit;
    FDConsultaemp_codigo: TFDAutoIncField;
    FDConsultaemp_rzsocial: TStringField;
    FDConsultaemp_cnpj: TStringField;
    edtCNPJ: TLabeledEdit;
    procedure gridPesquisaDblClick(Sender: TObject);
  private
    { Private declarations }
    FEmpresa : iEmpresa;
    FNomeTabela: String;
    FCampoControle: String;
  public
    { Public declarations }
    procedure LimparDados;
    procedure ColocarEmEstadoInclusao; override;
    procedure ExecutarPesquisa; Override;
    procedure CarregarRegistroPesquisa(AValor: String); override;
    procedure Persistir; Override;

    property NomeTabela: String read FNomeTabela write FNomeTabela;
    property CampoControle: String read FCampoControle write FCampoControle;
    function valida(aOpcao: integer):boolean;

  end;

var
  frameCadEmpresa: TframeCadEmpresa;




implementation

{$R *.dfm}

uses model.connection, UnMensagem, KrUtil, UnitPergunta, model.empresa;

{ TframeCadEmpresa }

procedure TframeCadEmpresa.CarregarRegistroPesquisa(AValor: String);
begin
  inherited;  
  try
    FEmpresa := 
      TEmpresa
       .New
        .getEmpresa(StrToInt(AValor));

    edtCodigo.Text := IntToStr(FEmpresa.Codigo);
    edtDescricao.Text := FEmpresa.Descricao;
    edtCNPJ.Text := FEmpresa.CNPJ;
    ColocarEmEstadoEdicao;
  //  edtDescricao.SetFocus;
  finally

  end;
end;

procedure TframeCadEmpresa.ColocarEmEstadoInclusao;
begin
  inherited;
  LimparDados;
   FEmpresa := 
     TEmpresa
      .New
       .IncluirEmpresa ;

  edtCodigo.Text := IntToStr(FEmpresa.Codigo);
  edtCodigo.Enabled := False;
  edtDescricao.SetFocus;
end;

procedure TframeCadEmpresa.ExecutarPesquisa;
begin
  TEmpresa
   .New
    .Open('', dsConsulta);
end;

procedure TframeCadEmpresa.gridPesquisaDblClick(Sender: TObject);
begin
  inherited;
  CarregarRegistroPesquisa(dsConsulta.DataSet.FieldByName('EMP_CODIGO').AsString);
end;

procedure TframeCadEmpresa.LimparDados;
begin
  edtCodigo.Clear;
  edtDescricao.Clear;
  Application.ProcessMessages;
end;

procedure TframeCadEmpresa.Persistir;
begin
  if valida(0) then
  begin
    if TfrmPergunta.Pergunta(mPerguntaGravacao, tmPergunta) then
    begin
      try
        if FInclusao then
          TEmpresa
           .New
            .Codigo(StrToInt(edtCodigo.Text))
            .Descricao(edtDescricao.text)
            .CNPJ(edtCNPJ.text)
             .Insert()
        else
          if FEdicao then
          TEmpresa
           .New
            .Codigo(StrToInt(edtCodigo.Text))
            .Descricao(edtDescricao.text)
            .CNPJ(edtCNPJ.text)
             .Update();

        TfrmMensagem.ExibirMensagem(mRegistroSalvoComSucesso, tmInformacao);
        inherited;
      except on E: Exception do
        begin
          raise Exception.Create('Problemas na grava��o da empresa! '+E.Message);
        end;
      end;
    end;
  end;
end;

function TframeCadEmpresa.valida(aOpcao: integer): boolean;
begin
  Result := False;
  if aOpcao in [0,1] then
  begin
    if trim(edtDescricao.Text) = EmptyStr then
    begin
      TFrmMensagem.ExibirMensagem('Informe a descri��o da empresa!', tmInformacao);
      Exit;
    end;
  end;
  Result := True;
end;

end.
