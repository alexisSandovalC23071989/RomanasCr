namespace Abstraciones.Modelos.ModeloPedido
{
    public class DetallePedidoResponse
    {
        public  string CodigoBarraProducto { get; set; } = string.Empty;

        public string? DescripcionProducto { get; set; }

        public int Cantidad { get; set; }

        public decimal PrecioUnitario { get; set; }

        public decimal Descuento { get; set; }

        public decimal Subtotal { get; set; }
    }
}
