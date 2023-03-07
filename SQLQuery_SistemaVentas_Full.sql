/**********************************CREATE DATABASE**********************************/

USE master
GO

/*
DROP DATABASE DB_SistemaVentas
*/

CREATE DATABASE DB_SistemaVentas
GO

USE DB_SistemaVentas
GO

--TABLA DEPARTAMENTOS
CREATE TABLE tbDepartamentos(
	 Dept_Id					CHAR(2) NOT NULL,
	 Dept_Departamento          NVARCHAR(150) NOT NULL,
 	 Usua_IdCreacion		    INT NOT NULL,
	 Dept_FechaCreacion         DATETIME NOT NULL,
	 Usua_IdModificacion		INT,
	 Dept_FechaModificacion		DATETIME
	 CONSTRAINT PK_tbDepartamento_Dept_Id PRIMARY KEY (Dept_Id)
);
GO

--TABLA MUNICIPIOS
CREATE TABLE tbMunicipios(
    Muni_Id							CHAR(4) NOT NULL,
	Muni_Municipios					NVARCHAR(150)NOT NULL,
	Dept_Id							CHAR(2),
	Usua_IdCreacion					INT NOT NULL,
	Muni_FechaCreacion				DATETIME NOT NULL,
	Usua_IdModificacion				INT,
    Muni_FechaModificacion			DATETIME
	CONSTRAINT PK_tbMunicipios_Muni_Id PRIMARY KEY (Muni_Id),
	CONSTRAINT FK_tbMunicipios_Dept_Id_tbDepartamentos_Dept_Id FOREIGN KEY (Dept_Id) REFERENCES tbDepartamentos(Dept_Id)
);
GO

--TABLA DIRECCIONES
CREATE TABLE tbDirecciones(
	Dire_Id					INT IDENTITY(1,1),
	Dire_Calle				NVARCHAR(255) NOT NULL,
	Dire_Numero				NVARCHAR(255) NOT NULL,
	Dire_Comuna				NVARCHAR(255) NOT NULL,
	Muni_Id					CHAR(4) NOT NULL,
	Usua_IdCreacion			INT NOT NULL,
	Dire_FechaCreacion		DATETIME NOT NULL,
	Usua_IdModificacion		INT,
	Dire_FechaModificacion	DATETIME
	CONSTRAINT PK_tbDirecciones_Dire_Id PRIMARY KEY(Dire_Id),
	CONSTRAINT FK_tbDirecciones_Muni_Id_tbMunicipios_Muni_Id FOREIGN KEY(Muni_Id) REFERENCES tbMunicipios(Muni_Id)
);
GO

--TABLA TIPO IDENTIFICACION
CREATE TABLE tbTipoIdentificacion (
    TiId_Id					INT IDENTITY(1,1),
	TiId_Identificacion     NVARCHAR(150) NOT NULL,
	Usua_IdCreacion			INT NOT NULL,
	TiId_FechaCreacion      DATETIME NOT NULL,
	Usua_IdModificacion		INT,
	TiId_FechaModificacion  DATETIME
	CONSTRAINT PK_tbTipoIdentificacion_TiId_Id PRIMARY KEY (TiId_Id)
);
GO

--TABLA ESTADOS CIVILES
CREATE TABLE tbEstadosCiviles(
	EsCi_Id					CHAR(1)NOT NULL,
	EsCi_EstadoCivil		NVARCHAR(150) NOT NULL,
	Usua_IdCreacion			INT NOT NULL,
	EsCi_FechaCreacion		DATETIME NOT NULL,
	Usua_IdModificacion		INT,
	EsCi_FechaModificacion	DATETIME,
	CONSTRAINT PK_tbEstadosCiviles_EsCi_Id PRIMARY KEY(EsCi_Id)
);
GO

--TABLA EMPLEADOS
CREATE TABLE tbEmpleados(
	Empl_Id					INT IDENTITY(1,1),
	Empl_DNI				VARCHAR(13) NOT NULL,
	Empl_Nombre				NVARCHAR(255)NOT NULl,
	Empl_Apellidos			NVARCHAR(255) NOT NULL,
	Empl_Sexo				CHAR(1) NOT NULL,
	EsCi_Id					CHAR(1) NOT NULL,
	Dire_Id					INT	NOT NULL,
	Empl_FechaNacimiento	DATE NOT NULL,
	Empl_Telefono			NVARCHAR(9)NOT NULL,
	Empl_CorreoEletronico	NVARCHAR(255)NOT NULL,
	Empl_Estado				BIT NOT NULL,
	Usua_IdCreacion			INT NOT NULL,
	Empl_FechaCreacion		DATETIME NOT NULL,
	Usua_IdModificacion		INT,
	Empl_FechaModificacion	DATETIME
	CONSTRAINT PK_tbEmpleados_Empl_Id PRIMARY KEY(Empl_Id),
	CONSTRAINT FK_tbEmpleados_EsCi_Id_tbEstadosCiviles_EsCi_Id FOREIGN KEY(EsCi_Id) REFERENCES tbEstadosCiviles(EsCi_Id),
	CONSTRAINT FK_tbEmpleados_Dire_Id_tbDirecciones_Dire_Id FOREIGN KEY(Dire_Id) REFERENCES tbDirecciones(Dire_Id),
	CONSTRAINT CK_tbEmpleados_Empl_Sexo CHECK(Empl_Sexo IN('F','M'))
);
GO

--TABLA USUARIOS
CREATE TABLE tbUsuarios(
	Usua_Id					INT IDENTITY(1,1),
	Empl_Id					INT NOT NULL,
	Usua_Nombre				NVARCHAR(255)NOT NULL,
	Usua_Clave				NVARCHAR(MAX)NOT NULL,
	Usua_EsAdmin			BIT NOT NULL,
	Usua_Estado				BIT NOT NULL,
	Usua_IdCreacion			INT NOT NULL,
	Usua_FechaCreacion		DATETIME NOT NULL,
	Usua_IdModificacion		INT,
	Usua_FechaModificacion	DATETIME
	CONSTRAINT PK_tbUsuarios_Usua_Id PRIMARY KEY(Usua_Id),
	CONSTRAINT FK_tbUsuarios_Empl_Id_tbEmpleados_Empl_Id FOREIGN KEY(Empl_Id) REFERENCES tbEmpleados(Empl_Id)
);
GO

--TABLA PROVEEDOR
CREATE TABLE tbProveedores(
	Prov_Id					INT IDENTITY(1,1),
	Prov_Rut				VARCHAR(14) NOT NULL,
	Prov_Nombre				NVARCHAR(150) NOT NULL,
	Dire_Id					INT NOT NULL,
	Prov_Telefono			VARCHAR(9) NOT NULL,
	Prov_PaginaWeb			NVARCHAR(255) NOT NULL,
	Prov_Estado				BIT NOT NULL,
	Usua_IdCreacion			INT NOT NULL,
	Prov_FechaCreacion		DATETIME  NOT NULL,
	Usua_IdModificacion		INT,
	Prov_FechaModificacion	DATETIME
	CONSTRAINT PK_tbProveedores_Prov_Id PRIMARY KEY(Prov_Id),
	CONSTRAINT FK_tbProveedores_Dire_Id_tbDirecciones_Dire_Id FOREIGN KEY(Dire_Id) REFERENCES tbDirecciones(Dire_Id)
);
GO

--TABLA CLIENTES
CREATE TABLE tbClientes(
	Clie_Id					INT IDENTITY(1,1),
	TiId_Id					INT NOT NULL,
	Clie_Identificacion		VARCHAR(150) NOT NULL,
	Clie_Nombre				NVARCHAR(255)  NOT NULL,
	Dire_Id					INT NOT NULL,
	Clie_Telefono			NVARCHAR(9)NOT NULL,
	Clie_CorreoElectronico	NVARCHAR(255) NOT NULL,
	Clie_Estado				BIT NOT NULL,
	Usua_IdCreacion			INT NOT NULL,
	Clie_FechaCreacion		DATETIME NOT NULL,
	Usua_IdModificacion		INT,
	Clie_FechaModificacion	DATETIME
	CONSTRAINT PK_tbClientes_Clie_Id PRIMARY KEY(Clie_Id),
	CONSTRAINT FK_tbClientes_TiId_ID_tbTipoIdentificacion_TiId_ID FOREIGN KEY(TiId_ID) REFERENCES tbTipoIdentificacion(TiId_ID),
	CONSTRAINT FK_tbClientes_Dire_Id_tbDirecciones_Dire_Id FOREIGN KEY(Dire_Id) REFERENCES tbDirecciones(Dire_Id)
);
GO

/**********************************************************************************************/

--TABLA CATEGORÍAS
CREATE TABLE tbCategorias(
    Cate_Id					INT IDENTITY(1,1),
	Cate_Categoria          NVARCHAR(150) NOT NULL,
	Cate_Estado             BIT NOT NULL,
	Usua_IdCreacion			INT NOT NULL,
	Cate_FechaCreacion      DATETIME NOT NULL,
	Usua_IdModifiacion		INT,
	Cate_FechaModificacion  DATETIME
	CONSTRAINT PK_tbCategoria_Cate_Id PRIMARY KEY (Cate_Id)
);
GO

--TABLA PRODUCTOS
CREATE TABLE tbProductos(
    Prod_Id					INT IDENTITY(1,1),
	Prod_CodigoProducto		VARCHAR(15) NOT NULL,
	Prod_Descripcion        NVARCHAR(255) NOT NULL,
	Cate_Id					INT NOT NULL,
	Prov_Id					INT NOT NULL,
	Prod_Stock              INT NOT NULL,
	Prod_PrecioCompra       DECIMAL(18,2) NOT NULL,
	Prod_PrecioVenta        DECIMAL(18,2) NOT NULL,
	Prod_Estado             BIT NOT NULL,
	Usua_IdCreacion			INT NOT NULL,
	Prod_FechaCreacion      DATETIME NOT NULL,
	Usua_IdModificacion		INT,
	Prod_FechaModificacion  DATETIME
	CONSTRAINT PK_tbProductos_Prod_Id PRIMARY KEY (Prod_Id),
	CONSTRAINT FK_tbProductos_Cate_Id_tbCategorias_Cate_Id FOREIGN KEY (Cate_Id) REFERENCES tbCategorias(Cate_Id),
	CONSTRAINT FK_tbProductos_Prov_Id_tbProveedores_Prov_Id	FOREIGN KEY (Prov_Id) REFERENCES tbProveedores(Prov_Id)
);
GO

--TABLA COMPRAS
CREATE TABLE tbCompras(
   Comp_Id					INT IDENTITY(1,1),
   Prov_Id					INT NOT NULL,
   Comp_Fecha               DATE NOT NULL,
   Comp_Estado              BIT NOT NULL,
   Usua_IdCreacion			INT NOT NULL,
   Comp_FechaCreacion       DATETIME NOT NULL,
   Usua_IdModificacion		INT,
   Comp_FechaModificacion   DATETIME
   CONSTRAINT PK_tbCompras_Comp_Id PRIMARY KEY (Comp_Id),
   CONSTRAINT FK_tbCompras_Prov_Id_tbProveedores_Prov_Id FOREIGN KEY (Prov_Id) REFERENCES tbProveedores(Prov_Id)
);
GO

