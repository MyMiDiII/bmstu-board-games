using Microsoft.EntityFrameworkCore;

namespace BoardGames.Data
{
    public static class BoardGamesContext
    {
        public static List<BoardGame> BoardGames = new List<BoardGame>()
        {
            new BoardGame()
            {
                ID = 1,
                Title = "Мрачная Гавань",
                Producer = "Hobby World",
                Year = 2018
            },
            new BoardGame()
            {
                ID = 2,
                Title = "Пандемия: Наследие. Первый сезон",
                Producer = "Стиль Жизни",
                Year = 2017
            },
            new BoardGame()
            {
                ID = 3,
                Title = "Dungeons And Dragons",
                Producer = "Not Remeber",
                Year = 1900
            }
        };
        public static List<FavoriteBoardGame> FavoriteBoardGames = new List<FavoriteBoardGame>();
    }
}
