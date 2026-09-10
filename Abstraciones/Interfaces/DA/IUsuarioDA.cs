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
        Task<IEnumerable<UsuarioResponse>> Obtener();
        Task<UsuarioResponse?>Obtener(Guid id);
        Task<Guid> Agregar(UsuarioResponse usuario);
        Task<Guid> Editar(Guid Id ,UsuarioResponse usuario);
        Task<Guid> Eliminar(Guid Id);
    }
}
