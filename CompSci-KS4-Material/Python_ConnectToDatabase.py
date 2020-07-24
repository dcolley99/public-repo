import pyodbc, string

conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=localhost;'
                      'Database=AdventureWorksLT2017;'
                      'Trusted_Connection=yes' )
cursor = conn.cursor()
cursor = conn.execute('SELECT name FROM sys.tables;')

outfile = open('C:\\temp\\data.txt', 'w+') 

for row in cursor:
    row = str(row)
    row = row.replace("'","") 
    row = row.replace(",","")
    row = row.replace("(","") 
    row = row.replace(")","")
    row = row.replace(" ","")
    print(row)
    outfile.write(row) 
    outfile.write("\n")

outfile.close() 


