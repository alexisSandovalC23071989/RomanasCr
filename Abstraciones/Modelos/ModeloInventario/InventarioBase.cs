namespace Abstraciones.Modelos.ModeloInventario
{
    public class InventarioBase
    {

        public string CodigoBarraProducto { get; set; } = string.Empty;
        public int CantidadDisponible { get; set; }
    }
}
