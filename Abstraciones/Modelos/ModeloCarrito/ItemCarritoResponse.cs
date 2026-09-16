using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Abstraciones.Modelos.ModeloCarrito
{
    public class ItemCarritoResponse
    {
        public Guid IdProducto { get; set; }

        public string? DescripcionProducto { get; set; }

        public int Cantidad { get; set; }

        public decimal Precio { get; set; }

        public decimal Descuento { get; set; }

        public decimal Subtotal { get; set; }
    }
}
