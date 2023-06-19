Create DataBase cm1
Go
Use cm1
Go

CREATE TABLE usuario(
email	VARCHAR(100) NOT NULL,
senha	VARBINARY(64) NOT NULL, 
tipo	CHAR(1)
PRIMARY KEY (email)
)
Create Table Cargo (
codigo		INT				NOT NULL,
nome		VARCHAR(50)		NOT NULL
Primary Key (codigo)
)
GO
Create TABLE Especialidade (
codigo		INT	 IDENTITY(01,1)	NOT NULL,
nome		VARCHAR(50)		NOT NULL
PRIMARY KEY(codigo)
)
Go
Create Table Gestor (
cpf			CHAR(11) CHECK(LEN (cpf)= 11) NOT NULL,
nome		VARCHAR(100)				  NOT NULL,
email		VARCHAR(100)				  NOT NULL,
telefone	CHAR(11)					  NOT NULL,
cargo		INT							NOT NULL,
senha		VARCHAR(50)                 NOT NULL
PRIMARY KEY(cpf)
FOREIGN KEY(cargo)
references Cargo (codigo)
)
Go
Create Table Medico (
cpf 			CHAR(11) CHECK(LEN (cpf)= 11) NOT NULL,
nome			VARCHAR(100)				  NOT NULL,
crm				CHAR(6)						  NOT NULL,
cargo			INT							  NOT NULL,
especialidade	INT     					  NOT NULL,
email			VARCHAR(100)				  NOT NULL,
telefone		CHAR(11)					  NOT NULL,
senha			VARCHAR(64)					  NOT NULL
PRIMARY KEY(crm)
FOREIGN KEY (especialidade) references Especialidade (codigo),
FOREIGN KEY (cargo) references Cargo(codigo)
)
GO
Create Table Atendente (
cpf			CHAR(11) CHECK(LEN (cpf)= 11) NOT NULL,
nome		VARCHAR(100)				  NOT NULL,
cargo		INT							  NOT NULL,
email		VARCHAR(100)				  NOT NULL,
telefone	CHAR(11)					  NOT NULL,
senha		VARCHAR(64)                 NOT NULL
Primary Key (cpf)
FOREIGN KEY(cargo)
references Cargo (codigo)
)
GO
Create Table Paciente (
cpf				CHAR(11) CHECK(LEN (cpf)= 11) NOT NULL,
nome			VARCHAR(100)				  NOT NULL,
cartao_sus	    CHAR(15)					  NOT NULL,
dataNasc		DATE						  NOT NULL,
email			VARCHAR(100)				  NOT NULL,
telefone		CHAR(11)					  NOT NULL,
genero			VARCHAR(10)					  NOT NULL,
tipoSangue		VARCHAR(3)					  NOT NULL,
peso			DECIMAL(4,1)				  NOT NULL,
altura			INT         				  NOT NULL,
senha_hash      VARBINARY(64)                 NOT NULL
PRIMARY KEY(cartao_sus)
)
GO
Create Table Prontuario (
codigo			INT				NOT NULL,
cartao_sus		CHAR(15)		NOT NULL,
crm				CHAR(6)			NOT NULL,
diagnostico		VARCHAR(255)	NOT NULL
PRIMARY KEY(codigo),
FOREIGN KEY (crm)	 references Medico(crm),
FOREIGN KEY (cartao_sus)  references Paciente(cartao_sus)
)
 GO
Create Table Consulta (
codigo			INT	 IDENTITY(1000,1)			 NOT NULL,
especialidade	INT			 NOT NULL,
crm				CHAR(6)		 NOT NULL,
cpf				CHAR(11)	 NOT NULL,
data     		DATE       	 NOT NULL,
hora			TIME		 NOT NULL
PRIMARY KEY(codigo),
FOREIGN KEY (crm)	 references Medico(crm),
FOREIGN KEY (cpf)  references Paciente(cpf),
FOREIGN KEY (especialidade)	 references Especialidade(codigo),
)
--CARGOS
GO
Insert Into Cargo Values 
(1, 'Gestor'),
(2, 'Médico'),
(3, 'Atendente')

--ESPECIALIDADES
GO
Insert Into Especialidade Values ('Quiropraxia')
select * from Especialidade
UPDATE Especialidade SET nome = 'Psicologia' WHERE codigo = 2

-- DECLARANDO SENHA E INSERINDO GESTOR
GO
DECLARE @senha VARCHAR(50) = '123456'
DECLARE @senha_hash VARBINARY(64) = HASHBYTES('SHA2_256', @senha)
GO
INSERT INTO Gestor (cpf, nome, email, telefone, cargo, senha)
VALUES ('12345678998', 'Gestor', 'gestor@hw.com', '11987361671', 1,'123456')

SELECT * FROM GESTOR

select * from usuario
select * from Atendente
select * from Medico
select * from Especialidade
select * from Paciente
select * from Consulta
SELECT data, hora, cpf, crm, especialidade FROM Consulta WHERE codigo = 1004

