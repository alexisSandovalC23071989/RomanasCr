
CREATE   PROCEDURE ObtenerMovimientosInventario
AS
BEGIN

    SELECT
        M.Id,
        M.CodigoBarraProducto,
        P.Descripcion AS DescripcionProducto,
        M.TipoMovimiento,
        M.Cantidad,
        M.Fecha

    FROM MovimientosInventario M

    INNER JOIN Productos P
        ON M.CodigoBarraProducto = P.CodigoBarra

    ORDER BY M.Fecha DESC;

END;