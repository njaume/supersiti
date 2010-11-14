USE DES_SUPER

-- PROCEDIMIENTOS DE CAJAS ESTADO

CREATE PROCEDURE [dbo].[STR_NUEVO_CAJA_TIPO_MOVIMIENTO](
	@CAE_ID AS INT OUTPUT,
	@CAE_NOMBRE AS VARCHAR(80),
	@CAE_ESTADO AS INT
)
AS

BEGIN
	BEGIN TRANSACTION
		--BEGIN TRY
			INSERT INTO V_CAJA_TIPO_MOVIMIENTO (CAE_NOMBRE,CAE_ESTADO,CAE_FECHAALTA)
			VALUES (@CAE_NOMBRE,@CAE_ESTADO,GETDATE())
			
		--END TRY
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR
				SET @CAE_ID = -1
				ROLLBACK TRANSACTION
			--	RETURN @CAE_ID
			END
		ELSE
			BEGIN
				SET @CAE_ID = @@IDENTITY
				COMMIT TRANSACTION
<<<<<<< .mine
=======

>>>>>>> .r36
				--RETURN @CAE_ID
			END		
	RETURN @CAE_ID
/*	BEGIN CATCH
		SELECT ERROR_MESSAGE(), ERROR_NUMBER()
		ROLLBACK TRANSACTION
		SET @CAE_ID = -1
		RETURN @CAE_ID
	END CATCH*/
END

go

CREATE PROCEDURE [dbo].[STR_MODIFICA_CAJA_TIPO_MOVIEMIENTO](
	@CAE_ID AS INT OUTPUT,
	@CAE_NOMBRE AS VARCHAR(80),
	@CAE_ESTADO AS INT
)

AS

BEGIN
	BEGIN TRANSACTION
		--BEGIN TRY
			IF (@CAE_ESTADO = 2)
				BEGIN
					UPDATE V_CAJA_TIPO_MOVIMIENTO SET
						CAE_ESTADO = @CAE_ESTADO
					WHERE CAE_ID = @CAE_ID
				END
			ELSE
				BEGIN
					UPDATE V_CAJA_TIPO_MOVIMIENTO SET
						CAE_NOMBRE = @CAE_NOMBRE,
						CAE_ESTADO = @CAE_ESTADO
					WHERE CAE_ID = @CAE_ID
				END
			--RETURN @CAE_ID
		--END TRY
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(), ERROR_NUMBER()
				SET @CAE_ID = -1
				ROLLBACK TRANSACTION
				--RETURN @CAE_ID
			END
		ELSE
			BEGIN
				COMMIT TRANSACTION
				--RETURN @CAE_ID
			END
		RETURN @CAE_ID
	/*BEGIN CATCH
		SELECT ERROR_MESSAGE(), ERROR_NUMBER()
		ROLLBACK TRANSACTION
		SET @CAE_ID = -1
		RETURN @CAE_ID
	END CATCH*/
END
go

--  PROCEDIMIENTOS DE CAJA
CREATE PROCEDURE [dbo].[STR_NUEVO_CAJA](
	@CAJ_ID AS INT OUTPUT,
	@CAJ_NUMERO AS INT,
	@CAJ_ESTADO AS INT
)
AS

BEGIN
	BEGIN TRANSACTION
--		BEGIN TRY
			INSERT INTO V_CAJA (CAJ_NUMERO,CAJ_ESTADO)
			VALUES (@CAJ_NUMERO,@CAJ_ESTADO)
			SET @CAJ_ID = @@IDENTITY
			--RETURN @CAJ_ID
--		END TRY
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(), ERROR_NUMBER()
				SET @CAJ_ID = -1
				ROLLBACK TRANSACTION
				--RETURN @CAJ_ID
			END
		ELSE
			BEGIN
				SET @CAJ_ID = @@IDENTITY
				COMMIT TRANSACTION
				--RETURN @CAJ_ID
			END
		RETURN @CAJ_ID
/*	BEGIN CATCH
		SELECT ERROR_MESSAGE(), ERROR_NUMBER()
		ROLLBACK TRANSACTION
		SET @CAJ_ID = -1
		RETURN @CAJ_ID
	END CATCH*/
END

go

CREATE PROCEDURE [dbo].[STR_MODIFICA_CAJA](
	@CAJ_ID AS INT OUTPUT,
	@CAJ_NUMERO AS INT,
	@CAJ_ESTADO AS INT
)

AS

BEGIN
	BEGIN TRANSACTION
		--BEGIN TRY
			IF (@CAJ_ESTADO = 2)
				BEGIN
					UPDATE V_CAJA SET
						CAJ_ESTADO = @CAJ_ESTADO
					WHERE CAJ_ID = @CAJ_ID
				END
			ELSE
				BEGIN
					UPDATE V_CAJA SET
						CAJ_NUMERO = @CAJ_NUMERO,
						CAJ_ESTADO = @CAJ_ESTADO
					WHERE CAJ_ID = @CAJ_ID
				END
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(), ERROR_NUMBER()
				SET @CAJ_ID = -1
				ROLLBACK TRANSACTION
				--RETURN @CAJ_ID
			END
		ELSE
			BEGIN
		--END TRY
				COMMIT TRANSACTION
				--RETURN @CAJ_ID
			END
			
		RETURN @CAJ_ID
	/*BEGIN CATCH
		SELECT ERROR_MESSAGE(), ERROR_NUMBER()
		ROLLBACK TRANSACTION
		SET @CAJ_ID = -1
		RETURN @CAJ_ID
	END CATCH*/
END
go

-- NO NECESITA MODIFICACIONES
CREATE PROCEDURE [dbo].[STR_NUEVO_CAJA_MOVIMIENTOS](
	@CAM_ID AS INT OUTPUT,
	@CAM_IMPORTE AS NUMERIC(18,2),
	@CAM_FECHA AS DATETIME,
	@CAE_ID AS INT,
	@USU_ID AS INT,
	@CAM_ESTADO AS INT
)
AS

BEGIN
	BEGIN TRANSACTION
--		BEGIN TRY
			INSERT INTO V_CAJA_MOVIMIENTOS (CAM_IMPORTE,CAM_FECHA,CAE_ID,USU_ID,CAM_ESTADO,CAM_FECHAALTA)
			VALUES (@CAM_IMPORTE,@CAM_FECHA,@CAE_ID,@USU_ID,@CAM_ESTADO,GETDATE())
			SET @CAM_ID = @@IDENTITY
			--RETURN @CAM_ID
--		END TRY
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(), ERROR_NUMBER()
				SET @CAM_ID = -1
				ROLLBACK TRANSACTION
				--RETURN @CAJ_ID
			END
		ELSE
			BEGIN
				SET @CAM_ID = @@IDENTITY
				COMMIT TRANSACTION
				--RETURN @CAJ_ID
			END
		RETURN @CAM_ID
/*	BEGIN CATCH
		SELECT ERROR_MESSAGE(), ERROR_NUMBER()
		ROLLBACK TRANSACTION
		SET @CAJ_ID = -1
		RETURN @CAJ_ID
	END CATCH*/
END
go

CREATE PROCEDURE [dbo].[STR_NUEVO_CAJA_CIERRES](
	@CAC_ID AS INT OUTPUT,
	@CAC_EFECTIVO AS NUMERIC(18,2),
	@CAC_BONO AS NUMERIC (18,2),
	@CAC_TARJETA AS NUMERIC (18,2),
	@CAC_CREDITO AS NUMERIC(18,2),
	@CAC_ESTADO AS INT
)
AS

BEGIN
	BEGIN TRANSACTION
--		BEGIN TRY
			INSERT INTO V_CAJA_CIERRES (CAC_EFECTIVO,CAC_BONO,CAC_TARJETA,CAC_CREDITO,CAC_ESTADO)
			VALUES (@CAC_EFECTIVO,@CAC_BONO,@CAC_TARJETA,@CAC_CREDITO,1)
			SET @CAC_ID = @@IDENTITY
			--RETURN @CAC_ID
--		END TRY
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(), ERROR_NUMBER()
				SET @CAC_ID = -1
				ROLLBACK TRANSACTION
				--RETURN @CAJ_ID
			END
		ELSE
			BEGIN
				SET @CAC_ID = @@IDENTITY
				COMMIT TRANSACTION
				--RETURN @CAJ_ID
			END
		RETURN @CAC_ID
/*	BEGIN CATCH
		SELECT ERROR_MESSAGE(), ERROR_NUMBER()
		ROLLBACK TRANSACTION
		SET @CAJ_ID = -1
		RETURN @CAJ_ID
	END CATCH*/
END

go

-- PROCEDIMIENTOS DE UNIDADES

CREATE PROCEDURE [dbo].[STR_NUEVO_UNIDAD](
	@UNI_ID AS INT OUTPUT,
	@UNI_NOMBRE AS VARCHAR(100),
	@UNI_SIGLA AS VARCHAR (10),
	@UNI_ESTADO AS INT
)
AS

BEGIN
	BEGIN TRANSACTION
--		BEGIN TRY
			INSERT INTO C_UNIDAD (UNI_NOMBRE,UNI_SIGLA,UNI_ESTADO)
			VALUES (@UNI_NOMBRE,@UNI_SIGLA,@UNI_ESTADO)
--			SET @UNI_ID = @@IDENTITY
--			RETURN @UNI_ID
--		END TRY
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(), ERROR_NUMBER()
				SET @UNI_ID = -1
				ROLLBACK TRANSACTION
				--RETURN @UNI_ID
			END
		ELSE
			BEGIN
				SET @UNI_ID = @@IDENTITY
				COMMIT TRANSACTION
				--RETURN @UNI_ID
			END
			RETURN @UNI_ID
	/*BEGIN CATCH
		SELECT ERROR_MESSAGE(), ERROR_NUMBER()
		ROLLBACK TRANSACTION
		SET @UNI_ID = -1
		RETURN @UNI_ID
	END CATCH*/
END

go

CREATE PROCEDURE [dbo].[STR_MODIFICA_UNIDAD](
	@UNI_ID AS INT OUTPUT,
	@UNI_NOMBRE AS VARCHAR(100),
	@UNI_SIGLA AS VARCHAR (10),
	@UNI_ESTADO AS INT
)

AS

BEGIN
	BEGIN TRANSACTION
--		BEGIN TRY
			IF (@UNI_ESTADO = 2)
				BEGIN
					UPDATE C_UNIDAD SET
						UNI_ESTADO = @UNI_ESTADO
					WHERE UNI_ID = @UNI_ID
				END
			ELSE
				BEGIN
					UPDATE C_UNIDAD SET
						UNI_NOMBRE = @UNI_NOMBRE,
						UNI_SIGLA = @UNI_SIGLA,
						UNI_ESTADO = @UNI_ESTADO
					WHERE UNI_ID = @UNI_ID
				END
			IF (@@ERROR != 0)
				BEGIN
					SELECT @@ERROR --ERROR_MESSAGE(), ERROR_NUMBER()
					ROLLBACK TRANSACTION
					SET @UNI_ID = -1
					ROLLBACK TRANSACTION
--					RETURN @UNI_ID
				END
			ELSE
				BEGIN
					COMMIT TRANSACTION
--					RETURN @UNI_ID
				END
			RETURN @UNI_ID
--		END TRY
/*	BEGIN CATCH
		SELECT ERROR_MESSAGE(), ERROR_NUMBER()
		ROLLBACK TRANSACTION
		SET @UNI_ID = -1
		RETURN @UNI_ID
	END CATCH*/
END

go

-- PROCEDIMIENTOS DE RUBRO

CREATE PROCEDURE [dbo].[STR_NUEVO_RUBRO](
	@RUB_ID AS INT OUTPUT,
	@RUB_NOMBRE AS VARCHAR(100),
	@RUB_DESCRIPCION AS VARCHAR(250),
	@RUB_ESTADO AS INT
)
AS

BEGIN
	BEGIN TRANSACTION 
--		BEGIN TRY
			INSERT INTO C_RUBRO (RUB_NOMBRE,RUB_DESCRIPCION,RUB_ESTADO,RUB_FECHAALTA)
			VALUES (@RUB_NOMBRE,@RUB_DESCRIPCION,@RUB_ESTADO,GETDATE())
		IF (@@ERROR != 0)			
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(), ERROR_NUMBER()
				SET @RUB_ID = -1
				ROLLBACK TRANSACTION
				--RETURN @RUB_ID
			END
		ELSE
			BEGIN
				SET @RUB_ID = @@IDENTITY
				--RETURN @RUB_ID
--		END TRY
				COMMIT TRANSACTION 
			END
			RETURN @RUB_ID
/*	BEGIN CATCH
		SELECT ERROR_MESSAGE(), ERROR_NUMBER()
		ROLLBACK TRANSACTION
		SET @RUB_ID = -1
		RETURN @RUB_ID
	END CATCH*/
END

go

CREATE PROCEDURE [dbo].[STR_MODIFICA_RUBRO](
	@RUB_ID AS INT OUTPUT,
	@RUB_NOMBRE AS VARCHAR(100),
	@RUB_DESCRIPCION AS VARCHAR(250),
	@RUB_ESTADO AS INT
)
AS 
BEGIN
	BEGIN TRANSACTION 
--		BEGIN TRY
			IF (@RUB_ESTADO = 2)
				BEGIN
					UPDATE C_RUBRO
						SET RUB_ESTADO = @RUB_ESTADO
					WHERE RUB_ID = @RUB_ID
				END
			ELSE
				BEGIN
					UPDATE C_RUBRO
						SET RUB_NOMBRE = @RUB_NOMBRE,
						    RUB_DESCRIPCION = @RUB_DESCRIPCION,
						    RUB_ESTADO = @RUB_ESTADO,
						    RUB_FECHAMODIFICADA = GETDATE()
					WHERE RUB_ID = @RUB_ID
				END
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(), ERROR_NUMBER()
				SET @RUB_ID = -1
				ROLLBACK TRANSACTION
				--RETURN @RUB_ID			
			END
		ELSE
			BEGIN
				--RETURN @RUB_ID
				--		END TRY
				COMMIT TRANSACTION
			END
			RETURN @RUB_ID

/*	BEGIN CATCH
		SELECT ERROR_MESSAGE(), ERROR_NUMBER()
		ROLLBACK TRANSACTION
		SET @RUB_ID = -1
		RETURN @RUB_ID
	END CATCH*/
END

go

-- PROCEDIMIENTOS DE FAMILIA

CREATE PROCEDURE [dbo].[STR_NUEVO_FAMILIA](
	@FAM_ID AS INT OUTPUT,
	@FAM_NOMBRE AS VARCHAR(100),
	@FAM_DESCRIPCION AS VARCHAR(250),
	@RUB_ID AS INT,
	@FAM_ESTADO AS INT
)

AS

BEGIN

	BEGIN TRANSACTION 
--		BEGIN TRY
			INSERT INTO C_FAMILIA (FAM_NOMBRE,FAM_DESCRIPCION,RUB_ID,FAM_ESTADO,FAM_FECHAALTA)
			VALUES (@FAM_NOMBRE,@FAM_DESCRIPCION,@RUB_ID,@FAM_ESTADO,GETDATE())
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(),ERROR_NUMBER()
				SET @FAM_ID = -1
				ROLLBACK TRANSACTION 	
				--RETURN @FAM_ID
			END
		ELSE
			BEGIN
				SET @FAM_ID = @@IDENTITY		
				--RETURN @FAM_ID
			--		END TRY
				COMMIT TRANSACTION 
			END
			RETURN @FAM_ID
/*	BEGIN CATCH
		SELECT ERROR_MESSAGE(),ERROR_NUMBER()
		ROLLBACK TRANSACTION 	
		SET @FAM_ID = -1
		RETURN @FAM_ID
	END CATCH*/
END

go

CREATE PROCEDURE [dbo].[STR_MODIFICA_FAMILIA](
	@FAM_ID AS INT OUTPUT,
	@FAM_NOMBRE AS VARCHAR(100),
	@FAM_DESCRIPCION AS VARCHAR(250),
	@RUB_ID AS INT,
	@FAM_ESTADO AS INT
)

AS

BEGIN

	BEGIN TRANSACTION 
--		BEGIN TRY
			IF(@FAM_ESTADO = 2)
				BEGIN
					UPDATE C_FAMILIA
						SET FAM_ESTADO = @FAM_ESTADO
					WHERE FAM_ID = @FAM_ID
				END
			ELSE
				BEGIN
					UPDATE C_FAMILIA
						SET FAM_NOMBRE = @FAM_NOMBRE,
						    FAM_DESCRIPCION = @FAM_DESCRIPCION,
						    RUB_ID = @RUB_ID,
						    FAM_FECHAMODIFICADA = GETDATE()
					WHERE FAM_ID = @FAM_ID
				END
		IF (@@ERROR = 0)			
			BEGIN
