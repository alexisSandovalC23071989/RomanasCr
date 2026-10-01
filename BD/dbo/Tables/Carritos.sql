CREATE TABLE [dbo].[Carritos] (
    [Id]        UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [IdUsuario] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_Carritos] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Carritos_Usuarios] FOREIGN KEY ([IdUsuario]) REFERENCES [dbo].[Usuarios] ([Id]),
    CONSTRAINT [UQ_Carritos_Usuario] UNIQUE NONCLUSTERED ([IdUsuario] ASC)
);

