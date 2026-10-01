CREATE TABLE [dbo].[DetallePedido] (
    [Id]                  UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [IdPedido]            UNIQUEIDENTIFIER NOT NULL,
    [CodigoBarraProducto] VARCHAR (50)     NOT NULL,
    [Cantidad]            INT              NOT NULL,
    [PrecioUnitario]      DECIMAL (18, 2)  NOT NULL,
    [Descuento]           DECIMAL (18, 2)  DEFAULT ((0)) NOT NULL,
    [Subtotal]            DECIMAL (18, 2)  NOT NULL,
    CONSTRAINT [PK_DetallePedido] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [CK_DetallePedido_Cantidad] CHECK ([Cantidad]>(0)),
    CONSTRAINT [CK_DetallePedido_Descuento] CHECK ([Descuento]>=(0)),
    CONSTRAINT [CK_DetallePedido_Precio] CHECK ([PrecioUnitario]>=(0)),
    CONSTRAINT [CK_DetallePedido_Subtotal] CHECK ([Subtotal]>=(0)),
    CONSTRAINT [FK_DetallePedido_Pedidos] FOREIGN KEY ([IdPedido]) REFERENCES [dbo].[Pedidos] ([Id]),
    CONSTRAINT [FK_DetallePedido_Productos] FOREIGN KEY ([CodigoBarraProducto]) REFERENCES [dbo].[Productos] ([CodigoBarra])
);

