
----Se crea la Tabla de Usuarios
CREATE TABLE Usuarios
(
    Id UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
    Nombre VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    Correo VARCHAR(150) NOT NULL,
    Contrasena VARCHAR(255) NOT NULL,

    CONSTRAINT PK_Usuarios PRIMARY KEY (Id),
    CONSTRAINT UQ_Usuarios_Correo UNIQUE (Correo)
);

----Se crea la Tabla de Productos


CREATE TABLE Productos
(
    CodigoBarra VARCHAR(50) NOT NULL,

    Descripcion VARCHAR(200) NOT NULL,

    Marca VARCHAR(100) NOT NULL,

    Modelo VARCHAR(100) NOT NULL,

    Precio DECIMAL(18,2) NOT NULL,

    PorcentajeIVA DECIMAL(5,2) NOT NULL,

    Imagen VARCHAR(500) NULL,

    CONSTRAINT PK_Productos
        PRIMARY KEY (CodigoBarra),

    CONSTRAINT CK_Productos_Precio
        CHECK (Precio >= 0),

    CONSTRAINT CK_Productos_PorcentajeIVA
        CHECK (PorcentajeIVA >= 0 AND PorcentajeIVA <= 100)
);

----- Se crea la Tabla de Inventario

CREATE TABLE Inventario
(
    Id UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),

    CodigoBarraProducto VARCHAR(50) NOT NULL,

    CantidadDisponible INT NOT NULL DEFAULT 0,

    CONSTRAINT PK_Inventario
        PRIMARY KEY (Id),

    CONSTRAINT FK_Inventario_Productos
        FOREIGN KEY (CodigoBarraProducto)
        REFERENCES Productos(CodigoBarra),

    CONSTRAINT UQ_Inventario_CodigoBarraProducto
        UNIQUE (CodigoBarraProducto),

    CONSTRAINT CK_Inventario_CantidadDisponible
        CHECK (CantidadDisponible >= 0)
);

---Tabla de Movimientos de Inventario.

CREATE TABLE MovimientosInventario
(
    Id UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),

    CodigoBarraProducto VARCHAR(50) NOT NULL,

    TipoMovimiento VARCHAR(20) NOT NULL,

    Cantidad INT NOT NULL,

    Fecha DATETIME2 NOT NULL DEFAULT GETDATE(),

    CONSTRAINT PK_MovimientosInventario
        PRIMARY KEY (Id),

    CONSTRAINT FK_MovimientosInventario_Productos
        FOREIGN KEY (CodigoBarraProducto)
        REFERENCES Productos(CodigoBarra),

    CONSTRAINT CK_MovimientosInventario_Cantidad
        CHECK (Cantidad > 0),

    CONSTRAINT CK_MovimientosInventario_Tipo
        CHECK (TipoMovimiento IN
        (
            'Entrada',
            'Salida',
            'AjustePositivo',
            'AjusteNegativo'
        ))
);

-----------------------------Procedimiento Almacenados-----------------------------------------------------------------------


------------------------------Obtener Usuarios----------------------------------
    CREATE PROCEDURE ObtenerUsuarios
      AS
    BEGIN

    SELECT
        Id,
        Nombre,
        Telefono,
        Correo,
        Contrasena
    FROM Usuarios;

    END;
 
 --------------------------Obtener usuario por ID--------------------------------

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
------------------------------------------Agregar Usuario-----------------------------------------


CREATE PROCEDURE AgregarUsuario
    @Nombre VARCHAR(100),
    @Telefono VARCHAR(20),
    @Correo VARCHAR(150),
    @Contrasena VARCHAR(255)
AS
BEGIN

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

-------------------------------------Editar Usuario------------------------------------------------

CREATE PROCEDURE EditarUsuario
    @Id UNIQUEIDENTIFIER,
    @Nombre VARCHAR(100),
    @Telefono VARCHAR(20),
    @Correo VARCHAR(150)