SELECT m.crm as crm, m.nome as nome, m.email as email, m.telefone as telefone, e.nome as especialidade
FROM Medico m, Especialidade e
WHERE m.nome LIKE 'Ana%'
AND m.especialidade = e.codigo



--------------------------------------------------- INÍCIO PROCEDURES E FUNÇÕES (LOGIN) ---------------------------------------------
--procedure que cria os usuarios do sistema
CREATE PROCEDURE sp_criptografaSenha(@email VARCHAR(50), @senha VARCHAR(50), @tipo CHAR(1))
AS
	DECLARE @senha_hash VARBINARY(64) = HASHBYTES('SHA2_256', @senha)
BEGIN
	INSERT INTO usuario VALUES(@email, @senha_hash, @tipo)
END

--function que valida o login
CREATE FUNCTION fn_validaLogin(@email VARCHAR(100), @senha VARCHAR(50))
RETURNS @login TABLE  (
tipo char(1)
)
AS
BEGIN
	DECLARE @senha_hash VARBINARY(64) = HASHBYTES('SHA2_256', @senha),
			@tipo CHAR(1)
	
	SET @tipo = (SELECT tipo FROM usuario WHERE email = @email AND senha = @senha_hash)

	INSERT INTO @login VALUES (@tipo)
RETURN
END

SELECT * FROM fn_validaLogin('gestor@hw.com', '123456')

--------------------------------------------------- PROCEDURES E FUNÇÕES (GESTOR) ---------------------------------------------
--procedure gestor mantendo funcionarios (Atendente) (CREATE, UPDATE, DELETE)
GO
CREATE PROCEDURE sp_manter_atendente (@opcao CHAR(1), @cpf CHAR(11), @nome VARCHAR(100), @cargo INT, @email VARCHAR(100), @telefone CHAR(11), @senha VARCHAR(50), @saida VARCHAR(250) OUTPUT
)
AS
BEGIN
  IF (UPPER(@opcao) = 'D' AND @cpf IS NOT NULL AND @email IS NOT NULL)
  BEGIN
	DELETE FROM usuario WHERE email = @email
    DELETE FROM Atendente WHERE cpf = @cpf;
    SET @saida = 'Atendente com o cpf: ' + CAST(@cpf AS VARCHAR(15)) + ' excluído'
  END
  ELSE
  BEGIN
    IF (UPPER(@opcao) = 'D' AND @cpf IS NULL)
    BEGIN
      RAISERROR('Atendente não encontrado', 16, 1)
    END
    ELSE
    BEGIN
      IF (UPPER(@opcao) = 'I')
      BEGIN
        
        INSERT INTO Atendente (cpf, nome, cargo, email, telefone, senha)
        VALUES (@cpf, @nome, @cargo, @email, @telefone, @senha)

		EXEC sp_criptografaSenha @email, @senha, 'A'
        
        SET @saida = 'Atendente cadastrado'
      END
      ELSE
      BEGIN
        IF (UPPER(@opcao) = 'U')
        BEGIN
          UPDATE Atendente
          SET cpf = @cpf, nome = @nome, cargo = @cargo, email = @email, telefone = @telefone, senha = @senha
          WHERE cpf = @cpf;

		  DELETE FROM usuario WHERE email = @email

		  EXEC sp_criptografaSenha @email, @senha, 'A'
          
          SET @saida = 'Atendente com o cpf: ' + CAST(@cpf AS VARCHAR(15)) + ' atualizado'
        END
        ELSE
        BEGIN
          RAISERROR('Operação Inválida', 16, 1)
        END
      END
    END
  END
END

-- TESTANDO A PROCEDURE ACIMA
GO
DECLARE @saida1 VARCHAR(MAX)
DECLARE @senha VARCHAR(50) = '123456'
EXEC sp_manter_atendente 'I', '62251856820', 'Tereza Alves', 3, 'tereza@gmail.com', '11985266471', @senha, @saida1 OUTPUT
PRINT @saida1
GO
DECLARE @saida2 VARCHAR(MAX)
EXEC sp_manter_espec 'I', ,'Louco', @saida2 OUTPUT
PRINT @saida2

SELECT * FROM Especialidade

--function GESTOR LISTANDO ATENDENTE (não está listando em ordem alfabética)
GO
Create function fn_listaratendente()
Returns @table Table (
cpf char(11),
nome varchar(100),
cargo varchar(20),
email varchar(100),
telefone char(11)
)
AS
Begin 
	Insert Into @table(cpf, nome, cargo, email, telefone)
	Select a.cpf, a.nome, c.nome, a.email, a.telefone From Atendente a, Cargo c
	Where a.cargo = c.codigo
	Order By a.nome Asc
Return
End

Select * From fn_listaratendente()

