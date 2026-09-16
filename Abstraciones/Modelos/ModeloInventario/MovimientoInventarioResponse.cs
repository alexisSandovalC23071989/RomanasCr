

namespace Abstraciones.Modelos.ModeloInventario
{
    public class MovimientoInventarioResponse
    {
        public Guid Id { get; set; }

        public Guid IdProducto { get; set; }

        public string? DescripcionProducto { get; set; }

        public string? TipoMovimiento { get; set; }

        public int Cantidad { get; set; }

        public DateTime Fecha { get; set; }
    }
}
