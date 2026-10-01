namespace Abstraciones.Modelos.ModeloProveedor
{
    public class ProveedorProductoResponse
    {
        public Guid Id { get; set; }

        public Guid IdProveedor { get; set; }
        public string? NombreProveedor { get; set; }

        public string CodigoBarraProducto { get; set; } = string.Empty;
        public string? DescripcionProducto { get; set; }
    }
}
