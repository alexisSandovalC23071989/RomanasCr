namespace Abstraciones.Modelos.ModeloPedido
{
    public class PedidoRequest
    {
        public Guid IdUsuario { get; set; }
        public List<DetallePedidoRequest> Detalles { get; set; }
    }
}
