namespace Abstraciones.Modelos.ModeloInventario
{
    public class MovimientoInventarioRequest
    {
        public string CodigoBarraProducto { get; set; } = string.Empty;

        public TipoMovimiento TipoMovimiento { get; set; }

        public int Cantidad { get; set; }
    }
}
