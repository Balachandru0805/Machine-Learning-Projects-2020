import requests
from bs4 import BeautifulSoup

url = 'http://www.imdb.com/title/tt0944947/episodes'
episodes = []
ratings = []

# Go over seasons 1 to 8
for season in range(1, 9):
    r = requests.get(url, params={'season': season})
    soup = BeautifulSoup(r.text, 'html.parser')
    listing = soup.find('div', class_='eplist')
    for epnr, div in enumerate(listing.find_all('div', recursive=False)):
        episode = "{}.{}".format(season, epnr + 1)
        rating_el = div.find(class_='ipl-rating-star__rating')
        rating = float(rating_el.get_text(strip=True))
        #print('Episode:', episode, '-- rating:', rating)
        episodes.append(episode)
        ratings.append(rating)

import matplotlib.pyplot as plt
import pandas as pd
df = pd.DataFrame(list(zip(episodes, ratings)),columns=['Episodes','Ratings'])
df['Session'] = df['Episodes'].apply( lambda x:x.split('.')[0])
df2 = df.groupby(df['Session'])['Ratings'].sum()
df2 = df2.reset_index()
print(df.head())
print("$$")
print(df2.head())
plt.figure()
plt.plot(df2['Session'], df2['Ratings'])
plt.xlabel('Session')
plt.ylabel('Ratings')
plt.show()
