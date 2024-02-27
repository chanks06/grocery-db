'''
this py script is the main program for pulling data from my on-prem mySQL database and preparing it for analysis in python. 
'''

# libraries
import mysql.connector
import pandas as pd 
import numpy as np 
import datetime as dt

#import credentials for connecting to db from config.py file
from config import HOST, DATABASE, USERNAME, PASSWORD

#establishing connection to grocery db

def open_connection(): 
    try:
        connection = mysql.connector.connect(
            host=HOST,
            database=DATABASE,
            user=USERNAME,
            password=PASSWORD
        )

        if connection.is_connected():
            cursor = connection.cursor()
            print("Connected to GROCERY database.")

            return connection, cursor 

    except mysql.connector.Error as err:
        print(f"Error: {err}")


## kk next I want to build a function that receives an SQL query and produces a formatted pandas dataframe: 

### I DON'T NEED THIS FUNCTION RIGHT NOW BUT LEAVING IT BECAUSE IT TOOK ME TO WHERE I WANTED TO GO
        
""" def import_one_table(connection, cursor): 

    ### 1. TABLE SELECTION 
    #first show user what tables are inside the GROCERY database 
    cursor.execute("SHOW TABLES")

    #list comprehension to grab only name of table, otherwise presenting a list of tuples
    tables = [table[0] for table in cursor.fetchall()] 
    print(tables)

    user_query = input("Which table would you like? ")

    while user_query not in tables: 
        print("Please enter a table from GROCERY DB")
        user_query = input("Which table would you like? ").lower()

    ### 2. TABLE LOAD
        
    #cursor.execute(f'SELECT * FROM {user_query}')
    #selected_table = cursor.fetchall() 

    # take contents of cursor (a list of tuples) and contruct a pd dataframe. 
    # columns arg takes the first element from description, which is the name of the table column from mySQL

    query = f"SELECT * FROM {user_query}"

    table = pd.read_sql(query, connection, parse_dates = ['date'], coerce_float= True)

    print(table.info())

    return table 
 """



# new function that imports all tables from grocery_db

def import_tables(connection, cursor):
    cursor.execute("SHOW TABLES")
    tables = cursor.fetchall() # assign result from query to var tables 

    all_table_names = [table[0] for table in tables] # grabbing table names from result

    ###
    # create dictionary that will store the dataframes
    table_dictionary = {}

    #iterate through table names, query each table, and then put it into table_dictionary
    for table_name in all_table_names:
        query = "SELECT * FROM " + table_name
        table = pd.read_sql(query, connection, parse_dates = ['date'], coerce_float= True)
        
        table_dictionary[table_name] = table

    #return dictonary of all the tables from grocery db
    return table_dictionary


   
def close_connection(connection, cursor): 
    if cursor: 
        cursor.close()

    if connection.is_connected(): 
        connection.close() 
        print("Connection to GROCERY DB is now closed.")

def main(): 
    connection, cursor = open_connection()

    grocery_tables = import_tables(connection, cursor)
    
    if grocery_tables:
        print("All tables loaded from GROCERY DB.")
    close_connection(connection, cursor)

    return grocery_tables
 
if __name__ == '__main__':
    grocery_tables = main()
