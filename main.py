'''
this py script is the main program for pulling data from my on-prem mySQL database and preparing it for analysis in python. 
'''

# libraries
import mysql.connector
import pandas as pd 
import numpy as np 

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


def close_connection(connection, cursor): 
    if cursor: 
        cursor.close()

    if connection.is_connected(): 
        connection.close() 
        print("Connection to GROCERY DB is now closed.")

def main(): 
    connection, cursor = open_connection()

    # ETL goes here 

    close_connection(connection, cursor)


if __name__ == '__main__':
    main()
