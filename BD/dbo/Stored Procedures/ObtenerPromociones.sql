
CREATE   PROCEDURE ObtenerPromociones
AS
BEGIN

    SET NOCOUNT ON;

    SELECT
        PR.Id,
        PR.CodigoBarraProducto,
        P.Descripcion AS DescripcionProducto,
        PR.PorcentajeDescuento,
        PR.FechaInicio,
        PR.FechaFin,
        P.Precio AS PrecioOriginal,

        P.Precio -
        (P.Precio * PR.PorcentajeDescuento / 100.0)
        AS PrecioConDescuento

    FROM Promociones PR

    INNER JOIN Productos P
        ON PR.CodigoBarraProducto = P.CodigoBarra;

END;