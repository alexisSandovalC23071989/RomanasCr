
CREATE   PROCEDURE ObtenerProveedores
AS
BEGIN

    SET NOCOUNT ON;

    SELECT
        Id,
        Nombre,
        Telefono,
        Correo,
        Direccion
    FROM Proveedores;

END;