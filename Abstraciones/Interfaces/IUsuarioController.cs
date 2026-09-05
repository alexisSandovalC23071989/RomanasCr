using Abstraciones.Modelos.ModeloAutenticacion;
using Microsoft.AspNetCore.Mvc;

namespace Abstraciones.Interfaces
{
    public  interface IUsuarioController
    {
        Task<IActionResult> Obtener();
        Task<IActionResult> Obtener(Guid id);

        Task<IActionResult> Agregar(UsuarioResponse usuario);
        Task<IActionResult>Editar(Guid id, UsuarioResponse usuario);

        Task<IActionResult>Eliminar(Guid id);

    }
}
