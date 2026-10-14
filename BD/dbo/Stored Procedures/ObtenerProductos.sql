CREATE PROCEDURE ObtenerProductos
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
    FROM Productos;

END;