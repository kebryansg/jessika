USE [BD_SM]
GO
/****** Object:  StoredProcedure [dbo].[Insert_IngresosHospital]    Script Date: 20/06/2017 20:51:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[Insert_IngresosHospital]
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