--TABLA DETALLES COMPRAS
CREATE TABLE tbDetallesCompras(
	DeCo_Id					INT IDENTITY(1,1),
	Comp_Id					INT NOT NULL,
	Prod_Id					INT NOT NULL,
	DeCo_Cantidad			INT NOT NULL,
	DeCo_PrecioCompra		DECIMAL(18,2) NOT NULL,
	DeCo_Estado				BIT NOT NULL,
	Usua_IdCreacion			INT NOT NULL,
	DeCo_FechaCreacion      DATETIME NOT NULL,
	Usua_IdModificacion		INT,
	DeCo_FechaModificacion  DATETIME
	CONSTRAINT PK_tbDetallesCompras_DeCo_Id PRIMARY KEY (DeCo_Id),
	CONSTRAINT FK_tbDetallesCompras_Comp_Id_tbCompras_Comp_Id FOREIGN KEY (Comp_Id) REFERENCES tbCompras (Comp_Id),
	CONSTRAINT FK_tbDetallesCompras_Prod_Id_tbProductos_Prod_Id FOREIGN KEY (Prod_Id) REFERENCES tbProductos (Prod_Id)
);
GO

CREATE TABLE tbVentas(
    Vent_Id		            INT IDENTITY(1,1),
	Vent_Fecha				DATE NOT NULL,
	Clie_Id	                INT NOT NULL,
	Vent_Descuento			DECIMAL(18,2),
	Vent_MontoFinal			DECIMAL(18,2),
    Vent_Estado             BIT NOT NULL,
	Usua_IdCreacion			INT NOT NULL,
	Vent_FechaCreacion      DATETIME NOT NULL,
	Usua_IdModificacion		INT,
	Vent_FechaModificacion  DATETIME
	CONSTRAINT PK_tbVentas_Vent_Id PRIMARY KEY (Vent_Id)
    CONSTRAINT FK_tbVentas_Clie_Id_tbClientes_Clie_Id FOREIGN KEY (Clie_Id) REFERENCES tbClientes(Clie_Id)
);
GO

CREATE TABLE tbDetallesVentas(
   DeVe_Id					INT IDENTITY(1,1),
   Vent_Id					INT NOT NULL,
   Prod_Id					INT NOT NULL,
   DeVe_Cantidad            INT NOT NULL,
   DeVe_PrecioVenta         DECIMAL(18,2) NOT NULL,
   DeVe_MontoTotal			DECIMAL(18,2),
   DeVe_Estado              BIT NOT NULL,
   Usua_IdCreacion			INT NOT NULL,
   DeVe_FechaCreacion       DATETIME NOT NULL,
   Usua_IdModificacion		INT,
   DeVe_FechaModificacion   DATETIME
   CONSTRAINT PK_tbDetallesVentas_DeVe_Id PRIMARY KEY (DeVe_Id),
   CONSTRAINT FK_tbDetallesVentas_Prod_Id_tbProductos_Prod_Id FOREIGN KEY (Prod_Id) REFERENCES tbProductos(Prod_Id),
   CONSTRAINT FK_tbDetallesVentas_Vent_Id_tbVentas_Vent_Id FOREIGN KEY (Vent_Id) REFERENCES tbVentas(Vent_Id)
);
GO

CREATE TABLE tbHistorialEntradasSalidas(
      HiES_Id		 INT IDENTITY(1,1),
	  Prod_Id	     INT NOT NULL,
	  HiES_Cantidad  INT NOT NULL,
	  HiES_Fecha     DATETIME NOT NULL,
	  HiES_Compra    BIT NOT NULL,
	  HiES_Venta     BIT NOT NULL
	  CONSTRAINT PK_tbHistorialEntradasSalidas_HiES_Id PRIMARY KEY (HiES_Id),
	  CONSTRAINT FK_tbHistorialEntradasSalidas_Prod_Id_tbProductos_Prod_Id FOREIGN KEY (Prod_Id) REFERENCES tbProductos(Prod_Id)
);
GO

/**********************************UDPS**********************************/

USE DB_SistemaVentas
GO

--***************************UDPS tbUsuarios***************************--

--CREATE PROCEDURE UDP_tbUsuarios_ValidarLogin
CREATE OR ALTER PROCEDURE UDP_tbUsuarios_ValidarLogin
(
	@Usua_Nombre AS NVARCHAR(150),
	@Usua_Clave AS NVARCHAR(150)
)
AS
BEGIN
	DECLARE @Pass AS NVARCHAR(MAX);
	SET @Pass = CONVERT(NVARCHAR(MAX), HASHBYTES('sha2_512', @Usua_Clave), 2);
	
	SELECT	[Usua_Id], 
			Usua_Nombre, 
			CASE [Usua_EsAdmin] 
			WHEN '1' THEN 'Admin'
			WHEN '0' THEN 'Not Admin'
			END AS usu_EsAdmin
	  FROM  [dbo].[tbUsuarios] tb1
INNER JOIN  [dbo].[tbEmpleados] tb2
		ON  tb1.Empl_Id = tb2.Empl_Id
	 WHERE  [Usua_Nombre] = @Usua_Nombre AND [Usua_Clave] = @Pass
	   AND  [Usua_Estado] = 1
END
GO

--CREATE PROCEDURE 'UDP_tbUsuarios_ValidarExisteUsername'
CREATE OR ALTER PROCEDURE UDP_tbUsuarios_ValidarExisteUsername
(
	@Usua_Nombre AS NVARCHAR(150)
)
AS
BEGIN
	SELECT	[Usua_Id]
	  FROM  [dbo].[tbUsuarios]
	 WHERE  [Usua_Nombre] = @Usua_Nombre 
	   AND  [Usua_Estado] = 1
END
GO

--CREATE PROCEDURE 'UDP_tbUsuarios_ActualizarContraseniaUsuario'
CREATE OR ALTER PROCEDURE UDP_tbUsuarios_ActualizarContraseniaUsuario
(
	@Usua_Nombre AS NVARCHAR(150),
	@PassNueva AS NVARCHAR(150)
)
AS
BEGIN
	DECLARE @Pass AS NVARCHAR(MAX);
	SET @Pass = CONVERT(NVARCHAR(MAX), HASHBYTES('sha2_512', @PassNueva), 2);

	UPDATE [dbo].[tbUsuarios]
	   SET [Usua_Clave] = @Pass
	 WHERE [Usua_Nombre] = @Usua_Nombre
END
GO
--***************************/UDPS tbUsuarios***************************--

--***************************TRIGGERS tbProductos***************************--
--CREATE TRIGGER 'TRG_tbDetallesVentas_UpdateStockProductosVentas' ON 'tbDetalleVentas'
CREATE OR ALTER TRIGGER TRG_tbDetallesVentas_UpdateStockProductosVentas
ON [dbo].[tbDetallesVentas]
AFTER INSERT
AS
BEGIN
	DECLARE @Prod_Id AS INT, @CantidadCompra AS INT, @Fecha AS DATE, @CantidadAnterior AS INT, @NuevaCantidad AS INT ;
	
	SELECT @Prod_Id = [Prod_Id],
		   @CantidadCompra = [DeVe_Cantidad],
		   @Fecha = tb2.Vent_Fecha
	  FROM inserted tb1 
	  INNER JOIN [dbo].[tbVentas] tb2
	  ON tb1.Vent_Id = tb2.Vent_Id

	INSERT INTO [dbo].[tbHistorialEntradasSalidas]
	VALUES(@Prod_Id, @CantidadCompra, @Fecha, '0', '1');

	SELECT @CantidadAnterior = [Prod_Stock] FROM [dbo].[tbProductos] WHERE [Prod_Id] = @Prod_Id

	SET @NuevaCantidad = @CantidadAnterior - @CantidadCompra;

	UPDATE [dbo].[tbProductos]
	   SET [Prod_Stock] = @NuevaCantidad
 	 WHERE [Prod_Id] = @Prod_Id
END
GO

--CREATE TRIGGER 'TRG_tbDetallesCompras_UpdateStockProductosCompras' ON 'tbDetalleCompras'
CREATE OR ALTER TRIGGER TRG_tbDetallesCompras_UpdateStockProductosCompras
ON [dbo].[tbDetallesCompras]
AFTER INSERT
AS
BEGIN
	DECLARE @Prod_Id AS INT, @CantidadCompra AS INT, @Fecha AS DATE, @CantidadAnterior AS INT, @NuevaCantidad AS INT ;
	
	SELECT @Prod_Id = [Prod_Id],
		   @CantidadCompra = [DeCo_Cantidad],
		   @Fecha = tb2.Comp_Fecha
	  FROM inserted tb1 
	  INNER JOIN [dbo].[tbCompras] tb2
	  ON tb1.Comp_Id = tb2.Comp_Id

	INSERT INTO [dbo].[tbHistorialEntradasSalidas]
	VALUES(@Prod_Id, @CantidadCompra, @Fecha, '1', '0');

	SELECT @CantidadAnterior = [Prod_Stock] FROM [dbo].[tbProductos] WHERE [Prod_Id] = @Prod_Id

	SET @NuevaCantidad = @CantidadAnterior + @CantidadCompra;

	UPDATE [dbo].[tbProductos]
	   SET [Prod_Stock] = @NuevaCantidad
	 WHERE [Prod_Id] = @Prod_Id
END
GO
--***************************/TRIGGERS tbProductos***************************--

--***************************UDPS tbCategorias***************************--
--CREATE PROCEDURE 'UDP_tbCategorias_ListarCategorias'
CREATE OR ALTER PROCEDURE UDP_tbCategorias_ListarCategorias
AS
BEGIN 
	SELECT	[Cate_Id],
			[Cate_Categoria]
	  FROM	[dbo].[tbCategorias]
	 WHERE	[Cate_Estado] = 1
END
GO

--CREATE PROCEDURE 'UDP_tbCategorias_ListarCategoriaPorId'
CREATE OR ALTER PROCEDURE UDP_tbCategorias_ListarCategoriaPorId
(
	@Cate_Id AS INT
)
AS
BEGIN 
	SELECT [Cate_Categoria]
	  FROM [dbo].[tbCategorias]
	 WHERE [Cate_Estado] = 1
	   AND [Cate_Id] = @Cate_Id
END
GO

--CREATE PROCEDURE 'UDP_tbCategorias_IngresarNuevaCategoria'
CREATE OR ALTER PROCEDURE UDP_tbCategorias_IngresarNuevaCategoria
(
	@NuevaCategoria AS NVARCHAR(150),
	@Usua_IdCreacion AS INT
)
AS
BEGIN
	INSERT INTO [dbo].[tbCategorias]
	VALUES(@NuevaCategoria, 1, @Usua_IdCreacion, GETDATE(), null, null);
END
GO

--CREATE PROCEDURE 'UDP_tbCategorias_ActualizarCategoria'
CREATE OR ALTER PROCEDURE UDP_tbCategorias_ActualizarCategoria
(
	@Cate_Id AS INT,
	@Cate_Categoria AS NVARCHAR(150),
	@Usua_IdModificacion AS INT 
)
AS
BEGIN
	UPDATE [dbo].[tbCategorias]
	   SET [Cate_Categoria] = @Cate_Categoria,
		   [Usua_IdModifiacion] = @Usua_IdModificacion,
		   [Cate_FechaModificacion] = GETDATE()
	 WHERE [Cate_Id] = @Cate_Id
END
GO