--		END TRY
				COMMIT TRANSACTION 
				--RETURN @FAM_ID
			END
		ELSE
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(),ERROR_NUMBER()
				SET @FAM_ID = -1
				ROLLBACK TRANSACTION 	
				--RETURN @FAM_ID
			END
			RETURN @FAM_ID
/*	BEGIN CATCH
		SELECT ERROR_MESSAGE(),ERROR_NUMBER()
		ROLLBACK TRANSACTION 	
		SET @FAM_ID = -1
		RETURN @FAM_ID
	END CATCH*/
END

go

-- PROCEDIMIENTOS DE PRODUCTO

CREATE PROCEDURE [dbo].[STR_NUEVO_PRODUCTO](
	@PRO_ID AS INT OUTPUT,
	@PRO_CODIGO AS VARCHAR(20),
	@PRO_CODIGO_BARRA AS VARCHAR(50),
	@PRO_CODIGO_PROVEEDOR AS VARCHAR(100),
	@PRO_NOMBRE AS VARCHAR(250),
	@PRO_DESCRIPCION AS VARCHAR(500),
	@PRO_MARCA AS VARCHAR(100),
	@PRO_PRECIOCOSTO AS NUMERIC (18,2),
	@PRO_PRECIOCOMPRA AS NUMERIC(18,2),
	@PRO_IVA AS NUMERIC(18,2),
	@PRO_IMPUESTOINTERNO AS NUMERIC(18,2),
	@PRO_IDPADRE AS INT,
	@PRO_MINIMO AS INT,
	@PRO_MAXIMO AS INT,
	@PRO_ALERTA AS INT,	
	@UNC_ID AS INT, -- UNIDAD DE COMPRA
	@UNV_ID AS INT, -- UNIDAD DE VENTA
	@RUB_ID AS INT, -- RUBRO
	@FAM_ID AS INT, -- FAMILIA
	@PRO_ESTADO AS INT
)

AS

BEGIN

	BEGIN TRANSACTION 
--		BEGIN TRY
			INSERT INTO C_PRODUCTO (PRO_CODIGO,PRO_CODIGO_BARRA,PRO_CODIGO_PROVEEDOR, PRO_NOMBRE, PRO_DESCRIPCION, PRO_MARCA, PRO_PRECIOCOSTO,
				PRO_PRECIOCOMPRA, PRO_IVA, PRO_IMPUESTOINTERNO, PRO_IDPADRE, PRO_MINIMO, PRO_MAXIMO,
				PRO_ALERTA, UNC_ID, UNV_ID, RUB_ID, FAM_ID)

			VALUES (@PRO_CODIGO,@PRO_CODIGO_BARRA,@PRO_CODIGO_PROVEEDOR, @PRO_NOMBRE, @PRO_DESCRIPCION, @PRO_MARCA, @PRO_PRECIOCOSTO,
				@PRO_PRECIOCOMPRA, @PRO_IVA, @PRO_IMPUESTOINTERNO, @PRO_IDPADRE, @PRO_MINIMO, @PRO_MAXIMO,
				@PRO_ALERTA, @UNC_ID, @UNV_ID, @RUB_ID, @FAM_ID)
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(),ERROR_NUMBER()
				SET @PRO_ID = -1
				ROLLBACK TRANSACTION 	
				--RETURN @PRO_ID
			END
		ELSE
			BEGIN
				SET @PRO_ID = @@IDENTITY		
				--RETURN @PRO_ID
			--		END TRY
				COMMIT TRANSACTION 
			END
		RETURN @PRO_ID
/*	BEGIN CATCH
		SELECT ERROR_MESSAGE(),ERROR_NUMBER()
		ROLLBACK TRANSACTION 	
		SET @PRO_ID = -1
		RETURN @PRO_ID
	END CATCH*/
END

go

CREATE PROCEDURE [dbo].[STR_MODIFICA_PRODUCTO](
	@PRO_ID AS INT OUTPUT,
	@PRO_CODIGO AS VARCHAR(20),
	@PRO_CODIGO_BARRA AS VARCHAR(50),
	@PRO_CODIGO_PROVEEDOR AS VARCHAR(100),
	@PRO_NOMBRE AS VARCHAR(250),
	@PRO_DESCRIPCION AS VARCHAR(500),
	@PRO_MARCA AS VARCHAR(100),
	@PRO_PRECIOCOSTO AS NUMERIC (18,2),
	@PRO_PRECIOCOMPRA AS NUMERIC(18,2),
	@PRO_IVA AS NUMERIC(18,2),
	@PRO_IMPUESTOINTERNO AS NUMERIC(18,2),
	@PRO_IDPADRE AS INT,
	@PRO_MINIMO AS INT,
	@PRO_MAXIMO AS INT,
	@PRO_ALERTA AS INT,	
	@UNC_ID AS INT, -- UNIDAD DE COMPRA
	@UNV_ID AS INT, -- UNIDAD DE VENTA
	@RUB_ID AS INT, -- RUBRO
	@FAM_ID AS INT, -- FAMILIA
	@PRO_ESTADO AS INT

)

AS

BEGIN

	BEGIN TRANSACTION 
--		BEGIN TRY
			IF(@PRO_ESTADO = 2)
				BEGIN
					UPDATE C_PRODUCTO
						SET PRO_ESTADO = @PRO_ESTADO
					WHERE PRO_ID = @PRO_ID
				END
			ELSE
				BEGIN
					UPDATE C_PRODUCTO
						SET PRO_CODIGO = @PRO_CODIGO,
						PRO_CODIGO_BARRA = @PRO_CODIGO_BARRA,
						PRO_CODIGO_PROVEEDOR = @PRO_CODIGO_PROVEEDOR,
						PRO_NOMBRE = @PRO_NOMBRE,
						PRO_DESCRIPCION = @PRO_DESCRIPCION,
						PRO_MARCA = @PRO_MARCA,
						PRO_PRECIOCOSTO = @PRO_PRECIOCOSTO,
						PRO_PRECIOCOMPRA = @PRO_PRECIOCOMPRA,
						PRO_IVA = @PRO_IVA,
						PRO_IMPUESTOINTERNO = @PRO_IMPUESTOINTERNO,
						PRO_IDPADRE = @PRO_IDPADRE,
						PRO_MINIMO = @PRO_MINIMO,
						PRO_MAXIMO = @PRO_MAXIMO,
						PRO_ALERTA = @PRO_ALERTA,	
						UNC_ID = @UNC_ID, -- UNIDAD DE COMPRA
						UNV_ID =@UNV_ID, -- UNIDAD DE VENTA
						RUB_ID = @RUB_ID, -- RUBRO
						FAM_ID = @FAM_ID, -- FAMILIA
						PRO_ESTADO = @PRO_ESTADO
					WHERE PRO_ID = @PRO_ID
				END
		IF (@@ERROR != 0)			
			BEGIN
--		END TRY
				COMMIT TRANSACTION 
				--RETURN @PRO_ID
			END
		ELSE
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(),ERROR_NUMBER()
				SET @PRO_ID = -1
				ROLLBACK TRANSACTION 	
				--RETURN @PRO_ID
			END
		RETURN @PRO_ID
/*	BEGIN CATCH
		SELECT ERROR_MESSAGE(),ERROR_NUMBER()
		ROLLBACK TRANSACTION 	
		SET @PRO_ID = -1
		RETURN @PRO_ID
	END CATCH*/
END

go

CREATE PROCEDURE [dbo].[STR_NUEVO_C_LISTA_PRECIO](
	@LPR_ID As INT OUTPUT,
	@PRO_ID As INT,
	@TPR_ID As INT,
	@LPR_PRECIO As NUMERIC(18,2),
	@LPR_PRECIOXCANTIDAD As NUMERIC(18,2),
	@LPR_ESTADO As INT
) AS

