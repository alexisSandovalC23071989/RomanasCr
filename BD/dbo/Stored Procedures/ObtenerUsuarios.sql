    CREATE PROCEDURE ObtenerUsuarios
      AS
    BEGIN

    SELECT
        Id,
        Nombre,
        Telefono,
        Correo,
        Contrasena
    FROM Usuarios;

    END;