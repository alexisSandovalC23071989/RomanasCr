CREATE TABLE [dbo].[ProveedorProducto] (
    [Id]                  UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [IdProveedor]         UNIQUEIDENTIFIER NOT NULL,
    [CodigoBarraProducto] VARCHAR (50)     NOT NULL,
    CONSTRAINT [PK_ProveedorProducto] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_ProveedorProducto_Producto] FOREIGN KEY ([CodigoBarraProducto]) REFERENCES [dbo].[Productos] ([CodigoBarra]),
    CONSTRAINT [FK_ProveedorProducto_Proveedor] FOREIGN KEY ([IdProveedor]) REFERENCES [dbo].[Proveedores] ([Id]),
    CONSTRAINT [UQ_ProveedorProducto] UNIQUE NONCLUSTERED ([IdProveedor] ASC, [CodigoBarraProducto] ASC)
);

