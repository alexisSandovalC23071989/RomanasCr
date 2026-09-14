using Abstraciones.Modelos.ModeloAutenticacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Abstraciones.Interfaces.DA
{
    public interface  IUsuarioDA
    {
        Task<IEnumerable<UsuarioBase>> Obtener();
        Task<UsuarioBase?>Obtener(Guid id);
        Task<Guid> Agregar(UsuarioBase usuario);
        Task<Guid> Editar(Guid Id ,UsuarioBase usuario);
        Task<Guid> Eliminar(Guid Id);
    }
}
