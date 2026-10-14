CREATE   PROCEDURE AgregarPromocion
    @CodigoBarraProducto VARCHAR(50),
    @PorcentajeDescuento DECIMAL(5,2),
    @FechaInicio DATETIME2,
    @FechaFin DATETIME2
AS
BEGIN

    SET NOCOUNT ON;

    -- 1. Validar que el producto exista
    IF NOT EXISTS
    (
        SELECT 1
        FROM Productos
        WHERE CodigoBarra = @CodigoBarraProducto
    )
    BEGIN
        THROW 50014, 'El producto no existe.', 1;
    END;

    -- 2. Validar el porcentaje de descuento
    IF @PorcentajeDescuento IS NULL
       OR @PorcentajeDescuento <= 0
       OR @PorcentajeDescuento > 100
    BEGIN
        THROW 50015,
              'El descuento debe ser mayor que 0 y menor o igual a 100.',
              1;
    END;

    -- 3. Validar las fechas
    IF @FechaInicio IS NULL
       OR @FechaFin IS NULL
       OR @FechaFin < @FechaInicio
    BEGIN
        THROW 50016,
              'La fecha final no puede ser anterior a la fecha inicial.',
              1;
    END;

    -- 4. Crear identificador
    DECLARE @Id UNIQUEIDENTIFIER = NEWID();

    -- 5. Registrar la promocion
    INSERT INTO Promociones
    (
        Id,
        CodigoBarraProducto,
        PorcentajeDescuento,
        FechaInicio,
        FechaFin
    )
    VALUES
    (
        @Id,
        @CodigoBarraProducto,
        @PorcentajeDescuento,
        @FechaInicio,
        @FechaFin
    );

    -- 6. Devolver el identificador creado
    SELECT @Id AS Id;

END;