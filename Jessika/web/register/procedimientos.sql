USE [BD_SM]

/****** Object:  StoredProcedure [dbo].[getPacientes]    Script Date: 26/06/2017 19:45:08 ******/




create PROCEDURE [dbo].[getPacientes] @trows int,
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


/****** Object:  StoredProcedure [dbo].[Insert_IngresosHospital]    Script Date: 26/06/2017 19:45:08 ******/




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Insert_IngresosHospital]
	-- Add the parameters for the stored procedure here
	@idHistoria as int,
	@fechaIngreso date,
	@idTipoIngreso as int,
	@idEspecialidadEgreso as int,
	@fechaEntrada as date,
	@fechaSalida as date,
	@hora as time(7),
	@sos as bit,
	@condicionEgreso as bit,
	@definitivoEgreso as text,
	@secundarioEgreso as text,
	@secundarioEgreso2 as text,
	@causaExterna as text,
	@codigoDiagnosticoDefinitivo as nvarchar(10)
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO caso (idHistorialClinico) values (@idHistoria);
	declare @idCaso int;
	SELECT Top 1  @idCaso= id from caso order by id desc
	INSERT INTO ingresos(idTipoIngreso, idCaso,idEspecialidadEgreso,fechaEntrada,fechaSalida,hora,sos,condicionEgreso,definitivoEgreso,secundarioEgreso,secundarioEgreso2,causaExterna,codigoDiagnosticoDefinitivo,estado) values 
	(@idTipoIngreso,@idCaso,@idEspecialidadEgreso,@fechaEntrada,@fechaSalida,@hora,@sos,@condicionEgreso,@definitivoEgreso,@secundarioEgreso,@secundarioEgreso2,@causaExterna,@codigoDiagnosticoDefinitivo,1);
	declare @idIngreso int;
	SELECT Top 1  @idIngreso= id from ingresos order by id desc
	INSERT INTO detalleIngresos (idIngreso, fecha,hora) values (@idIngreso,@fechaIngreso,@hora);
	
END



/****** Object:  StoredProcedure [dbo].[obtener_medicos]    Script Date: 26/06/2017 19:45:08 ******/




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[obtener_medicos]
	-- Add the parameters for the stored procedure here
	@NUM_PAGINA   INT,
	@totalRegistros   INT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	
	declare @totalRegistro int;
	SET @totalRegistro=(SELECT COUNT(id)   from medico where visible=1);	
	
    -- Insert statements for procedure here
	SELECT @totalRegistro as registros, * FROM medico WHERE VISIBLE=1 order by id OFFSET (@NUM_PAGINA*@totalRegistros) ROWS FETCH FIRST @totalRegistros ROWS ONLY;


	/*WITH DRV_TBL AS 
   (
      SELECT 
         ROW_NUMBER() OVER (ORDER BY medico.id asc) AS rownum
         ,  * from medico where visible=1)

   SELECT @totalRegistro as registros, * FROM DRV_TBL 
   WHERE ROWNUM BETWEEN (@NUM_PAGINA*@totalRegistros)-@totalRegistros+1 AND (@NUM_PAGINA*@totalRegistros) */
   
END



/****** Object:  StoredProcedure [dbo].[obtenerCamasMensuales]    Script Date: 26/06/2017 19:45:08 ******/




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[obtenerCamasMensuales]
	-- Add the parameters for the stored procedure here
	@fecha as date	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @diasEstada int
	declare @idParroquia as int 
	select @idParroquia=parroquia from establecimiento
	select @diasEstada=sum(DATEDIFF(day, ingresos.fechaEntrada,ingresos.fechaSalida)) FROM establecimiento,camas,ingresos 
	where (Month(@fecha) between MONTH(ingresos.fechaEntrada)
							 and MONTH(ingresos.fechaSalida)) and YEAR(@fecha) between YEAR(ingresos.fechaEntrada) and YEAR(ingresos.fechaSalida)
	SELECT establecimiento.nombre,BD_IP.dbo.provincia.descripcion as provincia, BD_IP.dbo.canton.descripcion AS canton, BD_IP.dbo.parroquia.descripcion AS parroquia, establecimiento.direccion, establecimiento.encargado,establecimiento.telefono,
	establecimiento.email,camas.*,@diasEstada as DiasDeEstada from camas,establecimiento ,
	BD_IP.dbo.canton INNER JOIN
						BD_IP.dbo.parroquia ON canton.id = BD_IP.dbo.parroquia.idCanton INNER JOIN
						BD_IP.dbo.provincia ON canton.idProvincia = BD_IP.dbo.provincia.id where BD_IP.dbo.parroquia.id=@idParroquia



	
