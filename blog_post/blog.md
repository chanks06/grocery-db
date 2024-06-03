# I COME WITH RECEIPTS 
Migrating my Grocery Expense Database to Azure 
Wednesday May 22, 2024 

## Introduction 

This articles guides you through my journey managing a database of grocery expenses, and then migrating it from my computer to the cloud. 

In September of 2023, I began logging my grocery expenses and storing that data in a MySQL database. This was great practice using SQL to design and manage data. The inspiration for this project came from my experience managing restaurant inventory. In a restaurant setting, food and labor costs are essential in maintaining the health of the business. I wanted to apply this same approach to my personal consumption habits. The goal was to use this database to extract insights on how to shop, or at the very least validate my claim that it's still possible to eat well on a budget.

Each week I would insert data into three tables: store, trip, and item information (schema](./sql/grocery-db-erd.png). Yes, data entry is not the sexiest task...neverthethess manually inserting data in SQL solidified my fundamentals of database managment: read, write, delete, etc, while ensuring constraints served my desired data integrity. Seven months later, I now have my grocery buying habits logged: I purchased 500 items over 56 trips at 11 stores. 

My next objective was to query the data in sql, and doing some exploratory data analysis. I wrote a [python script](https://github.com/chanks06/grocery-db/blob/main/data_loader_app/data_loader.py) to load the data into a notebook for analysis. The main takeway from exploring the data was that I do indeed spend about $40 - $50 dollars on groceries per week, and that I shop mainly at Winco and Costco. Stretching my dollars by buying in bulk!

At this point I had a functional database from which I could extract and analyze the data. Pretty cool stuff. And yet, my project was tethered to my pc running the MySQL server. Enter the cloud. As a user of both a pc and mac, and with desire to build real-time dashboard to showcase my findings, I knew that I would need to migrate this database to a cloud platform. I chose Azure because of my familiarity with the Microsoft ecosystem through my use of Power BI, and because of my Azure for Students account (thanks Willamette!). Cloud services can be costly, and [Microsoft](https://azure.microsoft.com/en-us/free/students) offers students many of the Azure services at no or low cost.

This [article](https://learn.microsoft.com/en-us/azure/azure-sql/migration-guides/database/mysql-to-sql-database-guide?view=azuresql) on the Microsoft Learn platform walked me through how to migrate the database using the SQL Server Migration Assistant for MySQL. Given the simplicity of my database's schema, this process was smooth. 

Now that my grocery db was hosted on Azure, it was time confirm that both my Mac and Windows devices could access the data. I installed the ODBC Driver for SQL Server v18 on my machines. I tested access through RStudio, because Posit's platform-agnostism and because that's where I do much of my work. Configuring the driver in MacOS took a bit more legwork - one has to create an environment variable in the .Renviron file and included the full file path of the driver in the connection strings so that the ODBC library recognizes the driver. 

Et viola! I can now query and add grocery expense data to my heart's desire in an R environment.

Finally, here is a Power BI dashboard as a proof of concept, showing some insights about my shopping behavoir since September 2023.





