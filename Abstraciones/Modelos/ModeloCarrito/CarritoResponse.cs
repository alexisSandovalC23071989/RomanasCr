using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Abstraciones.Modelos.ModeloCarrito
{
    public class CarritoResponse
    {
        public Guid Id { get; set; }

        public Guid IdUsuario { get; set; }

        public List<ItemCarritoResponse> Items { get; set; }

        public decimal Total { get; set; }
    }
}
