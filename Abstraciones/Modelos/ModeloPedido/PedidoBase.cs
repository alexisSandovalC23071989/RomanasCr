namespace Abstraciones.Modelos.ModeloPedido
{
    public class PedidoBase
    {
        public Guid IdUsuario { get; set; }

        public DateTime Fecha { get; set; }

        public decimal Total { get; set; }

        public string? Estado { get; set; }

    }
}
