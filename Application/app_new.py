from tornado.httpserver import HTTPServer
from tornado.options import define,options
from tornado.web import Application
from tornado.ioloop import IOLoop

from tornado.web import RequestHandler
from tornado import gen

import json
import queue
import pymysql
from lxml import etree
from requests import Session
from requests.auth import HTTPBasicAuth

from zeep import Client,Settings,Plugin,xsd
from zeep.transports import Transport
from zeep.exceptions import Fault
from zeep.plugins import HistoryPlugin

from abc import ABC, abstractmethod

import sys
import os


from datetime import datetime
import requests
#import concurrent.futures
from concurrent.futures import ThreadPoolExecutor
from tornado.concurrent import run_on_executor

import logging
import logging.handlers
from logging.config import fileConfig

MAX_WORKERS = 4

class prettyLogin(object):
    def __init__(self):
        logging.config.fileConfig('LoggerProperty.ini')
        self.log=logging.getLogger(__name__)


    def _write(self,string,debugtype=None):

        if debugtype=="INFO":
            self.log.info(string)
        elif debugtype=="WARNING":
            self.log.warning(string)
        elif debugtype=="ERROR":
            self.log.error(string)
        else:
            self.log.debug(string)


logger = prettyLogin()

class settings(object):

    DEBUG = False

    db = {
         "Host" : "127.0.0.1",
         "User" : "root",
         "Password" : "XXXXXXXXXXXXX",
         "Database" : "JSEAP",
         "Charset" : "utf8mb4",
         "Autocommit" : True
    }

    web_port = 8888
    WSDL_FILE = "schema/AXLAPI.wsdl"
    username = "jseap"
    password = "jseap"
    cucm_address = "127.0.0.1"
    cucm_port = "8443"
    CallManager = "https://%s:%s/axl/" % (cucm_address,cucm_port)
    axl_binding = "{http://www.cisco.com/AXLAPIService/}AXLAPIBinding"


class database(object):
    __instance = None

    def __init__(self):
        self.conn = pymysql.connect(host=settings.db.get("Host"),
                    user=settings.db.get("User"),
                    password=settings.db.get("Password"),
                    database=settings.db.get("Database"),
                    charset=settings.db.get("Charset"),
                    autocommit=settings.db.get("Autocommit"))

        self.cursor = self.conn.cursor(cursor=pymysql.cursors.DictCursor)

    def close_db(self):
        self.conn.close()

    def select(self,sql,args=None):

        sql1 = "USE %s" % settings.db.get("Database")
        self.cursor.execute(sql1)
        self.cursor.execute(sql,args)
        rs= self.cursor.fetchall()
        return rs

    def insert(self,sql,args=None):
        sql1 = "USE %s" % settings.db.get("Database")
        self.cursor.execute(sql1)
        self.cursor.execute(sql,args)
        return self.cursor.rowcount

    @classmethod
    def singleton(cls):
        if not cls.__instance:
            cls.__instance = cls()
        return cls.__instance

class QueueBuffer(object):
    global logger
    __instance = None

    @staticmethod
    def getInstance():
        if QueueBuffer.__instance ==None:
            QueueBuffer()
        return QueueBuffer.__instance

    def __init__(self):
        if QueueBuffer.__instance !=None:
            logger._write("Singleton: cannot create multiple instance",debugtype="DEBUG")
            raise Exception("Singleton: cannot create multiple instance")
        else:
            BUF_SIZE = 100
            self.queue = queue.Queue(BUF_SIZE)
            QueueBuffer.__instance = self

class Abstract_Notifier(ABC):

    @abstractmethod
    def add(self, observer):
        pass

    @abstractmethod
    def remove(self, observer):
        pass

    @abstractmethod
    def notify(self):
        pass

class Abstract_Observer(ABC):

    @abstractmethod
    def update(self, obj):
        pass


