CREATE   PROCEDURE AgregarProveedor
    @Nombre VARCHAR(150),
    @Telefono VARCHAR(20),
    @Correo VARCHAR(150),
    @Direccion VARCHAR(250)
AS
BEGIN

    SET NOCOUNT ON;

    -- 1. Validar el nombre
    IF @Nombre IS NULL OR LTRIM(RTRIM(@Nombre)) = ''
    BEGIN
        THROW 50022, 'El nombre del proveedor es obligatorio.', 1;
    END;

    -- 2. Validar el telefono
    IF @Telefono IS NULL OR LTRIM(RTRIM(@Telefono)) = ''
    BEGIN
        THROW 50023, 'El telefono del proveedor es obligatorio.', 1;
    END;

    -- 3. Validar el correo
    IF @Correo IS NULL OR LTRIM(RTRIM(@Correo)) = ''
    BEGIN
        THROW 50024, 'El correo del proveedor es obligatorio.', 1;
    END;

    -- 4. Validar la direccion
    IF @Direccion IS NULL OR LTRIM(RTRIM(@Direccion)) = ''
    BEGIN
        THROW 50025, 'La direccion del proveedor es obligatoria.', 1;
    END;

    -- 5. Validar correo duplicado
    IF EXISTS
    (
        SELECT 1
        FROM Proveedores
        WHERE Correo = @Correo
    )
    BEGIN
        THROW 50026, 'Ya existe un proveedor con ese correo.', 1;
    END;

    -- 6. Generar identificador
    DECLARE @Id UNIQUEIDENTIFIER = NEWID();

    -- 7. Registrar proveedor
    INSERT INTO Proveedores
    (
        Id,
        Nombre,
        Telefono,
        Correo,
        Direccion
    )
    VALUES
    (
        @Id,
        @Nombre,
        @Telefono,
        @Correo,
        @Direccion
    );

    -- 8. Devolver identificador
    SELECT @Id AS Id;

END;