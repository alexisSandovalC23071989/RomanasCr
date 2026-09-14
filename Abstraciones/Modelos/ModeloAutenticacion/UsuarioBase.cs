namespace Abstraciones.Modelos.ModeloAutenticacion
{
    public class UsuarioBase
    {
        
        public string Nombre { get; set; }  = string.Empty;
        public string Telefono { get; set; } = string.Empty;
        public string Correo { get; set; }= string.Empty;

        public string Contrasena { get; set; }= string.Empty;


    }
}
