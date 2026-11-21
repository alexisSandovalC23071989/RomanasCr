# RomanasCR

Backend en desarrollo para gestionar productos e inventario por código de barras. El proyecto combina una API en C# con ASP.NET Core 8 y una base de datos en SQL Server. La lógica más avanzada está en los procedimientos almacenados de inventario.

## Cómo se registra una salida de inventario

El procedimiento [RegistrarMovimientoInventario](BD/dbo/Stored%20Procedures/RegistrarMovimientoInventario.sql) recibe el código de barras del producto, el tipo de movimiento y la cantidad. Si hay 3 unidades disponibles y se solicita una salida de 5, el procedimiento devuelve un error por inventario insuficiente. Si se solicita una salida de 2, descuenta las unidades y registra el movimiento en el historial dentro de la misma transacción.

## Estructura y avance

| Proyecto | Contenido |
|---|---|
| [BD](BD) | Tablas y procedimientos de SQL Server para productos, usuarios, inventario, promociones y proveedores. También incluye tablas de pedidos y carrito. |
| [Abstraciones](Abstraciones) | Modelos de solicitudes y respuestas, e interfaces para las capas de la aplicación. |
| [API](API) | Proyecto ASP.NET Core con controladores y Swagger configurado para desarrollo. El controlador de usuarios está pendiente de implementación. |
| [Flujo](Flujo) | Proyecto destinado a coordinar las operaciones de negocio. |
| [DA](DA) | Capa de acceso a datos. Los métodos de usuarios están definidos y pendientes de implementación. |

Para explorar el código, abrí [RomanasCR.sln](RomanasCR.sln). Podés empezar por la [consulta de un producto](BD/dbo/Stored%20Procedures/ObtenerProducto.sql) y seguir con el procedimiento de inventario para ver cómo se validan las salidas y se conserva el historial.
