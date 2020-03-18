
if __name__ == '__main__': 
    from wlstModule import *#@UnusedWildImport

"""
Drops the following JMS Topic items:

    StudentModuleEventModule

All the artifacts associated with StudentModuleEventModule will be dropped.

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

" Connect to the server "
connect(userConfigFile=username,userKeyFile=password,url=adminUrl)

edit()
startEdit()
jmsResource = delete("StudentModuleEventModule","JMSSystemResource") 

try:
    save()
    activate(block="true")
except Exception, e:
    print e 
    print "Error while trying to save and/or activate!!!"
    dumpStack()
    raise