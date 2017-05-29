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