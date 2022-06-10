using BoardGames.Data;

namespace BoardGames.Services
{
    public class BoardGameService : IBoardGameService
    {
        private IAuthorizeService _authorizeService;

        public BoardGameService(IAuthorizeService authorizeService)
        {
            _authorizeService = authorizeService;
        }

        public List<BoardGame> GetBoardGames()
        {
            return BoardGamesContext.BoardGames;
        }

        public List<BoardGame> GetFavoriteBoardGames()
        {
            var userID = _authorizeService.GetCurrentUserID(); 
            var userBoardGameIDs = BoardGamesContext.FavoriteBoardGames
                .Where(x => x.UserID == userID)
                .Select(x => x.BoardGameID)
                .ToList();
            return BoardGamesContext.BoardGames
                .Where(x => userBoardGameIDs.Contains(x.ID)).ToList(); 
        }

        public void AddBoardGameToFavorite(BoardGame boardGame)
        {
            var userID = _authorizeService.GetCurrentUserID(); 
            if (!BoardGamesContext.FavoriteBoardGames.Any(x => x.UserID == userID && x.BoardGameID == boardGame.ID))
            {
                BoardGamesContext.FavoriteBoardGames.Add(new FavoriteBoardGame()
                {
                    ID = 0,
                    BoardGameID = boardGame.ID,
                    UserID = userID
                });
            }
        }

        public void RemoveBoardGameFromFavorite(BoardGame boardGame)
        {
            var userID = _authorizeService.GetCurrentUserID(); 
            BoardGamesContext.FavoriteBoardGames
                .RemoveAll(x => x.UserID == userID && x.BoardGameID == boardGame.ID);
        }
    }

    public interface IBoardGameService
    {
        List<BoardGame> GetBoardGames();
        List<BoardGame> GetFavoriteBoardGames();
        void AddBoardGameToFavorite(BoardGame boardGame);
        void RemoveBoardGameFromFavorite(BoardGame boardGame);
    }
}
