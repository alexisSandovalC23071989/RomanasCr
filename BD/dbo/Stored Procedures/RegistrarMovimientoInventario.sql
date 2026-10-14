CREATE   PROCEDURE RegistrarMovimientoInventario
    @CodigoBarraProducto VARCHAR(50),
    @TipoMovimiento VARCHAR(20),
    @Cantidad INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY

        BEGIN TRANSACTION;

        -- 1. Validar los parámetros
        IF @CodigoBarraProducto IS NULL
           OR LTRIM(RTRIM(@CodigoBarraProducto)) = ''
        BEGIN
            THROW 50008, 'Debe indicar el codigo de barras.', 1;
        END;

        IF @Cantidad IS NULL OR @Cantidad <= 0
        BEGIN
            THROW 50009, 'La cantidad debe ser mayor que cero.', 1;
        END;

        IF @TipoMovimiento IS NULL
           OR @TipoMovimiento NOT IN
           (
               'Entrada',
               'Salida',
               'AjustePositivo',
               'AjusteNegativo'
           )
        BEGIN
            THROW 50013, 'El tipo de movimiento no es valido.', 1;
        END;

        -- 2. Verificar que el producto exista
        IF NOT EXISTS
        (
            SELECT 1
            FROM Productos
            WHERE CodigoBarra = @CodigoBarraProducto
        )
        BEGIN
            THROW 50010, 'El producto no existe.', 1;
        END;

        -- 3. ENTRADA O AJUSTE POSITIVO
        IF @TipoMovimiento IN ('Entrada', 'AjustePositivo')
        BEGIN

            -- Intentar aumentar el inventario existente
            UPDATE Inventario WITH (UPDLOCK, SERIALIZABLE)
            SET CantidadDisponible = CantidadDisponible + @Cantidad
            WHERE CodigoBarraProducto = @CodigoBarraProducto;

            -- Si no se actualizo ninguna fila, crear el inventario
            IF @@ROWCOUNT = 0
            BEGIN
                INSERT INTO Inventario
                (
                    CodigoBarraProducto,
                    CantidadDisponible
                )
                VALUES
                (
                    @CodigoBarraProducto,
                    @Cantidad
                );
            END;

        END;

        -- 4. SALIDA O AJUSTE NEGATIVO
        ELSE IF @TipoMovimiento IN ('Salida', 'AjusteNegativo')
        BEGIN

            -- Restar solamente si existe cantidad suficiente
            UPDATE Inventario
            SET CantidadDisponible = CantidadDisponible - @Cantidad
            WHERE CodigoBarraProducto = @CodigoBarraProducto
              AND CantidadDisponible >= @Cantidad;

            -- Si no se actualizo ninguna fila, no habia suficiente
            IF @@ROWCOUNT = 0
            BEGIN
                THROW 50011,
                    'El producto no tiene inventario suficiente.',
                    1;
            END;

        END;

        -- 5. Registrar el movimiento en el historial
        INSERT INTO MovimientosInventario
        (
            CodigoBarraProducto,
            TipoMovimiento,
            Cantidad
        )
        VALUES
        (
            @CodigoBarraProducto,
            @TipoMovimiento,
            @Cantidad
        );

        -- 6. Confirmar los cambios
        COMMIT TRANSACTION;

    END TRY

    BEGIN CATCH

        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END;

        THROW;

    END CATCH;

END;