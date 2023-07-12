#!/usr/bin/env python
# coding: utf-8

# In[132]:


from bs4 import BeautifulSoup
import requests
import time
import datetime

import smtplib


# In[133]:


URL='https://www.flipkart.com/motorola-edge-40-coronet-blue-256-gb/p/itm32e082b2d4213?pid=MOBGKHNBYGH5KHJ9&param=11111&otracker=clp_bannerads_1_17.bannerAdCard.BANNERADS_A_mobile-phones-store_CKJJDZYB503K'
headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36",
        "Accept":"text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8", 
        "Accept-Encoding": "gzip, deflate, br", 
        "Accept-Language": "en-US,en",
        "DNT":"1","Connection":"close", "Upgrade-Insecure-Requests":"1"}

page = requests.get(URL, headers=headers)

soup1 = BeautifulSoup(page.content, "html.parser")


#soup2 = BeautifulSoup(soup1.prettify(), "html.parser")

title = soup1.find("span",attrs={"class":"B_NuCI"}).text

print(title)
#title







# In[134]:


today=datetime.date.today()

print(today)


# In[135]:


price = soup1.find("div", attrs={"class":"_30jeq3 _16Jk6d"}).text

price=price.strip()[1:]
print(price)

type(price)


# In[98]:


import csv

header=['title','price','today']

data=[title,price,today]

#with open("flipkart_web_scraper_dataset.csv",'w',newline='',encoding='UTF8')as f:
    
    #writer=csv.writer(f)
    #writer.writerow(header)
    #writer.writerow(data)








# In[136]:


import pandas as pd

df=pd.read_csv(r"C:\Users\geeth\flipkart_web_scraper_dataset.csv")
df


# In[104]:


with open("flipkart_web_scraper_dataset.csv",'a+',newline='',encoding='UTF8')as f:
    
    writer=csv.writer(f)
    
    writer.writerow(data)


# In[161]:


import smtplib


def send_mail():
    
    server= smtplib.SMTP('smtp.gmail.com',587)
    
    server.starttls()
    
    server.login('prasannavenkatesh2105@gmail.com','pmehlyszfjgqwhlu')
     
    subject="  NIJI AND DAISY CHECK OUT THIS SUPER DEAL ORDER NOW!!!!  "
    
    body= "The price have droped for the phone , order now ASAP! LIMITED DEAL !!!!!!!!!"
    
    msg= f"subject:{subject}\n\n{body}"
    
    server.sendmail('prasannavenkatesh2105@gmail.com','mathankie2001@gmail.com',msg)
    
    print("mail sent")
    
    


# In[154]:


def check_price():
    
    URL='https://www.flipkart.com/motorola-edge-40-coronet-blue-256-gb/p/itm32e082b2d4213?pid=MOBGKHNBYGH5KHJ9&param=11111&otracker=clp_bannerads_1_17.bannerAdCard.BANNERADS_A_mobile-phones-store_CKJJDZYB503K'
    headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36",
        "Accept":"text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8", 
        "Accept-Encoding": "gzip, deflate, br", 
        "Accept-Language": "en-US,en",
        "DNT":"1","Connection":"close", "Upgrade-Insecure-Requests":"1"}

    page = requests.get(URL, headers=headers)

    soup1 = BeautifulSoup(page.content, "html.parser")


    #soup2 = BeautifulSoup(soup1.prettify(), "html.parser")

    title = soup1.find("span",attrs={"class":"B_NuCI"}).text
    
    price = soup1.find("div", attrs={"class":"_30jeq3 _16Jk6d"}).text
    
    price=price.strip()[1:]
    
    today=datetime.date.today()
    
    
    import csv

    header=['title','price','today']

    data=[title,price,today]
    
    with open("flipkart_web_scraper_dataset.csv",'a+',newline='',encoding='UTF8')as f:
    
        writer=csv.writer(f)

        writer.writerow(data)

       


# In[121]:


while(True):
    check_price()
    time.sleep(5)


# In[162]:


import pandas as pd

df=pd.read_csv(r"C:\Users\geeth\flipkart_web_scraper_dataset.csv")
df
if price=="29,999":
               send_mail()
    


# In[145]:



    
    
    
    
    
    
    
    
    
    
    
    
    


# In[ ]:




