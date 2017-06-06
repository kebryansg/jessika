ALTER TABLE BD_SM.dbo.caso DROP COLUMN fecha go

ALTER TABLE BD_SM.dbo.consulta ADD fecha date go

ALTER TABLE BD_SM.dbo.signosVitales ADD frecuenciaC int go



ALTER TABLE BD_SM.dbo.consulta ADD motivo nvarchar(100) go
ALTER TABLE BD_SM.dbo.consulta ADD diagnostico nvarchar(100) go
ALTER TABLE BD_SM.dbo.consulta ADD prescripcion nvarchar(100) go
ALTER TABLE BD_SM.dbo.consulta ADD sintomas nvarchar(100) go

ALTER TABLE BD_SM.dbo.consultaEstudiosLabs ADD valores nvarchar(100) go


DROP TABLE BD_SM.dbo.prescripcion go
DROP TABLE BD_SM.dbo.diagnostico go


-- 24-05-2017
ALTER TABLE BD_SM.dbo.detallesEstudiosImg ADD extremidades char(1) go
ALTER TABLE BD_SM.dbo.consultaEstudiosImagen ADD detExtremidad char(1) go

create table tipoEstudioImg(
id int IDENTITY(1,1) not NULL,
descripcion nvarchar(100),
CONSTRAINT PK_tipoEstudioImg PRIMARY KEY (id),
);

ALTER TABLE BD_SM.dbo.estudioImagen ADD idTipoEstudioImg int go
ALTER TABLE BD_SM.dbo.estudioImagen ADD CONSTRAINT estudioImagen_tipoEstudioImg_FK FOREIGN KEY (idTipoEstudioImg) REFERENCES BD_SM.dbo.tipoEstudioImg(id) go


INSERT INTO BD_SM.dbo.tipoEstudioImg(descripcion) VALUES('tomografia');
INSERT INTO BD_SM.dbo.tipoEstudioImg(descripcion) VALUES('resonancia');
INSERT INTO BD_SM.dbo.tipoEstudioImg(descripcion) VALUES('rayos x');
INSERT INTO BD_SM.dbo.tipoEstudioImg(descripcion) VALUES('ecografia');
INSERT INTO BD_SM.dbo.tipoEstudioImg(descripcion) VALUES('densitometria osea');
INSERT INTO BD_SM.dbo.tipoEstudioImg(descripcion) VALUES('biopsias');
INSERT INTO BD_SM.dbo.tipoEstudioImg(descripcion) VALUES('mamas');


INSERT INTO BD_SM.dbo.estudioImagen(descripcion,idTipoEstudioImg) VALUES('cuello',1);
INSERT INTO BD_SM.dbo.estudioImagen(descripcion,idTipoEstudioImg) VALUES('torax',1);
INSERT INTO BD_SM.dbo.estudioImagen(descripcion,idTipoEstudioImg) VALUES('osteo articular',2);


INSERT INTO BD_SM.dbo.detallesEstudiosImg(idEstudiosImg, descripcion, extremidades) VALUES(1, 'cuello simple/contrastado', '0');
INSERT INTO BD_SM.dbo.detallesEstudiosImg(idEstudiosImg, descripcion, extremidades) VALUES(1, 'angio tc vasos de cuello', '0');


INSERT INTO BD_SM.dbo.detallesEstudiosImg(idEstudiosImg, descripcion, extremidades) VALUES(2, 'torax simple', '0');
INSERT INTO BD_SM.dbo.detallesEstudiosImg(idEstudiosImg, descripcion, extremidades) VALUES(2, 'torax simple y contrastado', '0');
INSERT INTO BD_SM.dbo.detallesEstudiosImg(idEstudiosImg, descripcion, extremidades) VALUES(2, 'torax alta resolucion', '0');
INSERT INTO BD_SM.dbo.detallesEstudiosImg(idEstudiosImg, descripcion, extremidades) VALUES(2, 'angio tc de aorta toracica', '0');

INSERT INTO BD_SM.dbo.detallesEstudiosImg(idEstudiosImg, descripcion, extremidades) VALUES(3, 'hombro', '1');
INSERT INTO BD_SM.dbo.detallesEstudiosImg(idEstudiosImg, descripcion, extremidades) VALUES(3, 'codo', '1');
INSERT INTO BD_SM.dbo.detallesEstudiosImg(idEstudiosImg, descripcion, extremidades) VALUES(3, 'mano', '1');
INSERT INTO BD_SM.dbo.detallesEstudiosImg(idEstudiosImg, descripcion, extremidades) VALUES(3, 'muñeca', '1');
INSERT INTO BD_SM.dbo.detallesEstudiosImg(idEstudiosImg, descripcion, extremidades) VALUES(3, 'articulaciones coxo femorales(pelvis osea)', '0');
INSERT INTO BD_SM.dbo.detallesEstudiosImg(idEstudiosImg, descripcion, extremidades) VALUES(3, 'rodilla', '1');
INSERT INTO BD_SM.dbo.detallesEstudiosImg(idEstudiosImg, descripcion, extremidades) VALUES(3, 'pie', '1');
INSERT INTO BD_SM.dbo.detallesEstudiosImg(idEstudiosImg, descripcion, extremidades) VALUES(3, 'huesos largos', '1');



---- 29 - 05 - 2017
-- En la BD-IP
create PROCEDURE getPacientes @trows int,
@inicio int,
@buscar NVARCHAR(100) as begin declare @total_registros int
set
@total_registros =(
	select
		count(*)
	from
		paciente inner join BD_SM.dbo.historialClinico on
		idPaciente = paciente.id
	where
		estado = '1'
		and(
			nombre1 like '%'+ @buscar +'%'
			or nombre2 like '%'+ @buscar +'%'
			or apellido1 like '%'+ @buscar +'%'
			or apellido2 like '%'+ @buscar +'%'
			or cedula like '%'+ @buscar +'%'
			or historialClinico.id like '%'+ @buscar +'%'
		)
);

select
	@total_registros registros,
	historialClinico.id as historia,
	paciente.*
from
	paciente inner join BD_SM.dbo.historialClinico on
	idPaciente = paciente.id
where
	estado = '1'
	and(
		nombre1 like '%'+ @buscar +'%'
		or nombre2 like '%'+ @buscar +'%'
		or apellido1 like '%'+ @buscar +'%'
		or apellido2 like '%'+ @buscar +'%'
		or cedula like '%%'
		or historialClinico.id like '%'+ @buscar +'%'
	)
order by
	id OFFSET @inicio ROWS FETCH NEXT @trows ROWS ONLY;
end


-- 03 Junio 2017
ALTER TABLE BD_SM.dbo.metodos DROP CONSTRAINT FK_metodos_causa go
ALTER TABLE BD_SM.dbo.metodos ADD idTipoConsulta int go
ALTER TABLE BD_SM.dbo.metodos ADD CONSTRAINT metodos_tipoConsulta_FK FOREIGN KEY (idTipoConsulta) REFERENCES BD_SM.dbo.tipoConsulta(id) go
ALTER TABLE BD_SM.dbo.consulta DROP CONSTRAINT FK_consulta_metodos go
ALTER TABLE BD_SM.dbo.causa ADD idTipoConsulta int
ALTER TABLE BD_SM.dbo.causa ADD CONSTRAINT causa_tipoConsulta_FK FOREIGN KEY (idTipoConsulta) REFERENCES BD_SM.dbo.tipoConsulta(id) go
ALTER TABLE BD_SM.dbo.signosVitales ADD periodo CHAR(1)

create table detallesMetodos(
id int IDENTITY(1,1) not NULL,
descripcion nVARCHAR(50) ,
sexo char(1),
CONSTRAINT PK_detallesMetodos PRIMARY KEY (id)
);


insert into tipoConsulta(descripcion) VALUES('AMBULATORIA'),('PREVENCION');
insert into metodos (descripcion,idTipoConsulta) VALUES('Planificacion Familiar',2),('Deteccion de cancer',2)

