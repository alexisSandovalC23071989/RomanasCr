namespace Abstraciones.Modelos.ModeloPromociones
{
    public class PromocionBase
    {
        public string CodigoBarraProducto { get; set; } = string.Empty;

        public decimal PorcentajeDescuento { get; set; }

        public DateTime FechaInicio { get; set; }

        public DateTime FechaFin { get; set; }

        
    }
}
