
if __name__ == '__main__': 
    from wlstModule import *#@UnusedWildImport

"""
Drops the JMS module passed in with sys.argv[1]. All the artifacts 
associated with module will be dropped.

Author: Simon Cutts
"""

import sys
from java.lang import System
from java.io import FileInputStream

if len(sys.argv) != 2:
     print "Invalid Arguements :: Usage DropJmsModule.py <JMS module name to drop>"
     exit()
     
else:
    moduleName=sys.argv[1]
    
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
jmsResource = delete(moduleName,"JMSSystemResource") 

try:
    save()
    activate(block="true")
except Exception, e:
    print e 
    print "Error while trying to save and/or activate!!!"
    dumpStack()
    raise