AS
BEGIN

    UPDATE Usuarios
    SET
        Nombre = @Nombre,
        Telefono = @Telefono,
        Correo = @Correo
    WHERE Id = @Id;

END;

-------------------------------------Eliminar Usuario -------------------------------------

CREATE PROCEDURE EliminarUsuario
    @Id UNIQUEIDENTIFIER
AS
BEGIN

    DELETE FROM Usuarios
    WHERE Id = @Id;

END;


-----------------------------------------Validacion para no tener usuarios duplicados----------------------

ALTER TABLE Usuarios
ADD CONSTRAINT UQ_Usuarios_Correo
UNIQUE (Correo);
----------------------------------------Se Actualizo el procedimiento almacenado de agregar Usuario-------------

ALTER PROCEDURE AgregarUsuario
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

---------------------------------------- Actualizacion del procedimiento de Editar Usuario----------------------------------

ALTER PROCEDURE EditarUsuario
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

---------------------------------------------------Actualizar procedimiento Eliminar-------------------------


CREATE PROCEDURE ObtenerProductos
AS
BEGIN

    SELECT
        CodigoBarra,
        Descripcion,
        Marca,
        Modelo,
        Precio,
        PorcentajeIVA,
        Imagen
    FROM Productos;

END;
GO

CREATE PROCEDURE ObtenerProducto
    @CodigoBarra VARCHAR(50)
AS
BEGIN

    SELECT
        CodigoBarra,
        Descripcion,
        Marca,
        Modelo,
        Precio,
        PorcentajeIVA,
        Imagen
    FROM Productos
    WHERE CodigoBarra = @CodigoBarra;

END;
GO


CREATE PROCEDURE AgregarProducto
    @CodigoBarra VARCHAR(50),
    @Descripcion VARCHAR(200),
    @Marca VARCHAR(100),
    @Modelo VARCHAR(100),
    @Precio DECIMAL(18,2),
    @PorcentajeIVA DECIMAL(5,2),
    @Imagen VARCHAR(500)
AS
BEGIN

    INSERT INTO Productos
    (
        CodigoBarra,
        Descripcion,
        Marca,
        Modelo,
        Precio,
        PorcentajeIVA,
        Imagen
    )
    VALUES
    (
        @CodigoBarra,
        @Descripcion,
        @Marca,
        @Modelo,
        @Precio,
        @PorcentajeIVA,
        @Imagen
    );

END;
GO

-------------------------------------------Se actualizo el procedimiento almacenado-----------------------------------

ALTER PROCEDURE AgregarProducto
    @CodigoBarra VARCHAR(50),
    @Descripcion VARCHAR(200),
    @Marca VARCHAR(100),
    @Modelo VARCHAR(100),
    @Precio DECIMAL(18,2),
    @PorcentajeIVA DECIMAL(5,2),
    @Imagen VARCHAR(500)
AS
BEGIN

    IF EXISTS
    (
        SELECT 1
        FROM Productos
        WHERE CodigoBarra = @CodigoBarra
    )
    BEGIN
        THROW 50005, 'El producto con este código de barras ya existe.', 1;
    END;

    INSERT INTO Productos
    (
        CodigoBarra,
        Descripcion,
        Marca,
        Modelo,
        Precio,
        PorcentajeIVA,
        Imagen
    )
    VALUES
    (
        @CodigoBarra,
        @Descripcion,
        @Marca,
        @Modelo,
        @Precio,
        @PorcentajeIVA,
        @Imagen
    );

END;
GO

--------------------------------------Procedimiento Editar Producto --------------------------------------------

CREATE PROCEDURE EditarProducto
    @CodigoBarra VARCHAR(50),
    @Descripcion VARCHAR(200),
    @Marca VARCHAR(100),
    @Modelo VARCHAR(100),
    @Precio DECIMAL(18,2),
    @PorcentajeIVA DECIMAL(5,2),
    @Imagen VARCHAR(500)