class Notifier(Abstract_Notifier):
    global logger

    def __init__(self):
        self._obj = QueueBuffer()

    Observers = []

    def add(self, observer):
        self.Observers.append(observer)

    def remove(self, observer):
        self.Observers.append(observer)

    def notify(self):
        for Observer in self.Observers:
            Observer.update(self)
        #print('---------------------------------------')

    @property
    def _queue_item(self):
        return self._obj.queue

    @_queue_item.setter
    def _queue_item(self, value):
        self._obj.queue.put(value)
        self.notify()

class Observer(object):
     def __init__(self, observername: str):
        self._observer = observername
        self.ac = axl_client()

     def update(self, item: Notifier):
         self.ac._validate_line(item._queue_item)
         logger._write("item._queue_item update : %s " % item._queue_item,debugtype="DEBUG")
         return

class Watcher(object):
    def __init__(self):
        self.notifier = Notifier()
        self.notifier.add(Observer('obs_1'))

    def _add_item(self,item):
        self.notifier._queue_item = item

class MyLoggingPlugin( Plugin ):

    def egress( self, envelope, http_headers, operation, binding_options ):

        # Format the request body as pretty printed XML
        xml = etree.tostring( envelope, pretty_print = True, encoding = 'unicode')

        print( f'\nRequest\n-------\nHeaders:\n{http_headers}\n\nBody:\n{xml}' )

    def ingress( self, envelope, http_headers, operation ):

        # Format the response body as pretty printed XML
        xml = etree.tostring( envelope, pretty_print = True, encoding = 'unicode')

        print( f'\nResponse\n-------\nHeaders:\n{http_headers}\n\nBody:\n{xml}' )

