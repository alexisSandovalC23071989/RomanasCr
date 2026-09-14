using Abstraciones.Modelos.ModeloAutenticacion;

namespace Abstraciones.Interfaces.Flujo
{
    public interface  IUsuarioFlujo
    {
        Task<IEnumerable<UsuarioBase>> Obtener();
        Task<UsuarioBase?> Obtener(Guid id);
        Task<Guid> Agregar(UsuarioBase usuario);
        Task<Guid> Editar( Guid Id, UsuarioBase usuario);
        Task<Guid>Eliminar(Guid Id);
    }
}