BEGIN
	BEGIN TRANSACTION
		INSERT INTO C_LISTA_PRECIO(PRO_ID,TPR_ID,LPR_PRECIO,LPR_PRECIOXCANTIDAD,LPR_ESTADO,LPR_FECHAALTA)
		 VALUES (@PRO_ID,@TPR_ID,@LPR_PRECIO,@LPR_PRECIOXCANTIDAD,@LPR_ESTADO,GETDATE())
		 SET @LPR_ID= @@IDENTITY
		
			IF (@@ERROR != 0)
				BEGIN
					SELECT @@ERROR --ERROR_MESSAGE(),ERROR_NUMBER()
					SET @LPR_ID = -1
					ROLLBACK TRANSACTION 	
					--RETURN @LPR_ID
				END
			ELSE
				BEGIN
					SET @LPR_ID = @@IDENTITY		
					--RETURN @LPR_ID
				--		END TRY
					COMMIT TRANSACTION 
				END
			RETURN @LPR_ID

END
GO

CREATE PROCEDURE [dbo].[STR_MODIFICA_C_LISTA_PRECIO](
	@LPR_ID As INT OUTPUT,
	@PRO_ID As INT,
	@TPR_ID As INT,
	@LPR_PRECIO As NUMERIC(18,2),
	@LPR_PRECIOXCANTIDAD As NUMERIC(18,2),
	@LPR_ESTADO As INT
) AS

BEGIN
	BEGIN TRANSACTION
		IF (@LPR_ESTADO = 2)
		BEGIN
		 UPDATE C_LISTA_PRECIO
		   SET @LPR_ESTADO = 2
		WHERE @LPR_ID = @LPR_ID
			END
		ELSE
			BEGIN
				UPDATE C_LISTA_PRECIO SET 
				
					PRO_ID = @PRO_ID,
					TPR_ID = @TPR_ID,
					LPR_PRECIO = @LPR_PRECIO,
					LPR_PRECIOXCANTIDAD = @LPR_PRECIOXCANTIDAD,
					LPR_ESTADO = @LPR_ESTADO
				WHERE LPR_ID = @LPR_ID
		END
		SELECT @@ERROR
			SET @LPR_ID = @@IDENTITY
			ROLLBACK TRANSACTION
		RETURN @LPR_ID

END
GO


CREATE PROCEDURE [dbo].[STR_CONSULTA_C_LISTA_PRECIO](
	@LPR_ID As INT = 0,
	@PRO_ID As INT = 0,
	@TPR_ID As INT = 0,
	@LPR_PRECIO As NUMERIC(18,2) = '0.00',
	@LPR_PRECIOXCANTIDAD As NUMERIC(18,2) = '0.00',
	@LPR_ESTADO As INT = 0

) AS

BEGIN
	SELECT 		LPR_ID,PRO_ID,TPR_ID,LPR_PRECIO,LPR_PRECIOXCANTIDAD,LPR_ESTADO
	FROM C_LISTA_PRECIO
	 WHERE (@LPR_ID = 0 OR (LPR_ID=@LPR_ID)) 
 AND (@PRO_ID = 0 OR (PRO_ID=@PRO_ID)) 
 AND (@TPR_ID = 0 OR (TPR_ID=@TPR_ID)) 
 AND (@LPR_PRECIO  = '0.00'  OR (LPR_PRECIO=@LPR_PRECIO)) 
 AND (@LPR_PRECIOXCANTIDAD  = '0.00'  OR (LPR_ESTADO=@LPR_PRECIOXCANTIDAD)) 
  
END
GO

CREATE PROCEDURE [dbo].[STR_NUEVO_C_TIPOS_PRECIOS](
	@TPR_ID As INT OUTPUT,
	@TPR_CODIGO As VARCHAR(100),
	@TPR_NOMBRE As VARCHAR(100),
	@TPR_DESCRIPCION As VARCHAR(100),
	@TPR_ESTADO As INT
) AS

BEGIN
	BEGIN TRANSACTION
		INSERT INTO C_TIPOS_PRECIOS(TPR_CODIGO,TPR_NOMBRE,TPR_DESCRIPCION,TPR_ESTADO,TPR_FECHAALTA)
		 VALUES (@TPR_CODIGO,@TPR_NOMBRE,@TPR_DESCRIPCION,@TPR_ESTADO,GETDATE())
		 SET @TPR_ID= @@IDENTITY
		IF (@@ERROR != 0)
		   BEGIN
			SELECT @@ERROR
			SET @TPR_ID = @@IDENTITY
			ROLLBACK TRANSACTION
		   END
		COMMIT TRANSACTION
		RETURN @TPR_ID
END
GO

CREATE PROCEDURE [dbo].[STR_MODIFICA_C_TIPOS_PRECIOS](
	@TPR_ID As INT,
	@TPR_CODIGO As VARCHAR(100),
	@TPR_NOMBRE As VARCHAR(100),
	@TPR_DESCRIPCION As VARCHAR(100),
	@TPR_ESTADO As INT
) AS

BEGIN
	BEGIN TRANSACTION
		IF (@TPR_ESTADO = 2)
		BEGIN
		 UPDATE C_TIPOS_PRECIOS
		   SET @TPR_ESTADO = 2
		WHERE @TPR_ID = @TPR_ID
			END
		ELSE
			BEGIN
				UPDATE C_TIPOS_PRECIOS SET 
				
					TPR_CODIGO = @TPR_CODIGO,
					TPR_NOMBRE = @TPR_NOMBRE,
					TPR_DESCRIPCION = @TPR_DESCRIPCION,
					TPR_ESTADO = @TPR_ESTADO
				WHERE TPR_ID = @TPR_ID
		END
		SELECT @@ERROR
			SET @TPR_ID = @@IDENTITY
			ROLLBACK TRANSACTION
		RETURN @TPR_ID

END
GO

CREATE PROCEDURE [dbo].[STR_CONSULTA_C_TIPOS_PRECIOS](
	@TPR_ID As INT = 0,
	@TPR_CODIGO As VARCHAR(100) = '',
	@TPR_NOMBRE As VARCHAR(100) = '',
	@TPR_DESCRIPCION As VARCHAR(100) = '',
	@TPR_ESTADO As INT = 0

) AS

BEGIN
	SELECT 		TPR_ID,TPR_CODIGO,TPR_NOMBRE,TPR_DESCRIPCION,TPR_ESTADO
	FROM C_TIPOS_PRECIOS
	 WHERE (@TPR_ID = 0 OR (TPR_ID=@TPR_ID)) 
 AND (@TPR_CODIGO = '' OR (TPR_CODIGO=@TPR_CODIGO)) 
 AND (@TPR_NOMBRE = '' OR (TPR_NOMBRE=@TPR_NOMBRE)) 
 AND (@TPR_DESCRIPCION = '' OR (TPR_DESCRIPCION=@TPR_DESCRIPCION)) 
 AND (@TPR_ESTADO = 0 OR (TPR_ESTADO=@TPR_ESTADO)) 

  
END

GO


--  PROCEDIMIENTOS DE IMPUESTO IVA

CREATE PROCEDURE [dbo].[STR_NUEVO_IMPUESTOIVA](
	@IVA_ID AS INT OUTPUT,
	@IVA_NOMBRE AS VARCHAR(250),
	@IVA_TASA AS NUMERIC(18,2),
	@IVA_ORDEN AS INT,
	@IVA_ESTADO AS INT
)
AS

BEGIN
	BEGIN TRANSACTION
--		BEGIN TRY
			INSERT INTO A_IMPUESTOIVA (IVA_NOMBRE,IVA_TASA,IVA_ORDEN,IVA_FECHAALTA,IVA_ESTADO)
			VALUES (@IVA_NOMBRE,@IVA_TASA,@IVA_ORDEN,GETDATE(),@IVA_ESTADO)
			SET @IVA_ID = @@IDENTITY
			--RETURN @IVA_ID
--		END TRY
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(), ERROR_NUMBER()
				SET @IVA_ID = -1
				ROLLBACK TRANSACTION
				--RETURN @IVA_ID
			END
		ELSE
			BEGIN
				SET @IVA_ID = @@IDENTITY
				COMMIT TRANSACTION
				--RETURN @IVA_ID
			END
		RETURN @IVA_ID
/*	BEGIN CATCH
		SELECT ERROR_MESSAGE(), ERROR_NUMBER()
		ROLLBACK TRANSACTION
		SET @IVA_ID = -1
		RETURN @IVA_ID
	END CATCH*/
END

go