--CREATE PROCEDURE 'UDP_tbCategorias_EliminarCategoria'
CREATE OR ALTER PROCEDURE UDP_tbCategorias_EliminarCategoria
(
	@Cate_Id AS INT,
	@Usua_IdModificacion AS INT 
)
AS
BEGIN
	UPDATE [dbo].[tbCategorias]
	   SET [Cate_Estado] = 0,
	       [Usua_IdModifiacion] = @Usua_IdModificacion,
	       [Cate_FechaModificacion] = GETDATE()
	 WHERE [Cate_Id] = @Cate_Id
END
GO

--CREATE PROCEDURE 'UDP_tbCategorias_CategoriaContieneProductos'
CREATE OR ALTER PROCEDURE UDP_tbCategorias_CategoriaContieneProductos
(
	@Cate_Id AS INT
)
AS
BEGIN
	SELECT [Prod_Id] 
	  FROM [dbo].[tbProductos] 
	 WHERE [Cate_Id] = @Cate_Id 
	   AND [Prod_Estado] = 1
END
GO

--CREATE PROCEDURE 'UDP_tbCategorias_DdlCategorias'
CREATE OR ALTER PROCEDURE UDP_tbCategorias_DdlCategorias
AS
BEGIN
	SELECT [Cate_Id], 
	       [Cate_Categoria] 
	  FROM [dbo].[tbCategorias] 
	 WHERE [Cate_Estado] = 1
END
GO
--***************************/UDPS tbCategorias***************************--

--***************************UDPS tbProductos***************************--
--CREATE PROCEDURE 'UDP_tbProductos_ListarProductos'
CREATE OR ALTER PROCEDURE UDP_tbProductos_ListarProductos
AS
BEGIN
	SELECT  [Prod_Id],
			[Prod_CodigoProducto],
			[Cate_Categoria],
			[Prod_Descripcion],
			[Prov_Nombre],
			[Prod_Stock]
	  FROM  [dbo].[tbProductos] tb1
INNER JOIN  [dbo].[tbCategorias] tb2
	    ON  tb1.Cate_Id = tb2.Cate_Id
INNER JOIN  [dbo].[tbProveedores] tb3
	    ON  tb1.Prov_Id = tb3.Prov_Id
	 WHERE  tb1.Prod_Estado = 1
END
GO

--CREATE PROCEDURE 'UDP_tbProductos_IngresarNuevoProducto'
CREATE OR ALTER PROCEDURE UDP_tbProductos_IngresarNuevoProducto
(
	@Prod_CodigoProducto AS VARCHAR(15),
	@Prod_Descripcion AS NVARCHAR(150),
	@Cate_Id AS INT,
	@Prov_Id AS INT,
	@Prod_Stock AS INT,
	@Prod_PrecioCompra AS DECIMAL(18,2),
	@Prod_PrecioVenta AS DECIMAL(18,2),
	@Usua_IdCreacion AS INT
)
AS
BEGIN
	INSERT INTO [dbo].[tbProductos]
	VALUES (@Prod_CodigoProducto, @Prod_Descripcion, @Cate_Id, @Prov_Id, @Prod_Stock, @Prod_PrecioCompra, @Prod_PrecioVenta, 1, @Usua_IdCreacion, GETDATE(), null, null)
END
GO

--CREATE PROCEDURE 'UDP_tbProductos_ActualizarProducto'
CREATE OR ALTER PROCEDURE UDP_tbProductos_ActualizarProducto
(
	@Prod_Id AS INT,
	@Prod_CodigoProducto AS VARCHAR(15),
	@Prod_Descripcion AS NVARCHAR(150),
	@Cate_Id AS INT,
	@Prov_Id AS INT,
	@Prod_Stock AS INT,
	@Prod_PrecioCompra AS DECIMAL(18,2),
	@Prod_PrecioVenta AS DECIMAL(18,2),
	@Usua_IdModificacion AS INT
)
AS
BEGIN
	UPDATE [dbo].[tbProductos]
	   SET [Prod_CodigoProducto] = @Prod_CodigoProducto,
		   [Cate_Id] = @Cate_Id,
		   [Prod_Descripcion] = @Prod_Descripcion,
		   [Prov_Id] = @Prov_Id,
		   [Prod_Stock] = @Prod_Stock,
		   [Prod_PrecioCompra] = @Prod_PrecioCompra,
		   [Prod_PrecioVenta] = @Prod_PrecioVenta,
		   [Usua_IdModificacion] = @Usua_IdModificacion,
		   [Prod_FechaModificacion] = GETDATE()
	 WHERE [Prod_Id] = @Prod_Id
	   AND [Prod_Estado] = 1
END
GO

--CREATE PROCEDURE 'UDP_tbProductos_EliminarProducto'
CREATE OR ALTER PROCEDURE UDP_tbProductos_EliminarProducto
(
	@Prod_Id AS INT,
	@Usua_IdModificacion AS INT
)
AS
BEGIN
	UPDATE [dbo].[tbProductos]
	   SET [Prod_Estado]= 0,
		   [Usua_IdModificacion] = @Usua_IdModificacion,
		   [Prod_FechaModificacion] = GETDATE()
	 WHERE [Prod_Id] = @Prod_Id
END
GO

--CREATE PROCEDURE 'UDP_tbProductos_ListarProductoPorId'
CREATE OR ALTER PROCEDURE UDP_tbProductos_ListarProductoPorId
(
	@Prod_Id AS INT
)
AS
BEGIN
	SELECT  [Prod_Id],
			[Prod_CodigoProducto],
			[Prod_Descripcion],
			[Cate_Id],
			[Prov_Id],
			[Prod_Stock],
			[Prod_PrecioCompra],
			[Prod_PrecioVenta]
	  FROM  [dbo].[tbProductos]
	 WHERE  [Prod_Id] = @Prod_Id
	   AND  [Prod_Estado] = 1
END
GO

--CREATE PROCEDURE 'UDP_tbProductos_ValidarCodigoProductoExiste'
CREATE OR ALTER PROCEDURE UDP_tbProductos_ValidarCodigoProductoExiste
(
	@Prod_CodigoProducto AS VARCHAR(15)
)
AS
BEGIN 
	SELECT [Prod_Id]
	  FROM [dbo].[tbProductos] 
	 WHERE [Prod_CodigoProducto] = @Prod_CodigoProducto
	   AND [Prod_Estado] = 1
END
GO

--CREATE PROCEDURE 'UDP_tbProductos_DdlProductos'
CREATE OR ALTER PROCEDURE UDP_tbProductos_DdlProductos
AS
BEGIN
	SELECT  [Prod_Id], 
			[Prod_Descripcion] 
	  FROM  [dbo].[tbProductos] 
	 WHERE  [Prod_Estado] = 1
END
GO

--CREATE PROCEDURE 'UDP_tbProductos_CargarStockProductoPorId'
CREATE OR ALTER PROCEDURE UDP_tbProductos_CargarStockProductoPorId
(
	 @Prod_Id AS INT
)
AS
BEGIN
	SELECT [Prod_Stock] 
	  FROM [dbo].[tbProductos] 
	 WHERE [Prod_Id] = @Prod_Id 
	   AND [Prod_Estado] = 1
END
GO

--***************************/UDPS tbProductos***************************--

--***************************UDPS tbProveedores***************************--

--CREATE PROCEDURE 'UDP_tbProveedores_DdlProveedores'
CREATE OR ALTER PROCEDURE UDP_tbProveedores_DdlProveedores
AS
BEGIN
	SELECT [Prov_Id], 
	       [Prov_Nombre] 
	  FROM [dbo].[tbProveedores] 
	 WHERE [Prov_Estado] = 1
END
GO

--***************************/UDPS tbProveedores***************************--

--***************************UDPS tbClientes***************************--

--CREATE PROCEDURE 'UDP_tbClientes_DdlClientes'
CREATE OR ALTER PROCEDURE UDP_tbClientes_DdlClientes
AS
BEGIN
	SELECT [Clie_Id], 
	       [Clie_Nombre] 
      FROM [dbo].[tbClientes] 
	 WHERE [Clie_Estado] = 1
END
GO

--***************************/UDPS tbClientes***************************--

--***************************UDPS tbVentas***************************--
--CREATE PROCEDURE 'UDP_tbVentas_ListarVentas'
CREATE OR ALTER PROCEDURE UDP_tbVentas_ListarVentas
AS
BEGIN
	SELECT	[Vent_Id],
			tb1.[Clie_Id],
			[TiId_Identificacion],
			tb2.[Clie_Nombre]
	  FROM  [dbo].[tbVentas] tb1
INNER JOIN  [dbo].[tbClientes] tb2
	    ON  tb1.Clie_Id = tb2.Clie_Id
INNER JOIN  [dbo].[tbTipoIdentificacion] tb3
	    ON  tb2.TiId_Id = tb3.TiId_Id
	 WHERE  [Vent_Id] = 1
END
GO

--CREATE PROCEDURE 'UDP_tbVentas_ListarVentaPorId'
CREATE OR ALTER PROCEDURE UDP_tbVentas_ListarVentaPorId
(
	@Vent_Id AS INT
)
AS
BEGIN
	SELECT [Clie_Id] FROM [dbo].[tbVentas] WHERE [Vent_Id] = @Vent_Id
END
GO

--CREATE PROCEDURE 'UDP_tbVentas_IngresarNuevaVenta'
CREATE OR ALTER PROCEDURE UDP_tbVentas_IngresarNuevaVenta
(
	@Clie_Id AS INT,
	@Usua_IdCreacion AS INT
)
AS
BEGIN
	INSERT INTO [dbo].[tbVentas]
	VALUES (GETDATE(), @Clie_Id, null, null, 1, @Usua_IdCreacion, GETDATE(), null, null)
END
GO

--CREATE PROCEDURE 'UDP_tbVentas_IdVentaReciente'
CREATE OR ALTER PROCEDURE UDP_tbVentas_IdVentaReciente
AS
BEGIN
	SELECT TOP 1 [Vent_Id]
			FROM [dbo].[tbVentas] 
		   WHERE [Vent_Estado] = 1 
		ORDER BY [Vent_Id] DESC 
END
GO

--***************************/UDPS tbVentas***************************--

--***************************TRIGGERS tbDetallesVentas***************************--
CREATE OR ALTER TRIGGER TRG_tbDetallesVentas_MontoTotal
ON [dbo].[tbDetallesVentas]
AFTER INSERT
AS
BEGIN
	DECLARE @DeVe_MontoTotal AS DECIMAL(18,2)

	SELECT @DeVe_MontoTotal = [DeVe_Cantidad] * [DeVe_PrecioVenta] FROM inserted 
	
	UPDATE [dbo].[tbDetallesVentas]
	   SET [DeVe_MontoTotal] = @DeVe_MontoTotal
	 WHERE [DeVe_Id] = (SELECT [DeVe_Id] FROM inserted)

	 UPDATE [dbo].[tbVentas]
	    SET [Vent_MontoFinal] = (SELECT [DeVe_MontoTotal] FROM inserted) - [Vent_Descuento]
	  WHERE [Vent_Id] = (SELECT [Vent_Id] FROM inserted)
END
GO
--***************************/TRIGGERS tbDetallesVentas***************************--

--***************************UDPS tbDetallesVentas***************************--

--CREATE PROCEDURE 'UDP_tbVentas_ListarDetallesVentasPorIdVenta'
CREATE OR ALTER PROCEDURE UDP_tbVentas_ListarDetallesVentasPorIdVenta
(
	@Vent_Id AS INT
)
AS
BEGIN
	SELECT [DeVe_Id],
		   [Vent_Id],
		   tb1.[Prod_Id],
		   [Prod_Descripcion],
		   [DeVe_Id],
		   [DeVe_PrecioVenta]
	  FROM [dbo].[tbDetallesVentas] tb1