--function GESTOR PESQUISANDO ATENDENTE POR CPF
GO
CREATE FUNCTION fn_pesquisaratendente(@cpf CHAR(11))
RETURNS @table TABLE (
    cpf CHAR(11),
    nome VARCHAR(100),
    cargo VARCHAR(20),
    email VARCHAR(100),
    telefone CHAR(11)
)
AS
BEGIN
    INSERT INTO @table (cpf, nome, cargo, email, telefone)
    SELECT a.cpf, a.nome, c.nome, a.email, a.telefone
    FROM Atendente a
    JOIN Cargo c ON a.cargo = c.codigo
    WHERE a.cpf = @cpf
    ORDER BY a.nome ASC

    RETURN
END

SELECT * FROM fn_pesquisaratendente('62251856820')

-- PROCEDURE DO GESTOR MANTENDO ESPECIALIDADE 
CREATE PROCEDURE sp_manter_espec(@op CHAR(1), @codigo INT, @nome VARCHAR(50), @saida VARCHAR(250) OUTPUT)
AS
BEGIN
  IF (UPPER(@op) = 'D' AND @codigo IS NOT NULL)
  BEGIN
    DELETE FROM Especialidade WHERE codigo = @codigo;
    SET @saida = 'Especialidade: ' + @nome + ' excluída'
  END
  ELSE
  BEGIN
    IF (UPPER(@op) = 'D' AND @codigo IS NULL)
    BEGIN
      RAISERROR('Especialidade não encontrada', 16, 1)
    END
    ELSE
    BEGIN
        IF (UPPER(@op) = 'U')
        BEGIN
          UPDATE Especialidade
          SET nome = @nome
          WHERE codigo = @codigo;
          
          SET @saida = 'Especialidade: ' + @nome + ' atualizado'
        END
        ELSE
        BEGIN
          RAISERROR('Operação Inválida', 16, 1)
        END
      END
    END
END
-- PROCEDURE DO GESTOR MANTENDO MÉDICO (CREATE, UPDATE, DELETE)
GO
CREATE PROCEDURE sp_manter_medico (@opcao CHAR(1), @cpf CHAR(11), @nome VARCHAR(100), @crm CHAR(6), @cargo INT, @especialidade INT, @email VARCHAR(100), @telefone CHAR(11), @senha VARCHAR(50), @saida VARCHAR(250) OUTPUT)
AS
BEGIN
  IF (UPPER(@opcao) = 'D' AND @crm IS NOT NULL AND @email IS NOT NULL)
  BEGIN
	DELETE FROM usuario WHERE email = @email
    DELETE FROM Medico WHERE crm = @crm;
    SET @saida = 'Médico com o CRM: ' + CAST(@crm AS VARCHAR(15)) + ' excluído'
  END
  ELSE
  BEGIN
    IF (UPPER(@opcao) = 'D' AND @crm IS NULL)
    BEGIN
      RAISERROR('Médico não encontrado', 16, 1)
    END
    ELSE
    BEGIN
      IF (UPPER(@opcao) = 'I')
      BEGIN
        
        INSERT INTO Medico (cpf, nome, crm, cargo, especialidade, email, telefone, senha)
        VALUES (@cpf, @nome, @crm, @cargo, @especialidade, @email, @telefone, @senha)

		EXEC sp_criptografaSenha @email, @senha, 'M'

        
        SET @saida = 'Médico cadastrado'
      END
      ELSE
      BEGIN
        IF (UPPER(@opcao) = 'U')
        BEGIN
          UPDATE Medico
          SET cpf = @cpf, nome = @nome, crm = @crm, cargo = @cargo, especialidade = @especialidade, email = @email, telefone = @telefone
          WHERE crm = @crm;

		  DELETE FROM usuario WHERE email = @email

		  EXEC sp_criptografaSenha @email, @senha, 'M'
          
          SET @saida = 'Médico com o CRM: ' + CAST(@crm AS VARCHAR(15)) + ' atualizado'
        END
        ELSE
        BEGIN
          RAISERROR('Operação Inválida', 16, 1)
        END
      END
    END
  END
END
--TESTANDO A PROCEDURE ACIMA
GO
DECLARE @saida1 VARCHAR(MAX)
DECLARE @senha VARCHAR(50) = '123456'
EXEC sp_manter_medico 'I', '10502942894', 'Dr. Hans Chucrute', '987654', '2', '4', 'drhc@gmail.com', '11970707070', @senha, @saida1 OUTPUT
PRINT @saida1
GO
DECLARE @saida2 VARCHAR(MAX)
DECLARE @senha VARCHAR(50) = '123456'
EXEC sp_manter_medico 'I', '83572980879', 'Dr. Fernanda Caldeira', '456789', '2', '1', 'drfc@gmail.com', '11911223344', @senha, @saida2 OUTPUT
PRINT @saida2

SELECT * FROM MEDICO

