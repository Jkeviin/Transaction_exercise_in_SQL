use master;
go

drop database BDUniversidad;
go

-- Para crear una base de datos
create database BDUniversidad;
go

-- Para referenciar la base de datos
use BDUniversidad;
go

-- Crear Base de Datos
create table Estudiante 
	(
	Id_Est int identity (10,1) not null,
	Nom1 nvarchar(50) not null,
	Nom2 nvarchar(50),
	Apell1 nvarchar(50) not null,
	Apell2 nvarchar(50) not null,
	Direcc nvarchar(50) not null,
	Telef nvarchar(15) not null,
	Email nvarchar(50) not null
	);
go

create table Materia
	(
	Id_Mat nvarchar(50) not null,
	Nombre nvarchar(50) not null,
	Cred int not null,
	Durac int default '',
	Semes int default ''
	);
go

create table Detalle_Mat
	(
	Id_Det int identity (1,1) not null,
	id_Est int not null,
	Id_Mat nvarchar (50) not null,
	Por70 float not null,
	Por30 float not null,
	Total float default ''
	);
go

-- Insertar 

insert into Estudiante(Nom1, Nom2, Apell1, Apell2, Direcc, Telef, Email)
		values  ('JOHNKEVIN', '', 'ORTEGA', 'APONTE', 'PTO ESPEJO', '3026009175', 'SLASH2130KEVIN@GMAIL.COM'),
				('LUCIA', 'ANDREA', 'LUJAN', 'MENDIETA', 'CLLE 105', '3-65-89-74', 'LUCIAANDREA@GMAIL.COM'),
				('PEDRO', '', 'LOPERA', '', 'CRA 92B', '2-65-69-87', 'PEDRO@GMAIL.COM'),
				('JORGE', 'ELIECER', 'DE OCCA', 'GARDEAZABAL', 'TRANSV. 32', '2-45-87-12', 'JORGEELIECER@GMAIL.COM'),
				('JOSE', 'ANIVAL', 'LOPEZ', '', 'CIRC. 40', '4-71-43-85', 'JOSEANIVAL@GMAIL.COM'),
				('AIDA', '', 'GOMEZ', 'QUINTANA', 'CRA 48', '4-78-78-12', 'AIDA@GMAIL.COM'),
				('CATALINA', '', 'QUINTANA', 'GUTIERREZ', 'CLLE 50', '2-67-05-05', 'CATALINA@GMAIL.COM'),
				('DIEGO', 'ERNESTO', 'QUIROZ', 'HERNANDEZ', 'CRA 58A', '2-34-57-80', 'DIEGOERNESTO@GMAIL.COM'),
				('EDWIN', '', 'MALDONADO', '', 'TRANSV. 31', '2-54-78-36', 'EDWIN@GMAIL.COM'),
				('NELSON', 'DE JESUS', 'MONTOYA', 'PELAEZ', 'CIRC. 3', '3-56-58-14', 'NELSONDEJESUS@GMAIL.COM'),
				('JAVIER', '', 'BRAND', 'LOPEZ', 'CRA 14', '3-56-78-41', 'JAVIER@GMAIL.COM'),
				('MATILDE', '', 'MONTES', '', 'CLLE 92C', '4-78-96-85', 'MATILDE@GMAIL.COM')
go


insert into MATERIA (ID_MAT, NOMBRE, CRED)
		values	('P100', 'MATEMATICAS', '4'),
				('P101', 'PROGRAMACION 1', '6'),
				('S102', 'PROGRAMACION 2', '4'),
				('S103', 'BASES DE DATOS', '4'),
				('T104', 'PROGRAMACION BASICA', '4'),
				('T105', 'LENGUA MATERNA', '4'),
				('C106', 'CALCULO I', '4'),
				('Q107', 'CALCULO II', '4'),
				('C108', 'CONSTRUCCION SOFTWARE', '6'),
				('Q109', 'INGENIERIA DE SOFTWARE', '6'),
				('Q110', 'TEORIA ADMINISTRATIVA', '2')	
go


insert into DETALLE_MAT (ID_EST, ID_MAT, POR70, POR30)
		values	('10', 'P100', '3.0', '3.0'),
				('11', 'P101', '2.5', '2.0'),
				('12', 'S102', '4.0', '5.0'),
				('13', 'S103', '1.0', '1.0'),
				('14', 'T104', '5.0', '4.2'),
				('15', 'T105', '4.7', '5.0'),
				('16', 'C106', '1.2', '3.4'),
				('17', 'Q107', '5.0', '1.2'),
				('18', 'C108', '4.0', '3.2'),
				('19', 'Q109', '3.4', '2.4'),
				('20', 'Q110', '1.2', '5.0'),
				('21', 'Q107', '3.2', '5.0'),
				('10', 'Q107', '2.4', '4.0'),
				('11', 'Q109', '5.0', '1.0'),
				('12', 'P100', '4.0', '3.0'),
				('13', 'P100', '2.0', '2.5'),
				('14', 'P101', '2.3', '4.0'),
				('18', 'S102', '3.5', '1.0'),
				('19', 'S103', '1.2', '5.0'),
				('20', 'T104', '1.0', '4.7'),
				('18', 'T105', '4.0', '1.2'),
				('19', 'C106', '4.0', '5.0'),
				('20', 'Q107', '5.0', '4.0'),
				('10', 'P101', '5.0', '4.0')
