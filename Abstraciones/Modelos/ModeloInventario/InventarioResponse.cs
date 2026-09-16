namespace Abstraciones.Modelos.ModeloInventario
{
    public class InventarioResponse : InventarioBase
    {
        public Guid Id { get; set; }

        public string? DescripcionProducto { get; set; }
    }
}
