#=======================================================
# ╔═╗╔╗╔╗     ╔══╗╔╗ ╔╗
# ║╔╝╚╬╬╝╔═══╗║╔╗║║║ ║║
# ║║ ╔╬╬╗╚═══╝║╚╝║║╚═╝║
# ╚╝ ╚╝╚╝     ║╔═╝╚═╗╔╝
#             ║║  ╔═╝║ 
#             ╚╝  ╚══╝ 
#
#  Author: rx-py
#  Github: github.com/rx-py
#
#=======================================================

import requests
from bs4 import BeautifulSoup
import notify2
import time
import webbrowser

def get_latest_news(url):
    response = requests.get(url)
    soup = BeautifulSoup(response.text, "html.parser")
    news_data = []

    # Extract news titles and links
    news_items = soup.find_all("h2", class_="home-title")
    for item in news_items:
        news_title = item.text.strip()
        # Search for the parent element encapsulating the title and link
        parent_element = item.find_parent("article")
        if parent_element:
            news_link = parent_element.find("a")["href"]
        else:
            news_link = "Link Unavailable"
        news_data.append({"title": news_title, "link": news_link})

    return news_data

def display_news(news):
    notify2.init("News Notification")
    for news_item in news[:5]:
        notification = notify2.Notification("The Hacker News", f"{news_item['title']}")
        notification.show()
        time.sleep(5)  # Wait for 5 seconds before showing the next news item


# URL of the website
news_url = "https://thehackernews.com/"

# Fetch latest news
latest_news = get_latest_news(news_url)

# Display one news item at a time
display_news(latest_news)

# Prompt user for input before opening the URL
user_input = input(f"Do you want to open {news_url}? (y/n): ")
if user_input.lower() =="y":
    webbrowser.open(news_url)
else:
    print("Skipping opening the link.")
