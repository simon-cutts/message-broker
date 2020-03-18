
if __name__ == '__main__': 
    from wlstModule import *#@UnusedWildImport

"""
Drops the following JMS items:

    JMSServer-OSB1
    JMSServer-OSB2

All the artifacts associated with ManageAllocationModule will be dropped.

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
servername2=configProps.get("servername2")

" Connect to the server "
connect(userConfigFile=username,userKeyFile=password,url=adminUrl)

edit()
startEdit()
jmsServer = delete("JMSServer-OSB1","JMSServer")

server2=getMBean(servername2)
if server2 is not None:
    jmsServer = delete("JMSServer-OSB2","JMSServer")

try:
    save()
    activate(block="true")
except Exception, e:
    print e 
    print "Error while trying to save and/or activate!!!"
    dumpStack()
    raise