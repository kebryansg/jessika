/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  Deivi
 * Created: 09-jul-2017
 */
USE [BD_SM]
GO
/****** Object:  StoredProcedure [dbo].[obtenerIngresosMensuales]    Script Date: 07/07/2017 19:48:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[obtenerIngresosMensuales]
	-- Add the parameters for the stored procedure here
	@fecha as date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

--edad cumplida al ingreso

SELECT      Month(@fecha) as MesRecoleccion,  historialClinico.id as NHistoriaClinica, caso.id AS NoArchivo, BD_IP.dbo.paciente.cedula, BD_IP.dbo.paciente.nombre1,
			BD_IP.dbo.paciente.nombre2,BD_IP.dbo.paciente.apellido1,BD_IP.dbo.paciente.apellido2, Nacionalidad= CASE BD_IP.dbo.paciente.nacionalidad WHEN 'Ecuatoriano' THEN '1' ELSE '2' end, 
			Pais= CASE BD_IP.dbo.paciente.nacionalidad WHEN 1 THEN '' ELSE BD_IP.dbo.paciente.nacionalidad end ,BD_IP.dbo.paciente.sexo,  
			 YEAR(BD_IP.dbo.paciente.fechaNacimiento) as AñoNacimiento, MONTH(BD_IP.dbo.paciente.fechaNacimiento) as MesNacimiento, DAY(BD_IP.dbo.paciente.fechaNacimiento) as DiaNacimiento, 
			 case when 
			datediff(year, paciente.fechaNacimiento , getdate())>0 then 4
			when datediff(month, paciente.fechaNacimiento , getdate())>0 then 3
			when datediff(day, paciente.fechaNacimiento, getdate()) >0 then 2  
			else 1 end  as condicionEdad,DATEDIFF(year, fechaNacimiento,fechaEntrada) as EdadCunplidaAlIngreso,  BD_IP.dbo.paciente.etnia, BD_IP.dbo.paciente.discapacidad,  BD_IP.dbo.provincia.descripcion AS Provincia, BD_IP.dbo.canton.descripcion AS Canton, BD_IP.dbo.parroquia.descripcion AS Parroquia, 
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