INNER JOIN [dbo].[tbProductos] tb2
	    ON tb1.Prod_Id = tb2.Prod_Id
	 WHERE [Vent_Id] = @Vent_Id
	   AND [DeVe_Estado]= 1
END
GO

--CREATE PROCEDURE 'UDP_tbVentas_IngresarNuevoDetalleVenta'
CREATE OR ALTER PROCEDURE UDP_tbVentas_IngresarNuevoDetalleVenta
(
	@Vent_Id AS INT,
	@Prod_Id AS INT,
	@DeVe_Cantidad AS INT,
	@DeVe_PrecioVenta AS DECIMAL(18,2),
	@DeVe_MontoTotal AS DECIMAL(18,2),
	@Usua_IdCreacion AS INT
)
AS
BEGIN
	INSERT INTO [dbo].[tbDetallesVentas] 
	VALUES(@Vent_Id, @Prod_Id, @DeVe_Cantidad, @DeVe_PrecioVenta, @DeVe_MontoTotal, 1, @Usua_IdCreacion, GETDATE(), null, null);
END
GO

--CREATE PROCEDURE 'UDP_tbDetallesVentas_EliminarVenta'
CREATE OR ALTER PROCEDURE UDP_tbDetallesVentas_EliminarVenta
(
	@DeVe_Id AS INT,
	@Usua_IdModificacion AS INT
)
AS
BEGIN
 UPDATE [dbo].[tbDetallesVentas]
	SET [DeVe_Estado] = 0,
		[Usua_IdModificacion] = @Usua_IdModificacion,
		[DeVe_FechaModificacion] = GETDATE()
  WHERE [DeVe_Id] = @DeVe_Id
END
GO

--CREATE PROCEDURE 'UDP_tbDetallesVentas_CargarDetalleVentaPorId'
CREATE OR ALTER PROCEDURE UDP_tbDetallesVentas_CargarDetalleVentaPorId
(
	@DeVe_Id AS INT
)
AS
BEGIN 
	SELECT	[Vent_Id], 
			[Prod_Id], 
			[DeVe_Cantidad], 
			[DeVe_PrecioVenta] 
	  FROM  [dbo].[tbDetallesVentas] 
	 WHERE  [DeVe_Id] = @DeVe_Id
END
GO

--CREATE PROCEDURE 'UDP_tbDetallesVentas_ActualizarDetalleVenta'
CREATE OR ALTER PROCEDURE UDP_tbDetallesVentas_ActualizarDetalleVenta
(
	@DeVe_Id AS INT,
	@Prod_Id AS INT,
	@DeVe_Cantidad AS INT,
	@DeVe_PrecioVenta AS DECIMAL(18,2),
	@Usua_IdModificacion AS INT
)
AS
BEGIN
 UPDATE [dbo].[tbDetallesVentas]
	SET [Prod_Id] = @Prod_Id,
		[DeVe_Cantidad] = @DeVe_Cantidad,
		[DeVe_PrecioVenta] = @DeVe_PrecioVenta,
		[Usua_IdModificacion] = @Usua_IdModificacion,
		[DeVe_FechaModificacion] = GETDATE()
  WHERE [DeVe_Id] = @DeVe_Id
END
GO

--***************************/UDPS tbDetallesVentas***************************--

--***************************UDPS DIRECCIONES,EstadosCiviles,Proveedores,Clientes,Usuarios***************************--
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
select t2.Empl_Id,t2.Empl_Nombre, t2.Empl_Apellidos from tbUsuarios t1 full join tbEmpleados t2  on t1.Empl_Id = t2.Empl_Id where t1.Usua_Id is null OR t1.Usua_Estado = 0
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

--Procedimiento para saber si existe un nombre de usuario
CREATE OR ALTER PROCEDURE UDP_tbUsuarios_ExisteNombreUsuario
	@Usua_Nombre	NVARCHAR(20)
AS
BEGIN
	SELECT Usua_Id  FROM tbUsuarios WHERE Usua_Nombre = @Usua_Nombre and Usua_Estado = 1
END;
GO

GO
--tbUsuarios
--------------------------------------------------------------------
--tbProveedores

--Procedimiento Mostrar todos los proveedores en la tabla
CREATE OR ALTER PROCEDURE [dbo].[UDP_tbProveedores_MostrarTodosProveedores]
AS
BEGIN
		  SELECT  [Prov_Id],
		          [Prov_Rut],
                  [Prov_Nombre],
				  [Dire_Id],
				  [Prov_Telefono],
                  [Prov_PaginaWeb] 
		   FROM	  [dbo].[tbProveedores]
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

--Procedimiento para llevar datos al eliminar
CREATE OR ALTER PROCEDURE UDP_tbProveedores_EliminarDatos
	@Prov_Id	NVARCHAR(10)
AS
BEGIN
	SELECT Prov_Id, Prov_Nombre, Prov_Rut, Dire_Id, Prov_Telefono, Prov_PaginaWeb FROM tbProveedores WHERE Prov_Id = @Prov_Id
END;

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
	@Prov_Id				AS NVARCHAR(10),
	@Prov_Rut				AS VARCHAR(14),
	@Prov_Nombre			AS NVARCHAR(150),	
	@Dire_Id				AS NVARCHAR(10),
	@Prov_Telefono			AS VARCHAR(9),
	@Prov_PaginaWeb			AS NVARCHAR(150),
	@Usua_IdModificacion	AS NVARCHAR(10)
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
------------------------------------------------------------------------
--tbClientes 

-- Procedimiento Mostrar todos los clientes en la tabla
CREATE OR ALTER PROCEDURE UDP_tbClientes_ClientesTodos
AS 
BEGIN 
   SELECT	[Clie_Id],
			[Clie_Identificacion],
			[Clie_Nombre],
			T2.Dire_Calle,
			T2.Dire_Comuna,
			T3.Muni_Municipios,
			T4.Dept_Departamento
			[Clie_Telefono],
			[Clie_CorreoElectronico] 
	FROM	[dbo].[tbClientes] T1 INNER JOIN [dbo].[tbDirecciones] T2
	ON		T1.Dire_Id = T2.Dire_Id INNER JOIN [dbo].[tbMunicipios] T3
	ON		T2.Muni_Id = T3.Muni_Id INNER JOIN [dbo].[tbDepartamentos] T4
	ON		T3.Dept_Id = T4.Dept_Id
	WHERE	[Clie_Estado] = 1
END
GO

--Procedimiento Mostrar los tipos de identificacion en ddl en la tabla
 CREATE OR ALTER PROCEDURE UDP_tbTipoIdentificacion_DDLIdentificacion
 AS
 BEGIN
   SELECT [TiId_ID],[TiId_Identificacion] FROM [dbo].[tbTipoIdentificacion]
 END
 go

 --Procedimiento Mostrar los tipos de identificacion en ddl en la tabla
 CREATE OR ALTER PROCEDURE UDP_tbClientes_InsertarNuevoCliente
(
	@TiId_ID					AS INT,
	@TiId_Identificacion		AS NVARCHAR(150),
	@Clie_Nombre				AS NVARCHAR(150),
	@Dire_Id					AS VARCHAR(4),
	@Clie_Telefono				AS VARCHAR(9),
	@Clie_CorreoElectronico		AS NVARCHAR(100),
	@Usua_IdCreacion			AS INT
)
AS
BEGIN
	INSERT INTO [dbo].[tbClientes]
	VALUES(@TiId_ID, @TiId_Identificacion, @Clie_Nombre, @Dire_Id, @Clie_Telefono, @Clie_CorreoElectronico, 1 ,@Usua_IdCreacion, GETDATE(), null, null);
END
GO

 --Procedimiento para cargar datos para editar los clientes
CREATE OR ALTER PROCEDURE UDP_tbClientes_CargarDatosEditarClientes
(
	@Clie_Id AS INT
)
AS
BEGIN
	SELECT	[TiId_ID], 
		    [Clie_Identificacion],
			[Clie_Nombre], 
			[Dire_Id]
			[Clie_Telefono], 
			[Clie_CorreoElectronico]
	FROM	[dbo].[tbClientes] 	
	WHERE	[Clie_Id]= @Clie_Id
END
GO

 --Procedimiento para cargar actualizar los clientes
CREATE OR ALTER PROCEDURE UDP_tbClientes_ActualizarCliente
(
	@Clie_Id					AS INT,
	@TiId_ID					AS INT,
	@Clie_Identificacion		AS NVARCHAR(150),
	@Clie_Nombre				AS NVARCHAR(150),	
	@Dire_Id					AS CHAR(4),
	@Clie_Telefono				AS VARCHAR(9),
	@Clie_CorreoElectronico		AS NVARCHAR(150),
	@Clie_FechaModificacion		AS INT
)
AS
BEGIN
UPDATE	[dbo].[tbClientes]
	SET [TiId_ID]= @TiId_ID,
	    [Clie_Identificacion]= @Clie_Identificacion,
		[Clie_Nombre]= @Clie_Nombre,		
		[Dire_Id]= @Dire_Id,
		[Clie_Telefono]= @Clie_Telefono,
		[Clie_CorreoElectronico] = @Clie_CorreoElectronico,
		[Usua_IdModificacion] = @Clie_FechaModificacion,
		[Clie_FechaModificacion] = GETDATE()
WHERE	[Clie_Id]= @Clie_Id
END
GO

 --Procedimiento para eliminar un cliente
CREATE OR ALTER PROCEDURE UDP_tbClientes_DeleteClientes
(
	@Clie_Id				AS INT,
	@Usua_IdModificacion	AS INT
)
AS
BEGIN
	UPDATE [dbo].[tbClientes]
	SET		[Clie_Estado] = 0,
			[Usua_IdModificacion] = @Usua_IdModificacion,
			[Clie_FechaModificacion] = GETDATE()
	WHERE	[Clie_Id] = @Clie_Id
END
GO

/**********************************INSERTS**********************************/
USE DB_SistemaVentas
GO

--INSERTS tbDepartamentos
INSERT INTO  tbDepartamentos  
VALUES ('01', 'Atlántida', 1, GETDATE(), null, null);
GO

INSERT INTO  tbDepartamentos  
VALUES ('02', 'Colón', 1, GETDATE(), null, null);
GO

INSERT INTO  tbDepartamentos  
VALUES ('03', 'Comayagua', 1, GETDATE(), null, null);
GO

INSERT INTO  tbDepartamentos  
VALUES ('04', 'Copán', 1, GETDATE(), null, null);
GO

INSERT INTO  tbDepartamentos  
VALUES ('05', 'Cortés', 1, GETDATE(), null, null);
GO

INSERT INTO  tbDepartamentos  
VALUES ('06', 'Choluteca', 1, GETDATE(), null, null);
GO

INSERT INTO  tbDepartamentos  
VALUES ('07', 'El Paraíso', 1, GETDATE(), null, null);
GO

INSERT INTO  tbDepartamentos  
VALUES ('08', 'Francisco Morazán', 1, GETDATE(), null, null);
GO

INSERT INTO  tbDepartamentos  
VALUES ('09', 'Gracias a Dios', 1, GETDATE(), null, null);
GO

