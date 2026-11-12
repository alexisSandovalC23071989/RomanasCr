CREATE   PROCEDURE ObtenerProveedoresProductos
AS
BEGIN

    SET NOCOUNT ON;

    SELECT
        PP.Id,
        PP.IdProveedor,
        PR.Nombre AS NombreProveedor,
        PP.CodigoBarraProducto,
        P.Descripcion AS DescripcionProducto

    FROM ProveedorProducto PP

    INNER JOIN Proveedores PR
        ON PP.IdProveedor = PR.Id

    INNER JOIN Productos P
        ON PP.CodigoBarraProducto = P.CodigoBarra;

END;