--tbTipoIdentificacion
CREATE OR ALTER PROCEDURE UDP_tbTipoIdentificacion_MostrarTodos
AS
BEGIN
	SELECT TiId_Id, TiId_Identificacion FROM [dbo].[tbTipoIdentificacion]
END;

GO
--tbTipoIdentificacion
----------------------------------------------------------------------------------------------------------------
--tbDirecciones
CREATE OR ALTER PROCEDURE UDP_tbDirecciones_MostrarTodos
AS
BEGIN
	SELECT Dire_Id, Dire_Calle, Dire_Numero, Dire_Comuna,T2.Muni_Municipios,T3.Dept_Departamento FROM [dbo].[tbDirecciones]  T1 INNER JOIN [dbo].[tbMunicipios] T2
	ON	T1.Muni_Id = T2.Muni_Id INNER JOIN [dbo].[tbDepartamentos] T3 ON T2.Dept_Id = T3.Dept_Id
END;
GO

--Procedimiento cargar municipios por id departamentos
CREATE OR ALTER PROCEDURE UDP_tbDirecciones_CargarMunicipios
	@Dept_Id	NVARCHAR(10)
AS
BEGIN
	SELECT Muni_Id, Muni_Municipios	FROM [dbo].[tbMunicipios] WHERE	Dept_Id = @Dept_Id
END;
go

CREATE OR ALTER PROCEDURE UDP_tbDirecciones_InsertarNuevoRegistros
	@Dire_Calle			NVARCHAR(255),
	@Dire_Numero		NVARCHAR(255),
	@Dire_Comuna		NVARCHAR(255),
	@Muni_Id			CHAR(4),
	@Usua_IdCreacion	NVARCHAR(10)
AS
BEGIN
	INSERT INTO [dbo].[tbDirecciones]([Dire_Calle],[Dire_Numero],[Dire_Comuna],[Muni_Id],[Usua_IdCreacion],[Dire_FechaCreacion],[Usua_IdModificacion],[Dire_FechaModificacion])
     VALUES (@Dire_Calle
             ,@Dire_Numero
             ,@Dire_Comuna
             ,@Muni_Id
             ,@Usua_IdCreacion
             ,GETDATE()
             ,NULL
             ,NULL)
END;
GO

--PROCEDIMIENTO CARGAR DATOS EDITAR
CREATE OR ALTER PROCEDURE UDP_tbDirecciones_CargarDatosEditar
	@Dire_Id		NVARCHAR(10)
AS
BEGIN
	SELECT Dire_Calle,Dire_Numero,Dire_Comuna, t1.Muni_Id, t2.Dept_Id FROM tbDirecciones t1 INNER JOIN tbMunicipios t2 ON t1.Muni_Id = t2.Muni_Id  WHERE Dire_Id = @Dire_Id 
END;
GO

--PROCEDIMIENTO OBTENER ID DEL DEPTO PARA BOTON EDITAR
CREATE OR ALTER PROCEDURE UPD_tbDirecciones_ObtenerDepartamentoId
	@Muni_Id		NVARCHAR(10)
AS
BEGIN
	SELECT Dept_Id, Dept_Departamento FROM tbDepartamentos
	WHERE Dept_Id = (SELECT Dept_Id FROM tbMunicipios where Muni_Id = @Muni_Id)
END;
go

--Procedimiento para editar una direccion
CREATE OR ALTER PROCEDURE UDP_tbDirecciones_EditarRegistro
	@Dire_Id				NVARCHAR(10),
	@Dire_Calle				NVARCHAR(255),
	@Dire_Numero			NVARCHAR(255),
	@Dire_Comuna			NVARCHAR(255),
	@Muni_Id				NVARCHAR(4),
	@Usua_IdModificacion	NVARCHAR(10)
AS
BEGIN
	UPDATE [dbo].[tbDirecciones]
   SET [Dire_Calle] = @Dire_Calle
      ,[Dire_Numero] = @Dire_Numero
      ,[Dire_Comuna] = @Dire_Comuna
      ,[Muni_Id] = @Muni_Id
      ,[Usua_IdModificacion] = @Usua_IdModificacion
      ,[Dire_FechaModificacion] = GETDATE()
 WHERE [Dire_Id] = @Dire_Id

END;
GO
CREATE OR ALTER PROCEDURE UDP_tbDirecciones_ValidarSiExisteRegistro
	@Dire_Calle		NVARCHAR(255),
	@Dire_Numero	NVARCHAR(255),
	@Dire_Comuna	NVARCHAR(255),
	@Muni_Id		NVARCHAR(10)