INSERT INTO  tbDepartamentos  
VALUES ('10', 'Intibucá', 1, GETDATE(), null, null);
GO

INSERT INTO  tbDepartamentos  
VALUES ('11', 'Islas de la Bahía', 1, GETDATE(), null, null);
GO

INSERT INTO  tbDepartamentos  
VALUES ('12', 'La Paz', 1, GETDATE(), null, null);
GO

INSERT INTO  tbDepartamentos  
VALUES ('13', 'Lempira', 1, GETDATE(), null, null);
GO

INSERT INTO  tbDepartamentos  
VALUES ('14', 'Ocotepeque', 1, GETDATE(), null, null);
GO

INSERT INTO  tbDepartamentos  
VALUES ('15', 'Olancho', 1, GETDATE(), null, null);
GO

INSERT INTO  tbDepartamentos  
VALUES ('16', 'Santa Bárbara', 1, GETDATE(), null, null);
GO

INSERT INTO  tbDepartamentos  
VALUES ('17', 'Valle', 1, GETDATE(), null, null);
GO

INSERT INTO  tbDepartamentos  
VALUES ('18', 'Yoro', 1, GETDATE(), null, null);
GO

--INSERTS tbMunicipios
INSERT INTO [dbo].[tbMunicipios]
VALUES('0101','La Ceiba','01',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0102','El Porvenir','01',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0103','Esparta','01',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0104','Jutiapa','01',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0105','La Masica','01',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0106','San Francisco','01',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0107','Tela','01',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0108','Arizona','01',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0201','Trujillo','02',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0202','Balfate','02',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0203','Iriona','02',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0204','Limón','02',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0205','Sabá','02',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0206','Santa Fe','02',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0207','Santa Rosa de Aguán','02',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0208','Sonaguera','02',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0209','Tocoa','02',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0210','Bonito Oriental','02',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0301','Comayagua','03',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0302','Ajuterique','03',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0303','El Rosario','03',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0304','Esquías','03',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0305','Humuya','03',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0306','La Libertad','03',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0307','Lamaní','03',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0308','La Trinidad','03',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0309','Lejamaní','03',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0310','Meámbar','03',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0311','Minas de Oro','03',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0312','Ojos de Agua','03',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0313','San Jerónimo','03',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0314','San José de Comayagua','03',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0315','San José del Potrero','03',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0316','San Luis','03',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0317','San Sebastián','03',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0318','Siguatepeque','03',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0319','Villa de San Antonio','03',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0320','Las Lajas','03',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0321','Taulabé','03',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0401','Santa Rosa de Copán','04',1,GETDATE(),NULL,NULL);
 GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0402','Cabañas','04',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0403','Concepción','04',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0404','Copán Ruinas','04',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0405','Corquín','04',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0406','Cucuyagua','04',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0407','Dolores','04',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0408','Dulce Nombre','04',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0409','El Paraíso','04',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0410','Florida','04',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0411','La Jigua','04',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0412','La Unión','04',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0413','Nueva Arcadia','04',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0414','San Agustín','04',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0415','San ANTONIO','04',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0416','San Jerónimo','04',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0417','San José','04',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0418','San Juan de Opoa','04',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0419','San Nicolás','04',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0420','San Pedro','04',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0421','Santa Rita','04',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0422','Trinidad de Copán','04',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0423','Veracruz','04',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0501','San Pedro Sula','05',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0502','Choloma','05',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0503','Omoa','05',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0504','Pimienta','05',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0505','Potrerillos','05',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0506','Puerto Cortés','05',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0507','San Antonio de Cortés','05',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0508','San Francisco de Yojoa','05',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0509','San Manuel','05',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0510','Santa Cruz de Yojoa','05',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0511','Villanueva','05',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0512','La Lima','05',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0601','Choluteca','06',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0602','Apacilagua','06',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0603','Concepción de María','06',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0604','Duyure','06',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0605','El Corpus','06',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0606','El Triunfo','06',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0607','Marcovia','06',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0608','Morolica','06',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0609','Namasigüe','06',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0610','Orocuina','06',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0611','Pespire','06',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0612','San Antonio de Flores','06',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0613','San Isidro','06',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0614','San José','06',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0615','San Marcos de Colón','06',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0616','Santa Ana de Yusguare,','06',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0701','Yuscarán','07',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0702','Alauca','07',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0703','Danlí','07',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0704','El Paraíso','07',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0705','"Güinope','07',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0706','Jacaleapa','07',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0707','Liure','07',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0708','Morocelí','07',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0709','Oropolí','07',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0710','Potrerillos','07',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0711','San Antonio de Flores','07',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0712','San Lucas','07',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0713','San Matías','07',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0714','Soledad','07',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0715','Teupasenti','07',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0716','Texiguat','07',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0717','Vado Ancho','07',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0718','Yauyupe','07',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0719','Trojes','07',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0801','Distrito Central (Tegucigalpa y Comayaguela)','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0802','Alubarén','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0803','Cedros','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0804','Curarén','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0805','El Porvenir','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0806','Guaimaca','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0807','La Libertad','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0808','La Venta','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0809','Lepaterique','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0810','Maraita','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0811','Marale','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0812','Nueva Armenia','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0813','Ojojona','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0814','Orica (Francisco Morazan)','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0815','Reitoca','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0816','Sabanagrande','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0817','San Antonio de Oriente','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0818','San Buenaventura','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0819','San Ignacio','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0820','San Juan de Flores o como se le conoce Cantarrana','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0821','San Miguelito','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0822','Santa Ana','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0823','Santa Lucía','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0824','Talanga','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0825','Tatumbla','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0826','Valle de Ángeles','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0827','Villa de San Francisco','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0828','Vallecillo','08',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0901','Puerto Lempira','09',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0902','Brus Laguna','09',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0903','Ahuas','09',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0904','Juan Francisco Bulnes','09',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('0905','Ramón Villeda Morales','09',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('0906','Wampusirpe','09',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1001','La Esperanza','10',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1002','Camasca','10',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1003','Colomoncagua','10',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1004','Concepción','10',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1005','Dolores','10',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1006','Intibucá','10',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1007','Jesús de Otoro','10',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1008','Magdalena','10',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1009','Masaguara','10',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1010','San Antonio','10',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1011','San Isidro','10',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1012','San Juan','10',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1013','San Marcos de la Sierra','10',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1014','San Miguel Guancapla','10',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1015','Santa Lucía','10',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1016','Yamaranguila','10',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1017','San Francisco de Opalaca','10',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1101','Roatán','11',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1102','Guanaja','11',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1103','José Santos Guardiola','11',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1104','Utila','11',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1201','La Paz','12',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1202','Aguanqueterique','12',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1203','Cabañas','12',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1204','Cane','12',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1205','Chinacla','12',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1206','Guajiquiro','12',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1207','Lauterique','12',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1208','Marcala','12',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1209','Mercedes de Oriente','12',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1210','Opatoro','12',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1211','San Antonio del Norte','12',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1212','San José','12',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1213','San Juan','12',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1214','San Pedro de Tutule','12',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1215','Santa Ana','12',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1216','Santa Elena','12',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1217','Santa María','12',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1218','Santiago de Puringla','12',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1219','Yarula','12',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1301','Gracias','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1302','Belén','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1303','Candelaria','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1304','Cololaca','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1305','Erandique','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1306','Gualcince','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1307','Guarita','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1308','La Campa','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1309','La Iguala','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1310','LaS Flores','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1311','La Unión','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1312','La Virtud','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1313','Lepaera','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1314','Mapulaca','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1315','Piraera','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1316','San Andrés','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1317','San Francisco','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1318','San Juan Guarita','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1319','San Manuel Colohete','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1320','San Rafael','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1321','San Sebastián','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1322','Santa Cruz','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1323','Talgua','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1324','Tambla','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1325','Tomalá','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1326','Valladolid','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1327','Virginia','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1328','San Marcos de Caiquín','13',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1401','Nueva Ocotepeque','14',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1402','Belén Gualcho','14',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1403','Concepción','14',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1404','Dolores Merendón','14',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1405','Fraternidad','14',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1406','La Encarnación','14',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1407','La Labor','14',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1408','Lucerna','14',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1409','Mercedes','14',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1410','San Fernando','14',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1411','San Francisco del Valle','14',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1412','San Jorge','14',1,GETDATE(),NULL,NULL);
 GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1413','San Marcos','14',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1414','Santa Fe','14',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1415','Sensenti','14',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1416','Sinuapa','14',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1501','Juticalpa','15',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1502','Campamento','15',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1503','Catacamas','15',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1504','Concordia','15',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1505','Dulce Nombre de Culmí','15',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1506','El Rosario','15',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1507','Esquipulas del Norte','15',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1508','Gualaco','15',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1509','Guarizama','15',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1510','GUATA','15',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1511','Guayape','15',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1512','Jano','15',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1513','La UNIÓN','15',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1514','Mangulile','15',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1515','Manto','15',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1516','Salamá','15',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1517','San Esteban','15',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1518','San Francisco de Becerra','15',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1519','San Francisco de la Paz','15',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1520','Santa María del Real','15',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1521','Silca','15',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1522','Yocón','15',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1523','Patuca','15',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1601','Santa Bárbara','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1602','Arada','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1603','Atima','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1604','Azacualpa','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1605','Ceguaca','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1606','San José de las Colinas','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1607','Concepción del Norte','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1608','Concepción del Sur','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1609','Chinda','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1610','El Níspero','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1611','Gualala','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1612','Ilama','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1613','Macuelizo','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1614','Naranjito','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1615','Nuevo Celilac','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1616','Petoa','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1617','Protección','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1618','Quimistán','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1619','San Francisco de Ojuera','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1620','San Luis','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1621','San Marcos','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1622','San Nicolás','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1623','San Pedro Zacapa','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1624','Santa Rita','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1625','San Vicente Centenario','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1626','Trinidad','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1627','LaS Vegas','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1628','Nueva Frontera','16',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1701','Nacaome','17',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1702','Alianza','17',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1703','Amapala','17',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1704','Aramecina','17',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1705','Caridad','17',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1706','Goascorán','17',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1707','Langue','17',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1708','San Francisco de Coray','17',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1709','San Lorenzo','17',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1801','Yoro','18',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1802','Arenal','18',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1803','El Negrito','18',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1804','El Progreso','18',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1805','Jocón','18',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1806','Morazán','18',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1807','Olanchito','18',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1808','Santa Rita','18',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1809','Sulaco','18',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios]
VALUES('1810','Victoria','18',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbMunicipios] 
VALUES('1811','Yorito','18',1,GETDATE(),NULL,NULL);

--INSERTS tbDirecciones
INSERT INTO [dbo].[tbDirecciones]
VALUES('Calle rosario','Numero 1','Colonia Rosario','0501',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbDirecciones]
VALUES('Calle Villeda','Numero 5','Colonia Estrada','0502',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbDirecciones]
VALUES('Calle Armando Cierra','Numero 8','Residencial Cierra 2','0704',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbDirecciones]
VALUES('Calle Aventura rosa','Numero 2','Colonia Ventura','0716',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbDirecciones]
VALUES('Calle Marco Ventura','Numero 1','Aldea Maestra','1219',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbDirecciones]
VALUES('Calle Caballero','Numero 9','Residencial Caballero','1504',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbDirecciones]
VALUES('Calle Unah, avenidad durango','Numero 1','Colonia Durango','1617',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbDirecciones]
VALUES('Calle Martinez','Numero 5','Colonia Martinez','1801',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbDirecciones]
VALUES('Calle Dominguez','Numero 1','Colonia Dominguez','1405',1,GETDATE(),NULL,NULL);
GO
INSERT INTO [dbo].[tbDirecciones]
VALUES('Calle Planeta, avenida 12','Numero 10','Colonia Planeta','0512',1,GETDATE(),NULL,NULL);
GO

