
if __name__ == '__main__': 
    from wlstModule import *#@UnusedWildImport

"""
Creates Nagios SNMP trap

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
hostname=configProps.get("nagios.local.hostname")

" Connect to the server "
connect(userConfigFile=username,userKeyFile=password,url=adminUrl)

server=getMBean(servername)
if server is None:
    print 'Server not found'

else:
    
    edit()
    startEdit()
    
    cd('/SNMPAgent/' + domain)
    cmo.setEnabled(true)
    cmo.setPrivacyProtocol('NoPriv')
    cmo.setAuthenticationProtocol('NoAuth')
    cmo.setPrivacyProtocol('NoPriv')
    cmo.setAuthenticationProtocol('NoAuth')

    cmo.createSNMPTrapDestination('LocalDestination')

    cd('/SNMPAgent/' + domain + '/SNMPTrapDestinations/LocalDestination')
    cmo.setPort(1162)
    cmo.setHost(hostname)
    cmo.setCommunity('weblogic')
    cmo.setSecurityLevel('noAuthNoPriv')

    try:
        activate(block="true")
    except Exception, e:
        print e 
        print "Error while trying to save and/or activate!!!"
        dumpStack()
        raise