--function GESTOR LISTANDO MÉDICO
Go
Create function fn_listarmedico()
Returns @table Table (
cpf char(11),
nome varchar(100),
crm char(6),
cargo varchar(20),
especialidade varchar(20),
email varchar(100),
telefone char(11)
)
AS
Begin 
	Insert Into @table(cpf, nome, crm, cargo, especialidade, email, telefone)
	Select m.cpf, m.nome, m.crm, c.nome, e.nome, m.email, m.telefone From Medico m, Cargo c, Especialidade e
	Where m.cargo = c.codigo
	And m.especialidade = e.codigo
	Order By m.nome Asc
Return
End

SELECT * FROM fn_listarmedico()


--function GESTOR PESQUISANDO MÉDICO POR CRM
GO
CREATE FUNCTION fn_pesquisarmedico(@crm CHAR(6))
RETURNS @table TABLE (
    crm CHAR(6),
    nome VARCHAR(100),
	cpf CHAR(11),
    cargo VARCHAR(20),
    especialidade VARCHAR(20),
    email VARCHAR(100),
    telefone CHAR(11)
)
AS
BEGIN
    INSERT INTO @table (cpf, nome, crm, cargo, especialidade, email, telefone)
    SELECT m.cpf, m.nome, m.crm, c.nome, e.nome, m.email, m.telefone
    FROM Medico m
    JOIN Cargo c ON m.cargo = c.codigo
    JOIN Especialidade e ON m.especialidade = e.codigo
    WHERE m.crm = @crm
    ORDER BY m.nome ASC

    RETURN
END

SELECT * FROM fn_pesquisarmedico('987654')

--------------------------------------------------- FIM PROCEDURES E FUNÇÕES (GESTOR) ---------------------------------------------------

--------------------------------------------------- INÍCIO PROCEDURES E FUNÇÕES (ATENDENTE) ---------------------------------------------
-- procedure ATENDENTE MANTENDO PACIENTE (CREATE, UPDATE, DELETE)
GO
CREATE PROCEDURE sp_manter_paciente (@opcao CHAR(1), @cpf CHAR(11), @nome VARCHAR(100), @cartao_sus CHAR(15), @data DATE, @email VARCHAR(100), @telefone CHAR(11), @genero VARCHAR(10), @tipoSangue VARCHAR(3), @peso DECIMAL(4,1), @altura INT, @senha VARCHAR(50), @saida VARCHAR(300) OUTPUT)
AS
BEGIN
  IF (UPPER(@opcao) = 'D' AND @cartao_sus IS NOT NULL)
  BEGIN
    DELETE FROM Paciente WHERE cartao_sus = @cartao_sus;
    SET @saida = 'Paciente com o cartão do SUS: ' + CAST(@cartao_sus AS VARCHAR(15)) + ' excluído';
  END
  ELSE
  BEGIN
    IF (UPPER(@opcao) = 'D' AND @cartao_sus IS NULL)
    BEGIN
      RAISERROR('Paciente não encontrado', 16, 1);
    END
    ELSE
    BEGIN
      IF (UPPER(@opcao) = 'I')
      BEGIN
        DECLARE @senha_hash VARBINARY(64) = HASHBYTES('SHA2_256', @senha);
        
        INSERT INTO Paciente (cpf, nome, cartao_sus, dataNasc, email, telefone, genero, tipoSangue, peso, altura, senha_hash)
        VALUES (@cpf, @nome, @cartao_sus, @data, @email, @telefone, @genero, @tipoSangue, @peso, @altura, @senha_hash);
        
        SET @saida = 'Paciente cadastrado';
      END
      ELSE
      BEGIN
        IF (UPPER(@opcao) = 'U')
        BEGIN
          UPDATE Paciente
          SET cpf = @cpf, nome = @nome, dataNasc = @data, email = @email,
              telefone = @telefone, genero = @genero, tipoSangue = @tipoSangue,
              peso = @peso, altura = @altura
          WHERE cartao_sus = @cartao_sus;
          
          SET @saida = 'Paciente com o cartão do SUS: ' + CAST(@cartao_sus AS VARCHAR(15)) + ' atualizado';
        END
        ELSE
        BEGIN
          RAISERROR('Operação Inválida', 16, 1);
        END
      END
    END
  END
END

--TESTANDO A PROCEDURE ACIMA
GO
DECLARE @saida1 VARCHAR(MAX)
DECLARE @senha VARCHAR(50) = '123456'
EXEC sp_manter_paciente 'I', '04488308848', 'Neymar JR.', '122053280290004', '05/02/1992', 'neymar@gmail.com', '11988261960', 'Masculino', 'O+', 68, 175, @senha, @saida1 OUTPUT
PRINT @saida1
GO
DECLARE @saida1 VARCHAR(MAX)
DECLARE @senha VARCHAR(50) = '123456'
EXEC sp_manter_paciente 'I', '39340987896', 'Raquel Araújo', '280631238630001', '27/05/1993', 'raquel@gmail.com', '11982559557', 'Feminino', 'AB-', 59, 165, @senha, @saida1 OUTPUT
PRINT @saida1

SELECT * FROM Paciente