AS
BEGIN
	SELECT Dire_Id FROM tbDirecciones WHERE (Dire_Calle = @Dire_Calle AND Dire_Numero = @Dire_Numero AND [Dire_Comuna] = @Dire_Comuna AND [Muni_Id] = @Muni_Id)
END;
GO

--tbDirecciones
-----------------------------------------------------------------------
--tbEstadosCiviles

--Procedimiento Estado Civiles para mostrarlos todos
CREATE OR ALTER PROCEDURE UDP_tbEstadosCiviles_MostrarTodos
AS
BEGIN
	SELECT EsCi_Id,EsCi_EstadoCivil FROM [dbo].[tbEstadosCiviles]
END;

GO

--Procedimientos Estados Civiles para mostrar en ddl 
CREATE OR ALTER PROCEDURE UDP_DDLEstadoCivil
AS
BEGIN
	SELECT [EsCi_Id], [EsCi_EstadoCivil] FROM [dbo].[tbEstadosCiviles]
END
GO

--Procedimiento Estados Civiles agregar estado civil
CREATE OR ALTER PROCEDURE UDP_tbEstadoCiviles_AgregarEstadoCivil
	@EsCi_Id			CHAR(1),
	@EsCi_EstadoCivil	NVARCHAR(255),
	@Usua_IdCreacion	NVARCHAR(10)
AS
BEGIN
	INSERT INTO [dbo].[tbEstadosCiviles]
	VALUES(@EsCi_Id,@EsCi_EstadoCivil,@Usua_IdCreacion,GETDATE(),NULL,NULL)
END;
GO

--Procedimiento Estados Civiles cargarEstado civil por el id
CREATE OR ALTER PROCEDURE UDP_tbEstadosCiviles_CargarEstadoCivilPorId
	@EsCi_Id	CHAR(1)
AS
BEGIN
	SELECT EsCi_Id,EsCi_EstadoCivil FROM [dbo].[tbEstadosCiviles] WHERE EsCi_Id = @EsCi_Id
END;
GO

--Procedimiento Estados Civiles para actualizar registro
CREATE OR ALTER PROCEDURE UDP_tbEstadosCiviles_ActualizarEstadoCivil
	@EsCi_Id				CHAR(1),
	@EsCi_EstadoCivil		NVARCHAR(255),
	@Usua_IdModificacion	NVARCHAR(10)
AS
BEGIN
	UPDATE [dbo].[tbEstadosCiviles]
   SET [EsCi_EstadoCivil] = @EsCi_EstadoCivil
      ,[Usua_IdModificacion] = @Usua_IdModificacion
      ,[EsCi_FechaModificacion] = GETDATE()
 WHERE [EsCi_Id]  = @EsCi_Id
END;
GO


--Procedimiento Estados Civiles para validad que el estado civil ingresado exista
CREATE OR ALTER PROCEDURE UDP_tbEstadosCiviles_ValidarRegistro
	@EsCi_EstadoCivil	NVARCHAR(150)
AS
BEGIN
	SELECT EsCi_Id	FROM tbEstadosCiviles WHERE [EsCi_EstadoCivil] = @EsCi_EstadoCivil
END;

GO

--Procedimiento Estados Civiles para validar el boton de editar en el cual revisaremos si el valor ingresado existe ya en la BD
CREATE OR ALTER PROCEDURE UDP_tbEstadosCiviles_ValidarBtnEditar
	@EsCi_EstadoCivil		NVARCHAR(255)
AS
BEGIN
	SELECT EsCi_Id FROM tbEstadosCiviles WHERE		EsCi_EstadoCivil = @EsCi_EstadoCivil
END;
GO

--PROCEDIMIENTO Estados Civiles para verificar un registro identico
CREATE OR ALTER PROCEDURE UDP_tbEstadosCiviles_RegistroIdentico
	@EsCi_Id			NVARCHAR(1),
	@EsCi_EstadoCivil	NVARCHAR(150)
AS
BEGIN
		SELECT EsCi_Id FROM tbEstadosCiviles WHERE	EsCi_Id = @EsCi_Id AND EsCi_EstadoCivil = @EsCi_EstadoCivil
END;
GO

--PROCEDIMIENTO Estados Civiles para verificar si existe el codigo del estado Civil
CREATE OR ALTER PROCEDURE UDP_tbEstadosCiviles_CodigoEstadoIdentico
	@EsCi_Id			NVARCHAR(1)
AS
BEGIN
		SELECT EsCi_Id FROM tbEstadosCiviles WHERE	EsCi_Id = @EsCi_Id 
END;
GO
--tbEstadosCiviles
--------------------------------------------------------------------------
--tbDepartamento

