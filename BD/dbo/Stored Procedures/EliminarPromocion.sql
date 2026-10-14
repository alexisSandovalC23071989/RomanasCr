
CREATE   PROCEDURE EliminarPromocion
    @Id UNIQUEIDENTIFIER
AS
BEGIN

    SET NOCOUNT ON;

    -- 1. Validar que la promocion exista
    IF NOT EXISTS
    (
        SELECT 1
        FROM Promociones
        WHERE Id = @Id
    )
    BEGIN
        THROW 50021, 'La promocion no existe.', 1;
    END;

    -- 2. Eliminar la promocion
    DELETE FROM Promociones
    WHERE Id = @Id;

END;