END


/****** Object:  StoredProcedure [dbo].[obtenerEspecialidadBuscar]    Script Date: 26/06/2017 19:45:08 ******/




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[obtenerEspecialidadBuscar]
	-- Add the parameters for the stored procedure here
	@NUM_PAGINA   INT,
	@totalRegistros   INT,
	@buscar as nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @totalRegistro int;
	SET @totalRegistro=(SELECT COUNT(id) as totalRegistros from especialidad where descripcion COLLATE Latin1_General_CI_AI like '%'+@buscar+'%' COLLATE Latin1_General_CI_AI and visible=1);
	SELECT @totalRegistro as registros, * from especialidad  where descripcion COLLATE Latin1_General_CI_AI like '%'+@buscar+'%' COLLATE Latin1_General_CI_AI and visible=1 order by id OFFSET (@NUM_PAGINA*@totalRegistros) ROWS FETCH FIRST @totalRegistros ROWS ONLY;
    -- Insert statements for procedure here
   /* WITH DRV_TBL AS 
   (
      SELECT top 20
         ROW_NUMBER() OVER (ORDER BY especialidad.id asc) AS rownum, 
         especialidad.* from especialidad where descripcion like '%'+@buscar+'%' and visible=1)

   SELECT @totalRegistro as registros,* FROM DRV_TBL 
   WHERE ROWNUM BETWEEN (@NUM_PAGINA*@totalRegistros)-@totalRegistros+1 AND (@NUM_PAGINA*@totalRegistros) */
	
END



/****** Object:  StoredProcedure [dbo].[obtenerEspecialidades]    Script Date: 26/06/2017 19:45:08 ******/




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[obtenerEspecialidades]
	-- Add the parameters for the stored procedure here
	@NUM_PAGINA   INT,
	@totalRegistros   INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @totalRegistro int;
	SET @totalRegistro=(SELECT COUNT(id) as totalRegistros from especialidad where visible=1);
	SELECT @totalRegistro as registros, * from especialidad  where visible=1 order by id OFFSET (@NUM_PAGINA*@totalRegistros) ROWS FETCH FIRST @totalRegistros ROWS ONLY;
    -- Insert statements for procedure here
	/*WITH DRV_TBL AS 
   (
      SELECT 
         ROW_NUMBER() OVER (ORDER BY especialidad.id) AS rownum
         , especialidad.* from especialidad where visible=1)

   SELECT @totalRegistro as registros, * FROM DRV_TBL 
   WHERE ROWNUM BETWEEN (@NUM_PAGINA*@totalRegistros)-@totalRegistros+1 AND (@NUM_PAGINA*@totalRegistros) */
END



