namespace Abstraciones.Modelos.ModeloPedido
{
    public class PedidoResponse : PedidoBase
    {
        public Guid Id { get; set; }

        public Guid IdUsuario { get; set; }

        public DateTime Fecha { get; set; }

        public decimal Total { get; set; }

        public string? Estado { get; set; }

        public List<DetallePedidoResponse> Detalles { get; set; }
    }
}
