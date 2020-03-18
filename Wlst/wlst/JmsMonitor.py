
if __name__ == '__main__': 
    from wlstModule import *#@UnusedWildImport

"""
Display message count of OSB error queues & topics. Only prints out those
JMS resources that have current messages present

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

servers = domainRuntimeService.getServerRuntimes();
if (len(servers) > 0):

    jms = {}
    for server in servers:
        jmsRuntime = server.getJMSRuntime();
        jmsServers = jmsRuntime.getJMSServers();

        for jmsServer in jmsServers:
            
            " Only care about OSB JMS queues and topics "
            if (jmsServer.getName().startswith('JMSServer-OSB')):
                destinations = jmsServer.getDestinations();
                
                for destination in destinations:
                    
                    if (destination.getName().endswith('Error')):
                        
                        if (destination.getMessagesCurrentCount() > 0):
                            jms[destination.getName()] = destination
                
    " Print the JMS queues/topics in sorted order "
    keys = jms.keys()
    
    if (len(keys) > 0):
        print 'Error Queues & Topics'
        print '---------------------'
    
        keys.sort()
        for key in keys:
            destination = jms[key]
            print '  ', destination.getName(), ':' , destination.getMessagesCurrentCount()
    
    else:
        print "Error queues are empty :0)"
                
    print ''

disconnect()
exit()