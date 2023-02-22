CREATE DATABASE BDVENTAS
GO
USE BDVENTAS


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



--TABLA TIPO IDENTIFICACION
CREATE TABLE tbTipoIdentificacion(
	TiId_ID				INT IDENTITY(1,1),
	TiId_Identificacion	NVARCHAR(150) NOT NULL,
	Usua_IdCreacion			INT NOT NULL,
	TiId_FechaCreacion		DATETIME NOT NULL,
	Usua_IdModificacion		INT,
	TiId_FechaModificacion	DATETIME
	CONSTRAINT PK_tbTipoIdentificacion_TiId_ID PRIMARY KEY(TiId_ID),	
);


--TABLA ESTADOS CIVILES
CREATE TABLE tbEstadosCiviles(
	EsCi_Id					CHAR(1)NOT NULL,
	EsCi_EstadoCivil		NVARCHAR(150) NOT NULL,
	Usua_IdCreacion			INT NOT NULL,
	EsCi_FechaCreacion		DATETIME NOT NULL,
	Usua_IdModificacion		INT,
	EsCi_FechaModificacion	DATETIME,
	CONSTRAINT PK_tbEstadosCiviles_EsCi_Id PRIMARY KEY(EsCi_Id),
	
);



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
	CONSTRAINT FK_tbUsuarios_Empl_Id_tbEmpleados_Empl_Id FOREIGN KEY(Empl_Id) REFERENCES tbEmpleados(Empl_Id),
	CONSTRAINT FK_tbUsuarios_Usua_IdModificacion FOREIGN KEY(Usua_IdModificacion) REFERENCES tbUsuarios(Usua_Id)
);



--TABLA PROVEEDOR
CREATE TABLE tbProveedor(
	Prov_Id					INT IDENTITY(1,1),
	Prov_Rut				VARCHAR(14) NOT NULL,
	Prov_Nombre				NVARCHAR(150) NOT NULL,
	Prov_Telefono			VARCHAR(9) NOT NULL,
	Prov_PaginaWeb			NVARCHAR(255) NOT NULL,
	Prov_Estado				BIT NOT NULL,
	Usua_IdCreacion			INT NOT NULL,
	Prov_FechaCreacion		DATETIME  NOT NULL,
	Usua_IdModificacion		INT,
	Prov_FechaModificacion	DATETIME
	CONSTRAINT PK_tbProveedor_Prov_Id PRIMARY KEY(Prov_Id),
	CONSTRAINT FK_tbProveedor_Usua_IdCreacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdCreacion) REFERENCES  tbUsuarios(Usua_Id),
	CONSTRAINT FK_tbProveedor_Usua_IdModificacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdModificacion) REFERENCES  tbUsuarios(Usua_Id)
);

--TABLA CLIENTES
CREATE TABLE tbClientes(
	Clie_Id					INT IDENTITY(1,1),
	TiId_ID					INT NOT NULL,
	Clie_Identificacion		VARCHAR(15) NOT NULL,
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
	CONSTRAINT FK_tbClientes_Dire_Id_tbDirecciones_Dire_Id FOREIGN KEY(Dire_Id) REFERENCES tbDirecciones(Dire_Id),
	CONSTRAINT FK_tbClientes_Usua_IdCreacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdCreacion) REFERENCES tbUsuarios(Usua_Id),
	CONSTRAINT FK_tbClientes_Usua_IdModificacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdModificacion) REFERENCES tbUsuarios(Usua_Id)
);
