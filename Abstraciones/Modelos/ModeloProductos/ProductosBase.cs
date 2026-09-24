namespace Abstraciones.Modelos.ModeloProductos
{
    public class ProductosBase
    {
        public string CodigoBarra { get; set; } = string.Empty;
        public string? Descripcion { get; set;} 
        public string? Marca { get; set; }
        public string? Modelo { get; set; }
        public decimal  Precio { get; set; } = 0;
        public decimal PorcentajeIVA { get; set; }
        public string? Imagen { get; set; }
    }
}
