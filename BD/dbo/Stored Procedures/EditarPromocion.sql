CREATE   PROCEDURE EditarPromocion
    @Id UNIQUEIDENTIFIER,
    @CodigoBarraProducto VARCHAR(50),
    @PorcentajeDescuento DECIMAL(5,2),
    @FechaInicio DATETIME2,
    @FechaFin DATETIME2
AS
BEGIN

    SET NOCOUNT ON;

    -- 1. Validar que la promocion exista
    IF NOT EXISTS
    (
        SELECT 1
        FROM Promociones
        WHERE Id = @Id
    )
    BEGIN
        THROW 50017, 'La promocion no existe.', 1;
    END;

    -- 2. Validar que el producto exista
    IF NOT EXISTS
    (
        SELECT 1
        FROM Productos
        WHERE CodigoBarra = @CodigoBarraProducto
    )
    BEGIN
        THROW 50018, 'El producto no existe.', 1;
    END;

    -- 3. Validar el porcentaje de descuento
    IF @PorcentajeDescuento IS NULL
       OR @PorcentajeDescuento <= 0
       OR @PorcentajeDescuento > 100
    BEGIN
        THROW 50019,
              'El descuento debe ser mayor que 0 y menor o igual a 100.',
              1;
    END;

    -- 4. Validar las fechas
    IF @FechaInicio IS NULL
       OR @FechaFin IS NULL
       OR @FechaFin < @FechaInicio
    BEGIN
        THROW 50020,
              'La fecha final no puede ser anterior a la fecha inicial.',
              1;
    END;

    -- 5. Actualizar la promocion
    UPDATE Promociones
    SET
        CodigoBarraProducto = @CodigoBarraProducto,
        PorcentajeDescuento = @PorcentajeDescuento,
        FechaInicio = @FechaInicio,
        FechaFin = @FechaFin
    WHERE Id = @Id;

END;