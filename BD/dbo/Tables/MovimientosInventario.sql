CREATE TABLE [dbo].[MovimientosInventario] (
    [Id]                  UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [CodigoBarraProducto] VARCHAR (50)     NOT NULL,
    [TipoMovimiento]      VARCHAR (20)     NOT NULL,
    [Cantidad]            INT              NOT NULL,
    [Fecha]               DATETIME2 (7)    DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_MovimientosInventario] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [CK_MovimientosInventario_Cantidad] CHECK ([Cantidad]>(0)),
    CONSTRAINT [CK_MovimientosInventario_Tipo] CHECK ([TipoMovimiento]='AjusteNegativo' OR [TipoMovimiento]='AjustePositivo' OR [TipoMovimiento]='Salida' OR [TipoMovimiento]='Entrada'),
    CONSTRAINT [FK_MovimientosInventario_Productos] FOREIGN KEY ([CodigoBarraProducto]) REFERENCES [dbo].[Productos] ([CodigoBarra])
);

