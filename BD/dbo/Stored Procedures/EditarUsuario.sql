CREATE PROCEDURE EditarUsuario
    @Id UNIQUEIDENTIFIER,
    @Nombre VARCHAR(100),
    @Telefono VARCHAR(20),
    @Correo VARCHAR(150)
AS
BEGIN

    IF NOT EXISTS
    (
        SELECT 1
        FROM Usuarios
        WHERE Id = @Id
    )
    BEGIN
        THROW 50002, 'El usuario no existe.', 1;
    END;

    IF EXISTS
    (
        SELECT 1
        FROM Usuarios
        WHERE Correo = @Correo
          AND Id <> @Id
    )
    BEGIN
        THROW 50003, 'El correo ya pertenece a otro usuario.', 1;
    END;

    UPDATE Usuarios
    SET
        Nombre = @Nombre,
        Telefono = @Telefono,
        Correo = @Correo
    WHERE Id = @Id;

END;