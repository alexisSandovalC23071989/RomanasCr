namespace Abstraciones.Modelos.ModeloInventario
{
    public class InventarioBase
    {
        public Guid IdProducto { get; set; }

        public int CantidadDisponible { get; set; }
    }
}