--Procedimiento para mostrar Departamentos en un ddl
CREATE OR ALTER PROCEDURE UDP_tbDepartamentos_DDLDepartamentos
AS
BEGIN
	SELECT[Dept_Id] ,[Dept_Departamento]  FROM [dbo].[tbDepartamentos]
END
GO

--Procedimiento Cargar departamento para editar
CREATE OR ALTER PROCEDURE UDP_tbDepartamentos_CargarDepartamentosEditarPorId
(
	@Dept_Id AS CHAR(2)
)
AS
BEGIN
	SELECT [Dept_Id],[Dept_Departamento] FROM [dbo].[tbDepartamentos] WHERE [Dept_Id] = @Dept_Id 
END
GO

--DepartamentoEditar
CREATE OR ALTER PROCEDURE UDP_tbDepartamento_EditarDepartamento
    @Dept_Id			   INT,
    @Dept_Departamento     AS NVARCHAR(150),
	@Usua_IdModificacion   AS INT
AS
BEGIN
   UPDATE [dbo].[tbDepartamentos]
   SET [Dept_Departamento] = @Dept_Departamento
      ,[Usua_IdModificacion] =  @Usua_IdModificacion
      ,[Dept_FechaModificacion] = GETDATE()
 WHERE [Dept_Id] = @Dept_Id
END
GO

CREATE OR ALTER PROCEDURE UDP_tbDepartamentos_DepartamentosTodos
AS
BEGIN
    SELECT[Dept_Id] ,[Dept_Departamento]  FROM [dbo].[tbDepartamentos]
END
GO

--Insertar nuevo Departamento
CREATE OR ALTER PROCEDURE UDP_tbDepartamentos_InsertarNuevoDepartamento
(
	@Dept_Departamento  AS NVARCHAR(150),
	@Dept_Id		    AS INT,
	@Usua_IdCreacion	AS INT
)
AS
BEGIN
	DECLARE @IdDepto AS CHAR(2);
	SELECT @IdDepto = [Dept_Id] FROM [dbo].[tbDepartamentos] ORDER BY [Dept_Id] ASC
	DECLARE @NextNewIdDepto AS CHAR(2);
	SET @NextNewIdDepto = CONVERT(CHAR(2), CONVERT(INT, @IdDepto) + 1);

	INSERT INTO [dbo].[tbDepartamentos]
	VALUES(@NextNewIdDepto, @Dept_Departamento, @Usua_IdCreacion, GETDATE(), NULL, NULL)
END
GO


--Validar existe departamento
CREATE OR ALTER PROCEDURE UDP_tbDepartamento_ValidarDepartamentoExiste
(
	@Dept_Departamento AS NVARCHAR(150)
)
AS
BEGIN
	SELECT [Dept_Id] FROM [dbo].[tbDepartamentos] WHERE [Dept_Departamento] = @Dept_Departamento
END
GO

--Validar existe municipio en departamento
CREATE OR ALTER PROCEDURE UDP_tbMunicipios_ValidarMunicipioExisteEnDepartamento
(
	@Dept_Id	AS CHAR(2),
	@Muni_Municipios	AS NVARCHAR(150)
)
AS
BEGIN
	SELECT [Muni_Id] FROM [dbo].[tbMunicipios] WHERE [Dept_Id] = @Dept_Id AND [Muni_Municipios] = @Muni_Municipios
END
GO

--Procedimiento Listar Departamento por id
CREATE OR ALTER PROCEDURE UDP_tbDepartamentos_ListarDepartamentosPorId
	@Dept_Id	NVARCHAR(10)
AS
BEGIN
	SELECT Dept_Id,Dept_Departamento FROM [dbo].[tbDepartamentos] WHERE Dept_Id = @Dept_Id
END;

GO

--tbDepartamento
-----------------------------------------------------------------
--tbMunicipios

--Procedimiento Cargar DDL municipio por medio del id del departamento
 CREATE OR ALTER PROCEDURE UDP_tbMunicipios_DDLMunicipiosPorIdDeDepartamento
 (
	@Dept_Id      AS VARCHAR(2)
 )
 AS
 BEGIN
    SELECT[Muni_Id],[Muni_Municipios] FROM [dbo].[tbMunicipios] WHERE [Dept_Id] = @Dept_Id
 END
 GO

--Procedimiento Buscar Municipio por id
 CREATE OR ALTER PROCEDURE UDP_tbMunicipio_BuscarMunicipioPorId
 (
	@Muni_Id CHAR(4)
 )
 AS
 BEGIN
	SELECT [muni_Municipios] FROM [dbo].[tbMunicipios] WHERE [Muni_Id] = @Muni_Id
 END
 GO

 