--function	ATENDENTE LISTANDO PACIENTE
GO
CREATE FUNCTION fn_listarpaciente()
RETURNS @table TABLE (
  cpf CHAR(11),
  nome VARCHAR(100),
  cartaoSus VARCHAR(15),
  dataNasc DATE,
  email VARCHAR(50),
  telefone CHAR(11),
  genero VARCHAR(10),
  tipoSangue VARCHAR(3),
  peso DECIMAL(4,1),
  altura INT
)
AS
BEGIN
  INSERT INTO @table (cpf, nome, cartaoSus, dataNasc, email, telefone, genero, tipoSangue, peso, altura)
  SELECT cpf, UPPER(nome) AS nome, cartao_sus, CONVERT(VARCHAR(10), dataNasc, 103) AS data , email, telefone, UPPER(genero), tipoSangue, peso, altura
  FROM Paciente
  ORDER BY nome ASC
  RETURN
END

SELECT * FROM fn_listarpaciente()

--function ATENDENTE PESQUISANDO PACIENTE POR CARTÃO DO SUS
CREATE FUNCTION fn_pesquisarpaciente(@cartaoSus CHAR(15))
RETURNS @table TABLE (
  cpf CHAR(11),
  nome VARCHAR(100),
  cartaoSus VARCHAR(15),
  dataNasc DATE,
  email VARCHAR(50),
  telefone CHAR(11),
  genero VARCHAR(10),
  tipoSangue VARCHAR(3),
  peso DECIMAL(4,1),
  altura INT
)
AS
BEGIN
  INSERT INTO @table (cpf, nome, cartaoSus, dataNasc, email, telefone, genero, tipoSangue, peso, altura)
  SELECT cpf, UPPER(nome) AS nome, cartao_sus, dataNasc, email, telefone, UPPER(genero), tipoSangue, peso, altura
  FROM Paciente
  WHERE cartao_sus = @cartaoSus
  ORDER BY nome ASC
  RETURN
END

SELECT * FROM fn_pesquisarpaciente('122053280290004')



--procedure ATENDENTE MANTENDO CONSULTA (CREATE, UPDATE, DELETE)
GO
CREATE PROCEDURE sp_manter_consulta (@opcao CHAR(1), @codigo INT, @especialidade INT, @crm CHAR(6), @cpf CHAR(11), @data DATE, @hora TIME, @saida VARCHAR(300) OUTPUT
)
AS
BEGIN
  IF (UPPER(@opcao) = 'D' AND @codigo IS NOT NULL)
  BEGIN
    DELETE FROM Consulta WHERE codigo = @codigo;
    SET @saida = 'Consulta com o código: ' + CAST(@codigo AS VARCHAR(15)) + ' excluída';
  END
  ELSE
  BEGIN
    IF (UPPER(@opcao) = 'D' AND @codigo IS NULL)
    BEGIN
      RAISERROR('Consulta não encontrada', 16, 1);
    END
    ELSE
    BEGIN
      IF (UPPER(@opcao) = 'I')
      BEGIN
        INSERT INTO Consulta (especialidade, crm, cpf, data, hora)
        VALUES (@especialidade, @crm, @cpf, @data, @hora);

        SET @saida = 'Consulta cadastrada';
      END
      ELSE
      BEGIN
        IF (UPPER(@opcao) = 'U')
        BEGIN
          UPDATE Consulta
          SET especialidade = @especialidade,
              crm = @crm,
              cpf = @cpf,
              data = CONVERT(DATE, @data, 103),
              hora = CONVERT(TIME, @hora)
          WHERE codigo = @codigo;

          SET @saida = 'Consulta com o código: ' + CAST(@codigo AS VARCHAR(15)) + ' atualizada';
        END
        ELSE
        BEGIN
          RAISERROR('Operação Inválida', 16, 1);
        END
      END
    END
  END
END

-- TESTANDO A PROCEDURE ACIMA
SELECT * FROM Medico
SELECT * FROM Paciente
SELECT * FROM Atendente
SELECT * FROM Especialidade
SELECT * FROM Consulta

GO
DECLARE @saida1 VARCHAR(MAX)
EXEC sp_manter_consulta 'I', NULL, 7, '987654', '55544433322', '2023-07-18', '15:30', @saida1 OUTPUT
PRINT @saida1 
GO
DECLARE @saida2 VARCHAR(MAX)
EXEC sp_manter_consulta 'I', 2, 1, '456789', '280631238630001', '14/06/2023', '15:40', @saida2 OUTPUT
PRINT @saida2

SELECT * FROM Consulta

