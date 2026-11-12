CREATE   PROCEDURE EditarProveedor
    @Id UNIQUEIDENTIFIER,
    @Nombre VARCHAR(150),
    @Telefono VARCHAR(20),
    @Correo VARCHAR(150),
    @Direccion VARCHAR(250)
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
        THROW 50027, 'El proveedor no existe.', 1;
    END;

    -- 2. Validar el nombre
    IF @Nombre IS NULL OR LTRIM(RTRIM(@Nombre)) = ''
    BEGIN
        THROW 50028, 'El nombre del proveedor es obligatorio.', 1;
    END;

    -- 3. Validar el telefono
    IF @Telefono IS NULL OR LTRIM(RTRIM(@Telefono)) = ''
    BEGIN
        THROW 50029, 'El telefono del proveedor es obligatorio.', 1;
    END;

    -- 4. Validar el correo
    IF @Correo IS NULL OR LTRIM(RTRIM(@Correo)) = ''
    BEGIN
        THROW 50030, 'El correo del proveedor es obligatorio.', 1;
    END;

    -- 5. Validar la direccion
    IF @Direccion IS NULL OR LTRIM(RTRIM(@Direccion)) = ''
    BEGIN
        THROW 50031, 'La direccion del proveedor es obligatoria.', 1;
    END;

    -- 6. Validar que otro proveedor no tenga el mismo correo
    IF EXISTS
    (
        SELECT 1
        FROM Proveedores
        WHERE Correo = @Correo
          AND Id <> @Id
    )
    BEGIN
        THROW 50032, 'Ya existe otro proveedor con ese correo.', 1;
    END;

    -- 7. Actualizar los datos
    UPDATE Proveedores
    SET
        Nombre = @Nombre,
        Telefono = @Telefono,
        Correo = @Correo,
        Direccion = @Direccion
    WHERE Id = @Id;

END;