CREATE DATABASE EsquelasDB

DROP DATABASE EsquelasDB

USE EsquelasDB

CREATE TABLE Esquelas_Normalizada(
	id_esquelas int primary key identity(1,1),
	Nro_Esquela text,
	Fecha text,
	Tipo_Falta text,
	Falta_Descripcion text,
	Departamento text,
	Estado text,
	Estado_Descripcion text,
	Valor text,
	Interes text,
	id_falta int, 
	id_departamento int, 
	id_valor int
)

DROP TABLE Esquelas_Normalizada

SELECT * FROM Esquelas_Normalizada 

UPDATE Esquelas_Normalizada SET Valor = '11.43' WHERE cast(Valor as varchar ) = 'CARGADA11.43'

ALTER TABLE Esquelas_Normalizada DROP COLUMN id_falta, id_departamento, id_valor


--Dimension tables
CREATE TABLE Dim_Falta(
	id_falta int IDENTITY(1,1),
	tipo_falta text,
	PRIMARY KEY (id_falta)
)
SELECT * from Dim_Falta
INSERT INTO Dim_Falta (tipo_falta) (SELECT DISTINCT CAST(Tipo_Falta as varchar) FROM Esquelas_Normalizada)

--

CREATE TABLE Dim_Departamento(
	id_departamento int PRIMARY KEY IDENTITY(1,1),
	departamento text
)
drop table Dim_Departamento
Select * from Dim_Departamento
INSERT INTO Dim_Departamento (departamento) (SELECT DISTINCT CAST(Departamento as varchar) FROM Esquelas_Normalizada where cast(Departamento as varchar) <> '')

--

CREATE TABLE Dim_Estado(
	estado varchar(4) PRIMARY KEY,
	estado_descripcion text
)
DROP TABLE Dim_Estado
SELECT * from Dim_Estado
INSERT INTO Dim_Estado (estado, estado_descripcion) (SELECT DISTINCT CAST(Estado as varchar), CAST(Estado_Descripcion as varchar) FROM Esquelas_Normalizada WHERE CAST(Estado as varchar) <> '' AND CAST(Estado_Descripcion as varchar) <> '')

--

CREATE TABLE Dim_Valor(
	id_valor int primary key IDENTITY(1,1),
	valor text
)
drop table Dim_Valor
Select * from Dim_Valor
insert into Dim_Valor (valor) (select distinct cast(Valor as varchar) from Esquelas_Normalizada WHERE cast(Valor as varchar) <> '')

--Adding IDs to the normalized table

UPDATE Esquelas_Normalizada SET Esquelas_Normalizada.id_falta = (select Dim_Falta.id_falta from Dim_Falta where cast(Dim_falta.tipo_falta as varchar) = cast(Esquelas_Normalizada.Tipo_Falta as varchar))
UPDATE Esquelas_Normalizada SET Esquelas_Normalizada.id_departamento = (select Dim_Departamento.id_departamento from Dim_Departamento where cast(Dim_departamento.departamento as varchar) = cast(Esquelas_Normalizada.Departamento as varchar))
UPDATE Esquelas_Normalizada SET Esquelas_Normalizada.id_valor = (select Dim_Valor.id_valor from Dim_Valor where cast(Dim_Valor.valor as varchar) = cast(Esquelas_Normalizada.Valor as varchar))

--Fact Table 
CREATE TABLE Fact_Esquelas(
	id int primary key identity(1,1),
	nro_esquela varchar(20),
	fecha text,
	interes text,
	falta_descripcion varchar(400),
	id_falta int,
	id_departamento int,
	estado varchar(4),
	id_valor int,
	FOREIGN KEY (id_falta) REFERENCES Dim_Falta(id_falta),
	FOREIGN KEY (id_departamento) REFERENCES Dim_Departamento(id_departamento),
	FOREIGN KEY (estado) references Dim_Estado(estado),
	FOREIGN KEY (id_valor) references Dim_Valor(id_valor)
)

DROP TABLE Fact_Esquelas
SELECT * from Fact_Esquelas
INSERT INTO Fact_Esquelas (nro_esquela, fecha, interes, falta_descripcion, id_falta, id_departamento, estado, id_valor) (SELECT Nro_Esquela, Fecha, Interes, Falta_Descripcion, id_falta, id_departamento, Estado, id_valor FROM Esquelas_Normalizada WHERE cast(Estado as varchar) <> '')

