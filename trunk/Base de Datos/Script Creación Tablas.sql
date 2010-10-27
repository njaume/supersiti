--CREATE DATABASE DES_SUPER
USE DEV_SUPER
-- V:Ventas, C:Comercializaci�n, A:Tablas auxiliares

-- =============================================================================================
--                      USUARIO, MODULOS Y ROLES DEL SISTEMA
-- =============================================================================================


CREATE TABLE [dbo].[S_MODULO](
	[MOD_ID] [INT] IDENTITY (1,1) NOT NULL,
	[MOD_NOMBRE] [VARCHAR](100) NOT NULL,
	[MOD_DESCRIPCION] [VARCHAR](250),
	[MOD_TIPO] [VARCHAR] (100),
	[MOD_URL] [VARCHAR](250),
	[MOD_ORDEN] [INT],
	[MOD_IDPADRE] [INT],
	[MOD_ESTADO] [INT],
	[MOD_FECHAALTA] [DATETIME],
	PRIMARY KEY ([MOD_ID])
)

CREATE TABLE [dbo].[S_ROL](
	[ROL_ID] [INT] IDENTITY (1,1) NOT NULL,
	[ROL_NOMBRE] [VARCHAR] (100),
	[ROL_ESTADO] [INT],
	[ROL_FECHAALTA] [DATETIME],
	PRIMARY KEY ([ROL_ID])
)

CREATE TABLE [dbo].[S_USUARIO](
	[USU_ID] [INT] IDENTITY (1,1) NOT NULL,
	[USU_NOMBRE] [VARCHAR] (100) NOT NULL,
	[USU_PASSWORD] [VARCHAR] (250) NOT NULL,
	[USU_MAIL] [VARCHAR](200),
	[USU_ESTADO] [INT],
	[USU_FECHAALTA] [DATETIME],
	[ROL_ID] [INT],
	PRIMARY KEY ([USU_ID]),
	CONSTRAINT [FK_USUARIO_ROL] FOREIGN KEY ([ROL_ID]) REFERENCES [S_ROL] ([ROL_ID])
)

CREATE TABLE [dbo].[S_ROL_MODULO](
	[ROM_ID] [INT] IDENTITY (1,1) NOT NULL,
	[ROM_ESTADO] [INT],
	[ROL_ID] [INT],
	[MOD_ID] [INT],
	PRIMARY KEY ([ROM_ID]),
	CONSTRAINT [FK_ROL_MODULO_ROLES] FOREIGN KEY ([ROL_ID]) REFERENCES [S_ROL] ([ROL_ID]),
	CONSTRAINT [FK_ROL_MODULO_MODULOS] FOREIGN KEY ([MOD_ID]) REFERENCES [S_MODULO] ([MOD_ID])
)
-- ESTADO DE CAJA CONTIENE LOS ESTADOS APERTURA, CIERRE X, CIERRE Z
CREATE TABLE [dbo].[V_CAJA_ESTADO](
	[CAE_ID] [INT] IDENTITY(1,1) NOT NULL,
	[CAE_NOMBRE] [VARCHAR] (80) NOT NULL,
	[CAE_ESTADO] [INT],
	[CAE_FECHAALTA] [DATETIME],
	PRIMARY KEY ([CAE_ID])
)

-- ====================================================================================
--                                  INICIO DE SCRIPT PARA CAJAS
-- ====================================================================================
CREATE TABLE [dbo].[V_CAJA](
	[CAJ_ID] [INT] IDENTITY (1,1) NOT NULL,
	[CAJ_NUMERO] [INT] NOT NULL,
	[CAE_ID] [INT], -- CAJA ESTADO (ABIERTA, CERRADA, CIERRE Z, ETC)
	[CAJ_FECHAAPERTURA] [DATETIME],
	[CAJ_FECHACIERRE] [DATETIME],
	[CAJ_ESTADO] [INT],
	[CAJ_FECHAALTA] [DATETIME],
	PRIMARY KEY ([CAJ_ID]),
	CONSTRAINT [FK_CAJA_ESTADOS_CAJA] FOREIGN KEY ([CAE_ID]) REFERENCES [V_CAJA_ESTADO] ([CAE_ID])
)

CREATE TABLE [dbo].[V_CAJA_ACCIONES](
	[CAA_ID] [INT] IDENTITY (1,1) NOT NULL,
	[CAA_IMPORTE] [NUMERIC] (18,2),
/*	[CAA_IMPORTE_RETIRO] [NUMERIC] (18,2),
	[CAA_IMPORTE_CIERREX][NUMERIC] (18,2),
	[CAA_FECHA_INICIO] [DATETIME],
	[CAA_FECHA_RETIRO] [DATETIME],*/
	[CAA_FECHA] [DATETIME],
	[CAE_ID] [INT],
	[USU_ID] [INT],
	[CAA_ESTADO] [INT],
	[CAA_FECHAALTA][DATETIME],
	PRIMARY KEY ([CAA_ID]),
	CONSTRAINT [FK_CAJA_ACCIONES_ESTADO] FOREIGN KEY ([CAE_ID]) REFERENCES [V_CAJA_ESTADO] ([CAE_ID]),
	CONSTRAINT [FK_CAJA_ACCIONES_USUARIO] FOREIGN KEY ([USU_ID]) REFERENCES [S_USUARIO] ([USU_ID])
)