go

-----------------
--BEGIN TRANSACTION TX
--INSERT INTO ESTUDIANTE (NOM1, NOM2, APELL1, APELL2, DIRECC, TELEF, EMAIL)
--VALUES ('ROSA', 'MARIA', 'PEREZ', 'PINEDA', 'CRA 52', '2-35-48-78', 'ROSPIN@GMAIL.COM')
--go

--ROLLBACK TRANSACTION TX  -- Devuelve al Begin
--go

--COMMIT TRANSACTION TX  -- Confirma Proceso
--go

--select * from Estudiante
--go
-----------------

--select * from Detalle_Mat
--go

---------------------------------------------
create procedure usp_UActualizarTotal
AS
BEGIN 
	TRANSACTION TX
	update Detalle_Mat
	set Total =(Por70 * 0.7 + Por30 * 0.3)

	IF @@ERROR > 0
	BEGIN 
		ROLLBACK TRANSACTION TX
		SELECT 'HUBO ERROR ' AS RESPUESTA
	END
	ELSE
	BEGIN 
		COMMIT TRANSACTION TX
		SELECT 'ACTUALIZACION EXITOSA' AS RESPUESTA
	END
go

execute usp_UActualizarTotal
go
----------------------------------------
select * from Materia
go

CREATE PROCEDURE USP_UDURACIONSEMESTRE
AS
BEGIN 
	TRANSACTION TX
	UPDATE MATERIA
		SET 
		DURAC = (CRED * 16 ),
		SEMES = CASE
		WHEN (ID_MAT LIKE 'P%')
			THEN 1
		WHEN (ID_MAT LIKE 'S%')
			THEN 2
		WHEN (ID_MAT LIKE 'T%')
			THEN 3
		WHEN (ID_MAT LIKE 'C%')
			THEN 4
		WHEN (ID_MAT LIKE 'Q%')
			THEN 5
	END
	IF @@ERROR > 0
	BEGIN
		ROLLBACK TRANSACTION TX
		SELECT 'HUBO ERROR' AS RESPUESTA
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION TX
		SELECT 'ACTUALIZCION EXITOSA' AS RESPUESTA
	END
go

execute USP_UDURACIONSEMESTRE
go
----------------------------------------
select * from Estudiante;
go

CREATE PROCEDURE USP_AgregarEstudiante
	@Nom1 nvarchar(50),
	@Nom2 nvarchar(50),
	@Apell1 nvarchar(50),
	@Apell2 nvarchar(50),
	@Direcc nvarchar(50),
	@Telef nvarchar(15),
	@Email nvarchar(50)
AS
BEGIN 
	TRANSACTION TX
	insert into Estudiante(Nom1, Nom2, Apell1, Apell2, Direcc, Telef, Email)
		values  (@Nom1, @Nom2, @Apell1, @Apell2, @Direcc, @Telef, @Email)
	IF @@ERROR > 0
	BEGIN
		ROLLBACK TRANSACTION TX
		SELECT 'HUBO ERROR' AS RESPUESTA
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION TX
		SELECT 'ESTUDIANTE REGISTRADO CON EXITO' AS RESPUESTA
	END
go

execute USP_AgregarEstudiante 'JOHANA', 'VANESSA', 'MOSQUERA', 'OLAYA', 'LOS QUINDOS', '3120000537', 'VANE@GMAIL.COM'
go
----------------------------------------
select * from Estudiante;
go

CREATE PROCEDURE USP_ActualizarEstudiante
	@Id_Est int,
	@Nom1 nvarchar(50),
	@Nom2 nvarchar(50),
	@Apell1 nvarchar(50),
	@Apell2 nvarchar(50),
	@Direcc nvarchar(50),
	@Telef nvarchar(15),
	@Email nvarchar(50)
AS
BEGIN 
	TRANSACTION TX
	UPDATE Estudiante
	SET Nom1 = @Nom1,
		Nom2 = @Nom2,
		Apell1 = @Apell1,
		Apell2 = @Apell2,
		Direcc = @Direcc,
		Telef = @Telef,
		Email = @Email
	WHERE Id_Est = @Id_Est
	IF @@ERROR > 0
	BEGIN
		ROLLBACK TRANSACTION TX
		SELECT 'HUBO ERROR' AS RESPUESTA
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION TX
		SELECT 'ESTUDIANDO ACTUALIZADO CON EXITO' AS RESPUESTA
	END
go

----------------------------------------

select * from Estudiante;
go

CREATE PROCEDURE USP_EliminarEstudiante
	@Id_Est int
