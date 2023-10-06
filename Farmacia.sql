-- CREATE DATABASE Venda_modelo01;
-- select * from Cliente, Cliente_Endereco, Cliente_Tel, Fabricante, Medicamento, Venda;

-- USE Venda_modelo01;

SELECT nome_cliente
FROM Cliente
WHERE YEAR(data_de_nascimento) > 1990;

-- Selecione os nomes de medicamentos da tabela medicamento com data de validade em 2024.


SELECT Nome
FROM Medicamento
WHERE YEAR(data_validade) = 2024;

-- Selecione todos os clientes da tabela cliente que possuem "Pessoa" em seus nomes.

SELECT *
FROM Cliente
WHERE nome_cliente LIKE '%Pessoa%';

-- Conte quantos medicamentos cada fabricante produz (identifique o fabricante pelo código).

SELECT F.Codigo, F.nome_fantasia, COUNT(M.Codigo) AS Quantidade_Medicamentos
FROM Fabricante F
LEFT JOIN Medicamento M ON F.Codigo = M.codigo_fabricante
GROUP BY F.Codigo, F.nome_fantasia;

-- Selecione o nome e o e-mail dos clientes que nasceram após 2000, ordene-os por nome em ordem decrescente e limite o resultado a 5 registros.

SELECT nome_cliente, Email
FROM Cliente
WHERE YEAR(data_de_nascimento) > 2000
ORDER BY nome_cliente DESC
LIMIT 5;
-- SUBCONSULTAS:

-- Selecione o(s) nome(s) e o(s) CPF(s) do(s) cliente(s) que têm São Paulo como cidade em seu endereço.

SELECT nome_cliente, cpf_cliente
FROM Cliente
WHERE cpf_cliente IN (
    SELECT cpf_cliente
    FROM Cliente_Endereco
    WHERE cidade = 'São Paulo'
);

-- Liste o nome de todos os clientes que compraram o medicamento 'Paracetamol'.

SELECT C.nome_cliente
FROM Cliente C
INNER JOIN Venda V ON C.cpf_cliente = V.cpf_cliente
INNER JOIN Medicamento M ON V.codigo_medicamento = M.Codigo
WHERE M.Nome = 'Paracetamol';

-- Encontre o nome do medicamento com a data de validade mais antiga registrada no sistema.

SELECT Nome
FROM Medicamento
ORDER BY data_validade
LIMIT 1;

-- Liste a quantidade de medicamentos diferentes registrados no sistema.

SELECT COUNT(DISTINCT Codigo) AS Quantidade_Medicamentos
FROM Medicamento;


-- Liste as datas das vendas e os nomes dos clientes.

SELECT V.data_venda, C.nome_cliente
FROM Venda V
INNER JOIN Cliente C ON V.cpf_cliente = C.cpf_cliente;

SELECT C.nome_cliente, CE.estado, CE.cidade, CE.bairro, CE.rua, CE.numero, CE.cep,
       CT.telefone_celular, CT.telefone_residencial, CT.telefone_comercial
FROM Cliente C
LEFT JOIN Cliente_Endereco CE ON C.cpf_cliente = CE.cpf_cliente
LEFT JOIN Cliente_Tel CT ON C.cpf_cliente = CT.cpf_cliente;


-- Liste o código, o nome fantasia e o e-mail de todos os fabricantes, inclusive os que não estão associados a nenhum medicamento. Ordene por código.

SELECT F.Codigo, F.nome_fantasia, F.Email
FROM Fabricante F
LEFT JOIN Medicamento M ON F.Codigo = M.codigo_fabricante
GROUP BY F.Codigo, F.nome_fantasia, F.Email;

-- Liste o nome e o CPF de todos os clientes, inclusive os que não estão associados à tabela cliente_telefone e cliente_endereco. Ordene por CPF.

SELECT C.nome_cliente, C.cpf_cliente, CT.telefone_celular, CE.estado, CE.cidade
FROM Cliente C
LEFT JOIN Cliente_Tel CT ON C.cpf_cliente = CT.cpf_cliente
LEFT JOIN Cliente_Endereco CE ON C.cpf_cliente = CE.cpf_cliente
ORDER BY C.cpf_cliente;


-- Liste todos os medicamentos com seus nomes e os nomes de seus fabricantes. Inclua fabricantes sem medicamentos.
SELECT M.Nome AS Nome_Medicamento, F.nome_fantasia AS Fabricante
FROM Medicamento M
RIGHT JOIN Fabricante F ON M.codigo_fabricante = F.Codigo;