class axl_client(object):

    DEBUG = False
    WSDL_FILE = settings.WSDL_FILE
    username = settings.username
    password = settings.password
    cucm_address = settings.cucm_address
    cucm_port = settings.cucm_port
    CallManager = "https://%s:%s/axl/" % (cucm_address,cucm_port)
    axl_binding = settings.axl_binding
    global logger

    def __init__(self):
        try:
            session = Session()
            session.auth = HTTPBasicAuth(axl_client.username,axl_client.password)
            session.verify = False
            transport = Transport(session = session,timeout = 3)
            settings = Settings(strict = False,xml_huge_tree = True)
            plugin = [ MyLoggingPlugin() ] if axl_client.DEBUG else [ ]
            client = Client(wsdl=axl_client.WSDL_FILE,settings = settings,transport=transport, plugins=plugin)
            self.service = client.create_service(axl_client.axl_binding,axl_client.CallManager)
        except Exception as e:
            logger._write("axl initialize failed %s" % e, debugtype="DEBUG")

    def _validate_line(self,params):
        print("validating item %s" % params)
        logger._write("validating item %s" % params,debugtype="DEBUG")
        #futures = []
        #with concurrent.futures.ThreadPoolExecutor(max_workers=5) as executor:
        while not params.empty():
                q = params.get()
                print("q items specs %s %s" % (q.new_user,q.orig_machine))
                #futures.append(executor.submit(self.cucm_axl_req,q))
                #print("thread executed wait")

           ###################################################
            #for future in concurrent.futures.as_completed(futures):
            #    print("future printing")
            #    print(future.result())
                event,event_text = self.cucm_axl_req(q)
                if event==0:
                    print("it is 0")
                    q.middleware.write(str(event),"update failed","axl_client",datetime.now().strftime("%m/%d/%Y, %H:%M:%S"),str(event_text),q.new_user,q.orig_machine)
                elif event==1:
                    print("it is 1")
                    q.middleware.write(str(event),"update success","axl_client",datetime.now().strftime("%m/%d/%Y, %H:%M:%S"),str(event_text),q.new_user,q.orig_machine)
                else:
                    pass

    def _update_line(self,q):
            if q.orig_phone:
                event,event_text = self.configure(q.orig_phone,q.orig_recordingflag,q.orig_recordingmediasource,
                q.orig_recordingprofilename,q.orig_monitoringcssname,q.orig_e164mask,
                q.orig_displayascii,q.new_lineId,q.new_pt)
            if q.new_phone:
                event,event_text = self.configure(q.new_phone,q.new_recordingflag,q.new_recordingmediasource,
                q.new_recordingprofilename,q.new_monitoringcssname,q.new_e164mask,
                q.new_displayascii,q.orig_lineId,q.orig_pt)
            return event,event_text

    def _revert_line(self,q):
            if q.orig_phone:
                event,event_text = self.configure(q.orig_phone,q.orig_recordingflag,q.orig_recordingmediasource,
                q.orig_recordingprofilename,q.orig_monitoringcssname,q.orig_e164mask,
                q.orig_displayascii,q.orig_lineId,q.orig_pt)
            return event,event_text

    def _remove_line(self,q):
        if q.old_phone:
            event,event_text = self.configure(q.old_phone,q.old_recordingflag,q.old_recordingmediasource,
            q.old_recordingprofilename,q.old_monitoringcssname,q.old_e164mask,
            q.old_displayascii,q.old_lineId,q.old_pt)

        return event,event_text

    def _check_sql(self,query,q):
        resp1 = self.service.executeSQLQuery(query)
        for rowXml in resp1[ 'return' ][ 'row' ]:
                z = rowXml[ 0 ].text
                if z!=q.orig_phone:
                    logger._write("this is z phone %s " % z ,debugtype="DEBUG")
                    rs = q.middleware.query(z,"PH")
                    q.verify_3(rs)
                    self._remove_line(q)

    def _all_lines(self,query):
        resp = self.service.executeSQLQuery(query)
        return resp

    def _query_validator(self,query):
        pass

    def cucm_axl_req(self,q):
        try:
            if q.orig_phone == q.new_phone:
                    sql = '''select d.name from Device as d,NumPlan as n, DeviceNumPlanMap as dnpm
                    where dnpm.fkdevice = d.pkid and dnpm.fknumplan = n.pkid
                    and n.dnorpattern = "%s"''' % q.orig_lineId
                    response = self._check_sql(sql,q)
                    event,event_text = self._revert_line(q)
            else:
                sql = '''select d.name from Device as d,NumPlan as n, DeviceNumPlanMap as dnpm
                where dnpm.fkdevice = d.pkid and dnpm.fknumplan = n.pkid
                and n.dnorpattern = "%s"''' % q.orig_lineId
                response = self._check_sql(sql,q)
                event,event_text = self._revert_line(q)
                event,event_text =self._update_line(q)
            return event,event_text
        except Exception as e:
            print(e)
            return 0,"exception while connecting cucm,phone update failed for user %s" % q.new_user



    def configure(self,phone,recordflag,recordmedia,recordprofile,moncss,e164,display,
    line,pt):
        logger._write("update phone request %s %s %s %s %s %s %s %s %s" % (phone,recordflag,recordmedia,recordprofile,moncss,e164,display,line,pt),debugtype="DEBUG")
        try:
            print("testing zeep")
            resp = self.service.updatePhone(
                    name = phone,
                    lines =  {
                            'line': [
                                        { 'index': 1,
                                        'dirn': {'pattern': line , 'routePartitionName': pt},
                                        'recordingProfileName': {
                                            '_value_1': recordprofile
                                        },
                                        'monitoringCssName': {
                                            '_value_1': moncss
                                        },
                                        'recordingFlag': recordflag,
                                        'recordingMediaSource': recordmedia,
                                        'displayAscii': display,
                                        'e164Mask': e164
                                        }
                                    ]
                                 }
                    )

            if resp:
                try:
                    resp2 = self.service.restartPhone(
                        name = phone)
                except Exception as err:
                    print(f'Zeep error: resp2 restart phone: { err }'.format( err = err ))
                    errstatus = f'Zeep error: update_Line: { err }'.format( err = err )
                    return 0 ,errstatus
                #logger._write(resp2,debugtype="DEBUG")
            #logger._write(resp,debugtype="DEBUG")
            return 1,"Zeep success: line %s updated for phone %s" % (line,phone)
        except Exception as err:
                errstatus = f'Zeep error: update_Line: { err }'.format( err = err )
                print(f'Zeep error: update_Line: { err }'.format( err = err ))
                #logger._write( f'Zeep error: update_Line: { err }',debugtype="DEBUG" )
                return 0,errstatus

