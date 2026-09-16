namespace Abstraciones.Modelos.ModeloPromociones
{
    public class PromocionResponse :PromocionBase
    {
        public Guid Id { get; set; }

        public string? DescripcionProducto { get; set; }

        public decimal PrecioOriginal { get; set; }

        public decimal PrecioConDescuento { get; set; }
    }
}
