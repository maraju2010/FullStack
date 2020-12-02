import pymysql

conn = pymysql.connect(host='localhost',
                       user='root',
                       password='xxxxxxxxxx')

#conn.cursor().execute('create database JSEAP')
conn.cursor().execute("""USE JSEAP""")
#conn.cursor().execute('''CREATE TABLE Machine (MachineId varchar(100) PRIMARY KEY , Line varchar(100) , Phone varchar(100) , PartitionId varchar(100) ,
#recordingFlag varchar(100) , recordingMediaSource varchar(100) , recordingProfileName varchar(100) ,
#monitoringCssName varchar(100) , e164Mask varchar(100) , displayAscii varchar(100) )''')

#conn.cursor().execute('''INSERT INTO Machine (MachineId, Line , Phone , PartitionId
#, recordingFlag , recordingMediaSource ,  recordingProfileName , monitoringCssName ,
#e164Mask , displayAscii ) VALUES ('MANORAJU2-3D4NH' , '130001' ,'CSF130001', 'Jason_Test',
#'Automatic Call Recording Enabled' , 'Gateway Preferred' , 'BIB' , 'None' , 'None' , 'None'  )''')
#conn.commit()
conn.cursor().execute('''INSERT INTO Machine (MachineId, Line , Phone , PartitionId
 , recordingFlag , recordingMediaSource ,  recordingProfileName , monitoringCssName ,
 e164Mask , displayAscii ) VALUES ('AgentMac-3' , '130001' ,'CSF130001', 'Jason_Test' ,
 'Automatic Call Recording Enabled' , 'Gateway Preferred' , 'BIB' , 'None' , 'None' , 'None' )''')

conn.commit()




#conn.cursor().execute('''CREATE TABLE Account (UserId varchar(100) PRIMARY KEY , Line varchar(100) , Phone varchar(100) , PartitionId varchar(100) ,
#recordingFlag varchar(100) , recordingMediaSource varchar(100) , recordingProfileName varchar(100) ,
#monitoringCssName varchar(100) , e164Mask varchar(100) , displayAscii varchar(100) )''')

#conn.cursor().execute('''INSERT INTO Account (UserId , Line , Phone , PartitionId
#, recordingFlag , recordingMediaSource ,  recordingProfileName , monitoringCssName ,
#e164Mask , displayAscii ) VALUES ('maraju22010' , '130001' ,'CSF130001', 'Jason_Test',
#'Automatic Call Recording Enabled' , 'Gateway Preferred' , 'BIB' , 'None' , 'None' , 'None'  )''')
#conn.commit()
conn.cursor().execute('''INSERT INTO Account (UserId , Line , Phone , PartitionId
 , recordingFlag , recordingMediaSource ,  recordingProfileName , monitoringCssName ,
 e164Mask , displayAscii ) VALUES ('manoraju' , '130001' ,'CSF130001', 'Jason_Test' ,
 'Automatic Call Recording Enabled' , 'Gateway Preferred' , 'BIB' , 'None' , 'None' , 'None' )''')

conn.commit()




#conn.cursor().execute('''CREATE TABLE Phone_Events (EventId varchar(100) , EventText varchar(100) , Service varchar(100) , TimeofEvent varchar(100) ,
#ActionRequired varchar(100) , UserId varchar(100) , MachineId varchar(100) ,
#Line varchar(100) )''')

#conn.commit()