AS
BEGIN

    IF NOT EXISTS
    (
        SELECT 1
        FROM Productos
        WHERE CodigoBarra = @CodigoBarra
    )
    BEGIN
        THROW 50006, 'El producto no existe.', 1;
    END;

    UPDATE Productos
    SET
        Descripcion = @Descripcion,
        Marca = @Marca,
        Modelo = @Modelo,
        Precio = @Precio,
        PorcentajeIVA = @PorcentajeIVA,
        Imagen = @Imagen
    WHERE CodigoBarra = @CodigoBarra;

END;
GO

--------------------------------------Procedimiento de Eliminar Producto---------------------------------
CREATE PROCEDURE EliminarProducto
    @CodigoBarra VARCHAR(50)
AS
BEGIN

    IF NOT EXISTS
    (
        SELECT 1
        FROM Productos
        WHERE CodigoBarra = @CodigoBarra
    )
    BEGIN
        THROW 50007, 'El producto no existe.', 1;
    END;

    DELETE FROM Productos
    WHERE CodigoBarra = @CodigoBarra;

END;
GO

---------------------------Procedimiento Almacenado Inventario----------------------

CREATE PROCEDURE ObtenerInventario
AS
BEGIN

    SELECT
        I.CodigoBarraProducto,
        P.Descripcion AS DescripcionProducto,
        I.Cantidad
    FROM Inventario I

    INNER JOIN Productos P
        ON I.CodigoBarraProducto = P.CodigoBarra;

END;
GO
-------------------------Obtener Inventario por Codigo de Barra-----------------------

ALTER PROCEDURE ObtenerInventarioProducto
    @CodigoBarraProducto VARCHAR(50)
AS
BEGIN

    SELECT
        I.CodigoBarraProducto,
        P.Descripcion AS DescripcionProducto,
        I.Cantidad
    FROM Inventario I

    INNER JOIN Productos P
        ON I.CodigoBarraProducto = P.CodigoBarra

    WHERE I.CodigoBarraProducto = @CodigoBarraProducto;

END;
GO
--------------------------------Registrar Movimiento de Inventario ---------------------

CREATE OR ALTER PROCEDURE RegistrarMovimientoInventario
    @CodigoBarraProducto VARCHAR(50),
    @TipoMovimiento VARCHAR(20),
    @Cantidad INT
AS
BEGIN

    BEGIN TRY

        BEGIN TRANSACTION;

        -- Validar que el producto exista
        IF NOT EXISTS
        (
            SELECT 1
            FROM Productos
            WHERE CodigoBarra = @CodigoBarraProducto
        )
        BEGIN
            THROW 50008, 'El producto no existe.', 1;
        END;

        -- Validar que la cantidad sea mayor que cero
        IF @Cantidad <= 0
        BEGIN
            THROW 50009, 'La cantidad debe ser mayor que cero.', 1;
        END;

        -- ENTRADA
        IF @TipoMovimiento = 'Entrada'
        BEGIN

            UPDATE Inventario
            SET CantidadDisponible = CantidadDisponible + @Cantidad
            WHERE CodigoBarraProducto = @CodigoBarraProducto;

        END;

        -- SALIDA
        ELSE IF @TipoMovimiento = 'Salida'
        BEGIN

            IF
            (
                SELECT CantidadDisponible
                FROM Inventario
                WHERE CodigoBarraProducto = @CodigoBarraProducto
            ) < @Cantidad
            BEGIN
                THROW 50010, 'No existe suficiente inventario.', 1;
            END;

            UPDATE Inventario
            SET CantidadDisponible = CantidadDisponible - @Cantidad
            WHERE CodigoBarraProducto = @CodigoBarraProducto;

        END;

        -- AJUSTE POSITIVO
        ELSE IF @TipoMovimiento = 'AjustePositivo'
        BEGIN

            UPDATE Inventario
            SET CantidadDisponible = CantidadDisponible + @Cantidad
            WHERE CodigoBarraProducto = @CodigoBarraProducto;

        END;

        -- AJUSTE NEGATIVO
        ELSE IF @TipoMovimiento = 'AjusteNegativo'
        BEGIN

            IF
            (
                SELECT CantidadDisponible
                FROM Inventario
                WHERE CodigoBarraProducto = @CodigoBarraProducto
            ) < @Cantidad
            BEGIN
                THROW 50011, 'No existe suficiente inventario para realizar el ajuste.', 1;
            END;

            UPDATE Inventario
            SET CantidadDisponible = CantidadDisponible - @Cantidad
            WHERE CodigoBarraProducto = @CodigoBarraProducto;

        END;

        -- Tipo de movimiento incorrecto
        ELSE
        BEGIN
            THROW 50012, 'El tipo de movimiento no es válido.', 1;
        END;

        -- Guardar el movimiento
        INSERT INTO MovimientosInventario
        (
            CodigoBarraProducto,
            TipoMovimiento,
            Cantidad
        )
        VALUES
        (
            @CodigoBarraProducto,
            @TipoMovimiento,
            @Cantidad
        );

        COMMIT TRANSACTION;

    END TRY

    BEGIN CATCH

        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END;

        THROW;

    END CATCH;

