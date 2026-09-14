namespace Abstraciones.Modelos.ModeloProductos
{
    public class ProductosBase
    {
        
        public string? Descripcion { get; set;} 

        public string? Marca { get; set; }
        public string? Modelo { get; set; }
        public decimal  Precio { get; set; } = 0;
        public decimal Descuento { get; set; } = 0;
        public string? Imagen { get; set; }
    }
}