--Procedimiento insertar nuevo municipio
CREATE OR ALTER PROCEDURE UDP_tbMunicipios_InsertarNuevoMunicipio
(
	@Dept_Id AS CHAR(2),
	@Muni_Municipios AS NVARCHAR(150),
	@Usua_IdCreacion AS INT
)
AS
BEGIN
	DECLARE @NextNewIdMuni AS CHAR(4), @IdMunicipio AS CHAR(4)
	SET @IdMunicipio = '';

	SELECT TOP 1 @IdMunicipio = [Muni_Id] FROM [dbo].[tbMunicipios] WHERE [Dept_Id] = @Dept_Id ORDER BY [Muni_Id] DESC 

	IF @IdMunicipio = '' OR @IdMunicipio = null
	BEGIN
		SET @NextNewIdMuni = @Dept_Id + '01'
	END
	ELSE
	BEGIN
		IF @IdMunicipio LIKE '0%'
		BEGIN
			SET @NextNewIdMuni = '0'+ CONVERT(CHAR(4), CONVERT(INT, @IdMunicipio) + 1)
		END
		ELSE
		BEGIN
			SET @NextNewIdMuni = CONVERT(CHAR(4), CONVERT(INT, @IdMunicipio) + 1)
		END
	END

	INSERT INTO [dbo].[tbMunicipios]
	VALUES(@NextNewIdMuni, @Muni_Municipios,@Dept_Id, @Usua_IdCreacion, GETDATE(), null, null);
END
GO

--Procedimiento Mostrar todos los municipiios tabla
CREATE OR ALTER PROCEDURE UDP_tbMunicipios_MunicipiosTodos
AS
BEGIN
    SELECT [Muni_Id],[Muni_Municipios],t2.Dept_Departamento  FROM [dbo].[tbMunicipios] t1 INNER JOIN [dbo].[tbDepartamentos] t2
	ON	t1.Dept_Id = t2.Dept_Id
END
GO


--Procedimiento editar Municipio
CREATE OR ALTER PROCEDURE UDP_tbMunicipios_EditarMunicipios
    @Muni_Id					AS NVARCHAR(10),
	@Dept_Id					AS NVARCHAR(10),	
    @Muni_Municipios			AS NVARCHAR(150),
	@Usua_IdModificacion		AS INT
AS
BEGIN
   UPDATE [dbo].[tbMunicipios]
   SET [Muni_Municipios] = @Muni_Municipios
      ,[Dept_Id] = @Dept_Id
      ,[Usua_IdModificacion] = @Usua_IdModificacion 
      ,[Muni_FechaModificacion] = GETDATE()
 WHERE [Muni_Id] = @Muni_Id
END
GO

--Procediminento para cargar datos al darle editar
CREATE OR ALTER PROCEDURE UDP_tbMunicipios_CargarDatosEditarPorIdMunicipio
	@Muni_Id		NVARCHAR(10)
AS
BEGIN
	SELECT Muni_Id,Muni_Municipios,Dept_Id FROM tbMunicipios WHERE Muni_Id = @Muni_Id
END;
GO

--Procedimientos 
CREATE OR ALTER PROCEDURE UDP_tbMunicipios_ValidarSiExisteMunicipioEnDepto
	@Dept_Id			NVARCHAR(2),
	@Muni_Municipios	NVARCHAR(255)
AS
BEGIN
	SELECT Muni_Id FROM tbMunicipios WHERE	Dept_Id = @Dept_Id  AND Muni_Municipios = @Muni_Municipios
END;
GO

--Procedimientos 
CREATE OR ALTER PROCEDURE UDP_tbMunicipios_ValidarSiExisteMunicipioEnDeptoEditar
	@Dept_Id			NVARCHAR(2),
	@Muni_Municipios	NVARCHAR(255)
AS
BEGIN
	SELECT Dept_Id FROM tbMunicipios WHERE	Dept_Id = @Dept_Id  AND Muni_Municipios = @Muni_Municipios
END;
GO

--tbMunicipios
----------------------------------------------------------------
--tbEmpleados

CREATE OR ALTER PROCEDURE UDP_tbEmpleados_EmpleadosExiste
	@Empl_DNI	NVARCHAR(100)
AS
BEGIN
	SELECT Empl_DNI FROM tbEmpleados WHERE Empl_DNI = @Empl_DNI
END;
GO


CREATE OR ALTER PROCEDURE UDP_tbEmpleados_ObtenerDireccionId
	@Dire_Id	NVARCHAR(10)
