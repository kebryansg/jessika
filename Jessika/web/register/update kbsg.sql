alter TABLE dbo.paciente drop COLUMN sexo
alter TABLE dbo.paciente add sexo CHAR(1)


CREATE PROCEDURE savePaciente 	
@id int,
@cedula NCHAR(10),
@nombre1 NVARCHAR(50),
@nombre2 NVARCHAR(50),
@apellido1 NVARCHAR(50),
@apellido2 NVARCHAR(50),
@domicilio NVARCHAR(50),
@nacionalidad char(1),
@ciudad NVARCHAR(50),
@estadocivil CHAR(1),
@telDomicilio NVARCHAR(50),
@telOficina NVARCHAR(50),
@email NVARCHAR(50),
@sexo char(1),
@paisNac NVARCHAR(50),
@lugarNac NVARCHAR(50),
@fechaNac date,
@etnia int,
@discapacidad int,
@idParroquia int,
@nombreContacto NVARCHAR(300),
@parentezco CHAR(1),
@movilContacto CHAR(10),
@idOut int OUTPUT
AS
BEGIN
	IF @id = 0
	BEGIN
		INSERT INTO [dbo].[paciente]([cedula],[nombre1],[nombre2],[apellido1],[apellido2],[domicilio],[nacionalidad],[ciudad],[estadoCivil],
		[telefonoDomicilio],[telefonoOficina],[email],[sexo],[paisNacimiento],[lugarNacimiento],[fechaNacimiento],[etnia],[discapacidad],[idParroquia],[nombreContacto],[movilContacto],[parentezco])
		VALUES(@cedula,@nombre1,@nombre2,@apellido1,@apellido2,@domicilio,@nacionalidad,@ciudad,@estadocivil,@teldomicilio,@telOficina,@email,@sexo,@paisNac,@lugarNac,@fechaNac,@etnia,@discapacidad,@idParroquia,@nombreContacto,@movilContacto,@parentezco);
		set @idOut = (SELECT top 1 id from dbo.paciente ORDER by id DESC);
		INSERT INTO BD_SM.[dbo].[historialClinico]([idPaciente],[fecha],[menarca],[estado]) VALUES(@idOut,GETDATE(),GETDATE(),'1');
	END;
	ELSE
	BEGIN
		set @idOut = @id;
		UPDATE [dbo].[paciente] SET cedula = @cedula , nombre1 = @nombre1 , nombre2 = @nombre2 , apellido1 = @apellido1 , apellido2 = @apellido2 , domicilio = @domicilio , nacionalidad = @nacionalidad , ciudad = @ciudad , estadoCivil = @estadocivil , telefonoDomicilio = @teldomicilio , telefonoOficina = @telOficina , email = @email , sexo = @sexo , paisNacimiento = @paisNac , lugarNacimiento = @lugarNac , fechaNacimiento = @fechaNac , etnia = @etnia , discapacidad = @discapacidad ,  idParroquia = @idParroquia ,  nombreContacto = @nombreContacto ,  movilContacto = @movilContacto ,  parentezco = @parentezco where id = @id; 
	END; 
	
END 