/****** Object:  StoredProcedure [dbo].[obtenerIngresos]    Script Date: 26/06/2017 19:45:08 ******/




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[obtenerIngresos]
	-- Add the parameters for the stored procedure here
	@NUM_PAGINA   INT,
	@totalRegistros   INT,
	@fechaInicio DATE,
	@fechaFin date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    declare @totalIngresos int;
    SET @totalIngresos=(SELECT  COUNT(BD_SM.dbo.ingresos.id) as totalRegistros FROM ingresos
    where (BD_SM.dbo.ingresos.fechaEntrada  BETWEEN @fechaInicio and @fechaFin 
			or BD_SM.dbo.ingresos.fechaSalida BETWEEN @fechaInicio and @fechaFin) and BD_SM.dbo.ingresos.estado=1 );
	SELECT @totalIngresos as registros, BD_SM.dbo.ingresos.id,  BD_IP.dbo.paciente.cedula, BD_IP.dbo.paciente.nombre1, BD_IP.dbo.paciente.nombre2,
			BD_IP.dbo.paciente.apellido1, BD_IP.dbo.paciente.apellido2,  BD_SM.dbo.ingresos.idTipoIngreso,
			BD_SM.dbo.ingresos.idCaso,BD_SM.dbo.ingresos.idEspecialidadEgreso, BD_SM.dbo.especialidadEgreso.descripcion, BD_SM.dbo.ingresos.fechaEntrada, BD_SM.dbo.ingresos.fechaSalida,
			BD_SM.dbo.ingresos.hora,BD_SM.dbo.ingresos.sos, BD_SM.dbo.ingresos.condicionEgreso,BD_SM.dbo.ingresos.definitivoEgreso,BD_SM.dbo.ingresos.secundarioEgreso,
			BD_SM.dbo.ingresos.secundarioEgreso2, BD_SM.dbo.ingresos.causaExterna,BD_SM.dbo.ingresos.codigoDiagnosticoDefinitivo
			from BD_IP.dbo.paciente inner join BD_SM.dbo.historialClinico on BD_IP.dbo.paciente.id= BD_SM.dbo.historialClinico.idPaciente inner join
			BD_SM.dbo.caso on BD_SM.dbo.caso.idHistorialClinico= BD_SM.dbo.historialClinico.id inner join BD_SM.dbo.ingresos on
			BD_SM.dbo.caso.id= BD_SM.dbo.ingresos.idCaso INNER JOIN BD_SM.dbo.especialidadEgreso on BD_SM.dbo.especialidadEgreso.id= BD_SM.dbo.ingresos.idEspecialidadEgreso
			where (BD_SM.dbo.ingresos.fechaEntrada  BETWEEN @fechaInicio and @fechaFin 
			or BD_SM.dbo.ingresos.fechaSalida BETWEEN @fechaInicio and @fechaFin) and BD_SM.dbo.ingresos.estado=1 order by id OFFSET (@NUM_PAGINA*@totalRegistros) ROWS FETCH FIRST @totalRegistros ROWS ONLY;
	/*WITH DRV_TBL AS 
   (
      SELECT 
         ROW_NUMBER() OVER (ORDER BY BD_SM.dbo.ingresos.id asc) AS rownum
         ,  BD_SM.dbo.ingresos.id,  BD_IP.dbo.paciente.cedula, BD_IP.dbo.paciente.nombre1, BD_IP.dbo.paciente.nombre2,
			BD_IP.dbo.paciente.apellido1, BD_IP.dbo.paciente.apellido2,  BD_SM.dbo.ingresos.idTipoIngreso,
			BD_SM.dbo.ingresos.idCaso,BD_SM.dbo.ingresos.idEspecialidadEgreso, BD_SM.dbo.especialidadEgreso.descripcion, BD_SM.dbo.ingresos.fechaEntrada, BD_SM.dbo.ingresos.fechaSalida,
			BD_SM.dbo.ingresos.hora,BD_SM.dbo.ingresos.sos, BD_SM.dbo.ingresos.condicionEgreso,BD_SM.dbo.ingresos.definitivoEgreso,BD_SM.dbo.ingresos.secundarioEgreso,
			BD_SM.dbo.ingresos.secundarioEgreso2, BD_SM.dbo.ingresos.causaExterna,BD_SM.dbo.ingresos.codigoDiagnosticoDefinitivo
			from BD_IP.dbo.paciente inner join BD_SM.dbo.historialClinico on BD_IP.dbo.paciente.id= BD_SM.dbo.historialClinico.idPaciente inner join
			BD_SM.dbo.caso on BD_SM.dbo.caso.idHistorialClinico= BD_SM.dbo.historialClinico.id inner join BD_SM.dbo.ingresos on
			BD_SM.dbo.caso.id= BD_SM.dbo.ingresos.idCaso INNER JOIN BD_SM.dbo.especialidadEgreso on BD_SM.dbo.especialidadEgreso.id= BD_SM.dbo.ingresos.idEspecialidadEgreso
			where (BD_SM.dbo.ingresos.fechaEntrada  BETWEEN @fechaInicio and @fechaFin 
			or BD_SM.dbo.ingresos.fechaSalida BETWEEN @fechaInicio and @fechaFin) and BD_SM.dbo.ingresos.estado=1)

   SELECT @totalIngresos as registros, * FROM DRV_TBL 
   WHERE ROWNUM BETWEEN (@NUM_PAGINA*@totalRegistros)-@totalRegistros+1 AND (@NUM_PAGINA*@totalRegistros) */
END