CREATE PROCEDURE [dbo].[STR_MODIFICA_IMPUESTOIVA](
	@IVA_ID AS INT OUTPUT,
	@IVA_NOMBRE AS VARCHAR(250),
	@IVA_TASA AS NUMERIC(18,2),
	@IVA_ORDEN AS INT,
	@IVA_ESTADO AS INT
)

AS

BEGIN
	BEGIN TRANSACTION
		--BEGIN TRY
			IF (@IVA_ESTADO = 2)
				BEGIN
					UPDATE A_IMPUESTOIVA SET
						IVA_ESTADO = @IVA_ESTADO
					WHERE IVA_ID = @IVA_ID
				END
			ELSE
				BEGIN
					UPDATE A_IMPUESTOIVA SET
						IVA_NOMBRE = @IVA_NOMBRE,
						IVA_TASA = @IVA_TASA,
						IVA_ORDEN = @IVA_ORDEN,
						IVA_ESTADO = @IVA_ESTADO
					WHERE IVA_ID = @IVA_ID
				END
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(), ERROR_NUMBER()
				SET @IVA_ID = -1
				ROLLBACK TRANSACTION
				--RETURN @IVA_ID
			END
		ELSE
			BEGIN
		--END TRY
				COMMIT TRANSACTION
				--RETURN @IVA_ID
			END
		RETURN @IVA_ID
	/*BEGIN CATCH
		SELECT ERROR_MESSAGE(), ERROR_NUMBER()
		ROLLBACK TRANSACTION
		SET @IVA_ID = -1
		RETURN @IVA_ID
	END CATCH*/
END


go


CREATE PROCEDURE [dbo].[STR_NUEVO_A_COMPROBANTES_VENTA](
	@COV_ID As INT,
	@COV_CODIGO As INT,
	@COV_DESCRIPCION As VARCHAR(100),
	@COV_SIGLA As VARCHAR(100),
	@COV_Letra As VARCHAR(100),
	@COV_Signo As VARCHAR(100),
	@COV_UltimoNro As VARCHAR(100)
) 
AS

BEGIN
	BEGIN TRANSACTION

		INSERT INTO A_COMPROBANTES_VENTA(COV_CODIGO,COV_DESCRIPCION,COV_SIGLA,COV_Letra,COV_Signo,COV_UltimoNro)
		 VALUES (@COV_CODIGO,@COV_DESCRIPCION,@COV_SIGLA,@COV_Letra,@COV_Signo,@COV_UltimoNro)
		SET @COV_ID = @@IDENTITY
		IF (@@ERROR != 0)
		BEGIN
			SELECT @@ERROR
			SET @COV_ID = @@IDENTITY
			ROLLBACK TRANSACTION
		END
		RETURN @COV_ID

END
GO

CREATE PROCEDURE [dbo].[STR_MODIFICA_A_COMPROBANTES_VENTA](
	@COV_ID As INT,
	@COV_CODIGO As INT,
	@COV_DESCRIPCION As VARCHAR(100),
	@COV_SIGLA As VARCHAR(100),
	@COV_Letra As VARCHAR(100),
	@COV_Signo As VARCHAR(100),
	@COV_UltimoNro As VARCHAR(100)
) 
AS

BEGIN
	BEGIN TRANSACTION
/*		IF (@COV_ESTADO = 2)
			BEGIN
			 UPDATE A_COMPROBANTES_VENTA SET 
			   @COV_ESTADO = 2
  			 WHERE @COV_ID = @COV_ID
			END
		ELSE
			BEGIN*/
				UPDATE A_COMPROBANTES_VENTA 
				   SET COV_CODIGO = @COV_CODIGO,
					COV_DESCRIPCION = @COV_DESCRIPCION,
					COV_SIGLA = @COV_SIGLA,
					COV_Letra = @COV_Letra,
					COV_Signo = @COV_Signo,
					COV_UltimoNro = @COV_UltimoNro
				WHERE COV_ID = @COV_ID
		--END
		SELECT @@ERROR
		ROLLBACK TRANSACTION
		--SET @COV_ID = @@IDENTITY
		RETURN @COV_ID

END
GO

CREATE PROCEDURE [dbo].[STR_CONSULTA_A_COMPROBANTES_VENTA](
	@COV_ID As INT = 0,
	@COV_CODIGO As INT = 0,
	@COV_DESCRIPCION As VARCHAR(100) = '',
	@COV_SIGLA As VARCHAR(100) = '',
	@COV_Letra As VARCHAR(100) = '',
	@COV_Signo As VARCHAR(100) = '',
	@COV_UltimoNro As VARCHAR(100) = ''

) AS

BEGIN
	SELECT 		COV_ID,
				COV_CODIGO,
				COV_DESCRIPCION,
				COV_SIGLA,
				COV_Letra,
				COV_Signo,
				COV_UltimoNro
	FROM A_COMPROBANTES_VENTA
    WHERE (@COV_ID = 0 OR (COV_ID=@COV_ID)) 
		 AND (@COV_CODIGO = 0 OR (COV_CODIGO=@COV_CODIGO)) 
		 AND (@COV_DESCRIPCION = '' OR (COV_DESCRIPCION=@COV_DESCRIPCION)) 
		 AND (@COV_SIGLA = '' OR (COV_SIGLA=@COV_SIGLA)) 
		 AND (@COV_Letra = '' OR (COV_Letra=@COV_Letra)) 
		 AND (@COV_Signo = '' OR (COV_Signo=@COV_Signo)) 
		 AND (@COV_UltimoNro = '' OR (COV_UltimoNro=@COV_UltimoNro)) 
		  
END
GO

CREATE PROCEDURE [dbo].[STR_NUEVO_A_SITUACION_IMPOSITIVA](
	@SII_ID As INT,
	@SII_CLAVE As VARCHAR(100),
	@SII_DESCRIPCION As VARCHAR(100),
	@SII_SIGLA As VARCHAR(100)
) 
AS
BEGIN
	BEGIN TRANSACTION
		INSERT INTO A_SITUACION_IMPOSITIVA(SII_CLAVE,SII_DESCRIPCION,SII_SIGLA)
		 VALUES (@SII_CLAVE,@SII_DESCRIPCION,@SII_SIGLA)
		SET @SII_ID = @@IDENTITY
		IF (@@ERROR != 0)
		BEGIN
			SELECT @@ERROR
			SET @SII_ID = @@IDENTITY
			ROLLBACK TRANSACTION
		END
		RETURN @SII_ID
END
GO

CREATE PROCEDURE [dbo].[STR_MODIFICA_A_SITUACION_IMPOSITIVA](
	@SII_ID As INT,
	@SII_CLAVE As VARCHAR(100),
	@SII_DESCRIPCION As VARCHAR(100),
	@SII_SIGLA As VARCHAR(100)
) 
AS
BEGIN
	BEGIN TRANSACTION
/*		IF ( = 2)
		BEGIN

		 UPDATE A_SITUACION_IMPOSITIVA SET 

		    = 2

		WHERE @SII_ID = @SII_ID

			END

		ELSE
			BEGIN*/
				UPDATE A_SITUACION_IMPOSITIVA 
					SET SII_CLAVE = @SII_CLAVE,
					SII_DESCRIPCION = @SII_DESCRIPCION,
					SII_SIGLA = @SII_SIGLA
				WHERE SII_ID = @SII_ID
--		END
		SELECT @@ERROR
		SET @SII_ID = @@IDENTITY
		ROLLBACK TRANSACTION
		RETURN @SII_ID
END
GO

CREATE PROCEDURE [dbo].[STR_CONSULTA_A_SITUACION_IMPOSITIVA](
	@SII_ID As INT = 0,
	@SII_CLAVE As VARCHAR(100) = '',
	@SII_DESCRIPCION As VARCHAR(100) = '',
	@SII_SIGLA As VARCHAR(100) = ''
) AS
BEGIN
	SELECT 	SII_ID,
		SII_CLAVE,
		SII_DESCRIPCION,
		SII_SIGLA
	FROM A_SITUACION_IMPOSITIVA
	 WHERE (@SII_ID = 0 OR (SII_ID=@SII_ID)) 
		 AND (@SII_CLAVE = '' OR (SII_CLAVE=@SII_CLAVE)) 
		 AND (@SII_DESCRIPCION = '' OR (SII_DESCRIPCION=@SII_DESCRIPCION)) 
		 AND (@SII_SIGLA = '' OR (SII_SIGLA=@SII_SIGLA)) 
 