AS
BEGIN
SELECT Muni_Id, Muni_Municipios FROM tbMunicipios
	WHERE Muni_Id = (SELECT Muni_Id FROM tbDirecciones where Dire_Id = @Dire_Id)
END;

GO

--Procedimiento insertar nuevo empleados tbEmpleados
 CREATE OR ALTER PROCEDURE UDP_tbEmpleados_InsertarNuevoEmpleado
(
	@Empl_DNI					AS VARCHAR(13),
	@Empl_Nombre				AS NVARCHAR(150),
	@Empl_Apellidos				AS NVARCHAR(150),
	@Empl_Sexo					AS CHAR(1),
	@EsCi_Id					AS CHAR(1),
	@Dire_Id					AS NVARCHAR(10),
	@Empl_FechaNacimientO		AS VARCHAR(25),
	@Empl_Telefono				AS NVARCHAR(9),
	@Empl_CorreoEletronico		AS VARCHAR(200),
	@Usua_IdCreacion			AS NVARCHAR(10)
)
AS
BEGIN
	INSERT INTO [dbo].[tbEmpleados]
	VALUES(@Empl_DNI, @Empl_Nombre, @Empl_Apellidos, @Empl_Sexo, @EsCi_Id,@Dire_Id, @Empl_FechaNacimientO, @Empl_Telefono, @Empl_CorreoEletronico, 1 ,@Usua_IdCreacion, GETDATE(), null, null);
END
GO

 CREATE OR ALTER PROCEDURE UDP_tbEmpleados_InsertarNuevoEmpleado2
(
	@Empl_DNI					AS VARCHAR(13),
	@Empl_Nombre				AS NVARCHAR(150),
	@Empl_Apellidos				AS NVARCHAR(150),
	@Empl_Sexo					AS CHAR(1),
	@EsCi_Id					AS CHAR(1),
	@Dire_Id					AS NVARCHAR(10),
	@Empl_FechaNacimientO		AS VARCHAR(25),
	@Empl_Telefono				AS NVARCHAR(9),
	@Empl_CorreoEletronico		AS VARCHAR(200),
	@Usua_IdCreacion			AS NVARCHAR(10)
)
AS
BEGIN
	INSERT INTO [dbo].[tbEmpleados]
	VALUES(@Empl_DNI, @Empl_Nombre, @Empl_Apellidos, @Empl_Sexo, @EsCi_Id,@Dire_Id, @Empl_FechaNacimientO, @Empl_Telefono, @Empl_CorreoEletronico, 1 ,@Usua_IdCreacion, GETDATE(), null, null);
END

GO
CREATE OR ALTER PROCEDURE UDP_tbEmpleados_FiltrarDireccionPorMunicipio
	@Muni_Id	NVARCHAR(10)
AS
BEGIN
	SELECT Dire_Id, Dire_Calle,Dire_Numero, Dire_Comuna  FROM tbDirecciones WHERE Muni_Id = @Muni_Id
END;
GO
--Procedimiento buscar empleado por id
CREATE OR ALTER PROCEDURE UDP_tbEmpleados_BuscarEmpleadosPorId
(
	@Empl_DNI AS VARCHAR(13)
)
AS
BEGIN
	SELECT [Empl_Id] FROM [dbo].[tbEmpleados] WHERE [Empl_Estado] = 1 AND [Empl_Id] = @Empl_DNI
END
GO

--Procedimiento Mostrar todos los empleados
CREATE OR ALTER PROCEDURE UDP_tbEmpleados_EmpleadosMostrarTodos
AS
BEGIN
		  SELECT	[Empl_Id], 
					[Empl_DNI], 
					[Empl_Nombre],
					[Empl_Apellidos],
					T2.EsCi_EstadoCivil,
					T3.Dire_Calle,
					T3.Dire_Numero,
					T3.Dire_Comuna,
					T4.Muni_Municipios,
					T5.Dept_Departamento,
					[Empl_Sexo],		             		 		 
					[Empl_FechaNacimiento],
					[Empl_CorreoEletronico] 
		   FROM   tbEmpleados T1 INNER JOIN tbEstadosCiviles T2
		   ON     T1.[EsCi_Id] = T2.[EsCi_Id] INNER JOIN [dbo].[tbDirecciones] T3
		   ON     T1.[Dire_Id] = T3.[Dire_Id] INNER JOIN [dbo].[tbMunicipios] T4
		   ON	  T3.Muni_Id = T4.Muni_Id INNER JOIN [dbo].[tbDepartamentos] T5
		   ON	  T4.Dept_Id = T5.Dept_Id
	       WHERE  T1.[Empl_Estado] = 1
END
GO