END;
GO

--------------------------------RegistrarMovimientoInventario---------------------------------
USE RomanasCr;
GO

CREATE OR ALTER PROCEDURE RegistrarMovimientoInventario
    @CodigoBarraProducto VARCHAR(50),
    @TipoMovimiento VARCHAR(20),
    @Cantidad INT
AS
BEGIN

    BEGIN TRY

        BEGIN TRANSACTION;

        -- Validar que el producto exista
        IF NOT EXISTS
        (
            SELECT 1
            FROM Productos
            WHERE CodigoBarra = @CodigoBarraProducto
        )
        BEGIN
            THROW 50008, 'El producto no existe.', 1;
        END;

        -- Validar que la cantidad sea mayor que cero
        IF @Cantidad <= 0
        BEGIN
            THROW 50009, 'La cantidad debe ser mayor que cero.', 1;
        END;


        -- ENTRADA
        IF @TipoMovimiento = 'Entrada'
        BEGIN

            -- ¿Ya existe el producto en Inventario?
            IF EXISTS
            (
                SELECT 1
                FROM Inventario
                WHERE CodigoBarraProducto = @CodigoBarraProducto
            )
            BEGIN

                -- Si existe, aumentar la cantidad
                UPDATE Inventario
                SET CantidadDisponible = CantidadDisponible + @Cantidad
                WHERE CodigoBarraProducto = @CodigoBarraProducto;

            END
            ELSE
            BEGIN

                -- Si no existe, crear el registro de inventario
                INSERT INTO Inventario
                (
                    CodigoBarraProducto,
                    CantidadDisponible
                )
                VALUES
                (
                    @CodigoBarraProducto,
                    @Cantidad
                );

            END;

        END;


        -- SALIDA
        ELSE IF @TipoMovimiento = 'Salida'
        BEGIN

            IF NOT EXISTS
            (
                SELECT 1
                FROM Inventario
                WHERE CodigoBarraProducto = @CodigoBarraProducto
            )
            BEGIN
                THROW 50010, 'El producto no tiene inventario disponible.', 1;
            END;

            IF
            (
                SELECT CantidadDisponible
                FROM Inventario
                WHERE CodigoBarraProducto = @CodigoBarraProducto
            ) < @Cantidad
            BEGIN
                THROW 50011, 'No existe suficiente inventario.', 1;
            END;

            UPDATE Inventario
            SET CantidadDisponible = CantidadDisponible - @Cantidad
            WHERE CodigoBarraProducto = @CodigoBarraProducto;

        END;


        -- AJUSTE POSITIVO
        ELSE IF @TipoMovimiento = 'AjustePositivo'
        BEGIN

            UPDATE Inventario
            SET CantidadDisponible = CantidadDisponible + @Cantidad
            WHERE CodigoBarraProducto = @CodigoBarraProducto;

        END;


        -- AJUSTE NEGATIVO
        ELSE IF @TipoMovimiento = 'AjusteNegativo'
        BEGIN

            IF
            (
                SELECT CantidadDisponible
                FROM Inventario
                WHERE CodigoBarraProducto = @CodigoBarraProducto
            ) < @Cantidad
            BEGIN
                THROW 50012,
                'No existe suficiente inventario para realizar el ajuste.',
                1;
            END;

            UPDATE Inventario
            SET CantidadDisponible = CantidadDisponible - @Cantidad
            WHERE CodigoBarraProducto = @CodigoBarraProducto;

        END;


        -- TIPO DE MOVIMIENTO INCORRECTO
        ELSE
        BEGIN
            THROW 50013, 'El tipo de movimiento no es válido.', 1;
        END;


        -- Registrar el movimiento
        INSERT INTO MovimientosInventario
        (
            CodigoBarraProducto,
            TipoMovimiento,
            Cantidad
        )
        VALUES
        (
            @CodigoBarraProducto,
            @TipoMovimiento,
            @Cantidad
        );


        COMMIT TRANSACTION;

    END TRY

    BEGIN CATCH

        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END;

        THROW;

    END CATCH;

