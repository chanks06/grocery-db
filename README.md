# GROCERY EXPENSE DATA COLLECTION & ANALYSIS 

The purpose of this project is to collect data and uncover trends regarding my home grocery shopping. 

The inspiration for this project comes from my years as a professional cook. In a restaurant setting, food and labor costs are essential to assessing the health of the business. I am applying this same outlook to my personal consumption habits. The goal is to use this database to extract insights on how to shop in a most cost-effective and nutrient-rich manner. 

I have a local [mySQL database](./sql/grocery-db-erd.png) into which I enter store, trip, and item information. I extract tables from this database using the `data_loader.py` script. I then analyze and visualize the data in a notebook. 


* What is the time frame of this data collected ? 
    September 2023 - February 2024 


* What is the average price per trip at each store ?
    $41.00 

* What is the most purchased item? 
    Bananas, apples, cucumber, dates 

* Could I use an LLM to help me categorize every item (categories: produce, dairy, meat, sundries, etc ?)
    TDB

* Could I create a grocery template list from this data, i.e. the 20 most frequently purchased items? 
    YES

* What do I buy, and from where do I buy it ? 
        ['BANANAS',
        'APPLE GOLDEN DELICIOUS',
        'EGGS ORG 1 DZ',
        'CUCUMBER',
        'DATES MEDJOOL',
        'LEMON LARGE',
        'CHOBANI FLIP',
        'BREAD DAVES KILLER',
        'ZUCCHINI',
        'KALE ORG']
