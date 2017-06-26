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