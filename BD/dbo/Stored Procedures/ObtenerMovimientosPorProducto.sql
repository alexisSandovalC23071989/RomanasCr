
CREATE   PROCEDURE ObtenerMovimientosPorProducto
    @CodigoBarraProducto VARCHAR(50)
AS
BEGIN

    SET NOCOUNT ON;

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

    WHERE M.CodigoBarraProducto = @CodigoBarraProducto

    ORDER BY M.Fecha DESC;

END;