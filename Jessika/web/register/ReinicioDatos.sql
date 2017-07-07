/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  Deivi
 * Created: 06-jul-2017
 */

use BD_IP
delete from obstetricos
DBCC CHECKIDENT(obstetricos, RESEED, 0)
delete from paciente
DBCC CHECKIDENT(paciente, RESEED, 0)
use BD_SM
delete from detalleIngresos
DBCC CHECKIDENT(detalleIngresos, RESEED, 0)
DELETE from ingresos
DBCC CHECKIDENT(ingresos, RESEED, 0)
delete from caso
DBCC CHECKIDENT(caso, RESEED, 0)
delete from historialClinico
DBCC CHECKIDENT(historialClinico, RESEED, 0)