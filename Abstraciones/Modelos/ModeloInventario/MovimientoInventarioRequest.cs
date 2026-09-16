namespace Abstraciones.Modelos.ModeloInventario
{
    public class MovimientoInventarioRequest
    {
        public Guid IdProducto { get; set; }

        public int Cantidad { get; set; }
    }
}
