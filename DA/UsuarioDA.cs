using Abstraciones.Interfaces.DA;
using Abstraciones.Modelos.ModeloAutenticacion;

namespace DA
{
    public class UsuarioDA : IUsuarioDA

    {

        public Task<Guid> Agregar(UsuarioBase usuario)
        {
            throw new NotImplementedException();
        }

        public Task<Guid> Editar(Guid Id, UsuarioBase usuario)
        {
            throw new NotImplementedException();
        }

        public Task<Guid> Eliminar(Guid Id)
        {
            throw new NotImplementedException();
        }

        public Task<IEnumerable<UsuarioBase>> Obtener()
        {
            throw new NotImplementedException();
        }

        public Task<UsuarioBase?> Obtener(Guid id)
        {
            throw new NotImplementedException();
        }
    }
}