END;
GO

-----------------------  ObtenerMovimientosInventario-------------------

USE RomanasCr;
GO

CREATE OR ALTER PROCEDURE ObtenerMovimientosInventario
AS
BEGIN

    SELECT
        M.Id,
        M.CodigoBarraProducto,
        P.Descripcion AS DescripcionProducto,
        M.TipoMovimiento,
        M.Cantidad,
        M.Fecha

    FROM MovimientosInventario M

    INNER JOIN Productos P
        ON M.CodigoBarraProducto = P.CodigoBarra

    ORDER BY M.Fecha DESC;

END;
GO


---------------------Actulizado RegistrarMovimientoInventario------------------

USE RomanasCr;
GO

CREATE OR ALTER PROCEDURE RegistrarMovimientoInventario
    @CodigoBarraProducto VARCHAR(50),
    @TipoMovimiento VARCHAR(20),
    @Cantidad INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY

        BEGIN TRANSACTION;

        -- 1. Validar los parámetros
        IF @CodigoBarraProducto IS NULL
           OR LTRIM(RTRIM(@CodigoBarraProducto)) = ''
        BEGIN
            THROW 50008, 'Debe indicar el codigo de barras.', 1;
        END;

        IF @Cantidad IS NULL OR @Cantidad <= 0
        BEGIN
            THROW 50009, 'La cantidad debe ser mayor que cero.', 1;
        END;

        IF @TipoMovimiento IS NULL
           OR @TipoMovimiento NOT IN
           (
               'Entrada',
               'Salida',
               'AjustePositivo',
               'AjusteNegativo'
           )
        BEGIN
            THROW 50013, 'El tipo de movimiento no es valido.', 1;
        END;

        -- 2. Verificar que el producto exista
        IF NOT EXISTS
        (
            SELECT 1
            FROM Productos
            WHERE CodigoBarra = @CodigoBarraProducto
        )
        BEGIN
            THROW 50010, 'El producto no existe.', 1;
        END;

        -- 3. ENTRADA O AJUSTE POSITIVO
        IF @TipoMovimiento IN ('Entrada', 'AjustePositivo')
        BEGIN

            -- Intentar aumentar el inventario existente
            UPDATE Inventario WITH (UPDLOCK, SERIALIZABLE)
            SET CantidadDisponible = CantidadDisponible + @Cantidad
            WHERE CodigoBarraProducto = @CodigoBarraProducto;

            -- Si no se actualizo ninguna fila, crear el inventario
            IF @@ROWCOUNT = 0
            BEGIN
                INSERT INTO Inventario
                (
                    CodigoBarraProducto,
                    CantidadDisponible
                )
                VALUES
                (
                    @CodigoBarraProducto,
                    @Cantidad
                );
            END;

        END;

        -- 4. SALIDA O AJUSTE NEGATIVO
        ELSE IF @TipoMovimiento IN ('Salida', 'AjusteNegativo')
        BEGIN

            -- Restar solamente si existe cantidad suficiente
            UPDATE Inventario
            SET CantidadDisponible = CantidadDisponible - @Cantidad
            WHERE CodigoBarraProducto = @CodigoBarraProducto
              AND CantidadDisponible >= @Cantidad;

            -- Si no se actualizo ninguna fila, no habia suficiente
            IF @@ROWCOUNT = 0
            BEGIN
                THROW 50011,
                    'El producto no tiene inventario suficiente.',
                    1;
            END;

        END;

        -- 5. Registrar el movimiento en el historial
        INSERT INTO MovimientosInventario
        (
            CodigoBarraProducto,
            TipoMovimiento,
            Cantidad
        )
        VALUES
        (
            @CodigoBarraProducto,
            @TipoMovimiento,
            @Cantidad
        );

        -- 6. Confirmar los cambios
        COMMIT TRANSACTION;

    END TRY

    BEGIN CATCH

        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END;

        THROW;

    END CATCH;

