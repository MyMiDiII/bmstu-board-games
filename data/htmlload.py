from bs4 import BeautifulSoup
import requests

site = "https://hobbygames.ru/nastolnie?results_per_page=60&parameter_type=0"
data = requests.get(site)
code = data.text

soup = BeautifulSoup(code, 'lxml')
print(soup.prettify())

print()
print('NEW')
product = soup.find('a', class_='name').get_text(strip=True)
print(product)
