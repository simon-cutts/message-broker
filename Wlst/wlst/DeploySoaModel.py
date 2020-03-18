
if __name__ == '__main__': 
    from wlstModule import *#@UnusedWildImport

"""
Deploy SoaModel application and start. Then manually set deployment order
in the OSB_Cluster console to 1000

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

stopApplication('SoaModel')
undeploy('SoaModel', timeout=60000)
deploy('SoaModel', 'C:/OULocal/tfs/OracleSoa/osb/release-2.5/Model/SoaModel/SoaModel.war', targets='OSB_Cluster', deploymentPrincipalName='weblogic', remote='true',upload='true')
startApplication('SoaModel')

disconnect()
exit()