-- 05 Junio 2017
alter table causa drop COLUMN descripcion
alter table causa add descripcion TEXT
alter table consulta add idTipoConsulta int


alter table consulta drop COLUMN motivo
alter table consulta drop COLUMN diagnostico
alter table consulta drop COLUMN prescripcion
alter table consulta drop COLUMN sintomas

alter table consulta add motivo TEXT
alter table consulta add diagnostico TEXT
alter table consulta add prescripcion TEXT
alter table consulta add sintomas TEXT

ALTER TABLE BD_SM.dbo.consulta ADD CONSTRAINT consulta_tipoConsulta_FK FOREIGN KEY (idTipoConsulta) REFERENCES BD_SM.dbo.tipoConsulta(id) go


CREATE PROCEDURE saveCausa
@descripcion text,
@id int OUTPUT
as
BEGIN
	insert into causa(descripcion,idTipoConsulta) values(@descripcion,1)
	SELECT Top 1  @id = id from causa order by id desc
END

create PROCEDURE saveConsulta
@idMedico_Especialidad int,
@idSignosvitales int,
@idCaso int,
@fecha DATE,
@idMetodo int,
@idTipoConsulta int,
@motivo text,
@diagnostico text,
@prescripcion TEXT,
@sintomas TEXT,
@id int OUTPUT
AS
BEGIN
	INSERT INTO BD_SM.dbo.consulta
	(idMedico_Especialidad, idMetodo, idSignosvitales, idCaso, fecha, idTipoConsulta, 
	motivo, diagnostico, prescripcion, sintomas)
	VALUES(@idMedico_Especialidad, @idMetodo, @idSignosvitales, @idCaso, @fecha, @idTipoConsulta, @motivo, @diagnostico, @prescripcion, @sintomas);
	SELECT Top 1  @id = id from BD_SM.dbo.consulta order by id desc

END 

create PROCEDURE saveConsulta
@idMedico_Especialidad int,
@idSignosvitales int,
@idCaso int,
@fecha DATE,
@idMetodo int,
@idTipoConsulta int,
@motivo text,
@diagnostico text,
@prescripcion TEXT,
@sintomas TEXT,
@id int OUTPUT
AS
BEGIN
	INSERT INTO BD_SM.dbo.consulta
	(idMedico_Especialidad, idMetodo, idSignosvitales, idCaso, fecha, idTipoConsulta, 
	motivo, diagnostico, prescripcion, sintomas)
	VALUES(@idMedico_Especialidad, @idMetodo, @idSignosvitales, @idCaso, @fecha, @idTipoConsulta, @motivo, @diagnostico, @prescripcion, @sintomas);
	SELECT Top 1  @id = id from BD_SM.dbo.consulta order by id desc

END 

alter table signosvitales drop COLUMN talla
alter table signosvitales drop COLUMN peso
alter table signosvitales drop COLUMN temperatura

alter table signosvitales add peso NVARCHAR(50)
alter table signosvitales add talla NVARCHAR(50)
alter table signosvitales add temperatura NVARCHAR(50)


create PROCEDURE saveSignosVitales
@peso NVARCHAR(50),
@talla NVARCHAR(50),
@temperatura NVARCHAR(50),
@presion NVARCHAR(50),
@fum DATE,
@fuc DATE,
@frecuencia NVARCHAR(50),
@periodo char(1),
@id int OUTPUT
AS
BEGIN
	INSERT INTO BD_SM.dbo.signosVitales
	(presion, fum, fuc, frecuenciaC, periodo, peso, talla, temperatura)
	VALUES(@presion, @fum, @fuc, @frecuencia, @periodo, @peso, @talla, @temperatura);
	SELECT Top 1  @id = id from BD_SM.dbo.signosVitales order by id desc

END

CREATE PROCEDURE saveCaso
@hc int,
@id int OUTPUT
AS
BEGIN
	INSERT INTO BD_SM.dbo.caso(idHistorialClinico) VALUES(@hc);
	SELECT Top 1  @id = id from BD_SM.dbo.caso order by id desc
END 


