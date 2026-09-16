namespace Abstraciones.Modelos.ModeloPromociones
{
    public class PromocionBase
    {
        public Guid IdProducto { get; set; }

        public decimal PorcentajeDescuento { get; set; }

        public DateTime FechaInicio { get; set; }

        public DateTime FechaFin { get; set; }

        
    }
}