CREATE OR ALTER PROCEDURE UDP_tbEmpleados_CargarSexoEmpleado
	@Empl_Id	NVARCHAR(10)
AS
BEGIN
	SELECT Empl_Sexo FROM tbEmpleados WHERE	Empl_Id = @Empl_Id
END;
GO


--Procedimiento CargarDatos de empleados para editarlos
CREATE OR ALTER PROCEDURE UDP_tbEmpleados_CargarDatosEditarEmpleados
(
	@Empl_Id AS INT
)
AS
BEGIN
	SELECT	[Empl_DNI], 
			[Empl_Nombre], 
			[Empl_Apellidos], 
			[Empl_Sexo], 
			[EsCi_Id], 
			[Empl_FechaNacimiento], 
			tb1.Dire_Id,
			tb3.[Dept_Id], 
			[Empl_Telefono], 
			[Empl_CorreoEletronico]
	FROM [dbo].[tbEmpleados] tb1
	INNER JOIN [dbo].[tbDirecciones]tb2
	ON tb1.Dire_Id = tb2.Dire_Id
	INNER JOIN [dbo].[tbMunicipios] tb3
	ON	tb2.Muni_Id = tb3.Muni_Id 
	INNER JOIN [dbo].[tbDepartamentos] tb4
	ON	tb3.Dept_Id = tb4.Dept_Id
	WHERE [Empl_Id] = @Empl_Id
END
GO

--Procedimiento Actualizar Datos
CREATE OR ALTER PROCEDURE UDP_tbEmpleados_ActualizarEmpleado
(
	@Empl_Id					AS INT,
	@Empl_DNI					AS VARCHAR(13),
	@Empl_Nombre				AS NVARCHAR(150),
	@Empl_Apellidos				AS NVARCHAR(150),
	@Empl_Sexo					AS CHAR(1),
	@EsCi_Id					AS CHAR(1),
	@Empl_FechaNacimiento		AS DATE,
	@Dire_Id					AS NVARCHAR(200),
	@Empl_Telefono				AS VARCHAR(14),
	@Empl_CorreoEletronico		AS NVARCHAR(100),
	@Usua_IdModificacion		AS INT
)
AS
BEGIN
UPDATE	[dbo].[tbEmpleados]
	SET  [Empl_DNI]= @Empl_DNI,
		 [Empl_Nombre]= @Empl_Nombre,
		 [Empl_Apellidos]= @Empl_Apellidos,
		 [Empl_Sexo]= @Empl_Sexo,
		 [EsCi_Id]= @EsCi_Id,
		 [Empl_FechaNacimiento]= @Empl_FechaNacimiento,
		 [Dire_Id]= @Dire_Id,
		 [Empl_Telefono]= @Empl_Telefono,
		 [Empl_CorreoEletronico]= @Empl_CorreoEletronico,
		[Usua_IdModificacion] = @Usua_IdModificacion,
		[Empl_FechaModificacion] = GETDATE()
WHERE	[Empl_Id] = @Empl_Id
END
GO


--Procedimiento Eliminar Empleados
CREATE OR ALTER PROCEDURE UDP_tbEmpleados_DeleteEmpleados
(
	@Empl_Id			AS INT,
	@Usua_IdModificacion AS INT
)
AS
BEGIN
	UPDATE [dbo].[tbEmpleados]
	SET [Empl_Estado] = 0,
		[Usua_IdModificacion] = @Usua_IdModificacion,
		[Empl_FechaModificacion] = GETDATE()
	WHERE [Empl_Id] = @Empl_Id
END
GO

CREATE OR ALTER PROCEDURE UDP_tbEmpleados_Eliminar
	@Empl_Id	NVARCHAR(10)
AS
BEGIN
	SELECT Empl_Id,Empl_DNI,Empl_Nombre, Empl_Apellidos, Empl_Sexo, Empl_Telefono, Empl_CorreoEletronico, Empl_FechaNacimiento FROM tbEmpleados WHERE Empl_Id = @Empl_Id
END;

GO
--tbEmpleados
------------------------------------------------------------
--tbUsuarios

CREATE OR ALTER PROCEDURE UDP_tbUsuarios_DDLEmpleadosTieneUsuario
AS
BEGIN
select t2.Empl_Id,t2.Empl_Nombre, t2.Empl_Apellidos from tbUsuarios t1 full join tbEmpleados t2  on t1.Empl_Id = t2.Empl_Id where t1.Usua_Id is null
END;
GO