END
GO


CREATE PROCEDURE [dbo].[STR_NUEVO_A_PUNTO_VENTA](
	@PTV_ID As INT,
	@PTV_CODIGO As VARCHAR(100),
	@PTV_NOMBRE As VARCHAR(100),
	@PTV_DESCRIPCION As VARCHAR(100),
	@PTV_SIGLA As VARCHAR(100)
) 
AS
BEGIN
	BEGIN TRANSACTION
		INSERT INTO A_PUNTO_VENTA(PTV_CODIGO,PTV_NOMBRE,PTV_DESCRIPCION,PTV_SIGLA)
		 VALUES (@PTV_CODIGO,@PTV_NOMBRE,@PTV_DESCRIPCION,@PTV_SIGLA)
		 SET @PTV_ID = @@IDENTITY
		IF (@@ERROR != 0)
		BEGIN
			SELECT @@ERROR
			SET @PTV_ID = @@IDENTITY
			ROLLBACK TRANSACTION
		END
		RETURN @PTV_ID
END
GO

CREATE PROCEDURE [dbo].[STR_MODIFICA_A_PUNTO_VENTA](
	@PTV_ID As INT,
	@PTV_CODIGO As VARCHAR(100),
	@PTV_NOMBRE As VARCHAR(100),
	@PTV_DESCRIPCION As VARCHAR(100),
	@PTV_SIGLA As VARCHAR(100)
) 
AS
BEGIN
	BEGIN TRANSACTION
/*		IF ( = 2)

		BEGIN

		 UPDATE A_PUNTO_VENTA SET 

		    = 2

		WHERE @PTV_ID = @PTV_ID

			END

		ELSE
			BEGIN*/

				UPDATE A_PUNTO_VENTA 
				SET PTV_CODIGO = @PTV_CODIGO,
					PTV_NOMBRE = @PTV_NOMBRE,
					PTV_DESCRIPCION = @PTV_DESCRIPCION,
					PTV_SIGLA = @PTV_SIGLA
				WHERE PTV_ID = @PTV_ID

--		END
		SELECT @@ERROR
		SET @PTV_ID = @@IDENTITY
		ROLLBACK TRANSACTION
		RETURN @PTV_ID
END
GO

CREATE PROCEDURE [dbo].[STR_CONSULTA_A_PUNTO_VENTA](
	@PTV_ID As INT = 0,
	@PTV_CODIGO As VARCHAR(100) = '',
	@PTV_NOMBRE As VARCHAR(100) = '',
	@PTV_DESCRIPCION As VARCHAR(100) = '',	
	@PTV_SIGLA As VARCHAR(100) = ''
) 
AS
BEGIN
	SELECT 	PTV_ID,
			PTV_CODIGO,
			PTV_NOMBRE,
			PTV_DESCRIPCION,
			PTV_SIGLA
	FROM A_PUNTO_VENTA
	 WHERE (@PTV_ID = 0 OR (PTV_ID=@PTV_ID)) 
		 AND (@PTV_CODIGO = '' OR (PTV_CODIGO=@PTV_CODIGO)) 
		 AND (@PTV_NOMBRE = '' OR (PTV_NOMBRE=@PTV_NOMBRE)) 
		 AND (@PTV_DESCRIPCION = '' OR (PTV_DESCRIPCION=@PTV_DESCRIPCION)) 
		 AND (@PTV_SIGLA = '' OR (PTV_SIGLA=@PTV_SIGLA)) 
  
END
GO

-- CONSULTAS --

CREATE PROCEDURE [dbo].[STR_CONSULTA_CAJA](
	@CAJ_ID AS INT =0,
	@CAJ_NUMERO AS INT =0
)
AS

BEGIN

	SELECT *
		FROM V_CAJA AS CAJA
	WHERE (@CAJ_ID ='' OR (CAJA.CAJ_ID = @CAJ_ID))
	  AND (@CAJ_NUMERO = '' OR (CAJA.CAJ_NUMERO = @CAJ_NUMERO))
	  AND (CAJA.CAJ_ESTADO = 1)
	ORDER BY CAJA.CAJ_NUMERO

END

go

CREATE PROCEDURE [dbo].[STR_CONSULTA_CAJA_TIPO_MOVIMIENTO](
	@CAE_ID AS INT = 0,
	@CAE_NOMBRE AS VARCHAR(100) =''	
)
AS

BEGIN
	SELECT * 
	FROM V_CAJA_TIPO_MOVIMIENTO
	WHERE (@CAE_ID = 0 OR (CAE_ID = @CAE_ID))
		AND (@CAE_NOMBRE = '' OR (CAE_NOMBRE = @CAE_NOMBRE))
		AND CAE_ESTADO = 1

END

go

CREATE PROCEDURE [dbo].[STR_CONSULTA_CAJA_MOVIMIENTOS](
	@CAM_ID AS INT = 0,
	@CAM_FECHA AS DATETIME = '1900/01/01',
	@CAE_ID AS INT = 0,
	@USU_ID AS INT = 0
)
AS

BEGIN
	SELECT * 
	FROM V_CAJA_MOVIMIENTOS
	WHERE (@CAM_ID = 0 OR (CAM_ID = @CAM_ID))
		AND (@CAM_FECHA = '1900/01/01' OR (CAM_FECHA = @CAM_FECHA))
		AND (@CAE_ID = 0 OR (CAE_ID = @CAE_ID))
		AND (@USU_ID = 0 OR (USU_ID = @USU_ID))
		AND CAM_ESTADO = 1

END

GO

CREATE PROCEDURE [dbo].[STR_VERIFICA_CAJA_MOVIMIENTOS](

	@SALIDA  AS INT OUTPUT,
	@CAE_ID AS INT = 0,
	@USU_ID AS INT = 0
)
AS
	BEGIN
		SET @CAE_ID = 1	 
		SET @SALIDA = (SELECT COUNT(*)
						FROM V_CAJA_MOVIMIENTOS
						WHERE (@CAE_ID = 0 OR (CAE_ID = @CAE_ID))	
						  AND (@USU_ID = 0 OR (USU_ID = @USU_ID))
					  )
			IF (@SALIDA = 0)	
				BEGIN
					SET @SALIDA = -1
				END
			RETURN @SALIDA
		-- SELECT @SALIDA
END

go

CREATE PROCEDURE [dbo].[STR_CONSULTA_UNIDAD](
	@UNI_ID AS INT =0,
	@UNI_NOMBRE AS VARCHAR(100) ='',
	@UNI_SIGLA AS VARCHAR (10)=''
)


AS

BEGIN

	SELECT *
		FROM C_UNIDAD AS UNI
	WHERE (@UNI_ID = 0 OR (UNI.UNI_ID = @UNI_ID))
	  AND (@UNI_NOMBRE = '' OR (UNI.UNI_NOMBRE = @UNI_NOMBRE))
	  AND (@UNI_SIGLA = '' OR (UNI.UNI_SIGLA = @UNI_SIGLA))
	  AND (UNI.UNI_ESTADO = 1)
	ORDER BY UNI.UNI_NOMBRE

END

go

CREATE PROCEDURE [dbo].[STR_CONSULTA_FAMILIA](
	@FAM_ID AS INT =0,
	@FAM_NOMBRE AS VARCHAR(100)= '',
	@RUB_ID AS INT=0
)

AS

BEGIN

	SELECT * FROM C_FAMILIA AS FAM INNER JOIN C_RUBRO RUB
		ON FAM.RUB_ID = RUB.RUB_ID
	WHERE (@FAM_ID = 0 OR (FAM.FAM_ID = @FAM_ID))
	  AND (@FAM_NOMBRE = '' OR (FAM.FAM_NOMBRE = @FAM_NOMBRE))
	  AND (@RUB_ID = 0 OR (FAM.RUB_ID = @RUB_ID))
	  AND (FAM.FAM_ESTADO = 1)
	ORDER BY FAM.FAM_NOMBRE

END

go


CREATE PROCEDURE [dbo].[STR_CONSULTA_RUBRO](
	@RUB_ID AS INT =0,
	@RUB_NOMBRE AS VARCHAR(100)=''
)

AS

