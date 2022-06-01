from bs4 import BeautifulSoup
import requests

GAMES_SITE = "https://hobbygames.ru/nastolnie?results_per_page=60"
SEP = "&"
PAGE_TMP = "page=%d"

def loadGamesInfo(siteURL):
    pageCode = requests.get(siteURL).text
    soup = BeautifulSoup(pageCode, 'lxml')

    lastPageRef = soup.find('a', class_='last', href=True)['href']
    lastPage = int(lastPageRef.partition('?page=')[-1].partition('&')[0])

    gamesNum = 1
    for i in range(1, lastPage + 1):
        curPageURL = (siteURL + SEP + PAGE_TMP) % i

        pageCode = requests.get(curPageURL).text
        soup = BeautifulSoup(pageCode, 'lxml')

        products = soup.find_all('a', class_='name')

        for product in products:
            print(gamesNum, ". ", product.get_text(strip=True), sep="")
            gamesNum += 1


if __name__ == "__main__":
    loadGamesInfo(GAMES_SITE)
