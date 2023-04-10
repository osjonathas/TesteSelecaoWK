#OBSERVAÇÃO
#A IDE RAD Studio trabalha em 32 bits, e portanto não pode conectar com o MySQL 8 que só está disponível em 64 bits.
#Por este motivo, estamos utilizando a versão 5.7 do MySQL; 
#



#CREATE schema bancoselecaowk;
USE bancoselecaowk;

# CRIANDO TABELA FUNCIONARIOS PARA ESTABELECER O LOGIN
CREATE TABLE funcionarios(
codigo int NOT NULL AUTO_INCREMENT,
login varchar(30) NOT NULL,
senha varchar(50),
PRIMARY KEY (codigo)
)AUTO_INCREMENT = 1;

# CRIANDO TABELA DE CLIENTES
CREATE TABLE clientes(
codigo int NOT NULL AUTO_INCREMENT,
nome varchar(30) NOT NULL,
cidade varchar(50),
uf      char(2),
PRIMARY KEY (codigo)
)AUTO_INCREMENT = 1;


# CRIANDO TABELA DE PRODUTOS
CREATE TABLE produtos(
codigo int NOT NULL AUTO_INCREMENT,
descricao varchar(30) NOT NULL,
precovenda Numeric(15,2) default 0,
PRIMARY KEY (codigo)
)AUTO_INCREMENT = 1;


# CRIANDO TABELA DE PEDIDOS DE VENDA
CREATE TABLE pedido_dados_gerais(
numeropedido int NOT NULL,
dataemissao varchar(30) NOT NULL,
codigocliente int NOT NULL,
valortotal Numeric(15,2) default 0,
PRIMARY KEY (numeropedido)
);

ALTER TABLE pedido_dados_gerais ADD CONSTRAINT fk_dados_pedido_clientes FOREIGN KEY(codigocliente) REFERENCES clientes(codigo);


# CRIANDO TABELA DE ITENS DOS PEDIDOS DE VENDA
CREATE TABLE produtos_do_pedido(
autoincrem int NOT NULL AUTO_INCREMENT,
numeropedido int NOT NULL,
codigoproduto int ,
quantidade Numeric(15,3) default 0,
vlrunitario Numeric(15,2) default 0,
vlrtotal Numeric(15,2) default 0,
PRIMARY KEY (autoincrem)
)AUTO_INCREMENT = 1;

ALTER TABLE produtos_do_pedido ADD CONSTRAINT fk_dados_pedido_produtos FOREIGN KEY (codigoproduto) REFERENCES produtos(codigo);
ALTER TABLE produtos_do_pedido ADD CONSTRAINT fk_produtos_pedido_dados_pedido FOREIGN KEY(numeropedido) REFERENCES pedido_dados_gerais(numeropedido) on update cascade on delete cascade;


# INSERINDO USUARIO PADRÃO  ADMIN  SENHA ADMIN
insert into funcionarios(login, senha) values('ADMIN', 'ADMIN');

# INSERINDO CLIENTES PARA TESTE
insert into clientes(nome, cidade, uf) values('João', 'Fortaleza', 'CE');
insert into clientes(nome, cidade, uf) values('Jose', 'Fortaleza', 'CE');
insert into clientes(nome, cidade, uf) values('Fernando de Oliveira', 'Fortaleza', 'CE');
insert into clientes(nome, cidade, uf) values('Maria das Graças', 'Fortaleza', 'CE');
insert into clientes(nome, cidade, uf) values('Maria das Dores', 'Euzébio', 'CE');
insert into clientes(nome, cidade, uf) values('Felipe', 'Fortaleza', 'CE');
insert into clientes(nome, cidade, uf) values('Fernando de Castro', 'Maracanau', 'CE');
insert into clientes(nome, cidade, uf) values('Jose de Arimatéia', 'Fortaleza', 'CE');
insert into clientes(nome, cidade, uf) values('Tiago', 'Maracanaú', 'CE');
insert into clientes(nome, cidade, uf) values('Cesar', 'Caucaia', 'CE');
insert into clientes(nome, cidade, uf) values('Edilberto', 'Fortaleza', 'CE');
insert into clientes(nome, cidade, uf) values('Joabe', 'Fortaleza', 'CE');
insert into clientes(nome, cidade, uf) values('Alvaro de Oliveira', 'Fortaleza', 'CE');
insert into clientes(nome, cidade, uf) values('Maria Conceição', 'Fortaleza', 'CE');
insert into clientes(nome, cidade, uf) values('Maria de Fátima', 'Euzébio', 'CE');
insert into clientes(nome, cidade, uf) values('Josefa', 'Fortaleza', 'CE');
insert into clientes(nome, cidade, uf) values('Lourdes', 'Maracanau', 'CE');
insert into clientes(nome, cidade, uf) values('Antonieta', 'Fortaleza', 'CE');
insert into clientes(nome, cidade, uf) values('Alessandra', 'Maracanaú', 'CE');
insert into clientes(nome, cidade, uf) values('Eduardo', 'Caucaia', 'CE');


# INSERINDO PRODUTOS PARA TESTE
insert into produtos(descricao, precoVenda) values('Mouse',  21.50);
insert into produtos(descricao, precoVenda) values('Teclado',  35.00);
insert into produtos(descricao, precoVenda) values('Caixa de Som',  45.50);
insert into produtos(descricao, precoVenda) values('Fone de Ouvido',  27.90);
insert into produtos(descricao, precoVenda) values('Oculos Anti-reflexo',  60.00);
insert into produtos(descricao, precoVenda) values('Monitor', 451.50);
insert into produtos(descricao, precoVenda) values('Mouse sem fio', 35.20);
insert into produtos(descricao, precoVenda) values('Carregador Universal', 150.00);
insert into produtos(descricao, precoVenda) values('Pen drive 8GB', 25.00);
insert into produtos(descricao, precoVenda) values('HD Externo', 250.00);
insert into produtos(descricao, precoVenda) values('SSD 256MB', 520.00);
insert into produtos(descricao, precoVenda) values('SSD 500MB', 750.00);
insert into produtos(descricao, precoVenda) values('Mouse Pad', 11.50);
insert into produtos(descricao, precoVenda) values('Lupa de Aumento', 71.50);
insert into produtos(descricao, precoVenda) values('Mochila para Notebook', 151.50);
insert into produtos(descricao, precoVenda) values('Notebook Dell', 2750.00);
insert into produtos(descricao, precoVenda) values('Notebook Samsung', 2550.00);
insert into produtos(descricao, precoVenda) values('Notebook Positivo', 2100.00);
insert into produtos(descricao, precoVenda) values('Modem Wireless', 160.00);
insert into produtos(descricao, precoVenda) values('Adaptador Bluethoth USB', 59.90);

