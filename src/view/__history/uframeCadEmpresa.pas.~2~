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
    procedure btImportarClick(Sender: TObject);
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
    procedure ImportarExcel;
    

  end;

var
  frameCadEmpresa: TframeCadEmpresa;




implementation

{$R *.dfm}

uses model.connection, UnMensagem, KrUtil, UnitPergunta, model.empresa;

{ TframeCadEmpresa }

procedure TframeCadEmpresa.btImportarClick(Sender: TObject);
begin
  inherited;
  ImportarExcel;
end;

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

procedure TframeCadEmpresa.ImportarExcel;
var
  wl_Arquivo: String;
  wl_Excel, wl_Plan, wl_TotLinhas: Variant;
  wl_Terminou: Boolean;
  wl_Linha, wl_ID: Integer;


  aEmpresa : iEmpresa;
begin
  inherited;
  if opdProduto.Execute then
  begin
    wl_Arquivo:= opdProduto.FileName;
    if Trim(wl_Arquivo) <> '' then
    begin
      wl_Terminou := False;
      if FileExists(wl_Arquivo) then
      begin
        with Mensagem('Importando endereços. Aguarde...') do
        begin
          try
            pgbMsg.Position := 0;
            pgbMsg.Visible := True;
            wl_Linha := 2;
            wl_Excel := CreateOleObject('Excel.Application');
            wl_Excel.Visible := False;
            wl_Excel.WorkBooks.open(wl_Arquivo); // abre planilha

            wl_plan := wl_Excel.Application.WorkBooks[1].WorkSheets[1].Range['A1:Z10000'];
            wl_TotLinhas := wl_Excel.Cells.SpecialCells(11).Row;
            setTamanhoBarra(wl_TotLinhas);

//            cdsDados.Close;
//            cdsDados.FetchParams;
//            cdsDados.Params.ParamByName('WCodigo').AsInteger := 0;
//            cdsDados.Open;
//          
//            wl_ID := DMDados.NovoCodigo('Endereco', 'CODENDERECO');

            aEmpresa := 
                  TEmpresa
                   .New
                    .IncluirEmpresa ;

            wl_ID := aEmpresa.Codigo;            
            
            while wl_Terminou <> True do
            begin
              if Trim(VarAsType(wl_Plan.Cells[wl_Linha,1], VarString)) <> '' then
              begin
                wl_Terminou := False;                

                TEmpresa
                 .New
                  .Codigo(wl_ID)
                  .Descricao(Trim(VarAsType(wl_Plan.Cells[wl_Linha,2], VarString)))
                   .Insert();

                wl_ID := wl_ID+1;
                Incrementa(1);
                Application.ProcessMessages;
                Inc(wl_Linha);
              end else wl_Terminou := True;
            end;

//            if cdsDados.ApplyUpdates(0) = 0 then
            TFrmMensagem.ExibirMensagem('Importação efetuada com sucesso!',tmInformacao);
              
          finally
            wl_Excel.Quit;
//            cdsDados.Close;
            Free;
          end;
        end;
      end;
    end
      else
    begin
      TFrmMensagem.ExibirMensagem('Arquivo não encontrado!!',tmInformacao);
      Exit;
    end;
  end;   
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
          raise Exception.Create('Problemas na gravação da empresa! '+E.Message);
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
      TFrmMensagem.ExibirMensagem('Informe a descrição da empresa!', tmInformacao);
      Exit;
    end;
  end;
  Result := True;
end;

end.