-- function ATENDENTE LISTANDO CONSULTAS  
GO
CREATE FUNCTION fn_listarconsultas()
RETURNS @table TABLE (
  codigo INT,
  data VARCHAR(10),
  hora VARCHAR(5),
  paciente VARCHAR(100),
  medico VARCHAR(100),
  especialidade VARCHAR(20)
)
AS
BEGIN
  INSERT INTO @table (codigo, data, hora, paciente, medico, especialidade)
  SELECT c.codigo as codigo, CONVERT(VARCHAR(10), c.data, 103) AS data, CONVERT(VARCHAR(5), c.hora, 108) AS hora, UPPER(p.nome) AS paciente, UPPER(m.nome) AS medico, UPPER(e.nome) AS especialidade
  FROM Consulta c
  INNER JOIN Paciente p ON p.cpf = c.cpf
  INNER JOIN Medico m ON m.crm = c.crm
  INNER JOIN Especialidade e ON e.codigo = c.especialidade
  ORDER BY c.data, c.hora ASC
  RETURN
END

SELECT * FROM fn_listarconsultas()

-- FUNCTION DE PESQUISA DE CONSULTAS POR PACIENTE, CRM, OU DATA

CREATE FUNCTION fn_buscaconsultas(@busca VARCHAR(50))
RETURNS @table TABLE (
	codigo int,
	data VARCHAR(10),
	hora VARCHAR(5),
	paciente VARCHAR(100),
	medico VARCHAR(100),
	especialidade VARCHAR(20)
)
AS
BEGIN
	INSERT INTO @table (codigo, data, hora, paciente, medico, especialidade)
	SELECT c.codigo, CONVERT(VARCHAR(10), c.data, 103) AS data, REPLACE(CONVERT(VARCHAR(5), c.hora, 108), ':00', '') AS hora, UPPER(p.nome) AS paciente, UPPER(m.nome) AS medico, UPPER(e.nome) AS especialidade
	FROM Consulta c, Paciente p, Medico m, Especialidade e
	WHERE c.cpf = p.cpf
	AND c.crm = m.crm
	AND c.especialidade = e.codigo
	AND (p.nome LIKE @busca OR m.nome LIKE @busca OR CONVERT(VARCHAR(10), c.data, 103) = @busca)
	RETURN
END

select * from fn_buscaconsultas('Hans')

-- function ATENDENTE PESQUISANDO CONSULTAS POR CARTÃO DO SUS
GO
CREATE FUNCTION fn_pesquisarconsultas(@cartao_sus CHAR(15))
RETURNS @table TABLE (
  data VARCHAR(10),
  hora VARCHAR(5),
  paciente VARCHAR(100),
  medico VARCHAR(100),
  especialidade VARCHAR(20)
)
AS
BEGIN
  INSERT INTO @table (data, hora, paciente, medico, especialidade)
  SELECT CONVERT(VARCHAR(10), c.data, 103) AS data, REPLACE(CONVERT(VARCHAR(5), c.hora, 108), ':00', '') AS hora, UPPER(p.nome) AS paciente, UPPER(m.nome) AS medico, UPPER(e.nome) AS especialidade
  FROM Consulta c
  INNER JOIN Paciente p ON p.cartao_sus = c.cartao_sus
  INNER JOIN Medico m ON m.crm = c.crm
  INNER JOIN Especialidade e ON e.codigo = c.especialidade
  WHERE p.cartao_sus = @cartao_sus
  ORDER BY c.data, c.hora ASC
  RETURN
END

SELECT * FROM fn_pesquisarconsultas('122053280290004')


--procedure ATENDENTE MANTENDO PRONTUARIO (CREATE, UPDATE, DELETE)
GO
CREATE PROCEDURE sp_manter_prontuario (@opcao CHAR(1), @codigo INT, @cartao_sus CHAR(15),  @crm CHAR(6), @diagnostico VARCHAR(255), @saida VARCHAR(300) OUTPUT)
AS
BEGIN
  IF (UPPER(@opcao) = 'D' AND @codigo IS NOT NULL)
  BEGIN
    DELETE FROM Prontuario
    WHERE codigo = @codigo
    SET @saida = 'Prontuário com o código: ' + CAST(@codigo AS VARCHAR(15)) + ' excluído'
  END
  ELSE
  BEGIN
    IF (UPPER(@opcao) = 'D' AND @codigo IS NULL)
    BEGIN
      RAISERROR('Prontuário não encontrado', 16, 1)
    END
    ELSE
    BEGIN
      IF (UPPER(@opcao) = 'I')
      BEGIN
        INSERT INTO Prontuario (codigo, cartao_sus, crm, diagnostico)
        VALUES (@codigo, @cartao_sus, @crm, @diagnostico)
        SET @saida = 'Prontuário cadastrado'
      END
      ELSE
      BEGIN
        IF (UPPER(@opcao) = 'U')
        BEGIN
          UPDATE Prontuario
          SET codigo = @codigo,
              cartao_sus = @cartao_sus,
              crm = @crm,
			  diagnostico = @diagnostico
          WHERE codigo = @codigo
          SET @saida = 'Prontuário com o código: ' + CAST(@codigo AS VARCHAR(15)) + ' atualizado'
        END
        ELSE
        BEGIN
          RAISERROR('Operação Inválida', 16, 1)
        END
      END
    END
  END