class Middleware(database):
    global logger

    def __init__(self):
        super(Middleware,self).__init__()

    def query(self,args,type):

        if type == "MU":
            sql = "select * from Account where UserId = %s"
        if type == "MM":
            sql = "select * from Machine where MachineId = %s"
        if type == "PH":
            sql =  "select * from Machine where Phone = %s"
        response = self.select(sql,args)
        return response

    def write(self,EventId,EventText,Service,TimeofEvent,ActionRequired,UserId,MachineId):
        try:
            print("write request to middleware received")
            args = (EventId,EventText,Service,TimeofEvent,ActionRequired,UserId,MachineId)
            sql = '''INSERT INTO phone_events (EventId, EventText , Service , TimeofEvent ,
             ActionRequired, UserId , MachineId) VALUES
             (%s , %s , %s ,%s, %s, %s , %s )'''
            response = self.insert(sql,args)
            print(response)
            return response
        except Exception as err:
            print(err)

class _parser(object):

    middleware = Middleware()
    global logger
    logger._write("initialize middleware instance %s" % middleware,debugtype="DEBUG")

    def __init__(self,params):

        self.orig_user = None
        self.new_user = None
        self.old_user = None
        self.orig_phone = None
        self.new_phone = None
        self.old_phone = None
        self.orig_lineId = None
        self.new_lineId = None
        self.old_lineId = None
        self.orig_machine = None
        self.new_machine = None
        self.old_machine = None
        self.orig_pt = None
        self.new_pt = None
        self.old_pt = None
        self.orig_recordingflag = None
        self.new_recordingflag = None
        self.old_recordingflag = None
        self.orig_recordingmediasource = None
        self.new_recordingmediasource = None
        self.old_recordingmediasource = None
        self.orig_recordingprofilename = None
        self.new_recordingprofilename = None
        self.old_recordingprofilename = None
        self.orig_monitoringcssname = None
        self.new_monitoringcssname = None
        self.old_monitoringcssname = None
        self.orig_e164mask = None
        self.new_e164mask = None
        self.old_e164mask = None
        self.orig_displayascii = None
        self.new_displayascii = None
        self.old_displayascii = None
        self.middleware = _parser.middleware

        data = json.loads(params.request.body)
        if data:
            self.__lookup(data)

    def __lookup(self,data):
        logger._write("_lookup method invoked",debugtype="DEBUG")

        Account = data['Account']
        Machine = data['Machine']
        if Account:
            if "=" in Account:
                logger._write("malicious traffic suspected %s " % Account,debugtype="INFO")
            elif "http" in Account:
                logger._write("malicious traffic suspected %s " % Account,debugtype="INFO")
            elif "//" in Account:
                logger._write("malicious traffic suspected %s " % Account,debugtype="INFO")
            else:
                row = _parser.middleware.query(Account,type='MU')
                if row:
                    self.verify_2(row)
        if Machine:
            if "=" in Machine:
                print("malicious traffic suspected %s " % Account,debugtype="INFO")
                logger._write("malicious traffic suspected %s " % Account,debugtype="INFO")
            elif "http" in Machine:
                logger._write("malicious traffic suspected %s " % Account,debugtype="INFO")
            elif "//" in Machine:
                logger._write("malicious traffic suspected %s " % Account,debugtype="INFO")
            else:
                row = _parser.middleware.query(Machine,type='MM')
                if row:
                    self.verify_1(row)

    def verify_1(self,row):

        logger._write("dumping contents for verify_1 of row[0][Phone] %s " % row[0]['Phone'],debugtype="DEBUG")
        self.orig_phone = row[0]['Phone']
        self.orig_lineId = row[0]['Line']
        self.orig_machine = row[0]['MachineId']
        self.orig_pt = row[0]['PartitionId']
        self.orig_recordingflag = None if row[0]['recordingFlag'] == 'None' else row[0]['recordingFlag']
        self.orig_recordingmediasource = None if row[0]['recordingMediaSource'] == 'None' else row[0]['recordingMediaSource']
        self.orig_recordingprofilename = None if row[0]['recordingProfileName'] == 'None' else row[0]['recordingProfileName']
        self.orig_monitoringcssname = None if row[0]['monitoringCssName'] == 'None' else row[0]['monitoringCssName']
        self.orig_e164mask = None if row[0]['e164Mask'] == 'None' else  row[0]['e164Mask']
        self.orig_displayascii = None if row[0]['displayAscii']  == 'None' else row[0]['displayAscii']
        logger._write("setting line map for orig_machine: %s" % self.orig_machine,debugtype="DEBUG")

    def verify_2(self,row):
        logger._write("dumping contents for verify_2 of row[0][Phone] %s " % row[0]['Phone'],debugtype="DEBUG")
        self.new_phone = row[0]['Phone']
        self.new_lineId = row[0]['Line']
        self.new_pt = row[0]['PartitionId']
        self.new_user = row[0]['UserId']
        self.new_recordingflag = None if row[0]['recordingFlag'] == 'None' else row[0]['recordingFlag']
        self.new_recordingmediasource = None if row[0]['recordingMediaSource'] == 'None' else row[0]['recordingMediaSource']
        self.new_recordingprofilename = None if row[0]['recordingProfileName'] == 'None' else row[0]['recordingProfileName']
        self.new_monitoringcssname = None if row[0]['monitoringCssName'] == 'None' else row[0]['monitoringCssName']
        self.new_e164mask = None if row[0]['e164Mask'] == 'None' else  row[0]['e164Mask']
        self.new_displayascii = None if row[0]['displayAscii'] == 'None' else row[0]['displayAscii']
        logger._write("setting line map for new_phone: %s" % self.new_phone,debugtype="DEBUG")

    def verify_3(self,row):
        logger._write("dumping contents for verify_3 of row[0][Phone] %s " % row[0]['Phone'],debugtype="DEBUG")
        self.old_phone = row[0]['Phone']
        self.old_lineId = row[0]['Line']
        self.old_machine = row[0]['MachineId']
        self.old_pt = row[0]['PartitionId']
        self.old_recordingflag = None if row[0]['recordingFlag'] == 'None' else row[0]['recordingFlag']
        self.old_recordingmediasource = None if row[0]['recordingMediaSource'] == 'None' else row[0]['recordingMediaSource']
        self.old_recordingprofilename = None if row[0]['recordingProfileName'] == 'None' else row[0]['recordingProfileName']
        self.old_monitoringcssname = None if row[0]['monitoringCssName'] == 'None' else row[0]['monitoringCssName']
        self.old_e164mask = None if row[0]['e164Mask'] == 'None' else  row[0]['e164Mask']
        self.old_displayascii = None if row[0]['displayAscii'] == 'None' else row[0]['displayAscii']
        logger._write("setting line map for old_phone : %s" % self.old_phone,debugtype="INFO")

