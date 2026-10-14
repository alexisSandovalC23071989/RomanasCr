CREATE PROCEDURE EliminarProducto
    @CodigoBarra VARCHAR(50)
AS
BEGIN

    IF NOT EXISTS
    (
        SELECT 1
        FROM Productos
        WHERE CodigoBarra = @CodigoBarra
    )
    BEGIN
        THROW 50007, 'El producto no existe.', 1;
    END;

    DELETE FROM Productos
    WHERE CodigoBarra = @CodigoBarra;

END;