--INSERTS tbTipoIdentificacion
INSERT INTO tbTipoIdentificacion
VALUES('RTN', 1, GETDATE(), null, null);
GO

INSERT INTO tbTipoIdentificacion
VALUES('DNI', 1, GETDATE(), null, null);
GO

INSERT INTO tbTipoIdentificacion
VALUES('Pasaporte', 1, GETDATE(), null, null);
GO

INSERT INTO tbTipoIdentificacion
VALUES('N/A', 1, GETDATE(), null, null);
GO

--INSERTS tbEstadosCiviles
INSERT INTO tbEstadosCiviles
VALUES ('S', 'Soltero(a)', 1, GETDATE(), null, null);
GO

INSERT INTO tbEstadosCiviles
VALUES ('C', 'Casado(a)', 1, GETDATE(), null, null);
GO

INSERT INTO tbEstadosCiviles
VALUES ('V', 'Viudo(a)', 1, GETDATE(), null, null);
GO

INSERT INTO tbEstadosCiviles
VALUES ('D', 'Divorciado(a)', 1, GETDATE(), null, null);
GO

INSERT INTO tbEstadosCiviles
VALUES ('U', 'Union Libre', 1, GETDATE(), null, null);
GO

--SETEAR LENGUAJE PARA LAS FECHAS
SET LANGUAGE ENGLISH

--INSERTS tbEmpleados
INSERT INTO tbEmpleados
VALUES('1884200105691', 'Ian Alexander', 'Hernandez Escobar', 'M', 'S',1,'10-22-2001', '9471-3500', 'ianh8902@gmail.com', 1, 1, GETDATE(), NULL, NULL);
GO

INSERT INTO tbEmpleados
VALUES('0501200209630', 'Axel Dario', 'Rivera Murillo', 'M', 'C', 2, '03-05-2002', '3165-0161', 'axeldm05@gmail.com', 1, 1, GETDATE(), NULL, NULL);
GO

INSERT INTO tbEmpleados
VALUES('0613199817853', 'Jose Miguel', 'Murcia Castro', 'M', 'C',3, '03-14-1998', '3831-3029', 'miguel.castro@gmail.com', 1, 1,GETDATE(), NULL, NULL);
GO

INSERT INTO tbEmpleados
VALUES('1801200000010', 'Noe Edil', 'Barnica Ramos', 'M', 'S',4, '05-19-2000','8925-8314', 'noe3@gmail.com', 1, 1 ,GETDATE(), NULL, NULL);
GO

INSERT INTO tbEmpleados
VALUES('0501200110543', 'Loany Michelle', 'Paz Guerra', 'F', 'V',5 ,'03-27-2001', '8586-2314', 'loany15@gmail.com', 1,1, GETDATE(), NULL, NULL);
GO

INSERT INTO tbEmpleados
VALUES('0409199934517', 'Daniel Enrique', 'Matamoros De la O', 'M', 'D',6,'04-30-1999','9991-4436', 'enrique.99@gmail.com', 1, 1 ,GETDATE(), NULL, NULL);
GO

INSERT INTO tbEmpleados
VALUES('0503200207911', 'Andrea Nicolle', 'Crivelli Zamorano', 'F', 'S',7, '10-29-2002', '3915-1658', 'nicolle29@gmail.com', 1, 1 ,GETDATE(), NULL, NULL);
GO

INSERT INTO tbEmpleados
VALUES('0607199301185', 'Mágdaly', 'Zúniga Alvarado', 'F', 'C',8 ,'11-25-1993', '3339-6645', 'magdalyz22@gmail.com', 1,1 , GETDATE(), NULL, NULL);
GO

INSERT INTO tbEmpleados
VALUES('0501200506681', 'Javier Eduardo', 'López', 'M', 'V',9 ,'03-09-2005', '9821-4819', 'javslopez7@gmail.com', 1, 1 ,GETDATE(), NULL, NULL);
GO

INSERT INTO tbEmpleados
VALUES('1615200500062', 'Juan David', 'Molina Sagastume', 'M', 'D', 10, '02-22-2005', '9451-9231', 'juanmolinasagastume@gmail.com', 1, 1 ,GETDATE(), NULL, NULL);
GO

INSERT INTO tbEmpleados
VALUES('1615200500069', 'Eder Jesus', 'Sanchez Mantinez', 'M', 'C',1, '04-22-2002', '9858-7548', 'eder85@hotmail.com', 1, 1 ,GETDATE(), NULL, NULL);
GO

INSERT INTO tbEmpleados
VALUES ('1615201504069', 'Mario Adalid', 'Escobar Flores', 'M', 'C',2,'10-05-2002','8478-6474', 'marioescobar87@hotmail.com', 1, 1 ,GETDATE(), NULL, NULL);
GO

INSERT INTO tbEmpleados
VALUES ('1154200504869', 'Esdra', 'Cerna', 'F', 'S',3,'10-05-1986','8745-9885', 'esdraCerna45@hotmail.com', 1, 1 ,GETDATE(), NULL, NULL);
GO

INSERT INTO tbEmpleados
VALUES ('1804200804125', 'Giovanny Antonio', 'Hernandez Escobar', 'M', 'C',4,'10-11-2001','8478-6474', 'gioantony@gmail.com', 1, 1 ,GETDATE(), NULL, NULL);
GO

INSERT INTO tbEmpleados
VALUES ('1804200305214', 'Edgardo Alexander', 'Sandoval Diaz', 'M', 'D',5,'02-14-2002','9784-5841', 'edgar84@hotmail.com', 1, 1 ,GETDATE(), NULL, NULL);
GO

INSERT INTO tbEmpleados
VALUES ('789456487254', 'Esdra Maria', 'Cerna', 'F', 'S',6,'04-20-1992','4512-1205', 'Esdra_Cerna@hotmail.com', 1, 1 ,GETDATE(), NULL, NULL);
GO



--INSERTS tbProveedores
INSERT INTO tbProveedores
VALUES('05051992168540', 'Carolina Nicolle', 1, '3132-3334', 'PlatanSpecial.com',1,1,GETDATE(),NULL,NULL)
GO

INSERT INTO tbProveedores
VALUES('08011998254871', 'Javier Alejandro', 3, '9192-9394', 'BestSteak.com',1,1,GETDATE(),NULL,NULL);
GO

INSERT INTO tbProveedores
VALUES('14061995162542', 'Juan Fabricio',4, '9493-9291', 'Catrashoes.com',1,1,GETDATE(),NULL,NULL);
GO

INSERT INTO tbProveedores
VALUES('07012001948573', 'Mario Roberto', 5, '8182-8384', 'TechMat.com',1,1,GETDATE(),NULL,NULL);
GO

INSERT INTO tbProveedores
VALUES('05032002084514', 'Allan Manuel', 8, '3433-3231', 'AllanArregla.com', 1,1,GETDATE(),NULL,NULL);
GO

INSERT INTO tbProveedores
VALUES('17062003168456', 'Sonny Eduardo', 10, '9091-9293', 'SonnyMC.com',1,1,GETDATE(),NULL,NULL);
GO

INSERT INTO tbProveedores
VALUES('08042001141515', 'Maria Stephanie', 1, '8081-8283', 'Saltia.com',1,1,GETDATE(),NULL,NULL);
GO

INSERT INTO tbProveedores
VALUES('05012000139878', 'Roger Alexander',7, '9392-9190', 'roger.bonilla@gmail.com',1,1,GETDATE(),NULL,NULL);
GO

INSERT INTO tbProveedores
VALUES('11071999198457', 'Nadia Jiovanessy', 8, '3332-3130', 'nadia.jiovanessy@gmail.com',1,1,GETDATE(),NULL,NULL);
GO

INSERT INTO tbProveedores
VALUES('15082003245169', 'Santos Domingo', 7, '9192-9397', 'Santos.carranza@gmail.com',1,1,GETDATE(),NULL,NULL);
GO

INSERT INTO tbProveedores
VALUES('06131998178530', 'Jose Miguel', 10, '9965-1235','CuerosVaca.com',1,1,GETDATE(),NULL,NULL);
GO

INSERT INTO tbProveedores
VALUES('18012000000101', 'Noe Edil', 8, '8925-8314', 'DeporteDep.com', 1,1,GETDATE(),NULL,NULL);
GO

INSERT INTO tbProveedores
VALUES('05012001105432', 'Loany Michelle',9, '8586-2314', 'Loanynails.com',1,1,GETDATE(),NULL,NULL);
GO

INSERT INTO tbProveedores
VALUES('04091999345173', 'Daniel Enrique',2, '9991-4436', 'EnriqueTech.com',1,1,GETDATE(),NULL,NULL);
GO

INSERT INTO tbProveedores
VALUES('05032002079114', 'Andrea Nicolle', 6, '3915-1658', 'AndreSuper.com',1,1,GETDATE(),NULL,NULL);
GO


