using Abstraciones.Modelos.ModeloAutenticacion;
using Microsoft.AspNetCore.Mvc;

namespace Abstraciones.Interfaces.API
{
    public  interface IUsuarioController
    {
        Task<IActionResult> Obtener();
        Task<IActionResult> Obtener(Guid id);
        Task<IActionResult> Agregar(UsuarioBase usuario);
        Task<IActionResult>Editar(Guid id, UsuarioBase usuario);
        Task<IActionResult>Eliminar(Guid id);
      

    }
}
