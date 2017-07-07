/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  Deivi
 * Created: 06-jul-2017
 */
USE [BD_SM]
GO
/****** Object:  UserDefinedFunction [dbo].[obtenerDatos]    Script Date: 04/07/2017 19:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[obtenerDatos](@idParroquia int)
RETURNS TABLE
AS
RETURN 
(
	SELECT        BD_IP.dbo.provincia.descripcion as provincia, BD_IP.dbo.canton.descripcion AS canton, BD_IP.dbo.parroquia.descripcion AS parroquia
	FROM            BD_IP.dbo.canton INNER JOIN
	                BD_IP.dbo.parroquia ON canton.id = BD_IP.dbo.parroquia.idCanton INNER JOIN
					BD_IP.dbo.provincia ON canton.idProvincia = BD_IP.dbo.provincia.id where BD_IP.dbo.parroquia.id=@idParroquia

) 

GO

