namespace Abstraciones.Modelos.ModeloPedido
{
    public  class DetallePedidoRequest
    {
        public string CodigoBarraProducto { get; set; } = string.Empty;

        public int Cantidad { get; set; }

       
    }
}
