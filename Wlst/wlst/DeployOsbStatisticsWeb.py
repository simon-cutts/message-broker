
if __name__ == '__main__': 
    from wlstModule import *#@UnusedWildImport

"""
Deploy OsbStatisticsWeb application and start. Then manually set deployment order
in the Admin console to 1000

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

stopApplication('OsbStatisticsWeb')
undeploy('OsbStatisticsWeb', timeout=60000)
deploy('OsbStatisticsWeb', 'C:/tfs/OracleSoa/osb/release-2.0/Java/OsbStatisticsWeb/OsbStatisticsWeb.war', targets='AdminServer', deploymentPrincipalName='weblogic', remote='true',upload='true')
startApplication('OsbStatisticsWeb')

disconnect()
exit()