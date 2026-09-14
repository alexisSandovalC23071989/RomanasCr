namespace Abstraciones.Modelos.ModeloPedido
{
    public class PedidoRequest : PedidoBase
    {
        public List<DetallePedidoRequest> Detalles { get; set; }
    }
}
