using BoardGames.Data;

namespace BoardGames.Services
{
    public class BoardGameService : IBoardGameService
    {
        public BoardGameService()
        {

        }

        public List<BoardGame> GetBoardGames()
        {
            return new List<BoardGame>()
            {
                new BoardGame()
                {
                    Title = "Мрачная Гавань",
                    Producer = "Hobby World",
                    Year = 2018
                },
                new BoardGame()
                {
                    Title = "Пандемия: Наследие. Первый сезон",
                    Producer = "Стиль Жизни",
                    Year = 2017
                }
            };
        }
    }

    public interface IBoardGameService
    {
        List<BoardGame> GetBoardGames();
    }
}
