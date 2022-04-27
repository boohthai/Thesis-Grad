import psycopg2
#!/usr/bin/python
from backend import settings
from backend.config import config
import backend.settings

def get_data(result):
    conn = None
   #result = []
    try:
        params = config()
        conn = psycopg2.connect(**params)
        cur = conn.cursor()
        cur.execute("SELECT * FROM public.\"UserConversation\"")
        print("The number of parts: ", cur.rowcount)
        result = cur.fetchall()
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
    return result
if __name__ == '__main__':
    #connect()
    settings.init()
    settings.lst = get_data(settings.lst)
    print(settings.lst)