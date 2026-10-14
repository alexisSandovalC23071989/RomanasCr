CREATE PROCEDURE ObtenerProducto
    @CodigoBarra VARCHAR(50)
AS
BEGIN

    SELECT
        CodigoBarra,
        Descripcion,
        Marca,
        Modelo,
        Precio,
        PorcentajeIVA,
        Imagen
    FROM Productos
    WHERE CodigoBarra = @CodigoBarra;

END;