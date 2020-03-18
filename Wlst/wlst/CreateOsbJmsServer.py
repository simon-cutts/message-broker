
if __name__ == '__main__': 
    from wlstModule import *#@UnusedWildImport

"""
Creates following JMS items:

    JMSServer-OSB

Author: Simon Cutts
"""

import sys
from java.lang import System
from java.io import FileInputStream

" Load the properties file"
propInputStream = FileInputStream("build.properties")
configProps = Properties()
configProps.load(propInputStream)

" Set the properties"
username=configProps.get("username")
password=configProps.get("password")
adminUrl=configProps.get("adminUrl")
servername1=configProps.get("servername1")
servername2=configProps.get("servername2")
filestore1=configProps.get("filestore1")
filestore2=configProps.get("filestore2")

" Connect to the server "
connect(userConfigFile=username,userKeyFile=password,url=adminUrl)

server1=getMBean(servername1)
if server1 is None:
    print 'Server not found'

else:
    
    edit()
    startEdit()
    
    " Create the JMS server with the file store "
    fileStore1 = getMBean(filestore1)
    
    jmsServer1 = create('JMSServer-OSB1','JMSServer')
    jmsServer1.addTarget(server1)
    jmsServer1.setPersistentStore(fileStore1)
    
    " Create the second JMS server, if present, with the file store "
    server2=getMBean(servername2)
    if server2 is not None:
        
        fileStore2 = getMBean(filestore2)

        jmsServer2 = create('JMSServer-OSB2','JMSServer')
        jmsServer2.addTarget(server2)
        jmsServer2.setPersistentStore(fileStore2)
    
    try:
        save()
        activate(block="true")
    except Exception, e:
        print e 
        print "Error while trying to save and/or activate!!!"
        dumpStack()
        raise