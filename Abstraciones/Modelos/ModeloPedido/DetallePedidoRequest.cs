namespace Abstraciones.Modelos.ModeloPedido
{
    public  class DetallePedidoRequest
    {
        public Guid IdProducto { get; set; }

        public int Cantidad { get; set; }

        public decimal PrecioUnitario { get; set; }

        public decimal Descuento { get; set; }
    }
}
