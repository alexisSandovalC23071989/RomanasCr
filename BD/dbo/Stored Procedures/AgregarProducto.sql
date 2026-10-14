CREATE PROCEDURE AgregarProducto
    @CodigoBarra VARCHAR(50),
    @Descripcion VARCHAR(200),
    @Marca VARCHAR(100),
    @Modelo VARCHAR(100),
    @Precio DECIMAL(18,2),
    @PorcentajeIVA DECIMAL(5,2),
    @Imagen VARCHAR(500)
AS
BEGIN

    IF EXISTS
    (
        SELECT 1
        FROM Productos
        WHERE CodigoBarra = @CodigoBarra
    )
    BEGIN
        THROW 50005, 'El producto con este código de barras ya existe.', 1;
    END;

    INSERT INTO Productos
    (
        CodigoBarra,
        Descripcion,
        Marca,
        Modelo,
        Precio,
        PorcentajeIVA,
        Imagen
    )
    VALUES
    (
        @CodigoBarra,
        @Descripcion,
        @Marca,
        @Modelo,
        @Precio,
        @PorcentajeIVA,
        @Imagen
    );

END;