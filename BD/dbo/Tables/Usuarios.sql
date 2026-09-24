CREATE TABLE [dbo].[Usuarios] (
    [Id]         UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [Nombre]     VARCHAR (100)    NOT NULL,
    [Telefono]   VARCHAR (20)     NOT NULL,
    [Correo]     VARCHAR (150)    NOT NULL,
    [Contrasena] VARCHAR (255)    NOT NULL,
    CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UQ_Usuarios_Correo] UNIQUE NONCLUSTERED ([Correo] ASC)
);