class App(RequestHandler):
    """Only allow GET requests."""
    SUPPORTED_METHODS = ["GET","POST"]
    watcher = Watcher()
    global logger
    executor = ThreadPoolExecutor(max_workers=MAX_WORKERS)

    @gen.coroutine
    def get(self):
        logger._write("get request sent for execution",debugtype="INFO")
        yield self.execute()

    @gen.coroutine
    def post(self):
        self.write("Task completed successfully!\n")
        logger._write("post request sent for execution",debugtype="INFO")
        yield self.execute()
        #user = self.get_argument("username")
        #passwd = self.get_argument("password")

    @gen.coroutine
    def prepare(self):
        # inspect request argument
        print("request received with body arguments %s" % self.request.body)
        logger._write("request received with body arguments %s" % self.request.body,debugtype="DEBUG")
        #logging.debug(self.request.body)
        #pass

    @run_on_executor
    def execute(self):
        App.watcher._add_item(_parser(self))

class webserver(object):

    def __init__(self):
        global logger

        define("port",default=settings.web_port,help="port to listen on")


        """ Construct and serve the tornado application."""

        app = Application([
            ("/",App)
        ])
        http_server = HTTPServer(app)
        http_server.listen(options.port)
        print('Starting webserver on http://localhost:%i' % options.port)
        logger._write('Starting webserver on http://localhost:%i' % options.port,debugtype="INFO")
        IOLoop.current().start()