END
-- TESTANDO A PROCEDURE ACIMA
GO
DECLARE @saida1 VARCHAR(MAX)
EXEC sp_manter_prontuario 'I', 1, '122053280290004', '987654', 'Torção no pé', @saida1 output
PRINT @saida1
GO
DECLARE @saida2 VARCHAR(MAX)
EXEC sp_manter_prontuario 'I', 2, '280631238630001', '456789', 'Problema no coração', @saida2 output
PRINT @saida2

SELECT * FROM Prontuario

-- function ATENDENTE LISTANDO PRONTUARIO
GO 
CREATE FUNCTION fn_listaprontuario()
RETURNS @table TABLE (
  codigo INT,
  cartao_sus CHAR(15),
  crm CHAR(6),
  diagnostico VARCHAR(255)
)
AS
BEGIN
  INSERT INTO @table (codigo, cartao_sus, crm, diagnostico)
  SELECT pr.codigo, p.cartao_sus, m.crm, pr.diagnostico
  FROM Prontuario pr
  INNER JOIN Paciente p ON p.cartao_sus = pr.cartao_sus
  INNER JOIN Medico m ON m.crm = pr.crm
  RETURN
END

SELECT * FROM fn_listaprontuario()


--function ATENDENTE PESQUISANDO PRONTUÁRIO
CREATE FUNCTION fn_pesquisaprontuario(@cartao_sus CHAR(15))
RETURNS @table TABLE (
  codigo INT,
  cartao_sus CHAR(15),
  crm CHAR(6),
  diagnostico VARCHAR(255)
)
AS
BEGIN
  INSERT INTO @table (codigo, cartao_sus, crm, diagnostico)
  SELECT pr.codigo, p.cartao_sus, m.crm, pr.diagnostico
  FROM Prontuario pr
  INNER JOIN Paciente p ON p.cartao_sus = pr.cartao_sus
  INNER JOIN Medico m ON m.crm = pr.crm
  WHERE p.cartao_sus = @cartao_sus
  RETURN
END

SELECT * FROM fn_pesquisaprontuario('122053280290004')


--------------------------------------------------- FIM PROCEDURES E FUNÇÕES (ATENDENTE) ---------------------------------------------


--------------------------------------------------- INÍCIO PROCEDURES E FUNÇÕES (MÉDICO) ---------------------------------------------
--function MÉDICO LISTANDO CONSULTAS
GO
CREATE FUNCTION fn_listarconsultasmedico(@email VARCHAR(200))
RETURNS @table TABLE (
  cod INT,
  data VARCHAR(10),
  hora VARCHAR(5),
  paciente VARCHAR(100)
)
AS
BEGIN
	DECLARE @crm CHAR(6)

	SET @crm = (SELECT m.crm FROM Medico m, usuario u WHERE m.email = u.email AND u.email = @email)
	
	INSERT INTO @table (cod, data, hora, paciente)
	SELECT c.codigo, CONVERT(VARCHAR(10), c.data, 103) AS data, CONVERT(VARCHAR(5), c.hora, 108) AS hora, p.nome
	FROM Consulta c
	INNER JOIN Paciente p ON p.cpf = c.cpf
	INNER JOIN Medico m ON m.crm = c.crm
	WHERE m.crm = @crm
	ORDER BY c.data, c.hora ASC
	RETURN
END

--function MÉDICO OBTENDO INFORMAÇÕES DO PACIENTE
CREATE FUNCTION fn_info(@consulta int)
RETURNS @table TABLE(
	nome		VARCHAR(MAX),
	dataNasc	DATE,
	genero		VARCHAR(100),
	altura		INT,
	peso		DECIMAL(4,1),
	tipoSangue	VARCHAR(3)
)
AS
BEGIN
	
	INSERT INTO @table (nome, dataNasc, genero, altura, peso, tipoSangue)
	SELECT p.nome, p.dataNasc, p.genero, p.altura, p.peso, p.tipoSangue
	FROM Paciente p, Consulta c
	WHERE p.cpf = c.cpf
	AND c.codigo = @consulta
	
	RETURN
END


SELECT nome, dataNasc, genero, altura, peso, tipoSangue FROM fn_info(1005)
SELECT * FROM Consulta
SELECT * FROM Medico
SELECT * FROM Atendente
SELECT * FROM Paciente

DECLARE @busca VARCHAR(100) = '27/06/2023'
SELECT * FROM fn_listarconsultasmedico('brunodr@hw.com') WHERE paciente LIKE @busca OR data = @busca

--function MÉDICO PESQUISANDO CONSULTAS POR CÓDIGO
GO
CREATE FUNCTION fn_pesquisarconsultasmedico(@email VARCHAR(200))
RETURNS @table TABLE (
  data VARCHAR(10),
  hora VARCHAR(5),
  paciente VARCHAR(100)
)
AS
BEGIN


  INSERT INTO @table (data, hora, paciente)
  SELECT CONVERT(VARCHAR(10), c.data, 103) AS data, CONVERT(VARCHAR(5), c.hora, 108) AS hora, p.nome
  FROM Consulta c
  INNER JOIN Paciente p ON p.cartao_sus = c.cpf
  INNER JOIN Medico m ON m.crm = c.crm
  WHERE p.cartao_sus = 
  ORDER BY c.data, c.hora ASC
  RETURN