BEGIN

	SELECT *
		FROM C_RUBRO AS RUBRO
	WHERE (@RUB_ID = 0 OR (RUBRO.RUB_ID = @RUB_ID))
	  AND (@RUB_NOMBRE = '' OR (RUBRO.RUB_NOMBRE = @RUB_NOMBRE))
	  AND (RUBRO.RUB_ESTADO = 1)
	ORDER BY RUBRO.RUB_NOMBRE

END

go

CREATE PROCEDURE [dbo].[STR_CONSULTA_PRODUCTO](
	@PRO_ID AS INT =0,
	@PRO_CODIGO AS VARCHAR(20)='',
	@PRO_NOMBRE AS VARCHAR(250)='',
	@PRO_MARCA AS VARCHAR(100)='',
	@PRO_IDPADRE AS INT =0,
	@RUB_ID AS INT =0, -- RUBRO
	@FAM_ID AS INT =0 -- FAMILIA
)

AS

BEGIN

	SELECT *
		FROM C_PRODUCTO AS PROD INNER JOIN C_RUBRO AS RUBRO
		ON PROD.RUB_ID = RUBRO.RUB_ID INNER JOIN C_FAMILIA AS FAMILIA
		ON PROD.FAM_ID = FAMILIA.FAM_ID 
	WHERE (@PRO_ID = 0 OR (PROD.PRO_ID = @PRO_ID))
	  AND (@PRO_CODIGO = '' OR (PROD.PRO_CODIGO = @PRO_CODIGO))
	  AND (@PRO_NOMBRE = '' OR (PROD.PRO_NOMBRE = @PRO_NOMBRE))
	  AND (@PRO_MARCA = '' OR (PROD.PRO_MARCA = @PRO_MARCA))
	  AND (@PRO_IDPADRE = 0 OR (PROD.PRO_IDPADRE = @PRO_IDPADRE))
	  AND (@RUB_ID = 0 OR (PROD.RUB_ID = @RUB_ID))
	  AND (@FAM_ID = 0 OR (PROD.FAM_ID = @FAM_ID))
	  AND (PROD.PRO_ESTADO = 1)
	ORDER BY PROD.PRO_NOMBRE

END

go


CREATE PROCEDURE [dbo].[STR_CONSULTA_PRODUCTO_MARCA](
	@PRO_MARCA AS VARCHAR(100)=''
)
AS

BEGIN


	SELECT * FROM C_PRODUCTO AS PROD INNER JOIN C_RUBRO AS RUBRO
		ON PROD.RUB_ID = RUBRO.RUB_ID INNER JOIN C_FAMILIA AS FAMILIA
		ON PROD.FAM_ID = FAMILIA.FAM_ID 
	WHERE (@PRO_MARCA = '' OR (PROD.PRO_MARCA = @PRO_MARCA))
	  AND (PROD.PRO_ESTADO = 1)
	ORDER BY PROD.PRO_MARCA

END

go

CREATE PROCEDURE [dbo].[STR_CONSULTA_IMPUESTOIVA](
	@IVA_ID AS INT =0,
	@IVA_NOMBRE AS VARCHAR(250) ='',
	@IVA_TASA AS NUMERIC(18,2) =0.0
)
AS

BEGIN

	SELECT *
		FROM A_IMPUESTOIVA
	WHERE (@IVA_ID =0 OR (IVA_ID = @IVA_ID))
	  AND (@IVA_NOMBRE ='' OR (IVA_NOMBRE = @IVA_NOMBRE))
	  AND (@IVA_TASA =0.0 OR (IVA_TASA = @IVA_TASA))
	  AND (IVA_ESTADO = 1)
	ORDER BY IVA_ORDEN ASC

END

go
-- ===============================================================================
--					CREACION DE STORES PARA PERMISOS DE SISTEMA
-- ===============================================================================

CREATE PROCEDURE [dbo].[STR_NUEVO_USUARIO](
	@USU_ID AS INT OUTPUT,
	@USU_NOMBRE AS VARCHAR(100),
	@USU_PASSWORD AS VARCHAR(250),
	@USU_MAIL AS VARCHAR(100),
	@USU_ESTADO AS INT,
	@ROL_ID AS INT
)
AS

BEGIN

	BEGIN TRANSACTION
--		BEGIN TRY
			INSERT INTO S_USUARIO(USU_NOMBRE,USU_PASSWORD,USU_MAIL,USU_ESTADO,USU_FECHAALTA,ROL_ID)
			VALUES (@USU_NOMBRE,@USU_PASSWORD,@USU_MAIL,@USU_ESTADO,GETDATE(),@ROL_ID)
			SET @USU_ID = @@IDENTITY
			--RETURN @IVA_ID
--		END TRY
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(), ERROR_NUMBER()
				SET @USU_ID = -1
				ROLLBACK TRANSACTION
				--RETURN @IVA_ID
			END
		ELSE
			BEGIN
				COMMIT TRANSACTION
				--SET @USU_ID = @@IDENTITY
				--RETURN @IVA_ID
			END
		RETURN @USU_ID

END

go

CREATE PROCEDURE [dbo].[STR_MODIFICA_USUARIO](
	@USU_ID AS INT,
	@USU_NOMBRE AS VARCHAR(100),
	@USU_PASSWORD AS VARCHAR(250),
	@USU_MAIL AS VARCHAR(100),
	@USU_ESTADO AS INT,
	@ROL_ID AS INT
)
AS

BEGIN
	BEGIN TRANSACTION
		--BEGIN TRY
			IF (@USU_ESTADO = 2)
				BEGIN
					UPDATE S_USUARIO SET
						USU_ESTADO = @USU_ESTADO
					WHERE USU_ID = @USU_ID
				END
			ELSE
				BEGIN
					UPDATE S_USUARIO SET
						USU_NOMBRE = @USU_NOMBRE,
						USU_PASSWORD= @USU_PASSWORD,
						USU_MAIL = @USU_MAIL,
						USU_ESTADO = @USU_ESTADO,
						ROL_ID = @ROL_ID
					WHERE USU_ID = @USU_ID
				END
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(), ERROR_NUMBER()
				SET @USU_ID = -1
				ROLLBACK TRANSACTION
				--RETURN @IVA_ID
			END
		ELSE
			BEGIN
		--END TRY
				COMMIT TRANSACTION
				--RETURN @IVA_ID
			END
		RETURN @USU_ID
	/*BEGIN CATCH
		SELECT ERROR_MESSAGE(), ERROR_NUMBER()
		ROLLBACK TRANSACTION
		SET @IVA_ID = -1
		RETURN @IVA_ID
	END CATCH*/
END

go

CREATE PROCEDURE [dbo].[STR_NUEVO_ROL](
	@ROL_ID AS INT OUTPUT,
	@ROL_NOMBRE AS VARCHAR(100),
	@ROL_ESTADO AS INT
)
AS

BEGIN

	BEGIN TRANSACTION
--		BEGIN TRY
			INSERT INTO S_ROL(ROL_NOMBRE,ROL_ESTADO,ROL_FECHAALTA)
			VALUES (@ROL_NOMBRE,@ROL_ESTADO,GETDATE())
			SET @ROL_ID = @@IDENTITY
			--RETURN @IVA_ID
--		END TRY
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(), ERROR_NUMBER()
				SET @ROL_ID = -1
				ROLLBACK TRANSACTION
				--RETURN @IVA_ID
			END
		ELSE
			BEGIN
				COMMIT TRANSACTION
				--SET @USU_ID = @@IDENTITY
				--RETURN @IVA_ID
			END
		RETURN @ROL_ID
END

go

CREATE PROCEDURE [dbo].[STR_MODIFICA_ROL](
	@ROL_ID AS INT,
	@ROL_NOMBRE AS VARCHAR(100),
	@ROL_ESTADO AS INT
)
AS

BEGIN
	BEGIN TRANSACTION
		--BEGIN TRY
			IF (@ROL_ESTADO = 2)
				BEGIN
					UPDATE S_ROL SET
						ROL_ESTADO = @ROL_ESTADO
					WHERE ROL_ID = @ROL_ID
				END
			ELSE
				BEGIN
					UPDATE S_ROL SET
						ROL_NOMBRE = @ROL_NOMBRE,
						ROL_ESTADO = @ROL_ESTADO
					WHERE ROL_ID = @ROL_ID
				END
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(), ERROR_NUMBER()
				SET @ROL_ID = -1
				ROLLBACK TRANSACTION
				--RETURN @IVA_ID
			END
		ELSE
			BEGIN
		--END TRY
				COMMIT TRANSACTION
				--RETURN @IVA_ID
			END
		RETURN @ROL_ID
	/*BEGIN CATCH
		SELECT ERROR_MESSAGE(), ERROR_NUMBER()
		ROLLBACK TRANSACTION
		SET @IVA_ID = -1
		RETURN @IVA_ID
	END CATCH*/
