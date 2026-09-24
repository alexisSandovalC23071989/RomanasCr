CREATE TABLE [dbo].[Inventario] (
    [Id]                  UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [CodigoBarraProducto] VARCHAR (50)     NOT NULL,
    [CantidadDisponible]  INT              DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Inventario] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [CK_Inventario_CantidadDisponible] CHECK ([CantidadDisponible]>=(0)),
    CONSTRAINT [FK_Inventario_Productos] FOREIGN KEY ([CodigoBarraProducto]) REFERENCES [dbo].[Productos] ([CodigoBarra]),
    CONSTRAINT [UQ_Inventario_CodigoBarraProducto] UNIQUE NONCLUSTERED ([CodigoBarraProducto] ASC)
);