END

SELECT * FROM fn_pesquisarconsultasmedico('122053280290004')

-- procedure MÉDICO EDITANDO PRONTUARIO
GO
CREATE PROCEDURE sp_editar_prontuario(@opcao CHAR(1), @codigo INT, @diagnostico VARCHAR(255), @crm CHAR(6), @cartao_sus CHAR(15), @saida VARCHAR(300) OUTPUT)
AS
BEGIN
  IF (UPPER(@opcao) = 'U')
  BEGIN
    DECLARE @medicoExiste BIT

    -- Verificar se o médico com o CRM fornecido existe
    SELECT @medicoExiste = CASE WHEN EXISTS (SELECT 1 FROM Medico WHERE crm = @crm) THEN 1 ELSE 0 END

    IF (@medicoExiste = 1)
    BEGIN
      -- Atualizar o prontuário apenas se o médico existir
      UPDATE Prontuario
      SET diagnostico = @diagnostico
      WHERE codigo = @codigo
        AND crm = @crm

      -- Verificar se a atualização foi bem-sucedida
      IF @@ROWCOUNT > 0
        SET @saida = 'Prontuário com o código: ' + CAST(@codigo AS VARCHAR(15)) + ' atualizado'
      ELSE
        SET @saida = 'Nenhum prontuário encontrado para o código: ' + CAST(@codigo AS VARCHAR(15))
    END
    ELSE
    BEGIN
      SET @saida = 'Médico com CRM ' + @crm + ' não encontrado'
    END
  END
  ELSE
  BEGIN
    RAISERROR('Operação inválida', 16, 1)
  END
END

DECLARE @saida1 VARCHAR(Max)
EXEC sp_editar_prontuario 'U', 1, 'Afastamento', '987654', '122053280290004', @saida1 OUTPUT
PRINT @saida1

SELECT * FROM Prontuario WHERE codigo = 1


--------------------------------------------------- FIM PROCEDURES E FUNÇÕES (MÉDICO) ---------------------------------------------

--------------------------------------------------- INÍCIO PROCEDURES E FUNÇÕES (PACIENTE) ----------------------------------------
--function PACIENTE LISTANDO CONSULTAS
GO 
CREATE FUNCTION fn_pacientelistaconsultas(@email VARCHAR(200))
RETURNS @table TABLE (
  data VARCHAR(10),
  hora VARCHAR(5),
  medico VARCHAR(100),
  especialidade VARCHAR(20)
)
AS
BEGIN
	DECLARE @cpf CHAR(11)
	SET @cpf = (SELECT p.cpf FROM Paciente p, usuario u WHERE p.email = u.email AND u.email = @email)

	INSERT INTO @table (data, hora, medico, especialidade)
	SELECT CONVERT(VARCHAR(10), c.data, 103) AS data, CONVERT(VARCHAR(5), c.hora, 108) AS hora,m.nome, e.nome
	FROM Consulta c
	INNER JOIN Paciente p ON p.cpf = c.cpf
	INNER JOIN Medico m ON m.crm = c.crm
	INNER JOIN Especialidade e ON e.codigo = c.especialidade
	WHERE p.cpf = @cpf
	ORDER BY c.data, c.hora ASC
	RETURN
END

DECLARE @busca VARCHAR(100) = '28/06/2023%'
SELECT * FROM fn_pacientelistaconsultas('ney@gmail.com') WHERE medico LIKE @busca OR data = @busca


SELECT * FROM Paciente
SELECT * FROM fn_listarconsultas()

SELECT p.cpf 
FROM Paciente p, usuario u
WHERE p.email = u.email
AND u.email = 'ney@gmail.com'
--function PACIENTE PESQUISANDO CONSULTAS
GO
CREATE FUNCTION fn_pacientepesquisaconsultas (@cartao_sus CHAR(15))
RETURNS @table TABLE (
  data VARCHAR(10),
  hora VARCHAR(5),
  paciente VARCHAR(100),
  especialidade VARCHAR(20)
)
AS
BEGIN
  INSERT INTO @table (data, hora, paciente, especialidade)
  SELECT CONVERT(VARCHAR(10), c.data, 103) AS data, CONVERT(VARCHAR(5), c.hora, 108) AS hora, p.nome, e.nome
  FROM Consulta c
  INNER JOIN Paciente p ON p.cartao_sus = c.cartao_sus
  INNER JOIN Medico m ON m.crm = c.crm
  INNER JOIN Especialidade e ON e.codigo = c.especialidade
  WHERE p.cartao_sus = @cartao_sus
  ORDER BY c.data, c.hora ASC
  RETURN
END

SELECT * FROM fn_pacientepesquisaconsultas('122053280290004')






