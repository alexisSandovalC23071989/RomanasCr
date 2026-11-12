using Abstraciones.Modelos.ModeloAutenticacion;


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
