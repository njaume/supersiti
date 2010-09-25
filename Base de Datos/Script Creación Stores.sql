-- USE DES_SUPER

-- PROCEDIMIENTOS DE CAJAS ESTADO

CREATE PROCEDURE [dbo].[STR_NUEVO_CAJA_ESTADO](
	@CAE_ID AS INT OUTPUT,
	@CAE_NOMBRE AS VARCHAR(80),
	@CAE_ESTADO AS INT
)
AS

BEGIN
	BEGIN TRANSACTION
		--BEGIN TRY
			INSERT INTO V_CAJA_ESTADO (CAE_NOMBRE,CAE_ESTADO)
			VALUES (@CAE_NOMBRE,@CAE_ESTADO)
			
		--END TRY
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR
				ROLLBACK TRANSACTION
				SET @CAE_ID = -1
			--	RETURN @CAE_ID
			END
		ELSE
			BEGIN
				COMMIT TRANSACTION
				SET @CAE_ID = @@IDENTITY
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

CREATE PROCEDURE [dbo].[STR_MODIFICA_CAJA_ESTADO](
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
					UPDATE V_CAJA_ESTADO SET
						CAE_ESTADO = @CAE_ESTADO
					WHERE CAE_ID = @CAE_ID
				END
			ELSE
				BEGIN
					UPDATE V_CAJA_ESTADO SET
						CAE_NOMBRE = @CAE_NOMBRE,
						CAE_ESTADO = @CAE_ESTADO
					WHERE CAE_ID = @CAE_ID
				END
			--RETURN @CAE_ID
		--END TRY
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(), ERROR_NUMBER()
				ROLLBACK TRANSACTION
				SET @CAE_ID = -1
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

--  PROCEDIMIENTOS DE CAJA
CREATE PROCEDURE [dbo].[STR_NUEVO_CAJA](
	@CAJ_ID AS INT OUTPUT,
	@CAJ_NUMERO AS INT,
	@CAJ_FECHAAPERTURA AS DATETIME,
	@CAJ_FECHACIERRE AS DATETIME,
	@CAJ_ESTADO AS INT,
	@CAE_ID AS INT
)
AS

BEGIN
	BEGIN TRANSACTION
--		BEGIN TRY
			INSERT INTO V_CAJA (CAJ_NUMERO,CAJ_FECHAAPERTURA,CAJ_FECHACIERRE,CAJ_ESTADO)
			VALUES (@CAJ_NUMERO,@CAJ_FECHAAPERTURA,@CAJ_FECHACIERRE,@CAJ_ESTADO)
			SET @CAJ_ID = @@IDENTITY
			RETURN @CAJ_ID
--		END TRY
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(), ERROR_NUMBER()
				ROLLBACK TRANSACTION
				SET @CAJ_ID = -1
				--RETURN @CAJ_ID
			END
		ELSE
			BEGIN
				COMMIT TRANSACTION
				SET @CAJ_ID = @@IDENTITY
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

CREATE PROCEDURE [dbo].[STR_MODIFICA_CAJA](
	@CAJ_ID AS INT OUTPUT,
	@CAJ_NUMERO AS INT,
	@CAJ_FECHAAPERTURA AS DATETIME,
	@CAJ_FECHACIERRE AS DATETIME,
	@CAJ_ESTADO AS INT,
	@CAE_ID AS INT
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
						CAJ_FECHAAPERTURA = @CAJ_FECHAAPERTURA,
						CAJ_FECHACIERRE = @CAJ_FECHACIERRE,
						CAJ_ESTADO = @CAJ_ESTADO,
						CAE_ID = @CAE_ID
					WHERE CAJ_ID = @CAJ_ID
				END
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(), ERROR_NUMBER()
				ROLLBACK TRANSACTION
				SET @CAJ_ID = -1
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
				ROLLBACK TRANSACTION
				SET @UNI_ID = -1
				--RETURN @UNI_ID
			END
		ELSE
			BEGIN
				COMMIT TRANSACTION
				SET @UNI_ID = @@IDENTITY
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


-- PROCEDIMIENTOS DE FAMILIA

CREATE PROCEDURE [dbo].[STR_NUEVO_FAMILIA](
	@FAM_ID AS INT OUTPUT,
	@FAM_NOMBRE AS VARCHAR(100),
	@FAM_DESCRIPCION AS VARCHAR(250),
	@FAM_ESTADO AS INT
)
AS

BEGIN
	BEGIN TRANSACTION 
--		BEGIN TRY
			INSERT INTO C_FAMILIA (FAM_NOMBRE,FAM_DESCRIPCION,FAM_ESTADO,FAM_FECHAALTA)
			VALUES (@FAM_NOMBRE,@FAM_DESCRIPCION,@FAM_ESTADO,GETDATE())
		IF (@@ERROR != 0)			
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(), ERROR_NUMBER()
				ROLLBACK TRANSACTION
				SET @FAM_ID = -1
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
		SELECT ERROR_MESSAGE(), ERROR_NUMBER()
		ROLLBACK TRANSACTION
		SET @FAM_ID = -1
		RETURN @FAM_ID
	END CATCH*/
END

CREATE PROCEDURE [dbo].[STR_MODIFICA_FAMILIA](
	@FAM_ID AS INT OUTPUT,
	@FAM_NOMBRE AS VARCHAR(100),
	@FAM_DESCRIPCION AS VARCHAR(250),
	@FAM_ESTADO AS INT
)
AS 
BEGIN
	BEGIN TRANSACTION 
--		BEGIN TRY
			IF (@FAM_ESTADO = 2)
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
						    FAM_ESTADO = @FAM_ESTADO,
						    FAM_FECHAMODIFICADA = GETDATE()
					WHERE FAM_ID = @FAM_ID
				END
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(), ERROR_NUMBER()
				ROLLBACK TRANSACTION
				SET @FAM_ID = -1
				--RETURN @FAM_ID			
			END
		ELSE
			BEGIN
				--RETURN @FAM_ID
				--		END TRY
				COMMIT TRANSACTION
			END
			RETURN @FAM_ID

/*	BEGIN CATCH
		SELECT ERROR_MESSAGE(), ERROR_NUMBER()
		ROLLBACK TRANSACTION
		SET @FAM_ID = -1
		RETURN @FAM_ID
	END CATCH*/
END

-- PROCEDIMIENTOS DE RUBROS

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
				SELECT @@ERROR --ERROR_MESSAGE(),ERROR_NUMBER()
				ROLLBACK TRANSACTION 	
				SET @RUB_ID = -1
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
		SELECT ERROR_MESSAGE(),ERROR_NUMBER()
		ROLLBACK TRANSACTION 	
		SET @RUB_ID = -1
		RETURN @RUB_ID
	END CATCH*/
END


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
			IF(@RUB_ESTADO = 2)
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
						    RUB_FECHAMODIFICADA = GETDATE()
					WHERE RUB_ID = @RUB_ID
				END
		IF (@@ERROR = 0)			
			BEGIN
--		END TRY
				COMMIT TRANSACTION 
				--RETURN @RUB_ID
			END
		ELSE
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(),ERROR_NUMBER()
				ROLLBACK TRANSACTION 	
				SET @RUB_ID = -1
				--RETURN @RUB_ID
			END
			RETURN @RUB_ID
/*	BEGIN CATCH
		SELECT ERROR_MESSAGE(),ERROR_NUMBER()
		ROLLBACK TRANSACTION 	
		SET @RUB_ID = -1
		RETURN @RUB_ID
	END CATCH*/
END


-- PROCEDIMIENTOS DE PRODUCTO

CREATE PROCEDURE [dbo].[STR_NUEVO _PRODUCTO](
	@PRO_ID AS INT OUTPUT,
	@PRO_CODIGO AS VARCHAR(20),
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
			INSERT INTO C_PRODUCTO (PRO_CODIGO, PRO_NOMBRE, PRO_DESCRIPCION, PRO_MARCA, PRO_PRECIOCOSTO,
				PRO_PRECIOCOMPRA, PRO_IVA, PRO_IMPUESTOINTERNO, PRO_IDPADRE, PRO_MINIMO, PRO_MAXIMO,
				PRO_ALERTA, UNC_ID, UNV_ID, RUB_ID, FAM_ID)

			VALUES (@PRO_CODIGO, @PRO_NOMBRE, @PRO_DESCRIPCION, @PRO_MARCA, @PRO_PRECIOCOSTO,
				@PRO_PRECIOCOMPRA, @PRO_IVA, @PRO_IMPUESTOINTERNO, @PRO_IDPADRE, @PRO_MINIMO, @PRO_MAXIMO,
				@PRO_ALERTA, @UNC_ID, @UNV_ID, @RUB_ID, @FAM_ID)
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(),ERROR_NUMBER()
				ROLLBACK TRANSACTION 	
				SET @PRO_ID = -1
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


CREATE PROCEDURE [dbo].[STR_MODIFICA_PRODUCTO](
	@PRO_ID AS INT OUTPUT,
	@PRO_CODIGO AS VARCHAR(20),
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
				ROLLBACK TRANSACTION 	
				SET @PRO_ID = -1
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
			RETURN @IVA_ID
--		END TRY
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(), ERROR_NUMBER()
				ROLLBACK TRANSACTION
				SET @IVA_ID = -1
				--RETURN @IVA_ID
			END
		ELSE
			BEGIN
				COMMIT TRANSACTION
				SET @IVA_ID = @@IDENTITY
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
						IVA_ESTADO = @IVA_ESTADO,
						IVA_ID = @IVA_ID
					WHERE IVA_ID = @IVA_ID
				END
		IF (@@ERROR != 0)
			BEGIN
				SELECT @@ERROR --ERROR_MESSAGE(), ERROR_NUMBER()
				ROLLBACK TRANSACTION
				SET @IVA_ID = -1
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


-- CONSULTAS --

CREATE PROCEDURE [dbo].[STR_CONSULTA_CAJA](
	@CAJ_ID AS INT =0,
	@CAJ_NUMERO AS INT =0,
	@CAJ_FECHAAPERTURA AS DATETIME ='19000101',
	@CAJ_FECHACIERRE AS DATETIME ='19000101'
)
AS

BEGIN

	SELECT *
		FROM V_CAJA AS CAJA
	WHERE (@CAJ_ID ='' OR (CAJA.CAJ_ID = @CAJ_ID))
	  AND (@CAJ_NUMERO = '' OR (CAJA.CAJ_NUMERO = @CAJ_NUMERO))
	  AND (@CAJ_FECHAAPERTURA ='19000101' OR (CAJA.CAJ_FECHAAPERTURA = @CAJ_FECHAAPERTURA))
	  AND (@CAJ_FECHACIERRE ='19000101' OR (CAJA.CAJ_FECHACIERRE = @CAJ_FECHACIERRE))
	  AND (CAJA.CAJ_ESTADO = 1)

END




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

END




CREATE PROCEDURE [dbo].[STR_CONSULTA_FAMILIA](
	@FAM_ID AS INT =0,
	@FAM_NOMBRE AS VARCHAR(100)= ''
)

AS

BEGIN

	SELECT *
		FROM C_FAMILIA AS FAM
	WHERE (@FAM_ID = 0 OR (FAM.FAM_ID = @FAM_ID))
	  AND (@FAM_NOMBRE = '' OR (FAM.FAM_NOMBRE = @FAM_NOMBRE))
	  AND (FAM.FAM_ESTADO = 1)

END





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

END





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

END




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

END



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