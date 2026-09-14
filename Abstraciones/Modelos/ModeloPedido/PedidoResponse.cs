namespace Abstraciones.Modelos.ModeloPedido
{
    internal class PedidoResponse
    {
        public Guid Id { get; set; }

        public List<DetallePedidoResponse> Detalles { get; set; }
    }
}