-- Liste os códigos das vendas e os clientes que as fizeram, juntamente com os nomes dos clientes.

SELECT V.codigo, C.nome_cliente
FROM Venda V
INNER JOIN Cliente C ON V.cpf_cliente = C.cpf_cliente;

-- Liste todos os CPFs dos clientes que residem na mesma cidade (para validar a saída, também adicione a coluna da cidade).

SELECT C1.cpf_cliente, CE1.cidade AS Cidade_Cliente1, C2.cpf_cliente, CE2.cidade AS Cidade_Cliente2
FROM Cliente C1
INNER JOIN Cliente C2 ON C1.cpf_cliente <> C2.cpf_cliente
INNER JOIN Cliente_Endereco CE1 ON C1.cpf_cliente = CE1.cpf_cliente
INNER JOIN Cliente_Endereco CE2 ON C2.cpf_cliente = CE2.cpf_cliente
WHERE CE1.cidade = CE2.cidade;



CREATE TABLE Cliente (
   cpf_cliente VARCHAR(15) NOT NULL PRIMARY KEY,
   nome_cliente VARCHAR(50) NOT NULL,
   Email VARCHAR(100),
   data_de_nascimento DATE
);

CREATE TABLE Cliente_Endereco (
   cpf_cliente VARCHAR(15) NOT NULL,
   estado VARCHAR(50),
   cidade VARCHAR(50),
   bairro VARCHAR(50),
   rua VARCHAR(100),
   numero INT,
   cep VARCHAR(10),
   FOREIGN KEY (cpf_cliente) REFERENCES Cliente(cpf_cliente)
);


CREATE TABLE Cliente_Tel (
   cpf_cliente VARCHAR(15) NOT NULL,
   telefone_celular VARCHAR(15),
   telefone_residencial VARCHAR(15),
   telefone_comercial VARCHAR(15),
   FOREIGN KEY (cpf_cliente) REFERENCES Cliente(cpf_cliente)
);


CREATE TABLE Fabricante (
   Codigo VARCHAR(15) PRIMARY KEY,
   nome_fantasia VARCHAR(50) NOT NULL,
   razao_social VARCHAR(100),
   Email VARCHAR(100)
);

