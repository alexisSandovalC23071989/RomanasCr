namespace Abstraciones.Modelos.ModeloProveedor
{
    public class ProveedorProductoRequest
    {
        public Guid IdProveedor { get; set; }
        public string CodigoBarraProducto { get; set; } = string.Empty;
    }
}
