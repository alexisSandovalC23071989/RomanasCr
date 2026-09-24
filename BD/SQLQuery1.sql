
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