/****** Object:  StoredProcedure [dbo].[obtenerIngresosMensuales]    Script Date: 26/06/2017 19:45:08 ******/




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[obtenerIngresosMensuales]
	-- Add the parameters for the stored procedure here
	@fecha as date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
declare @condicion as int 
set @condicion=4
--edad cumplida al ingreso

SELECT      Month(@fecha) as MesRecoleccion,  historialClinico.id as NHistoriaClinica, caso.id AS NoArchivo, BD_IP.dbo.paciente.cedula, BD_IP.dbo.paciente.nombre1,
			BD_IP.dbo.paciente.nombre2,BD_IP.dbo.paciente.apellido1,BD_IP.dbo.paciente.apellido2, Nacionalidad= CASE BD_IP.dbo.paciente.nacionalidad WHEN 'Ecuatoriano' THEN '1' ELSE '2' end, 
			Pais= CASE BD_IP.dbo.paciente.nacionalidad WHEN 'Ecuatoriano' THEN '' ELSE BD_IP.dbo.paciente.nacionalidad end ,BD_IP.dbo.paciente.sexo,  
			 YEAR(BD_IP.dbo.paciente.fechaNacimiento) as AñoNacimiento, MONTH(BD_IP.dbo.paciente.fechaNacimiento) as MesNacimiento, DAY(BD_IP.dbo.paciente.fechaNacimiento) as DiaNacimiento, 
			 @condicion as condicionEdad,DATEDIFF(year, fechaNacimiento,fechaEntrada) as EdadCunplidaAlIngreso,  BD_IP.dbo.paciente.etnia, BD_IP.dbo.paciente.discapacidad,  BD_IP.dbo.provincia.descripcion AS Provincia, BD_IP.dbo.canton.descripcion AS Canton, BD_IP.dbo.parroquia.descripcion AS Parroquia, 
                         BD_IP.dbo.paciente.domicilio as direccion, YEAR(ingresos.fechaEntrada) AñoIngreso,Month(ingresos.fechaEntrada) MesIngreso, DAY(ingresos.fechaEntrada) DiaIngreso,
						  YEAR(ingresos.fechaSalida) as AñoEgreso, MONTH(ingresos.fechaSalida) as MesEgreso,day(ingresos.fechaSalida) AS DiaEgreso,
						  DATEDIFF(day, ingresos.fechaEntrada,ingresos.fechaSalida) as DiasEstada, ingresos.idEspecialidadEgreso, ingresos.condicionEgreso, ingresos.definitivoEgreso, 
                         ingresos.secundarioEgreso, ingresos.secundarioEgreso2, ingresos.causaExterna, ingresos.codigoDiagnosticoDefinitivo
FROM            BD_SM.dbo.historialClinico  inner join BD_IP.dbo.paciente on BD_SM.dbo.historialClinico.idPaciente=paciente.id 
INNER JOIN
                         BD_IP.dbo.parroquia ON BD_IP.dbo.paciente.idParroquia = BD_IP.dbo.parroquia.id INNER JOIN
						 BD_IP.dbo.canton on BD_IP.dbo.parroquia.idCanton= canton.id INNER JOIN
						 BD_IP.dbo.provincia on BD_IP.dbo.canton.idProvincia=BD_IP.dbo.provincia.id
INNER JOIN
                         caso ON BD_SM.dbo.historialClinico.id = BD_SM.dbo.caso.idHistorialClinico INNER JOIN
                         BD_SM.dbo.ingresos ON caso.id = ingresos.idCaso INNER JOIN
                         tipoIngreso ON ingresos.idTipoIngreso = tipoIngreso.id where (Month(@fecha) between MONTH(ingresos.fechaEntrada)
						 and MONTH(ingresos.fechaSalida)) and YEAR(@fecha) between YEAR(ingresos.fechaEntrada) and YEAR(ingresos.fechaSalida)


END


