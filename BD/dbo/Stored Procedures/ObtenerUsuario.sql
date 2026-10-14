CREATE PROCEDURE ObtenerUsuario
    @Id UNIQUEIDENTIFIER
AS
BEGIN

    SELECT
        Id,
        Nombre,
        Telefono,
        Correo
    FROM Usuarios
    WHERE Id = @Id;

END;