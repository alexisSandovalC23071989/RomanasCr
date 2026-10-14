CREATE PROCEDURE EditarProducto
    @CodigoBarra VARCHAR(50),
    @Descripcion VARCHAR(200),
    @Marca VARCHAR(100),
    @Modelo VARCHAR(100),
    @Precio DECIMAL(18,2),
    @PorcentajeIVA DECIMAL(5,2),
    @Imagen VARCHAR(500)
AS
BEGIN

    IF NOT EXISTS
    (
        SELECT 1
        FROM Productos
        WHERE CodigoBarra = @CodigoBarra
    )
    BEGIN
        THROW 50006, 'El producto no existe.', 1;
    END;

    UPDATE Productos
    SET
        Descripcion = @Descripcion,
        Marca = @Marca,
        Modelo = @Modelo,
        Precio = @Precio,
        PorcentajeIVA = @PorcentajeIVA,
        Imagen = @Imagen
    WHERE CodigoBarra = @CodigoBarra;

END;