/****** Object:  StoredProcedure [dbo].[obtenerMedicosBuscar]    Script Date: 26/06/2017 19:45:08 ******/




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[obtenerMedicosBuscar]
	-- Add the parameters for the stored procedure here
	@NUM_PAGINA   INT,
	@totalRegistros   INT,
	@buscar as nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    declare @totalRegistro int;
    SET @totalRegistro=(SELECT  COUNT(id) as totalRegistros FROM medico WHERE cedula like '%'+@buscar+'%' or nombre1 +' '+ nombre2 +' '+apellidos1  +' ' +apellidos2  like  '%'+@buscar+'%' or domicilio like '%'+@buscar+'%' or email like  '%'+@buscar+'%' and visible=1);
	SELECT @totalRegistro as registros, * from medico
         WHERE cedula like '%'+@buscar+'%' or  nombre1 +' '+ nombre2 +' '+apellidos1  +' ' +apellidos2 COLLATE Latin1_General_CI_AI like  '%'+@buscar+'%' COLLATE Latin1_General_CI_AI
		 or domicilio like '%'+@buscar+'%'  and visible=1 order by id OFFSET (@NUM_PAGINA*@totalRegistros) ROWS FETCH FIRST @totalRegistros ROWS ONLY;
	/*WITH DRV_TBL AS 
   (
      SELECT 
         ROW_NUMBER() OVER (ORDER BY medico.id asc) AS rownum
         ,  * from medico
         WHERE cedula like '%'+@buscar+'%' or nombre1 +' '+ nombre2 +' '+apellidos1  +' ' +apellidos2  like  '%'+@buscar+'%' or domicilio like '%'+@buscar+'%' or email like  '%'+@buscar+'%' and visible=1)

   SELECT @totalRegistro as registros ,* FROM DRV_TBL 
   WHERE ROWNUM BETWEEN (@NUM_PAGINA*@totalRegistros)-@totalRegistros+1 AND (@NUM_PAGINA*@totalRegistros) */
END



/****** Object:  StoredProcedure [dbo].[obtenerPacientes]    Script Date: 26/06/2017 19:45:08 ******/




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[obtenerPacientes]
	-- Add the parameters for the stored procedure here
	@NUM_PAGINA   INT,
	@totalRegistros   INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @totalRegistro int;
	SET @totalRegistro=(select count(BD_SM.dbo.historialClinico.idPaciente) as totalRegistros from  BD_IP.dbo.paciente inner join BD_SM.dbo.historialClinico on BD_SM.dbo.historialClinico.idPaciente=paciente.id);
	SELECT @totalRegistro as registros, BD_SM.dbo.historialClinico.id, BD_SM.dbo.historialClinico.idPaciente, BD_IP.dbo.paciente.cedula,BD_IP.dbo.paciente.nombre1,BD_IP.dbo.paciente.nombre2,BD_IP.dbo.paciente.apellido1, BD_IP.dbo.paciente.apellido2 ,BD_IP.dbo.paciente.domicilio, BD_IP.dbo.paciente.email  from BD_IP.dbo.paciente inner join BD_SM.dbo.historialClinico on BD_SM.dbo.historialClinico.idPaciente=paciente.id order by id OFFSET (@NUM_PAGINA*@totalRegistros) ROWS FETCH FIRST @totalRegistros ROWS ONLY;
    -- Insert statements for procedure here
	/*WITH DRV_TBL AS 
   (
      SELECT 
         ROW_NUMBER() OVER (ORDER BY BD_SM.dbo.historialClinico.id asc) AS rownum
         , BD_SM.dbo.historialClinico.id, BD_SM.dbo.historialClinico.idPaciente, BD_IP.dbo.paciente.cedula,BD_IP.dbo.paciente.nombre1,BD_IP.dbo.paciente.nombre2,BD_IP.dbo.paciente.apellido1, BD_IP.dbo.paciente.apellido2 ,BD_IP.dbo.paciente.domicilio, BD_IP.dbo.paciente.email  from BD_IP.dbo.paciente inner join BD_SM.dbo.historialClinico on BD_SM.dbo.historialClinico.idPaciente=paciente.id)	

   SELECT @totalRegistro as registros, * FROM DRV_TBL 
   WHERE ROWNUM BETWEEN (@NUM_PAGINA*@totalRegistros)-@totalRegistros+1 AND (@NUM_PAGINA*@totalRegistros) */
END