CREATE TABLE [dbo].[V_CAJA_CIERRES](
	[CAC_ID] [INT] IDENTITY (1,1) NOT NULL,
	[CAC_EFECTIVO] [NUMERIC] (18,2),
	[CAC_BONO] [NUMERIC] (18,2),
	[CAC_TARJETA] [NUMERIC] (18,2),
	[CAC_CREDITO] [NUMERIC] (18,2),
	[CAC_ESTADO] [INT],
	[CAC_FECHAALTA] [DATETIME],
	PRIMARY KEY ([CAC_ID])	
)

-- ====================================================================================
--                    INICIO SCRIPT PARA COMERCIALIZACION
-- ====================================================================================
CREATE TABLE [dbo].[C_UNIDAD](
	[UNI_ID] [INT] IDENTITY (1,1) NOT NULL,
	[UNI_NOMBRE] [VARCHAR](100) NOT NULL,
	[UNI_SIGLA] [VARCHAR](10),
	[UNI_ESTADO] [INT],
	[UNI_FECHAALTA] [DATETIME],
	[UNI_FECHAMODIFICADA] [DATETIME],
	PRIMARY KEY ([UNI_ID])
)

CREATE TABLE [dbo].[C_RUBRO](
	[RUB_ID] [INT] IDENTITY (1,1) NOT NULL,
	[RUB_NOMBRE] [VARCHAR](100) NOT NULL,
	[RUB_DESCRIPCION] [VARCHAR](250),
	[RUB_ESTADO] [INT] DEFAULT 1,
	[RUB_FECHAALTA] [DATETIME] ,
	[RUB_FECHAMODIFICADA] [DATETIME],
	PRIMARY KEY ([RUB_ID])
)

CREATE TABLE [dbo].[C_FAMILIA](
	[FAM_ID] [INT] IDENTITY (1,1) NOT NULL,
	[FAM_NOMBRE] [VARCHAR](100) NOT NULL,
	[FAM_DESCRIPCION] [VARCHAR](250),
	[RUB_ID] [INT],
	[FAM_ESTADO] [INT] DEFAULT 1,
	[FAM_FECHAALTA] [DATETIME],
	[FAM_FECHAMODIFICADA] [DATETIME],
	PRIMARY KEY ([FAM_ID]),
	CONSTRAINT [PK_RUBRO_FAMILIA] FOREIGN KEY ([RUB_ID]) REFERENCES [C_RUBRO] ([RUB_ID])
)

CREATE TABLE [dbo].[C_PRODUCTO](
	[PRO_ID] [INT] IDENTITY (1,1) NOT NULL,
	[PRO_CODIGO] [VARCHAR](20),
	[PRO_NOMBRE] [VARCHAR](250) NOT NULL,
	[PRO_DESCRIPCION] [VARCHAR](500),
	[PRO_MARCA] [VARCHAR](100),
	[PRO_PRECIOCOSTO] [NUMERIC] (18,2),
	[PRO_PRECIOCOMPRA] [NUMERIC](18,2),
	[PRO_IVA] [NUMERIC] (18,2),
	[PRO_IMPUESTOINTERNO] [NUMERIC](18,2),
	[PRO_IDPADRE] [INT],
	[PRO_MINIMO] [INT],
	[PRO_MAXIMO] [INT],
	[PRO_ALERTA] [INT],	
	[UNC_ID] [INT], -- UNIDAD DE COMPRA
	[UNV_ID] [INT], -- UNIDAD DE VENTA
	[FAM_ID] [INT], -- RUBRO
	[RUB_ID] [INT], -- FAMILIA
	[PRO_ESTADO] [INT] DEFAULT 1,
	PRIMARY KEY ([PRO_ID]),
	CONSTRAINT [PK_PRODUCTO_UNIDAD_COMPRA] FOREIGN KEY ([UNC_ID]) REFERENCES [C_UNIDAD] ([UNI_ID]),
	CONSTRAINT [PK_PRODUCTO_UNIDAD_VENTA] FOREIGN KEY ([UNV_ID]) REFERENCES [C_UNIDAD] ([UNI_ID]),
	CONSTRAINT [PK_PRODUCTO_RUBRO] FOREIGN KEY ([RUB_ID]) REFERENCES [C_RUBRO] ([RUB_ID]),
	CONSTRAINT [PK_PRODUCTO_FAMILIA] FOREIGN KEY ([FAM_ID]) REFERENCES [C_FAMILIA] ([FAM_ID])
)

--IMPUESTO IVA SER� EL PORCENTAJE DE IVA, CATEGOR�A IVA SER�, POR EJEMPLO, RESPONSABLE INSCRIPTO
CREATE TABLE [dbo].[A_IMPUESTOIVA](
	[IVA_ID] [INT] IDENTITY (1,1) NOT NULL,
	[IVA_NOMBRE] [VARCHAR](250) NOT NULL,
	[IVA_TASA] [NUMERIC](18,2), -- PORCENTAJE DE IVA 21, 10.5, 27
	[IVA_ORDEN] [INT],
	[IVA_FECHAALTA] [DATETIME],
	[IVA_ESTADO] [INT] DEFAULT 1,
	PRIMARY KEY ([IVA_ID])
)
