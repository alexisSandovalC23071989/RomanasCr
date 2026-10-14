CREATE PROCEDURE EliminarUsuario
    @Id UNIQUEIDENTIFIER
AS
BEGIN

    IF NOT EXISTS
    (
        SELECT 1
        FROM Usuarios
        WHERE Id = @Id
    )
    BEGIN
        THROW 50004, 'El usuario no existe.', 1;
    END;

    DELETE FROM Usuarios
    WHERE Id = @Id;

END;