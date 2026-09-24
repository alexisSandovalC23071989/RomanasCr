CREATE TABLE [dbo].[Productos] (
    [CodigoBarra]   VARCHAR (50)    NOT NULL,
    [Descripcion]   VARCHAR (200)   NOT NULL,
    [Marca]         VARCHAR (100)   NOT NULL,
    [Modelo]        VARCHAR (100)   NOT NULL,
    [Precio]        DECIMAL (18, 2) NOT NULL,
    [PorcentajeIVA] DECIMAL (5, 2)  NOT NULL,
    [Imagen]        VARCHAR (500)   NULL,
    CONSTRAINT [PK_Productos] PRIMARY KEY CLUSTERED ([CodigoBarra] ASC),
    CONSTRAINT [CK_Productos_PorcentajeIVA] CHECK ([PorcentajeIVA]>=(0) AND [PorcentajeIVA]<=(100)),
    CONSTRAINT [CK_Productos_Precio] CHECK ([Precio]>=(0))
);

