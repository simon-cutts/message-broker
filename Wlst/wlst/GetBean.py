
if __name__ == '__main__': 
    from wlstModule import *#@UnusedWildImport

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

connect(userConfigFile=username,userKeyFile=password,url=adminUrl)

bean = getMBean('/Servers/WLS_OSB1')

if bean is None:
    print 'Value is Null'

else:
    print bean

disconnect()

