CREATE TABLE [dbo].[Pedidos] (
    [Id]        UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [IdUsuario] UNIQUEIDENTIFIER NOT NULL,
    [Fecha]     DATETIME2 (7)    DEFAULT (getdate()) NOT NULL,
    [Total]     DECIMAL (18, 2)  NOT NULL,
    [Estado]    VARCHAR (30)     DEFAULT ('Pendiente') NOT NULL,
    CONSTRAINT [PK_Pedidos] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [CK_Pedidos_Total] CHECK ([Total]>=(0)),
    CONSTRAINT [FK_Pedidos_Usuarios] FOREIGN KEY ([IdUsuario]) REFERENCES [dbo].[Usuarios] ([Id])
);

