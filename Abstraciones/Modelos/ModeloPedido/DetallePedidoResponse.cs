namespace Abstraciones.Modelos.ModeloPedido
{
    public class DetallePedidoResponse
    {
        public Guid Id { get; set; }

        public Guid IdProducto { get; set; }

        public string? DescripcionProducto { get; set; }

        public int Cantidad { get; set; }

        public decimal PrecioUnitario { get; set; }

        public decimal Descuento { get; set; }

        public decimal Subtotal { get; set; }
    }
}
