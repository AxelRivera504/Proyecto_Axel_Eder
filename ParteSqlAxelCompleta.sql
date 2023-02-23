--CREATE DATABASE BDSistema_Ventas
--GO
USE BDSistema_Ventas


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


--TABLA ESantaDOS CIVILES
CREATE TABLE tbESantadosCiviles(
	EsCi_Id					CHAR(1)NOT NULL,
	EsCi_ESantadoCivil		NVARCHAR(150) NOT NULL,
	Usua_IdCreacion			INT NOT NULL,
	EsCi_FechaCreacion		DATETIME NOT NULL,
	Usua_IdModificacion		INT,
	EsCi_FechaModificacion	DATETIME,
	CONSTRAINT PK_tbESantadosCiviles_EsCi_Id PRIMARY KEY(EsCi_Id),	
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
	Empl_ESantado				BIT NOT NULL,
	Usua_IdCreacion			INT NOT NULL,
	Empl_FechaCreacion		DATETIME NOT NULL,
	Usua_IdModificacion		INT,
	Empl_FechaModificacion	DATETIME
	CONSTRAINT PK_tbEmpleados_Empl_Id PRIMARY KEY(Empl_Id),
	CONSTRAINT FK_tbEmpleados_EsCi_Id_tbESantadosCiviles_EsCi_Id FOREIGN KEY(EsCi_Id) REFERENCES tbESantadosCiviles(EsCi_Id),
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
	Usua_ESantado				BIT NOT NULL,
	Usua_IdCreacion			INT NOT NULL,
	Usua_FechaCreacion		DATETIME NOT NULL,
	Usua_IdModificacion		INT,
	Usua_FechaModificacion	DATETIME
	CONSTRAINT PK_tbUsuarios_Usua_Id PRIMARY KEY(Usua_Id),
	CONSTRAINT FK_tbUsuarios_Empl_Id_tbEmpleados_Empl_Id FOREIGN KEY(Empl_Id) REFERENCES tbEmpleados(Empl_Id),
);



--TABLA PROVEEDOR
CREATE TABLE tbProveedores(
	Prov_Id					INT IDENTITY(1,1),
	Prov_Rut				VARCHAR(14) NOT NULL,
	Prov_Nombre				NVARCHAR(150) NOT NULL,
	Dire_Id					INT NOT NULL,
	Prov_Telefono			VARCHAR(9) NOT NULL,
	Prov_PaginaWeb			NVARCHAR(255) NOT NULL,
	Prov_ESantado				BIT NOT NULL,
	Usua_IdCreacion			INT NOT NULL,
	Prov_FechaCreacion		DATETIME  NOT NULL,
	Usua_IdModificacion		INT,
	Prov_FechaModificacion	DATETIME
	CONSTRAINT PK_tbProveedores_Prov_Id PRIMARY KEY(Prov_Id),
	CONSTRAINT FK_tbProveedores_Dire_Id_tbDirecciones_Dire_Id FOREIGN KEY(Dire_Id) REFERENCES tbDirecciones(Dire_Id)
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
	Clie_ESantado				BIT NOT NULL,
	Usua_IdCreacion			INT NOT NULL,
	Clie_FechaCreacion		DATETIME NOT NULL,
	Usua_IdModificacion		INT,
	Clie_FechaModificacion	DATETIME
	CONSTRAINT PK_tbClientes_Clie_Id PRIMARY KEY(Clie_Id),
	CONSTRAINT FK_tbClientes_TiId_ID_tbTipoIdentificacion_TiId_ID FOREIGN KEY(TiId_ID) REFERENCES tbTipoIdentificacion(TiId_ID),
	CONSTRAINT FK_tbClientes_Dire_Id_tbDirecciones_Dire_Id FOREIGN KEY(Dire_Id) REFERENCES tbDirecciones(Dire_Id),
);


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
VALUES('1521','SILCASilca15',1,GETDATE(),NULL,NULL);
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


--INSERTS tbESantadosCiviles
INSERT INTO tbESantadosCiviles
VALUES ('S', 'Soltero(a)', 1, GETDATE(), null, null);
GO

INSERT INTO tbESantadosCiviles
VALUES ('C', 'Casado(a)', 1, GETDATE(), null, null);
GO

INSERT INTO tbESantadosCiviles
VALUES ('V', 'Viudo(a)', 1, GETDATE(), null, null);
GO

INSERT INTO tbESantadosCiviles
VALUES ('D', 'Divorciado(a)', 1, GETDATE(), null, null);
GO

INSERT INTO tbESantadosCiviles
VALUES ('U', 'Union Libre', 1, GETDATE(), null, null);
GO


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
VALUES(1, 'Admin', @Pass, 0, 1, 1, GETDATE(), NULL, NULL);
GO

DECLARE @Pass AS NVARCHAR(MAX);
DECLARE @Clave AS NVARCHAR(250);
SET @Clave = 'ESDRINHA'
SET @Pass = CONVERT (NVARCHAR(MAX), HASHBYTES('sha2_512',@Clave),2)

INSERT INTO tbUsuarios
VALUES(16, 'ECERNA', @Pass, 0, 1, 1, GETDATE(), NULL, NULL);
GO



--ALTER TABLE PARA LAS TABLAS CUANDO SE LLENE LA TABLA DE USUARIOS

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

--tbESantadosCiviles

ALTER TABLE tbESantadosCiviles ADD CONSTRAINT FK_tbESantadosCiviles_Usua_IdCreacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdCreacion) REFERENCES tbUsuarios(Usua_Id) 
ALTER TABLE tbESantadosCiviles ADD CONSTRAINT FK_tbESantadosCiviles_Usua_IdModificacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdModificacion) REFERENCES tbUsuarios(Usua_Id) 

--tbEmpleados

ALTER TABLE tbEmpleados ADD CONSTRAINT FK_tbEmpleados_Usua_IdCreacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdCreacion) REFERENCES tbUsuarios(Usua_Id) 
ALTER TABLE tbEmpleados ADD CONSTRAINT FK_tbEmpleados_Usua_IdModificacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdModificacion) REFERENCES tbUsuarios(Usua_Id) 


--tbProveedor

ALTER TABLE tbProveedores ADD CONSTRAINT FK_tbProveedores_Usua_IdCreacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdCreacion) REFERENCES tbUsuarios(Usua_Id) 
ALTER TABLE tbProveedores ADD CONSTRAINT FK_tbProveedores_Usua_IdModificacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdModificacion) REFERENCES tbUsuarios(Usua_Id) 

--tbClientes

ALTER TABLE tbClientes ADD CONSTRAINT FK_tbClientes_Usua_IdCreacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdCreacion) REFERENCES tbUsuarios(Usua_Id) 
ALTER TABLE tbClientes ADD CONSTRAINT FK_tbClientes_Usua_IdModificacion_tbUsuarios_Usua_Id FOREIGN KEY(Usua_IdModificacion) REFERENCES tbUsuarios(Usua_Id) 


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
VALUES('06131998178530', 'Jose Miguel', 10, 'CuerosVaca.com',1,1,GETDATE(),NULL,NULL);
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