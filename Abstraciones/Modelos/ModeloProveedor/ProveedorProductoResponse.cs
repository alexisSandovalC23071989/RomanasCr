namespace Abstraciones.Modelos.ModeloProveedor
{
    public class ProveedorProductoResponse
    {
        public Guid Id { get; set; }

        public Guid IdProveedor { get; set; }
        public string? NombreProveedor { get; set; }

        public Guid IdProducto { get; set; }
        public string? DescripcionProducto { get; set; }
    }
}
