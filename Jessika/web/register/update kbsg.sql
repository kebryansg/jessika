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