ALTER PROCEDURE getConsultas
@fechaI date,
@fechaF date,
@fecha date,
@idHC int,
@idTipoConsulta int,
@idsEspecialidad VARCHAR(MAX),
@opFecha int,
@tops int,
@pag int,
@total int OUTPUT
AS BEGIN
	-- 1 Fecha - 2 Mes - 3 Año
	set @total = (SELECT COUNT(*) from dbo.consulta con
	inner join dbo.caso cs on cs.id = con.idCaso
	inner join dbo.historialClinico hc on hc.id = cs.idHistorialClinico and (@idHC = 0 or hc.id = @idHC)
	inner join dbo.medico_especialidad m_e on m_e.id= con.idMedico_Especialidad
	inner join dbo.especialidad esp on esp.id = m_e.idEspecialidad
	inner join dbo.tipoConsulta  tc on tc.id = con.idTipoConsulta
	where 
		((@opFecha = 1 and (con.fecha BETWEEN @fechaI and @fechaF))
		or (@opFecha = 2 and (MONTH(con.fecha) = MONTH(@fecha) and YEAR(con.fecha) = YEAR(@fecha)))
		or (@opFecha = 4 and YEAR(con.fecha) = YEAR(@fecha)))
		and (@idsEspecialidad = '0' or esp.id in (SELECT value FROM STRING_SPLIT(@idsEspecialidad, ',')))
		and (@idTipoConsulta = 0 or tc.id = @idTipoConsulta)
		)
		
	
	SELECT esp.id id_especialidad , esp.descripcion des_especialidad,tc.descripcion tipo, case tc.id
	WHEN 1 THEN (select ca.descripcion from dbo.causa ca where con.idMetodo = ca.id) 
	WHEN 2 THEN (select dmt.descripcion from dbo.detallesMetodos dmt where con.idMetodo = dmt.id)
	END causa_motivo, hc.id idHC, con.* from dbo.consulta con
	inner join dbo.caso cs on cs.id = con.idCaso
	inner join dbo.historialClinico hc on hc.id = cs.idHistorialClinico and (@idHC = 0 or hc.id = @idHC)
	inner join dbo.medico_especialidad m_e on m_e.id= con.idMedico_Especialidad
	inner join dbo.medico me on me.id = m_e.idMedico
	inner join dbo.especialidad esp on esp.id = m_e.idEspecialidad
	inner join dbo.tipoConsulta  tc on tc.id = con.idTipoConsulta
	where 
		((@opFecha = 1 and (con.fecha BETWEEN @fechaI and @fechaF))
		or (@opFecha = 2 and (MONTH(con.fecha) = MONTH(@fecha) and YEAR(con.fecha) = YEAR(@fecha)))
		or (@opFecha = 4 and YEAR(con.fecha) = YEAR(@fecha)))
		and (@idsEspecialidad = '0' or esp.id in (SELECT value FROM STRING_SPLIT(@idsEspecialidad, ',')))
		and (@idTipoConsulta = 0 or tc.id = @idTipoConsulta)
		order by con.fecha 
		OFFSET @pag ROWS FETCH NEXT @tops ROWS ONLY;
END

-- 22 Junio
CREATE PROCEDURE insertTipoConsulta
AS BEGIN
	SET IDENTITY_INSERT [dbo].[tipoConsulta] ON;
	INSERT [dbo].[tipoConsulta](id,descripcion) values
	(1,'AMBULATORIA'),(2,'PREVENCION');
	SET IDENTITY_INSERT [dbo].[tipoConsulta] OFF 
END



ALTER PROCEDURE [dbo].[obtenerEspecialidades]
	@NUM_PAGINA   INT,
	@totalRegistros   INT,
	@total   INT OUTPUT,
	@buscar as nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	SET @total=(SELECT COUNT(id) as totalRegistros from especialidad where descripcion COLLATE Latin1_General_CI_AI like '%'+@buscar+'%' COLLATE Latin1_General_CI_AI and visible=1);
	SELECT * from especialidad  where descripcion COLLATE Latin1_General_CI_AI like '%'+@buscar+'%' COLLATE Latin1_General_CI_AI and visible=1 order by id OFFSET (@NUM_PAGINA) ROWS FETCH FIRST @totalRegistros ROWS ONLY;	
END

-- Insert
SET IDENTITY_INSERT [dbo].[tipoConsulta] ON;
INSERT INTO BD_SM.dbo.tipoConsulta (id,descripcion) VALUES (1,'AMBULATORIA');
INSERT INTO BD_SM.dbo.tipoConsulta (id,descripcion) VALUES (2,'PREVENCION');
SET IDENTITY_INSERT [dbo].[tipoConsulta] OFF;

SET IDENTITY_INSERT [dbo].[metodos] ON;
INSERT INTO BD_SM.dbo.metodos (id,descripcion,idTipoConsulta) VALUES (2,'Planificacion Familiar',2);
INSERT INTO BD_SM.dbo.metodos (id,descripcion,idTipoConsulta) VALUES (3,'Deteccion de cancer',2);
SET IDENTITY_INSERT [dbo].[metodos] OFF;

SET IDENTITY_INSERT [dbo].[detallesMetodos] ON;
INSERT INTO BD_SM.dbo.detallesMetodos (id,descripcion,sexo,idMetodo) VALUES (1,'Dispositivo Intrauterino','2',2);
INSERT INTO BD_SM.dbo.detallesMetodos (id,descripcion,sexo,idMetodo) VALUES (2,'Gestàgenos Orales','0',2);
INSERT INTO BD_SM.dbo.detallesMetodos (id,descripcion,sexo,idMetodo) VALUES (3,'Inyectable','0',2);
INSERT INTO BD_SM.dbo.detallesMetodos (id,descripcion,sexo,idMetodo) VALUES (4,'Preservativos','0',2);
INSERT INTO BD_SM.dbo.detallesMetodos (id,descripcion,sexo,idMetodo) VALUES (5,'Implantes','2',2);
INSERT INTO BD_SM.dbo.detallesMetodos (id,descripcion,sexo,idMetodo) VALUES (6,'Vasectomia','1',2);
INSERT INTO BD_SM.dbo.detallesMetodos (id,descripcion,sexo,idMetodo) VALUES (7,'Salpingectomìa','2',2);
INSERT INTO BD_SM.dbo.detallesMetodos (id,descripcion,sexo,idMetodo) VALUES (8,'Cervicouterino','2',3);
INSERT INTO BD_SM.dbo.detallesMetodos (id,descripcion,sexo,idMetodo) VALUES (9,'Prospata','1',3);
INSERT INTO BD_SM.dbo.detallesMetodos (id,descripcion,sexo,idMetodo) VALUES (10,'Mamario','0',3);
INSERT INTO BD_SM.dbo.detallesMetodos (id,descripcion,sexo,idMetodo) VALUES (11,'Pulmonar','0',3);
INSERT INTO BD_SM.dbo.detallesMetodos (id,descripcion,sexo,idMetodo) VALUES (12,'Gastrico','0',3);
INSERT INTO BD_SM.dbo.detallesMetodos (id,descripcion,sexo,idMetodo) VALUES (13,'Hepatico','0',3);
INSERT INTO BD_SM.dbo.detallesMetodos (id,descripcion,sexo,idMetodo) VALUES (14,'Colorrectal','0',3);
INSERT INTO BD_SM.dbo.detallesMetodos (id,descripcion,sexo,idMetodo) VALUES (15,'Piel','0',3);
SET IDENTITY_INSERT [dbo].[detallesMetodos] OFF;