/****** Object:  StoredProcedure [dbo].[obtenerPacientesBuscar]    Script Date: 26/06/2017 19:45:08 ******/




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[obtenerPacientesBuscar]
	-- Add the parameters for the stored procedure here
	@NUM_PAGINA   INT,
	@totalRegistros   INT,
	@buscar as nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @totalRegistro int;
	SET @totalRegistro=(select count(BD_SM.dbo.historialClinico.idPaciente) as totalRegistros from  BD_IP.dbo.paciente inner join BD_SM.dbo.historialClinico on BD_SM.dbo.historialClinico.idPaciente=paciente.id
	WHERE cedula like '%'+@buscar+'%' or nombre1 +' '+ nombre2 +' '+apellido1  +' ' +apellido2  like  '%'+@buscar+'%' or domicilio like '%'+@buscar+'%' or email like  '%'+@buscar+'%');
	SELECT @totalRegistro as registros, BD_SM.dbo.historialClinico.id, BD_SM.dbo.historialClinico.idPaciente, BD_IP.dbo.paciente.cedula,BD_IP.dbo.paciente.nombre1,BD_IP.dbo.paciente.nombre2,BD_IP.dbo.paciente.apellido1, BD_IP.dbo.paciente.apellido2 ,BD_IP.dbo.paciente.domicilio, BD_IP.dbo.paciente.email   from  BD_IP.dbo.paciente inner join
        BD_SM.dbo.historialClinico on BD_SM.dbo.historialClinico.idPaciente=paciente.id WHERE cedula like '%'+@buscar+'%' or nombre1 +' '+ nombre2 +' '+apellido1  +' ' +apellido2 COLLATE Latin1_General_CI_AI like  '%'+@buscar+'%' COLLATE Latin1_General_CI_AI or domicilio like '%'+@buscar+'%'  order by id OFFSET (@NUM_PAGINA*@totalRegistros) ROWS FETCH FIRST @totalRegistros ROWS ONLY;
    -- Insert statements for procedure here
	/*WITH DRV_TBL AS 
   (
      SELECT top 20
         ROW_NUMBER() OVER (ORDER BY BD_SM.dbo.historialClinico.idPaciente asc) AS rownum
         , BD_SM.dbo.historialClinico.id, BD_SM.dbo.historialClinico.idPaciente, BD_IP.dbo.paciente.cedula,BD_IP.dbo.paciente.nombre1,BD_IP.dbo.paciente.nombre2,BD_IP.dbo.paciente.apellido1, BD_IP.dbo.paciente.apellido2 ,BD_IP.dbo.paciente.domicilio, BD_IP.dbo.paciente.email   from  BD_IP.dbo.paciente inner join
        BD_SM.dbo.historialClinico on BD_SM.dbo.historialClinico.idPaciente=paciente.id WHERE cedula like '%'+@buscar+'%' or nombre1 +' '+ nombre2 +' '+apellido1  +' ' +apellido2  like  '%'+@buscar+'%' or domicilio like '%'+@buscar+'%' or email like  '%'+@buscar+'%')

   SELECT @totalRegistro as registros,* FROM DRV_TBL 
   WHERE ROWNUM BETWEEN (@NUM_PAGINA*@totalRegistros)-@totalRegistros+1 AND (@NUM_PAGINA*@totalRegistros) */
END



/****** Object:  StoredProcedure [dbo].[UpdateIngresos]    Script Date: 26/06/2017 19:45:08 ******/




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateIngresos] 
	-- Add the parameters for the stored procedure here
	@idIngreso as int,
	@fechaIngreso date,
	@idTipoIngreso as int,
	@idEspecialidadEgreso as int,
	@fechaEntrada as date,
	@fechaSalida as date,
	@hora as time(7),
	@sos as bit,
	@condicionEgreso as bit,
	@definitivoEgreso as text,
	@secundarioEgreso as text,
	@secundarioEgreso2 as text,
	@causaExterna as text,
	@codigoDiagnosticoDefinitivo as nvarchar(10),
	@idCaso as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	update caso set fecha=@fechaIngreso where id=@idCaso
	UPDATE ingresos set idEspecialidadEgreso=@idEspecialidadEgreso, fechaEntrada=@fechaEntrada, fechaSalida=@fechaSalida, hora=@hora, condicionEgreso=@condicionEgreso,
	definitivoEgreso=@definitivoEgreso, secundarioEgreso=@secundarioEgreso, secundarioEgreso2=@secundarioEgreso2, causaExterna=@causaExterna,codigoDiagnosticoDefinitivo=@codigoDiagnosticoDefinitivo where id= @idIngreso
	update detalleIngresos set fecha=@fechaIngreso,  hora=@hora where idIngreso=@idIngreso 	
END