END;
GO

-------------------------ObtenerMovimientosPorProducto-----------------------------
USE RomanasCr;
GO

CREATE OR ALTER PROCEDURE ObtenerMovimientosPorProducto
    @CodigoBarraProducto VARCHAR(50)
AS
BEGIN

    SET NOCOUNT ON;

    SELECT
        M.Id,
        M.CodigoBarraProducto,
        P.Descripcion AS DescripcionProducto,
        M.TipoMovimiento,
        M.Cantidad,
        M.Fecha

    FROM MovimientosInventario M

    INNER JOIN Productos P
        ON M.CodigoBarraProducto = P.CodigoBarra

    WHERE M.CodigoBarraProducto = @CodigoBarraProducto

    ORDER BY M.Fecha DESC;

END;
GO
------------------------ ObtenerPromociones--------------------------

CREATE OR ALTER PROCEDURE ObtenerPromociones
AS
BEGIN

    SET NOCOUNT ON;

    SELECT
        PR.Id,
        PR.CodigoBarraProducto,
        P.Descripcion AS DescripcionProducto,
        PR.PorcentajeDescuento,
        PR.FechaInicio,
        PR.FechaFin,
        P.Precio AS PrecioOriginal,

        P.Precio -
        (P.Precio * PR.PorcentajeDescuento / 100.0)
        AS PrecioConDescuento

    FROM Promociones PR

    INNER JOIN Productos P
        ON PR.CodigoBarraProducto = P.CodigoBarra;

END;
GO

-----------------------  ObtenerPromocion-------------------------------


CREATE OR ALTER PROCEDURE ObtenerPromocion
    @Id UNIQUEIDENTIFIER
AS
BEGIN

    SET NOCOUNT ON;

    SELECT
        PR.Id,
        PR.CodigoBarraProducto,
        P.Descripcion AS DescripcionProducto,
        PR.PorcentajeDescuento,
        PR.FechaInicio,
        PR.FechaFin,
        P.Precio AS PrecioOriginal,

        P.Precio -
        (P.Precio * PR.PorcentajeDescuento / 100.0)
        AS PrecioConDescuento

    FROM Promociones PR

    INNER JOIN Productos P
        ON PR.CodigoBarraProducto = P.CodigoBarra

    WHERE PR.Id = @Id;

END;
GO
----------------------------AgregarPromocion----------------------


CREATE OR ALTER PROCEDURE AgregarPromocion
    @CodigoBarraProducto VARCHAR(50),
    @PorcentajeDescuento DECIMAL(5,2),
    @FechaInicio DATETIME2,
    @FechaFin DATETIME2
