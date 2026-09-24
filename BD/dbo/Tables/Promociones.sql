CREATE TABLE [dbo].[Promociones] (
    [Id]                  UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [CodigoBarraProducto] VARCHAR (50)     NOT NULL,
    [PorcentajeDescuento] DECIMAL (5, 2)   NOT NULL,
    [FechaInicio]         DATETIME2 (7)    NOT NULL,
    [FechaFin]            DATETIME2 (7)    NOT NULL,
    CONSTRAINT [PK_Promociones] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [CK_Promociones_Fechas] CHECK ([FechaFin]>=[FechaInicio]),
    CONSTRAINT [CK_Promociones_PorcentajeDescuento] CHECK ([PorcentajeDescuento]>(0) AND [PorcentajeDescuento]<=(100)),
    CONSTRAINT [FK_Promociones_Productos] FOREIGN KEY ([CodigoBarraProducto]) REFERENCES [dbo].[Productos] ([CodigoBarra])
);

