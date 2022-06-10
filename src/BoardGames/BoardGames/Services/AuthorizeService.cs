namespace BoardGames.Services
{
    public class AuthorizeService : IAuthorizeService
    {
        public long GetCurrentUserID() => 1; 
    }

    public interface IAuthorizeService
    {
        long GetCurrentUserID();
    }
}
