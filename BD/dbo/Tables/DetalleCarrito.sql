CREATE TABLE [dbo].[DetalleCarrito] (
    [Id]                  UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [IdCarrito]           UNIQUEIDENTIFIER NOT NULL,
    [CodigoBarraProducto] VARCHAR (50)     NOT NULL,
    [Cantidad]            INT              NOT NULL,
    CONSTRAINT [PK_DetalleCarrito] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [CK_DetalleCarrito_Cantidad] CHECK ([Cantidad]>(0)),
    CONSTRAINT [FK_DetalleCarrito_Carritos] FOREIGN KEY ([IdCarrito]) REFERENCES [dbo].[Carritos] ([Id]),
    CONSTRAINT [FK_DetalleCarrito_Productos] FOREIGN KEY ([CodigoBarraProducto]) REFERENCES [dbo].[Productos] ([CodigoBarra]),
    CONSTRAINT [UQ_DetalleCarrito_Producto] UNIQUE NONCLUSTERED ([IdCarrito] ASC, [CodigoBarraProducto] ASC)
);

