

namespace Abstraciones.Modelos.ModeloInventario
{
    public class MovimientoInventarioResponse
    {
        public Guid Id { get; set; }

        public string CodigoBarraProducto { get; set; } = string.Empty;

        public string? DescripcionProducto { get; set; }

        public string? TipoMovimiento { get; set; }

        public int Cantidad { get; set; }

        public DateTime Fecha { get; set; }
    }
}
