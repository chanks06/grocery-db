# libraries
import mysql.connector
import pandas as pd 
import numpy as np 
import datetime as dt
import matplotlib.pyplot as plt

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

############

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


