from bs4 import BeautifulSoup
import requests

GAMES_SITE = "https://hobbygames.ru/nastolnie?results_per_page=60"
SEP = "&"
PAGE_TMP = "page=%d"

def getGameName(soup):
    nameBox = soup.find('div', class_='product-info__main')
    name = nameBox.find('h1').get_text(strip=True)

    return name


def getGameProducer(soup):
    producerBox = soup.find('a', class_='manufacturers__value main-color')
    producer = producerBox.get_text(strip=True)

    return producer


def getGameYear(soup):
    yearBox = soup.find('div', class_='manufacturers__value main-color')
    year = yearBox.get_text(strip=True)

    return int(year)


def loadGameInfo(soup):
    name = getGameName(soup)
    producer = getGameProducer(soup)
    year = getGameYear(soup)

    print(name)
    print(producer)
    print(year)


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

        gamesRef = soup.find_all('a', class_='name', href=True)

        for gameRef in gamesRef:
            print(gamesNum, ".")
            ref = gameRef['href']

            pageCode = requests.get(ref).text
            soup = BeautifulSoup(pageCode, 'lxml')

            loadGameInfo(soup)

            gamesNum += 1


if __name__ == "__main__":
    loadGamesInfo(GAMES_SITE)
