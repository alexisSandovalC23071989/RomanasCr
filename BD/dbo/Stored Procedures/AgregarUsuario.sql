CREATE PROCEDURE AgregarUsuario
    @Nombre VARCHAR(100),
    @Telefono VARCHAR(20),
    @Correo VARCHAR(150),
    @Contrasena VARCHAR(255)
AS
BEGIN

    IF EXISTS
    (
        SELECT 1
        FROM Usuarios
        WHERE Correo = @Correo
    )
    BEGIN
        THROW 50001, 'El correo ya está registrado.', 1;
    END;

    DECLARE @Id UNIQUEIDENTIFIER = NEWID();

    INSERT INTO Usuarios
    (
        Id,
        Nombre,
        Telefono,
        Correo,
        Contrasena
    )
    VALUES
    (
        @Id,
        @Nombre,
        @Telefono,
        @Correo,
        @Contrasena
    );

    SELECT @Id AS Id;

END;