--INSERTS tbClientes
INSERT INTO tbClientes
VALUES(1, '06071993011851', 'Mágdaly Zúniga Alvarado', 1, '3339-6645', 'magdalyz22@gmail.com', 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbClientes
VALUES(2, '0501200506681', 'Javier Eduardo López',2, '9821-4819', 'javslopez7@gmail.com', 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbClientes
VALUES(4, 'Consumidor Final', 'Juan David Molina', 3, '9451-9231', 'juanmolinasagastume@gmail.com', 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbClientes
VALUES(1, '18842001056914', 'Ian Alexander Hernandez', 8, '9471-3500', 'ianh8902@gmail.com', 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbClientes
VALUES(2, '0501200209630', 'Axel Dario Rivera', 10, '3165-0161', 'axeldm05@gmail.com', 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbClientes
VALUES(4, 'Consumidor Final', 'Juan Alberto Centeno', 1, '9498-8747', 'juancsabillon06@gmail.com', 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbClientes
VALUES(1, '05012002067027', 'Eder Jesus Sánchez', 9, '9617-8153', 'ederjSanchez22@gmail.com', 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbClientes
VALUES(2, '0501200401519', 'Alex Efrain Castro', 5, '3198-0431', 'alexefraincastro4@gmail.com', 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbClientes
VALUES(4, 'Consumidor Final', 'Sarai Elizabeth Quintanilla', 6, '3352-9652', 'saraieqp@gmail.com', 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbClientes
VALUES(1, '10062005002782', 'Zadiel Jesus Dominguez', 7, '3154-9718', 'zadieldominguez48@gmail.com', 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbClientes
VALUES(2, '0512200300736', 'Angie Yahaira Campos', 8, '9588-7062', 'angie.camposyc03@gmail.com', 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbClientes
VALUES(4, 'Consumidor Final', 'Karla Cecilia Alejandro', 3, '9613-7663', 'karlaalejandro01@gmail.com', 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbClientes
VALUES(1, '09032000127929', 'Ashley Camila Sanchez', 4, '9614-7536', 'camila08@gmail.com', 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbClientes
VALUES(2, '1601199502781', 'Rigoberto Portillo Vu', 5, '9416-5372', 'rigoberto95@gmail.com', 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbClientes
VALUES(4, 'Consumidor Final', 'Maria Canales',6, '9418-2514', 'mariamag90@gmail.com', 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbClientes
VALUES(4, 'Consumidor Final', 'Consumidor Final', 8, '0000-0000', 'null@gmail.com', 1, 1, GETDATE(), null, null);
GO

--INSERTS tbUsuarios
DECLARE @Pass AS NVARCHAR(MAX);
DECLARE @Clave AS NVARCHAR(250);
SET @Clave = '12345';
SET @Pass = CONVERT(NVARCHAR(MAX), HASHBYTES('sha2_512', @Clave),2)

INSERT INTO tbUsuarios
VALUES(2, 'Axel', @Pass, 1, 1, 1, GETDATE(), NULL, NULL);
GO

DECLARE @Pass AS NVARCHAR(MAX);
DECLARE @Clave AS NVARCHAR(250);
SET @Clave = '2023';
SET @Pass = CONVERT(NVARCHAR(MAX), HASHBYTES('sha2_512', @Clave),2)

INSERT INTO tbUsuarios
VALUES(11, 'Eder', @Pass, 1, 1, 1, GETDATE(), NULL, NULL);
GO

DECLARE @Pass AS NVARCHAR(MAX);
DECLARE @Clave AS NVARCHAR(250);
SET @Clave = 'Admin123'
SET @Pass = CONVERT (NVARCHAR(MAX), HASHBYTES('sha2_512',@Clave),2)

INSERT INTO tbUsuarios
VALUES(3, 'Admin', @Pass, 0, 1, 1, GETDATE(), NULL, NULL);
GO

DECLARE @Pass AS NVARCHAR(MAX);
DECLARE @Clave AS NVARCHAR(250);
SET @Clave = 'ESDRINHA'
SET @Pass = CONVERT (NVARCHAR(MAX), HASHBYTES('sha2_512',@Clave),2)

INSERT INTO tbUsuarios
VALUES(16, 'ECERNA', @Pass, 0, 1, 1, GETDATE(), NULL, NULL);
GO


--12 INSERTS a 'tbCategorias'
INSERT INTO tbCategorias
VALUES('Higiene Personal', 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbCategorias
VALUES('Aceites y más', 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbCategorias
VALUES('Granos Básicos', 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbCategorias
VALUES('Snacks', 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbCategorias
VALUES('Condimentos y más', 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbCategorias
VALUES('Lactéos', 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbCategorias
VALUES('Carnes', 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbCategorias
VALUES('Mariscos', 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbCategorias
VALUES('Articulos de limpieza para el hogar', 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbCategorias
VALUES('Electrodomesticos', 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbCategorias
VALUES('Cervezas y Licores', 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbCategorias
VALUES('Cereales', 1, 1, GETDATE(), null, null);
GO

--12 INSERTS a 'tbProductos'
INSERT INTO tbProductos
VALUES('HP-0001', 'Pasta dental 250 CM³', 1, 1, 50, 27.00, 38.15, 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbProductos
VALUES('CM-0001', 'Salsa de tomate Ketchup 100Gramos', 5, 2, 40, 12.00, 18.00, 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbProductos
VALUES('AM-0001', 'Aceite CLOVER 1Lbs', 2, 3, 50, 41.00, 54.00, 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbProductos
VALUES('HP-0002', 'Cepillo dental Slim Soft 4Unidades', 1, 1, 60, 169.95, 194.52, 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbProductos
VALUES('GB-0001', 'Azúcar Morena 2Lbs', 3, 4, 80, 28.15, 37.46, 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbProductos
VALUES('SK-0001', 'Galleta Pingüinos', 4, 5, 100, 32.75, 39.25, 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbProductos
VALUES('AM-0002', 'Manteca vegetal 1/2Lbs', 2, 3, 70, 14.00, 19.20, 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbProductos
VALUES('HP-0003', 'Shampoo Head & Shoulder 3 en 1 580ML', 1, 1, 64, 142.85, 215.63, 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbProductos
VALUES('CM-0002', 'Pasta de tomate 100Gramos', 5, 2, 50, 13.00, 18.70, 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbProductos
VALUES('GB-0002', 'Azúcar 4Lbs', 3, 4, 60, 47.00, 56.82, 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbProductos
VALUES('CN-0001', 'Lomo de res 1Lb', 7, 6, 40, 90.00, 118.82, 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbProductos
VALUES('MC-0001', 'Camaron Jumbo 1Lb', 8, 6, 60, 150.00, 220.30, 1, 1, GETDATE(), null, null);
GO


--15 INSERTS a 'tbVentas'
INSERT INTO [dbo].[tbVentas]
VALUES(GETDATE(), 1, null, null, 1, 1, GETDATE(), null, null);
GO

INSERT INTO [dbo].[tbVentas]
VALUES(GETDATE(), 2, null, null, 1, 1, GETDATE(), null, null);
GO

INSERT INTO [dbo].[tbVentas]
VALUES(GETDATE(), 3, null, null, 1, 1, GETDATE(), null, null);
GO

INSERT INTO [dbo].[tbVentas]
VALUES(GETDATE(), 4, null, null, 1, 1, GETDATE(), null, null);
GO

INSERT INTO [dbo].[tbVentas]
VALUES(GETDATE(), 5, null, null, 1, 1, GETDATE(), null, null);
GO

INSERT INTO [dbo].[tbVentas]
VALUES(GETDATE(), 6, null, null, 1, 1, GETDATE(), null, null);
GO

INSERT INTO [dbo].[tbVentas]
VALUES(GETDATE(), 7, null, null, 1, 1, GETDATE(), null, null);
GO

INSERT INTO [dbo].[tbVentas]
VALUES(GETDATE(), 8, null, null, 1, 1, GETDATE(), null, null);
GO

INSERT INTO [dbo].[tbVentas]
VALUES(GETDATE(), 9, null, null, 1, 1, GETDATE(), null, null);
GO

INSERT INTO [dbo].[tbVentas]
VALUES(GETDATE(), 10, null, null, 1, 1, GETDATE(), null, null);
GO

INSERT INTO [dbo].[tbVentas]
VALUES(GETDATE(), 11, null, null, 1, 1, GETDATE(), null, null);
GO

INSERT INTO [dbo].[tbVentas]
VALUES(GETDATE(), 12, null, null, 1, 1, GETDATE(), null, null);
GO

INSERT INTO [dbo].[tbVentas]
VALUES(GETDATE(), 13, null, null, 1, 1, GETDATE(), null, null);
GO

INSERT INTO [dbo].[tbVentas]
VALUES(GETDATE(), 14, null, null, 1, 1, GETDATE(), null, null);
GO

INSERT INTO [dbo].[tbVentas]
VALUES(GETDATE(), 15, null, null, 1, 1, GETDATE(), null, null);
GO

--17 INSERTS a 'tbDetallesVentas'
DECLARE @PrecioVenta AS DECIMAL(18,2);
SELECT @PrecioVenta = [Prod_PrecioVenta] FROM [dbo].[tbProductos] WHERE [Prod_Id] = 1

INSERT INTO [dbo].[tbDetallesVentas]
VALUES(1, 1, 5, @PrecioVenta, null, 1, 1, GETDATE(), null, null);
GO

DECLARE @PrecioVenta AS DECIMAL(18,2);
SELECT @PrecioVenta = [Prod_PrecioVenta] FROM [dbo].[tbProductos] WHERE [Prod_Id] = 2

INSERT INTO [dbo].[tbDetallesVentas]
VALUES(1, 2, 8, @PrecioVenta, null, 1, 1, GETDATE(), null, null);
GO

DECLARE @PrecioVenta AS DECIMAL(18,2);
SELECT @PrecioVenta = [Prod_PrecioVenta] FROM [dbo].[tbProductos] WHERE [Prod_Id] = 3

INSERT INTO [dbo].[tbDetallesVentas]
VALUES(1, 3, 2, @PrecioVenta, null, 1, 1, GETDATE(), null, null);
GO

DECLARE @PrecioVenta AS DECIMAL(18,2);
SELECT @PrecioVenta = [Prod_PrecioVenta] FROM [dbo].[tbProductos] WHERE [Prod_Id] = 1

INSERT INTO [dbo].[tbDetallesVentas]
VALUES(2, 1, 7, @PrecioVenta, null, 1, 1, GETDATE(), null, null);
GO

DECLARE @PrecioVenta AS DECIMAL(18,2);
SELECT @PrecioVenta = [Prod_PrecioVenta] FROM [dbo].[tbProductos] WHERE [Prod_Id] = 1

INSERT INTO [dbo].[tbDetallesVentas]
VALUES(3, 4, 3, @PrecioVenta, null, 1, 1, GETDATE(), null, null);
GO

DECLARE @PrecioVenta AS DECIMAL(18,2);
SELECT @PrecioVenta = [Prod_PrecioVenta] FROM [dbo].[tbProductos] WHERE [Prod_Id] = 1

INSERT INTO [dbo].[tbDetallesVentas]
VALUES(4, 5, 3, @PrecioVenta, null, 1, 1, GETDATE(), null, null);
GO

DECLARE @PrecioVenta AS DECIMAL(18,2);
SELECT @PrecioVenta = [Prod_PrecioVenta] FROM [dbo].[tbProductos] WHERE [Prod_Id] = 1

INSERT INTO [dbo].[tbDetallesVentas]
VALUES(5, 6, 3, @PrecioVenta, null, 1, 1, GETDATE(), null, null);
GO

DECLARE @PrecioVenta AS DECIMAL(18,2);
SELECT @PrecioVenta = [Prod_PrecioVenta] FROM [dbo].[tbProductos] WHERE [Prod_Id] = 1

INSERT INTO [dbo].[tbDetallesVentas]
VALUES(6, 7, 3, @PrecioVenta, null, 1, 1, GETDATE(), null, null);
GO

DECLARE @PrecioVenta AS DECIMAL(18,2);
SELECT @PrecioVenta = [Prod_PrecioVenta] FROM [dbo].[tbProductos] WHERE [Prod_Id] = 1

INSERT INTO [dbo].[tbDetallesVentas]
VALUES(7, 8, 3, @PrecioVenta, null, 1, 1, GETDATE(), null, null);
GO

DECLARE @PrecioVenta AS DECIMAL(18,2);
SELECT @PrecioVenta = [Prod_PrecioVenta] FROM [dbo].[tbProductos] WHERE [Prod_Id] = 1

INSERT INTO [dbo].[tbDetallesVentas]
VALUES(8, 9, 5, @PrecioVenta, null, 1, 1, GETDATE(), null, null);
GO

DECLARE @PrecioVenta AS DECIMAL(18,2);
SELECT @PrecioVenta = [Prod_PrecioVenta] FROM [dbo].[tbProductos] WHERE [Prod_Id] = 1

INSERT INTO [dbo].[tbDetallesVentas]
VALUES(9, 10, 2, @PrecioVenta, null, 1, 1, GETDATE(), null, null);
GO

DECLARE @PrecioVenta AS DECIMAL(18,2);
SELECT @PrecioVenta = [Prod_PrecioVenta] FROM [dbo].[tbProductos] WHERE [Prod_Id] = 1

INSERT INTO [dbo].[tbDetallesVentas]
VALUES(10, 1, 6, @PrecioVenta, null, 1, 1, GETDATE(), null, null);
GO

DECLARE @PrecioVenta AS DECIMAL(18,2);
SELECT @PrecioVenta = [Prod_PrecioVenta] FROM [dbo].[tbProductos] WHERE [Prod_Id] = 1

INSERT INTO [dbo].[tbDetallesVentas]
VALUES(11, 8, 1, @PrecioVenta, null, 1, 1, GETDATE(), null, null);
GO

DECLARE @PrecioVenta AS DECIMAL(18,2);
SELECT @PrecioVenta = [Prod_PrecioVenta] FROM [dbo].[tbProductos] WHERE [Prod_Id] = 1

INSERT INTO [dbo].[tbDetallesVentas]
VALUES(12, 3, 3, @PrecioVenta, null, 1, 1, GETDATE(), null, null);
GO

DECLARE @PrecioVenta AS DECIMAL(18,2);
SELECT @PrecioVenta = [Prod_PrecioVenta] FROM [dbo].[tbProductos] WHERE [Prod_Id] = 1

INSERT INTO [dbo].[tbDetallesVentas]
VALUES(13, 11, 3, @PrecioVenta, null, 1, 1, GETDATE(), null, null);
GO

DECLARE @PrecioVenta AS DECIMAL(18,2);
SELECT @PrecioVenta = [Prod_PrecioVenta] FROM [dbo].[tbProductos] WHERE [Prod_Id] = 1

INSERT INTO [dbo].[tbDetallesVentas]
VALUES(14, 12, 4, @PrecioVenta, null, 1, 1, GETDATE(), null, null);
GO

DECLARE @PrecioVenta AS DECIMAL(18,2);
SELECT @PrecioVenta = [Prod_PrecioVenta] FROM [dbo].[tbProductos] WHERE [Prod_Id] = 1

INSERT INTO [dbo].[tbDetallesVentas]
VALUES(15, 6, 3, @PrecioVenta, null, 1, 1, GETDATE(), null, null);
GO

--10 INSERTS a 'tbCompras'
INSERT INTO [dbo].[tbCompras]
VALUES(1, GETDATE(), 1, 1, GETDATE(), null, null);
GO

INSERT INTO [dbo].[tbCompras]
VALUES(2, GETDATE(), 1, 1, GETDATE(), null, null);
GO

INSERT INTO [dbo].[tbCompras]
VALUES(3, GETDATE(), 1, 1, GETDATE(), null, null);
GO

INSERT INTO [dbo].[tbCompras]
VALUES(4, GETDATE(), 1, 1, GETDATE(), null, null);
GO

INSERT INTO [dbo].[tbCompras]
VALUES(5, GETDATE(), 1, 1, GETDATE(), null, null);
GO

INSERT INTO [dbo].[tbCompras]
VALUES(6, GETDATE(), 1, 1, GETDATE(), null, null);
GO

INSERT INTO [dbo].[tbCompras]
VALUES(7, GETDATE(), 1, 1, GETDATE(), null, null);
GO

INSERT INTO [dbo].[tbCompras]
VALUES(8, GETDATE(), 1, 1, GETDATE(), null, null);
GO

INSERT INTO [dbo].[tbCompras]
VALUES(9, GETDATE(), 1, 1, GETDATE(), null, null);
GO

INSERT INTO [dbo].[tbCompras]
VALUES(10, GETDATE(), 1, 1, GETDATE(), null, null);
GO

--15 INSERTS a 'tbDetalleCompras'
INSERT INTO tbDetallesCompras
VALUES(1, 1, 50, 25.00, 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbDetallesCompras
VALUES(1, 2, 30, 11.00, 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbDetallesCompras
VALUES(2, 3, 100, 52.00, 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbDetallesCompras
VALUES(3, 1, 30, 25.00, 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbDetallesCompras
VALUES(4, 2, 50, 13.00, 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbDetallesCompras
VALUES(5, 3, 50, 52.00, 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbDetallesCompras
VALUES(6, 4, 50, 150.63, 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbDetallesCompras
VALUES(7, 5, 50, 25.00, 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbDetallesCompras
VALUES(7, 10, 50, 150.00, 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbDetallesCompras
VALUES(8, 6, 50, 30.85, 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbDetallesCompras
VALUES(8, 10, 50, 90.00, 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbDetallesCompras
VALUES(9, 7, 50, 13.00, 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbDetallesCompras
VALUES(9, 10, 50, 47.00, 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbDetallesCompras
VALUES(10, 8, 50, 152.00, 1, 1, GETDATE(), null, null);
GO

INSERT INTO tbDetallesCompras
VALUES(10, 9, 50, 12.00, 1, 1, GETDATE(), null, null);
GO


/***********************************************ALTERS TABLES***********************************************/
--tbUsuarios
ALTER TABLE tbUsuarios ADD CONSTRAINT FK_tbUsuarios_Usua_IdCreacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdCreacion) REFERENCES tbUsuarios(Usua_Id) 
ALTER TABLE tbUsuarios ADD CONSTRAINT FK_tbUsuarios_Usua_IdModificacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdModificacion) REFERENCES tbUsuarios(Usua_Id) 

--tbDepartamentos
ALTER TABLE tbDepartamentos ADD CONSTRAINT FK_tbDepartamentos_Usua_IdCreacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdCreacion) REFERENCES tbUsuarios(Usua_Id) 
ALTER TABLE tbDepartamentos ADD CONSTRAINT FK_tbDepartamentos_Usua_IdModificacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdModificacion) REFERENCES tbUsuarios(Usua_Id) 

--tbMunicipios
ALTER TABLE tbMunicipios ADD CONSTRAINT FK_tbMunicipios_Usua_IdCreacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdCreacion) REFERENCES tbUsuarios(Usua_Id) 
ALTER TABLE tbMunicipios ADD CONSTRAINT FK_tbMunicipios_Usua_IdModificacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdModificacion) REFERENCES tbUsuarios(Usua_Id)

--tbDirecciones
ALTER TABLE tbDirecciones ADD CONSTRAINT FK_tbDirecciones_Usua_IdCreacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdCreacion) REFERENCES tbUsuarios(Usua_Id) 
ALTER TABLE tbDirecciones ADD CONSTRAINT FK_tbDirecciones_Usua_IdModificacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdModificacion) REFERENCES tbUsuarios(Usua_Id)

--tbTipoIdentificacion
ALTER TABLE tbTipoIdentificacion ADD CONSTRAINT	 FK_tbTipoIdentificacion_Usua_IdCreacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdCreacion) REFERENCES tbUsuarios(Usua_Id) 
ALTER TABLE tbTipoIdentificacion ADD CONSTRAINT	 FK_tbTipoIdentificacion_Usua_IdModificacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdModificacion) REFERENCES tbUsuarios(Usua_Id)

--tbEstadosCiviles
ALTER TABLE tbEstadosCiviles ADD CONSTRAINT FK_tbEstadosCiviles_Usua_IdCreacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdCreacion) REFERENCES tbUsuarios(Usua_Id) 
ALTER TABLE tbEstadosCiviles ADD CONSTRAINT FK_tbEstadosCiviles_Usua_IdModificacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdModificacion) REFERENCES tbUsuarios(Usua_Id) 

--tbEmpleados
ALTER TABLE tbEmpleados ADD CONSTRAINT FK_tbEmpleados_Usua_IdCreacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdCreacion) REFERENCES tbUsuarios(Usua_Id) 
ALTER TABLE tbEmpleados ADD CONSTRAINT FK_tbEmpleados_Usua_IdModificacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdModificacion) REFERENCES tbUsuarios(Usua_Id) 

--tbProveedor
ALTER TABLE tbProveedores ADD CONSTRAINT FK_tbProveedores_Usua_IdCreacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdCreacion) REFERENCES tbUsuarios(Usua_Id) 
ALTER TABLE tbProveedores ADD CONSTRAINT FK_tbProveedores_Usua_IdModificacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdModificacion) REFERENCES tbUsuarios(Usua_Id) 

--tbClientes
ALTER TABLE tbClientes ADD CONSTRAINT FK_tbClientes_Usua_IdCreacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdCreacion) REFERENCES tbUsuarios(Usua_Id) 
ALTER TABLE tbClientes ADD CONSTRAINT FK_tbClientes_Usua_IdModificacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdModificacion) REFERENCES tbUsuarios(Usua_Id) 

--tbCategorias
ALTER TABLE tbCategorias ADD CONSTRAINT FK_tbCategorias_Usua_IdCreacion_tbUsuarios_Usua_IdCreacion FOREIGN KEY (Usua_IdCreacion) REFERENCES tbUsuarios(Usua_Id)
ALTER TABLE tbCategorias ADD CONSTRAINT FK_tbCategorias_Usua_IdModifiacion_tbUsuarios_Usua_Id FOREIGN KEY (Usua_IdModifiacion) REFERENCES tbUsuarios(Usua_Id)

--tbProductos
ALTER TABLE tbProductos ADD CONSTRAINT FK_tbProductos_Usua_IdCreacion_tbUsuarios_Usua_Id FOREIGN KEY (Usua_IdCreacion) REFERENCES  tbUsuarios(Usua_Id)
ALTER TABLE tbProductos ADD CONSTRAINT FK_tbProductos_Usua_IdModificacion_tbUsuarios_Usua_Id FOREIGN KEY (Usua_IdModificacion) REFERENCES  tbUsuarios(Usua_Id)

--tbCompras
ALTER TABLE tbCompras ADD CONSTRAINT FK_tbCompras_Usua_IdCreacion_tbUsuarios_Usua_Id FOREIGN KEY (Usua_IdCreacion) REFERENCES  tbUsuarios(Usua_Id)
ALTER TABLE tbCompras ADD CONSTRAINT FK_tbCompras_Usua_IdModificacion_tbUsuarios_Usua_Id FOREIGN KEY (Usua_IdModificacion) REFERENCES  tbUsuarios(Usua_Id)

--tbDetallesCompras
ALTER TABLE tbDetallesCompras ADD CONSTRAINT FK_tbDetallesCompras_Usua_IdCreacion FOREIGN KEY (Usua_IdCreacion) REFERENCES tbUsuarios(Usua_Id)
ALTER TABLE tbDetallesCompras ADD CONSTRAINT FK_tbDetallesCompras_Usua_IdModificacion FOREIGN KEY (Usua_IdModificacion) REFERENCES tbUsuarios(Usua_Id)

--tbVentas
ALTER TABLE tbVentas ADD CONSTRAINT FK_tbVentas_Usua_IdCreacion_tbUsuarios_Usua_Id FOREIGN KEY (Usua_IdCreacion) REFERENCES tbUsuarios(Usua_Id)
ALTER TABLE tbVentas ADD CONSTRAINT FK_tbVentas_Usua_IdModificacion_tbUsuarios_Usua_Id FOREIGN KEY (Usua_IdModificacion) REFERENCES tbUsuarios(Usua_Id)

--tbDetallesVentas
ALTER TABLE tbDetallesVentas ADD CONSTRAINT FK_tbDetallesVentas_Usua_IdCreacion_tbUsuarios_Usua_Id FOREIGN KEY (Usua_IdCreacion) REFERENCES tbUsuarios(Usua_Id)
ALTER TABLE tbDetallesVentas ADD CONSTRAINT FK_tbDetallesVentas_Usua_IdModificacion_tbUsuarios_Usua_Id  FOREIGN KEY (Usua_IdModificacion) REFERENCES tbUsuarios(Usua_Id)

