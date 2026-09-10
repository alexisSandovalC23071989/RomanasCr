using Abstraciones.Interfaces.DA;
using Abstraciones.Modelos.ModeloAutenticacion;

namespace DA
{
    public class UsuarioDA : IUsuarioDA
    {
        public Task<Guid> Agregar(UsuarioResponse usuario)
        {
            throw new NotImplementedException();
        }

        public Task<Guid> Editar(Guid Id, UsuarioResponse usuario)
        {
            throw new NotImplementedException();
        }

        public Task<Guid> Eliminar(Guid Id)
        {
            throw new NotImplementedException();
        }

        public Task<IEnumerable<UsuarioResponse>> Obtener()
        {
            throw new NotImplementedException();
        }

        public Task<UsuarioResponse?> Obtener(Guid id)
        {
            throw new NotImplementedException();
        }
    }
}
