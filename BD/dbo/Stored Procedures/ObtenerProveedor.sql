CREATE   PROCEDURE ObtenerProveedor
    @Id UNIQUEIDENTIFIER
AS
BEGIN

    SET NOCOUNT ON;

    SELECT
        Id,
        Nombre,
        Telefono,
        Correo,
        Direccion
    FROM Proveedores
    WHERE Id = @Id;

END;