using Abstraciones.Modelos.ModeloAutenticacion;

namespace Abstraciones.Interfaces.Flujo
{
    public interface  IUsuarioFlujo
    {
        Task<IEnumerable<UsuarioResponse>> Obtener();
        Task<UsuarioResponse?> Obtener(Guid id);
        Task<Guid> Agregar(UsuarioResponse usuario);
        Task<Guid> Editar( Guid Id, UsuarioResponse usuario);
        Task<Guid>Eliminar(Guid Id);
    }
}
