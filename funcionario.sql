CREATE TABLE Departamento (
  SiglaDepto VARCHAR(15),
  NomeDepto VARCHAR(50), 
  QtdFunc INT NOT NULL,
   PRIMARY KEY (SiglaDepto, NomeDepto)
  
 );
 CREATE TABLE Funcionario (
   CodigoFunc INT,
   NomeFunc VARCHAR(50) NOT NULL,
   idCargo INT NOT NULL,
   SiglaDepto VARCHAR(15) NOT NULL,
   PRIMARY KEY (CodigoFunc, NomeFunc),
 FOREIGN KEY (SiglaDepto) REFERENCES Departamento(SiglaDepto)
 );
 CREATE TABLE FuncionarioCargo (
    idCargo INT,
    CodigoFunc INT,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(100),
    PRIMARY KEY (idCargo , CodigoFunc),
    FOREIGN KEY (CodigoFunc)
        REFERENCES Funcionario (CodigoFunc)
);
 CREATE TABLE projeto (
  SiglaProj VARCHAR(15),
  NomeProj VARCHAR(50),
  CodigoFunc INT NOT NULL,
  SiglaDepto VARCHAR(15),
   PRIMARY KEY (SiglaProj, NomeProj),
    FOREIGN KEY (SiglaDepto) REFERENCES Departamento(SiglaDepto),
    FOREIGN KEY (CodigoFunc) REFERENCES Funcionario(CodigoFunc)
 );