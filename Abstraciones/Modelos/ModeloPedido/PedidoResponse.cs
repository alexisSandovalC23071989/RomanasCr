namespace Abstraciones.Modelos.ModeloPedido
{
    public class PedidoResponse : PedidoBase
    {
        public Guid Id { get; set; }

        public List<DetallePedidoResponse> Detalles { get; set; } = new();

    }
}