--Procedimiento para mostrar todos los usuarios en tablas
CREATE OR ALTER PROCEDURE UDP_tbUsuarios_UsuariosMostrarTodos
AS
BEGIN
     SELECT [Usua_Id],
			[Empl_Nombre],
			[Usua_Nombre] ,
	 CASE	[Usua_EsAdmin]
	 WHEN '1' THEN 'Si'
	 WHEN '0' THEN 'No'
	 END AS [usu_EsAdmin]
	 FROM [dbo].[tbUsuarios] tb1 INNER JOIN [dbo].[tbEmpleados] tb2 
	 ON tb1.Empl_Id = tb2.Empl_Id
	 WHERE [Usua_Estado] = 1
END
GO

--Procedimiento crear usuarios apartir de empleados
CREATE OR ALTER PROCEDURE UDP_tbEmpleados_DDLEmpleadosCrearUsuarios
    @DDL       AS BIT
AS 
BEGIN

    IF @DDL = 1
	BEGIN 
	SELECT [Empl_Id],[Empl_Nombre] FROM [dbo].[tbEmpleados] WHERE [Empl_Id] NOT IN (SELECT [Empl_Id] FROM [dbo].[tbUsuarios])
	END
    ELSE
	BEGIN
	SELECT [Empl_Id],[Empl_Nombre] FROM [dbo].[tbEmpleados] WHERE [Empl_Estado] = 1;
	END
END
GO

--Procedimiento insertar nuevo usuario
CREATE OR ALTER PROCEDURE UDP_tbUsuarios_InsertarNuevoUsuario
(
	 @Empl_Id			AS NVARCHAR(10),
	 @Usua_Nombre		AS NVARCHAR(150),
	 @Usua_Clave        AS NVARCHAR(150),
	 @Usua_EsAdmin      AS CHAR(1),
	 @Usua_IdCreacion   AS NVARCHAR(10)
)
AS
BEGIN
     DECLARE @Pass AS NVARCHAR(MAX);
	 SET @Pass = CONVERT(NVARCHAR(MAX), HASHBYTES('sha2_512', @Usua_Clave), 2);
     INSERT INTO [dbo].[tbUsuarios]
	 VALUES (@Empl_Id, @Usua_Nombre, @Pass,@Usua_EsAdmin , 1, @Usua_IdCreacion, GETDATE(), NULL, NULL)
END
GO

--Procedimiento para cargar los datos para editar los usuarios
CREATE OR ALTER PROCEDURE UDP_tbUsuarios_CargarDatosEditarUsuarios
(
   @Usua_Id AS INT
)
AS
BEGIN 
   SELECT tb1.[Empl_Id],
          [Usua_Nombre],
          [Usua_Clave],
          [Usua_EsAdmin]
	FROM [dbo].[tbUsuarios] tb1 INNER JOIN [dbo].[tbEmpleados] tb2
	ON tb1.[Empl_Id] = tb2.[Empl_Id]
	WHERE  [Usua_Id]= @Usua_Id
END
GO

--Procedimientos para actualizar los usuarios
CREATE OR ALTER PROCEDURE UDP_tbUsuarios_ActualizarUsuario
       @Usua_Id               AS NVARCHAR(10),
       @Usua_Nombre			  AS NVARCHAR(150),
	   @Usua_EsAdmin          AS NVARCHAR(10),
	   @Usua_IdModificacion   AS NVARCHAR(10)
AS
BEGIN  
         UPDATE [dbo].[tbUsuarios]
	     SET   [Usua_Nombre] = @Usua_Nombre,
		       [Usua_EsAdmin] = @Usua_EsAdmin,
               [Usua_IdModificacion] = @Usua_IdModificacion,
               [Usua_FechaModificacion] = GETDATE()
		 WHERE [Usua_Id] =  @Usua_Id
END
GO

CREATE OR ALTER PROCEDURE UDP_tbUsuario_CargarDatosEditar_Eliminar_Detalles
	@Usua_Id	NVARCHAR(10)
AS
BEGIN
	SELECT Usua_Id, Usua_Nombre, Usua_EsAdmin,t2.Empl_Nombre FROM tbUsuarios t1 INNER JOIN tbEmpleados t2 ON t1.Empl_Id = t2.Empl_Id WHERE t1.Usua_Id = @Usua_Id 
END;

GO
---Procedimiento para eliminar un usuario
CREATE OR ALTER PROCEDURE UDP_tbUsuarios_DeleteUsuarios
(
	@Usua_Id AS INT,
	@Usua_FechaModificacion AS INT
)
AS
BEGIN
	UPDATE [dbo].[tbUsuarios]
	SET [Usua_Estado] = 0,
		[Usua_IdModificacion] = @Usua_FechaModificacion,
		[Usua_FechaModificacion] = GETDATE()
	WHERE [Usua_Id] = @Usua_Id
