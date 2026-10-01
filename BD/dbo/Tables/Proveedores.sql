CREATE TABLE [dbo].[Proveedores] (
    [Id]        UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [Nombre]    VARCHAR (150)    NOT NULL,
    [Telefono]  VARCHAR (20)     NULL,
    [Correo]    VARCHAR (150)    NULL,
    [Direccion] VARCHAR (300)    NULL,
    CONSTRAINT [PK_Proveedores] PRIMARY KEY CLUSTERED ([Id] ASC)
);