END

go

CREATE PROCEDURE [dbo].[STR_NUEVO_MODULO](
	@MOD_ID AS INT OUTPUT,
	@MOD_NOMBRE AS VARCHAR(100),
	@MOD_DESCRIPCION AS VARCHAR(250),
	@MOD_TIPO AS VARCHAR(100),
	@MOD_URL AS VARCHAR(250),
	@MOD_ORDEN AS INT,
	@MOD_IDPADRE AS INT,	
	@MOD_ESTADO AS INT
)
AS

BEGIN

	BEGIN TRANSACTION
--		BEGIN TRY
			INSERT INTO S_MODULO(MOD_NOMBRE,MOD_DESCRIPCION,MOD_TIPO,MOD_URL,MOD_ORDEN,MOD_IDPADRE,MOD_ESTADO,MOD_FECHAALTA)
				    VALUES (@MOD_NOMBRE,@MOD_DESCRIPCION,@MOD_TIPO,@MOD_URL,@MOD_ORDEN,@MOD_IDPADRE,@MOD_ESTADO,GETDATE())
			SET @MOD_ID = @@IDENTITY
			--RETURN @IVA_ID
--		END TRY
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(), ERROR_NUMBER()
				SET @MOD_ID = -1
				ROLLBACK TRANSACTION
				--RETURN @IVA_ID
			END
		ELSE
			BEGIN
				--SET @MOD_ID = @@IDENTITY
				--RETURN @IVA_ID
				COMMIT TRANSACTION
				
			END
		RETURN @MOD_ID

END

go

CREATE PROCEDURE [dbo].[STR_MODIFICA_MODULO](
	@MOD_ID AS INT,
	@MOD_NOMBRE AS VARCHAR(100),
	@MOD_DESCRIPCION AS VARCHAR(250),
	@MOD_TIPO AS VARCHAR(100),
	@MOD_URL AS VARCHAR(250),
	@MOD_ORDEN AS INT,
	@MOD_IDPADRE AS INT,	
	@MOD_ESTADO AS INT
)
AS 

BEGIN
	BEGIN TRANSACTION
		--BEGIN TRY
			IF (@MOD_ESTADO = 2)
				BEGIN
					UPDATE S_MODULO SET
						MOD_ESTADO = @MOD_ESTADO
					WHERE MOD_ID = @MOD_ID
				END
			ELSE
				BEGIN
					UPDATE S_MODULO SET
						MOD_NOMBRE = @MOD_NOMBRE,
						MOD_DESCRIPCION= @MOD_DESCRIPCION,
						MOD_TIPO = @MOD_TIPO,
						MOD_URL = @MOD_URL,
						MOD_ORDEN = @MOD_ORDEN,
						MOD_IDPADRE = @MOD_IDPADRE						
					WHERE MOD_ID = @MOD_ID
				END
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(), ERROR_NUMBER()
				SET @MOD_ID = -1
				ROLLBACK TRANSACTION
				--RETURN @IVA_ID
			END
		ELSE
			BEGIN
		--END TRY
				COMMIT TRANSACTION
				--RETURN @IVA_ID
			END
		RETURN @MOD_ID
	/*BEGIN CATCH
		SELECT ERROR_MESSAGE(), ERROR_NUMBER()
		ROLLBACK TRANSACTION
		SET @IVA_ID = -1
		RETURN @IVA_ID
	END CATCH*/
END

go

CREATE PROCEDURE [dbo].[STR_NUEVO_ROL_MODULO](
	@ROM_ID AS INT OUTPUT,
	@ROM_ESTADO AS INT,
	@ROL_ID AS INT,	
	@MOD_ID AS INT
)
AS

BEGIN

	BEGIN TRANSACTION
--		BEGIN TRY
			INSERT INTO S_ROL_MODULO(ROM_ESTADO,ROL_ID,MOD_ID)
			VALUES (@ROM_ESTADO,@ROL_ID,@MOD_ID)
			SET @ROM_ID = @@IDENTITY
			--RETURN @IVA_ID
--		END TRY
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(), ERROR_NUMBER()
				SET @ROM_ID = -1
				ROLLBACK TRANSACTION
				--RETURN @IVA_ID
			END
		ELSE
			BEGIN
				COMMIT TRANSACTION
				--SET @USU_ID = @@IDENTITY
				--RETURN @IVA_ID
			END
		RETURN @ROM_ID

END

go

CREATE PROCEDURE [dbo].[STR_MODIFICA_ROL_MODULO](
	@ROM_ID AS INT,
	@ROM_ESTADO AS INT,
	@ROL_ID AS INT,
	@MOD_ID AS INT
)
AS 

BEGIN
	BEGIN TRANSACTION
		--BEGIN TRY
			IF (@ROM_ESTADO = 2)
				BEGIN
					UPDATE S_ROL_MODULO SET
						ROM_ESTADO = @ROM_ESTADO
					WHERE ROM_ID = @ROM_ID
				END
			ELSE
				BEGIN
					UPDATE S_ROL_MODULO SET
						ROM_ESTADO = @ROM_ESTADO,
						ROL_ID = @ROL_ID,
						MOD_ID = @MOD_ID
					WHERE ROM_ID = @ROM_ID
				END
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(), ERROR_NUMBER()
				SET @ROM_ID = -1
				ROLLBACK TRANSACTION
				--RETURN @IVA_ID
			END
		ELSE
			BEGIN
		--END TRY
				COMMIT TRANSACTION
				--RETURN @IVA_ID
			END
		RETURN @ROM_ID
	/*BEGIN CATCH
		SELECT ERROR_MESSAGE(), ERROR_NUMBER()
		ROLLBACK TRANSACTION
		SET @IVA_ID = -1
		RETURN @IVA_ID
	END CATCH*/
END

go

CREATE PROCEDURE [dbo].[STR_CONSULTA_USUARIO](
	@USU_ID AS INT,
	@USU_NOMBRE AS VARCHAR(100),
	@USU_MAIL AS VARCHAR(250),
	@ROL_ID AS INT
)
AS

BEGIN

	SELECT USU_ID,
	       USU_NOMBRE,
	       USU_MAIL
	FROM S_USUARIO
	WHERE USU_ESTADO = 1
	  AND (@USU_ID = 0 OR (USU_ID = @USU_ID))
	  AND (@USU_NOMBRE = '' OR (USU_NOMBRE = @USU_NOMBRE))
	  AND (@USU_MAIL = '' OR (USU_MAIL = @USU_MAIL))
	  AND (@ROL_ID = 0 OR (ROL_ID = @ROL_ID))
END

go

CREATE PROCEDURE [dbo].[STR_VALIDA_INGRESO](
	@USU_NOMBRE AS VARCHAR(100),
	@USU_PASSWORD AS VARCHAR(250)	
)
AS

BEGIN

	SELECT  USU.USU_ID,
		    USU.USU_NOMBRE,
			USU.USU_MAIL,
			ROL.ROL_ID,
			ROL.ROL_NOMBRE,
			ROLMOD.ROM_ID,
			ROLMOD.ROM_ESTADO,
			MOD.MOD_ID,
			MOD.MOD_NOMBRE,
			MOD.MOD_DESCRIPCION,
			MOD.MOD_TIPO,
			MOD.MOD_URL,
			MOD.MOD_ORDEN,
			MOD.MOD_IDPADRE

	FROM S_USUARIO USU INNER JOIN S_ROL ROL
	    ON USU.ROL_ID = ROL.ROL_ID LEFT JOIN S_ROL_MODULO ROLMOD
	    ON ROLMOD.MOD_ID = ROLMOD.MOD_ID LEFT JOIN S_MODULO MOD
	    ON ROLMOD.MOD_ID = MOD.MOD_ID
	WHERE USU.USU_ESTADO = 1 AND ROL.ROL_ESTADO = 1
	 AND ((USU.USU_NOMBRE = @USU_NOMBRE) 
	 AND (USU.USU_PASSWORD = @USU_PASSWORD))
END

go

