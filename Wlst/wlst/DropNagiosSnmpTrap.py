
if __name__ == '__main__': 
    from wlstModule import *#@UnusedWildImport

"""
Drops the Nagios SNMP trap

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
servername=configProps.get("nagios.servername")
domain=configProps.get("domain")

" Connect to the server "
connect(userConfigFile=username,userKeyFile=password,url=adminUrl)

server=getMBean(servername)
if server is None:
    print 'Server not found'

else:
    
    edit()
    startEdit()
    
    cd('/SNMPAgent/' + domain)
    cmo.setEnabled(false)
    cmo.setPrivacyProtocol('NoPriv')
    cmo.setAuthenticationProtocol('NoAuth')
    cmo.setPrivacyProtocol('NoPriv')
    cmo.setAuthenticationProtocol('NoAuth')

    cmo.destroySNMPTrapDestination(getMBean('/SNMPAgent/' + domain + '/SNMPTrapDestinations/NagiosDestination'))

    try:
        save()
        activate(block="true")
    except Exception, e:
        print e 
        print "Error while trying to save and/or activate!!!"
        dumpStack()
        raise