CREATE TABLE Medicamento (
    Codigo VARCHAR(15) PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    codigo_fabricante VARCHAR(15),
    data_validade DATE NOT NULL,
    FOREIGN KEY (codigo_fabricante) REFERENCES Fabricante(Codigo) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Venda (
    codigo VARCHAR(15) PRIMARY KEY,
    quantidade INT,
    data_venda DATE NOT NULL,
    cpf_cliente VARCHAR(15),
    codigo_medicamento VARCHAR(15) NOT NULL,  -- Alteração do tipo de dados para VARCHAR
    FOREIGN KEY (codigo_medicamento) REFERENCES Medicamento(Codigo) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (cpf_cliente) REFERENCES Cliente(cpf_cliente) ON DELETE CASCADE ON UPDATE CASCADE
);




-- Inserts para Clientes
INSERT INTO cliente (cpf_cliente, nome_cliente, email, data_de_nascimento)
VALUES
    ('12345678901', 'Euclidis da Cunha', 'euclidis@email.com', '1980-05-15'),
    ('23456789012', 'Fernando Pessoa', 'fernando@email.com', '1982-02-28'),
    ('34567890123', 'Joana de Almeida', 'joana@email.com', '1985-09-10'),
    ('45678901234', 'Carlos da Silva', 'carlos@email.com', '2008-12-20'),
    ('56789012345', 'Bianca Nunes', 'bianca@email.com', '1995-04-05'),
    ('67890123456', 'Gilberto Pessoa', 'gilberto@email.com', '2000-07-12'),
    ('78901234567', 'Fabiana de Almeida', 'fabiana@email.com', '1999-11-30'),
    ('89012345678', 'Ana Pessoa', 'ana@email.com', '2007-03-25'),
	('11890023414', 'Daniel Abrantes', 'daniel@email.com', '1991-04-11'),
    ('33301034101', 'Fabio Cortes', 'fabio@email.com', '1989-01-30'),
    ('29022345222', 'Cleber Amaral', 'camaral@email.com', '1998-09-23');

-- Inserts para Fabricantes
INSERT INTO fabricante (codigo, nome_fantasia, razao_social, email)
VALUES
     ('F001', 'Nossa Farma Farmacêutica', 'FarmA', 'nossafarma@farma.com'),
     ('F002', 'Saúde Farmacêutica', 'FarmB', 'contatosaude@farma.com'),
     ('F003', 'Quimica Boa Farmacêutica', 'FarmC', 'quimicaboa@farma.com'),
     ('F004', 'Melhora Farmacêutica', 'FarmD', 'melhora@farma.com'),
     ('F005', 'CEMAC Farmacêutica', 'FarmE', 'cemac@farma.com'),
     ('F006', 'Quimio Farmacêutica', 'FarmF', 'quimeiofarma@farma.com'),
     ('F007', 'Quimera Farmacêutica', 'FarmG', 'quimerafarma@farma.com'),
     ('F008', 'Cooperativa Farmacêutica', 'FarmH', 'coopfarma@farma.com'),
     ('F009', 'Vitta Farmacêutica', 'FarmI', 'vittafarma@farma.com'),
     ('F010', 'Vital Medical Farmacêutica', 'FarmJ', 'vmedical@farma.com'),
     ('F011', 'SANS Farmacêutica', 'FarmL', 'sansfarma@farma.com');


-- Inserts para Medicamentos
INSERT INTO medicamento (codigo, nome, codigo_fabricante, data_validade)
VALUES
    ('M001', 'Paracetamol', 'F001', '2025-12-31'),
    ('M002', 'Ibuprofeno', 'F002', '2024-06-30'),
    ('M003', 'Amoxicilina', 'F003', '2026-09-15'),
    ('M004', 'Dipirona', 'F004', '2023-12-20'),
    ('M005', 'Omeprazol', 'F005', '2024-11-30'),
    ('M006', 'Ranitidina', 'F006', '2026-08-25'),
    ('M007', 'Losartana', 'F001', '2024-07-10'),
    ('M008', 'Metformina', 'F001', '2025-11-05');


-- Inserts para Endereços (cliente_endereco)
INSERT INTO cliente_endereco (cpf_cliente, estado, cidade, bairro, rua, numero, cep)
VALUES
    ('12345678901', 'SP', 'São Paulo', 'Centro', 'Rua XV de Novembro', 123, '01234-567'),
    ('23456789012', 'RJ', 'Rio de Janeiro', 'Copacabana', 'Avenida Beira Rio', 456, '04567-890'),
    ('34567890123', 'MG', 'Belo Horizonte', 'Savassi', 'Avenida Tiradentes', 789, '05678-901'),
    ('45678901234', 'RS', 'Porto Alegre', 'Moinhos de Vento', 'Avenida Dom Pedro', 801, '06789-012'),
    ('56789012345', 'PR', 'Curitiba', 'Batel', 'Rua Emiliano Costa', 202, '07890-123'),
	('67890123456', 'SP', 'São Paulo', 'Vila Madalena', 'Rua Das Alamedas', 303, '08901-234'),
    ('78901234567', 'SP', 'São Paulo', 'Ipiranga', 'Avenida Getulio Vargas', 585, '09012-345'),
    ('89012345678', 'SP', 'São Paulo', 'Liberdade', 'Rua Coronel Leonidas', 757, '09123-456');

-- Inserts para Números de Telefone (cliente_telefone)
INSERT INTO Cliente_Tel (cpf_cliente, telefone_celular, telefone_residencial, telefone_comercial)
VALUES
    ('12345678901', '1198765421', '1123456789', '1133334411'),
    ('23456789012', '2199998881', '2145678901', '2112345678'),
    ('34567890123', '3198800771', '3123456789', '3155556600'),
    ('45678901234', '5199996662', '5123456789', '5133334488'),
    ('56789012345', '4199811771', '4123456789', '4144499556'),
    ('67890123456', '1199777662', '7123456789', '1133399441'),
    ('78901234567', '1199622555', '8123456789', '1133300442'),
    ('89012345678', '1199711440', '6123456789', '1133322443');


-- Inserts para Vendas
INSERT INTO venda (codigo, quantidade, data_venda, cpf_cliente, codigo_medicamento)
VALUES
    ('V001', 2, '2023-01-15', '12345678901', 'M001'),
    ('V002', 3, '2023-02-20', '23456789012', 'M002'),
    ('V003', 3, '2023-02-25', '34567890123', 'M003'),
    ('V004', 3, '2023-04-30', '45678901234', 'M004'),
    ('V005', 4, '2023-02-10', '56789012345', 'M005');

