
namespace DA
{
    public  class DBContext
    {
        private readonly IConfiguration _configuration; 

        public DBContext(IConfiguration configuration)
        {
            _configuration = configuration;
        }
    }
}