END
GO

--tbUsuarios
--------------------------------------------------------------------
--tbProveedores

--Procedimiento Mostrar todos los proveedores en la tabla
CREATE OR ALTER PROCEDURE UDP_tbProveedores_MostrarTodosProveedores
AS
BEGIN
		  SELECT  [Prov_Id],
		          [Prov_Rut],
                  [Prov_Nombre],
                  t2.Dire_Calle,
				  t2.Dire_Numero,
				  t2.Dire_Comuna,
				  T3.Muni_Municipios,
				  T4.Dept_Departamento,
				  [Prov_Telefono],
                  [Prov_PaginaWeb] 
		   FROM	  [dbo].[tbProveedores] t1 INNER JOIN  [dbo].[tbDirecciones] t2
		   ON	  t1.Dire_Id = t2.Dire_Id INNER JOIN [dbo].[tbMunicipios] T3
		   ON	  t2.Muni_Id = T3.Muni_Id INNER JOIN [dbo].[tbDepartamentos] T4
		   ON	  T3.Dept_Id = T4.Dept_Id
	       WHERE  [Prov_Estado] = 1
END
GO

 --Procedimiento Insertar nuevo proveedor
 CREATE OR ALTER PROCEDURE UDP_tbProveedores_InsertarNuevoProveedores
(
	@Prov_Rut			AS VARCHAR(14),
	@Prov_Nombre		AS NVARCHAR(150),
	@Dire_Id			AS NVARCHAR(10),
	@Prov_Telefono		AS NVARCHAR(9),
	@Prov_PaginaWeb		AS VARCHAR(150),
	@Usua_IdCreacion	INT
)
AS
BEGIN
	INSERT INTO [dbo].[tbProveedores]
	VALUES(@Prov_Rut, @Prov_Nombre,@Dire_Id,@Prov_Telefono,@Prov_PaginaWeb , 1 ,@Usua_IdCreacion, GETDATE(), NULL, NULL);
END
GO

--Procedimiento buscar proveedor por RUT
CREATE OR ALTER PROCEDURE UDP_tbProveedores_buscarProveedorPorRUT
(
	@Prov_Rut AS VARCHAR(14)
)
AS
BEGIN
	SELECT [Prov_Rut] FROM [dbo].[tbProveedores] WHERE [Prov_Estado] = 1 AND [Prov_Rut] = @Prov_Rut
END
GO

--Procedimiento Cargar datos editar para editar Proveedor
CREATE OR ALTER PROCEDURE UDP_tbProveedores_CargarDatosEditarProveedor
(
	@Prov_Id AS INT
)
AS
BEGIN
	SELECT	[Prov_Rut], 
			[Prov_Nombre], 
			[Dire_Id], 
			[Prov_Telefono],
			[Prov_PaginaWeb]
	FROM [dbo].[tbProveedores]
	WHERE [Prov_Id] = @Prov_Id
END
GO

--Procedimiento Actualizar proveedor 
CREATE OR ALTER PROCEDURE UDP_tbProveedores_ActualizarProveedor
(
	@Prov_Id				AS INT,
	@Prov_Rut				AS VARCHAR(13),
	@Prov_Nombre			AS NVARCHAR(150),	
	@Dire_Id				AS NVARCHAR(10),
	@Prov_Telefono			AS VARCHAR(9),
	@Prov_PaginaWeb			AS NVARCHAR(150),
	@Usua_IdModificacion	AS INT
)
AS
BEGIN
UPDATE	[dbo].[tbProveedores]
	SET [Prov_Rut] = @Prov_Rut,
		[Prov_Nombre] = @Prov_Nombre,		
		[Dire_Id] = @Dire_Id,
		[Prov_Telefono] = @Prov_Telefono,
		[Prov_PaginaWeb] = @Prov_PaginaWeb,
		[Usua_IdModificacion] = @Usua_IdModificacion,
		[Prov_FechaModificacion] = GETDATE()
WHERE	[Prov_Id] = @Prov_Id
END
GO

--Procedimiento Eliminar Proveedor
CREATE OR ALTER PROCEDURE UDP_tbProveedores_DeleteProveedores
(
	@Prov_Id				AS INT,
	@Usua_IdModificacion    AS INT
)
AS
BEGIN
	UPDATE [dbo].[tbProveedores]
	SET   [Prov_Estado] = 0,
		  [Usua_IdModificacion] = @Usua_IdModificacion,
		  [Prov_FechaModificacion] = GETDATE()
	WHERE [Prov_Id] = @Prov_Id
END
GO

--tbProveedores