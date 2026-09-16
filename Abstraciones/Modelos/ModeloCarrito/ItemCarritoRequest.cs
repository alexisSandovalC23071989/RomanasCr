using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Abstraciones.Modelos.ModeloCarrito
{
    public class ItemCarritoRequest
    {
        public Guid IdProducto { get; set; }

        public int Cantidad { get; set; }
    }
}
