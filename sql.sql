CREATE TABLE departamento (
    sigla_depto VARCHAR(15),
    nome_depto VARCHAR(50),
    qtdfuncionariosdepto INT NOT NULL,
    PRIMARY KEY (sigla_depto, nome_depto)
);
INSERT INTO departamento (sigla_depto, nome_depto, qtd_funcionario)
VALUES ('TI''Tecnologia da Informacao',30);

Alter Table departamento
MODIFY COLUMN sigla_depto VARCHAR(15);

select * from departamento;



CREATE TABLE funcionario (
    codfuncionario INT,
    nome_funcionario VARCHAR(50) NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    sigla_depto VARCHAR(15) UNIQUE NOT NULL,
    PRIMARY KEY (codfuncionario, nome_funcionario),
    FOREIGN KEY (sigla_depto) REFERENCES departamento(sigla_depto)
);
INSERT INTO  funcionario (codfuncionario, nome_funcionario, cargo, sigla_depto)
VALUE ('46','gilson','banqueiro','bnc');

Alter table funcionario
MODIFY COLUMN sigla_depto VARCHAR(50) NOT NULL;

select * from funcionario;



CREATE TABLE projeto (
    sigla_projeto VARCHAR(15),
    nome_projeto VARCHAR(50),
    codfuncionario INT NOT NULL,
    sigla_depto VARCHAR(15) NOT NULL,
    PRIMARY KEY (sigla_projeto, nome_projeto),
    FOREIGN KEY (sigla_depto) REFERENCES departamento(sigla_depto),
    FOREIGN KEY (codfuncionario) REFERENCES funcionario(codfuncionario)
);
INSERT INTO projeto (sigla_projeto, nome_projeto, codfuncionario, sigla_depto)
VALUE ('CMD','indentificação de sintaxe','56','cld');
('JPD','reconfiguração de banco de dados','62','mpf');
('HTML','manutenção do itau personlitte','85','ldd');
('MND','manutenção do nuvem de dados','11','lmc');
('RCC','reconfiguração do cpu central','23','lyx');

alter table projeto
MODIFY COLUMN sigla_depto VARCHAR(15) NOT NULL;

select * from projeto;