class getConfig(object):

    def __init__(self):
        self.config_client = axl_client()
        self.phonelist = {}

    def _execute(self):
        sql = '''select eds.userid as UserId , n.dnorpattern as Line , d.name as Phone,rt.name as PartitionId ,trf.name as recordingFlag,tms.name as recordingMediaSource,rp.name as recordingProfileName,cs.name as monitoringCssName,dnpm.e164mask as e164Mask,dnpm.displayascii  as displayAscii from Device as d LEFT JOIN  DeviceNumPlanMap as dnpm  on dnpm.fkdevice = d.pkid LEFT JOIN NumPlan as n on dnpm.fknumplan = n.pkid LEFT JOIN recordingprofile as rp  on dnpm.fkrecordingprofile = rp.pkid  LEFT JOIN routepartition as rt on rt.pkid = n.fkroutepartition LEFT JOIN callingsearchspace as cs on dnpm.fkcallingsearchspace_monitoring = cs.pkid LEFT JOIN typepreferredmediasource  as tms on tms.enum = dnpm.tkpreferredmediasource LEFT JOIN RecordingDynamic as rd on rd.fkDeviceNumPlanMap = dnpm.pkid LEFT JOIN typerecordingflag as trf on trf.enum = rd.tkrecordingflag LEFT JOIN enduser eds on eds.pkid = fkenduser'''
        response = self.config_client._all_lines(sql)
        if self.phonelist:
              new_hashvalue = hash(tuple([UserId , Line , Phone,PartitionId ,recordingFlag,recordingMediaSource,recordingProfileName,monitoringCssName,e164Mask,displayAscii]))
              old_hashvalue = self.phonelist.get(UserId,None)
              if old_hashvalue:
                  if old_hashvalue == new_hashvalue:
                      pass
                  else:
                       #write to DB
                       pass
        for rowXml in response[ 'return' ][ 'row' ]:
              UserId = rowXml[0].text
              Line  = rowXml[1].text
              Phone = rowXml[2].text
              PartitionId = rowXml[3].text
              recordingFlag = rowXml[4].text
              recordingMediaSource = rowXml[5].text
              recordingProfileName = rowXml[6].text
              monitoringCssName = rowXml[7].text
              e164Mask = rowXml[8].text
              displayAscii = rowXml[9].text
              if UserId:
                      hashvalue = hash(tuple([UserId , Line , Phone,PartitionId ,recordingFlag,recordingMediaSource,recordingProfileName,monitoringCssName,e164Mask,displayAscii]))
                      self.phonelist[UserId] = hashvalue
                      #write to DB
        logger._write("phonelist : %s" % self.phonelist,debugtype="INFO")


if __name__ == "__main__":
    try:
        webserver()
        #conf = getConfig()
        #conf._execute()
    except Exception as e:
        print(e)
        sys.exit( 1 )