AS
BEGIN 
	TRANSACTION TX
	DELETE FROM Estudiante WHERE Id_Est = @Id_Est
	IF @@ERROR > 0
	BEGIN
		ROLLBACK TRANSACTION TX
		SELECT 'HUBO ERROR' AS RESPUESTA
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION TX
		SELECT 'ESTUDIANTE ELIMINADO CON EXITO' AS RESPUESTA
	END
go

execute USP_EliminarEstudiante '24'
go

----------------------------------------
select * from Materia;
go

CREATE PROCEDURE USP_AgregarMateria
	@Id_Mat nvarchar(50),
	@Nombre nvarchar(50),
	@Cred int
AS
BEGIN 
	TRANSACTION TX
	insert into MATERIA (ID_MAT, NOMBRE, CRED)
		values	(@Id_Mat, @Nombre, @Cred)
	IF @@ERROR > 0
	BEGIN
		ROLLBACK TRANSACTION TX
		SELECT 'HUBO ERROR' AS RESPUESTA
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION TX
		SELECT 'MATERIA SE REGISTRO CON EXITO' AS RESPUESTA
	END
go

execute USP_AgregarMateria 'P110', 'MATEMATICAS', '2'
go
----------------------------------------
select * from Materia;
go

CREATE PROCEDURE USP_ActualizarMateria
	
	@Id_Mat nvarchar(50),
	@Nombre nvarchar(50),
	@Cred int
AS
BEGIN 
	TRANSACTION TX
	UPDATE Materia
	SET Id_Mat = @Id_Mat,
		Nombre = @Nombre,
		Cred = @Cred
	WHERE Id_Mat = @Id_Mat
	IF @@ERROR > 0
	BEGIN
		ROLLBACK TRANSACTION TX
		SELECT 'HUBO ERROR' AS RESPUESTA
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION TX
		SELECT 'MATERIA ACTUALIZADA CON EXITO' AS RESPUESTA
	END
go

execute USP_ActualizarMateria 'P110', 'MATEMATICASS', '2'
go
----------------------------------------

select * from Materia;
go

CREATE PROCEDURE USP_EliminarMateria
	@Id_Mat nvarchar(50)
AS
BEGIN 
	TRANSACTION TX
	DELETE FROM Materia WHERE Id_Mat = @Id_Mat
	IF @@ERROR > 0
	BEGIN
		ROLLBACK TRANSACTION TX
		SELECT 'HUBO ERROR' AS RESPUESTA
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION TX
		SELECT 'ESTUDIANTE ELIMINADO CON EXITO' AS RESPUESTA
	END
go

execute USP_EliminarMateria 'P110'
go

----------------------------------------
select * from Detalle_Mat;
go

CREATE PROCEDURE USP_AgregarDetalle_Mat
	@id_Est int,
	@Id_Mat nvarchar(50),
	@Por70 float,
	@Por30 float
AS
BEGIN 
	TRANSACTION TX
	insert into Detalle_Mat(ID_EST, ID_MAT, POR70, POR30)
			values	(@id_Est, @Id_Mat, @Por70, @Por30)
	IF @@ERROR > 0
	BEGIN
		ROLLBACK TRANSACTION TX
		SELECT 'HUBO ERROR' AS RESPUESTA
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION TX
		SELECT 'DETALLE_MAT SE REGISTRO CON EXITO' AS RESPUESTA
	END
go

execute USP_AgregarDetalle_Mat '12', 'P100', '3.0', '3.0'
go

----------------------------------------
select * from Detalle_Mat;
go

CREATE PROCEDURE USP_ActualizarDetalle_Mat
	@Id_Det int,
	@id_Est int,
	@Id_Mat nvarchar(50),
	@Por70 float,
	@Por30 float
AS
BEGIN 
	TRANSACTION TX
	UPDATE Detalle_Mat
	SET id_Est = @id_Est,
		Id_Mat = @Id_Mat,
		Por70 = @Por70,
		Por30 = @Por30
	WHERE Id_Det = @Id_Det
	IF @@ERROR > 0
	BEGIN
		ROLLBACK TRANSACTION TX
		SELECT 'HUBO ERROR' AS RESPUESTA
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION TX
		SELECT 'DETALLE_MAT ACTUALIZADA CON EXITO' AS RESPUESTA
	END
go

execute USP_ActualizarDetalle_Mat '1','12','P120','3.0','3.0'
go

----------------------------------------

select * from Detalle_Mat;
go

CREATE PROCEDURE USP_EliminarDetalle_Mat
	@Id_Det int
AS
BEGIN 
	TRANSACTION TX
	DELETE FROM Detalle_Mat WHERE Id_Det = @Id_Det
	IF @@ERROR > 0
	BEGIN
		ROLLBACK TRANSACTION TX
		SELECT 'HUBO ERROR' AS RESPUESTA
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION TX
		SELECT 'DETALLE_MAT ELIMINADO CON EXITO' AS RESPUESTA
	END
go

execute USP_EliminarDetalle_Mat '25'
go