AS
BEGIN

    SET NOCOUNT ON;

    -- 1. Validar que el producto exista
    IF NOT EXISTS
    (
        SELECT 1
        FROM Productos
        WHERE CodigoBarra = @CodigoBarraProducto
    )
    BEGIN
        THROW 50014, 'El producto no existe.', 1;
    END;

    -- 2. Validar el porcentaje de descuento
    IF @PorcentajeDescuento IS NULL
       OR @PorcentajeDescuento <= 0
       OR @PorcentajeDescuento > 100
    BEGIN
        THROW 50015,
              'El descuento debe ser mayor que 0 y menor o igual a 100.',
              1;
    END;

    -- 3. Validar las fechas
    IF @FechaInicio IS NULL
       OR @FechaFin IS NULL
       OR @FechaFin < @FechaInicio
    BEGIN
        THROW 50016,
              'La fecha final no puede ser anterior a la fecha inicial.',
              1;
    END;

    -- 4. Crear identificador
    DECLARE @Id UNIQUEIDENTIFIER = NEWID();

    -- 5. Registrar la promocion
    INSERT INTO Promociones
    (
        Id,
        CodigoBarraProducto,
        PorcentajeDescuento,
        FechaInicio,
        FechaFin
    )
    VALUES
    (
        @Id,
        @CodigoBarraProducto,
        @PorcentajeDescuento,
        @FechaInicio,
        @FechaFin
    );

    -- 6. Devolver el identificador creado
    SELECT @Id AS Id;

END;
GO

------------------------- EditarPromocion-------------------------------------



CREATE OR ALTER PROCEDURE EditarPromocion
    @Id UNIQUEIDENTIFIER,
    @CodigoBarraProducto VARCHAR(50),
    @PorcentajeDescuento DECIMAL(5,2),
    @FechaInicio DATETIME2,
    @FechaFin DATETIME2
AS
BEGIN

    SET NOCOUNT ON;

    -- 1. Validar que la promocion exista
    IF NOT EXISTS
    (
        SELECT 1
        FROM Promociones
        WHERE Id = @Id
    )
    BEGIN
        THROW 50017, 'La promocion no existe.', 1;
    END;

    -- 2. Validar que el producto exista
    IF NOT EXISTS
    (
        SELECT 1
        FROM Productos
        WHERE CodigoBarra = @CodigoBarraProducto
    )
    BEGIN
        THROW 50018, 'El producto no existe.', 1;
    END;

    -- 3. Validar el porcentaje de descuento
    IF @PorcentajeDescuento IS NULL
       OR @PorcentajeDescuento <= 0
       OR @PorcentajeDescuento > 100
    BEGIN
        THROW 50019,
              'El descuento debe ser mayor que 0 y menor o igual a 100.',
              1;
    END;

    -- 4. Validar las fechas
    IF @FechaInicio IS NULL
       OR @FechaFin IS NULL
       OR @FechaFin < @FechaInicio
    BEGIN
        THROW 50020,
              'La fecha final no puede ser anterior a la fecha inicial.',
              1;
    END;

    -- 5. Actualizar la promocion
    UPDATE Promociones
    SET
        CodigoBarraProducto = @CodigoBarraProducto,
        PorcentajeDescuento = @PorcentajeDescuento,
        FechaInicio = @FechaInicio,
        FechaFin = @FechaFin
    WHERE Id = @Id;

END;
GO

------------------------EliminarPromocion---------------------------



CREATE OR ALTER PROCEDURE EliminarPromocion
    @Id UNIQUEIDENTIFIER
AS
BEGIN

    SET NOCOUNT ON;

    -- 1. Validar que la promocion exista
    IF NOT EXISTS
    (
        SELECT 1
        FROM Promociones
        WHERE Id = @Id
    )
    BEGIN
        THROW 50021, 'La promocion no existe.', 1;
    END;

    -- 2. Eliminar la promocion
    DELETE FROM Promociones
    WHERE Id = @Id;

END;
GO