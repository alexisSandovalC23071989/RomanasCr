CREATE   PROCEDURE EliminarProveedor
    @Id UNIQUEIDENTIFIER
AS
BEGIN

    SET NOCOUNT ON;

    -- 1. Validar que el proveedor exista
    IF NOT EXISTS
    (
        SELECT 1
        FROM Proveedores
        WHERE Id = @Id
    )
    BEGIN
        THROW 50033, 'El proveedor no existe.', 1;
    END;

    -- 2. Validar que no tenga productos asociados
    IF EXISTS
    (
        SELECT 1
        FROM ProveedorProducto
        WHERE IdProveedor = @Id
    )
    BEGIN
        THROW 50034,
              'No se puede eliminar el proveedor porque tiene productos asociados.',
              1;
    END;

    -- 3. Eliminar el proveedor
    DELETE FROM Proveedores
    WHERE Id = @Id;

END;