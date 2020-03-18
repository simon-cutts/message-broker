
if __name__ == '__main__': 
    from wlstModule import *#@UnusedWildImport

"""
Creates following JMS items:

    RaiseVoiceActivityModule
    RaiseVoiceActivitySubDeployment
    RaiseVoiceActivityDistributedQueue
    RaiseVoiceActivityDistributedQueueError
    SendVoiceActivityDistributedQueue
    SendVoiceActivityDistributedQueueError

Assumes the JMSServer-OSB1 and JMSServer-OSB2 JMS servers already present

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

" Connect to the server "
connect(userConfigFile=username,userKeyFile=password,url=adminUrl)

server1=getMBean(servername1)
if server1 is None:
    print 'Server not found'

else:
    
    edit()
    startEdit()
    
    " Get the first JMS server JMSServer-OSB1 "
    cd("/JMSServers")
    jmsServer1 = getMBean("JMSServer-OSB1")
    cd("/")

    " Create the JMS module "
    jmsModule = create('RaiseVoiceActivityModule','JMSSystemResource')
    jmsModule.addTarget(server1)

    " Target the sub-deployment to the JMS server"
    subDeployment = jmsModule.createSubDeployment('RaiseVoiceActivitySubDeployment')
    subDeployment.addTarget(jmsServer1)
    
    " Get the second JMS server, if present "
    server2=getMBean(servername2)
    if server2 is not None:
        
        cd("/JMSServers")
        jmsServer2 = getMBean("JMSServer-OSB2")
        cd("/")

        "Target to the module and sub deployment"
        jmsModule.addTarget(server2)
        subDeployment.addTarget(jmsServer2)
    
    jmsResource = jmsModule.getJMSResource()
        
    " RaiseVoiceActivityDistributedQueue"

    jmsQueueError = jmsResource.createUniformDistributedQueue('RaiseVoiceActivityDistributedQueueError')
    jmsQueueError.setJNDIName('jms.RaiseVoiceActivityDistributedQueueError')
    jmsQueueError.setSubDeploymentName('RaiseVoiceActivitySubDeployment')
    print "MBean type UniformDistributedQueue with name RaiseVoiceActivityDistributedQueueError has been created successfully"
    
    jmsQueue = jmsResource.createUniformDistributedQueue('RaiseVoiceActivityDistributedQueue')
    jmsQueue.setJNDIName('jms.RaiseVoiceActivityDistributedQueue')
    jmsQueue.setSubDeploymentName('RaiseVoiceActivitySubDeployment')
    jmsQueue.getDeliveryFailureParams().setRedeliveryLimit(3)
    jmsQueue.getDeliveryParamsOverrides().setRedeliveryDelay(1800000)
    jmsQueue.getDeliveryFailureParams().setErrorDestination(jmsQueueError)
    print "MBean type UniformDistributedQueue with name RaiseVoiceActivityDistributedQueue has been created successfully"
    
    " SendVoiceActivityDistributedQueue"

    jmsQueueError = jmsResource.createUniformDistributedQueue('SendVoiceActivityDistributedQueueError')
    jmsQueueError.setJNDIName('jms.SendVoiceActivityDistributedQueueError')
    jmsQueueError.setSubDeploymentName('RaiseVoiceActivitySubDeployment')
    print "MBean type UniformDistributedQueue with name SendVoiceActivityDistributedQueueError has been created successfully"
    
    jmsQueue = jmsResource.createUniformDistributedQueue('SendVoiceActivityDistributedQueue')
    jmsQueue.setJNDIName('jms.SendVoiceActivityDistributedQueue')
    jmsQueue.setSubDeploymentName('RaiseVoiceActivitySubDeployment')
    jmsQueue.getDeliveryFailureParams().setRedeliveryLimit(3)
    jmsQueue.getDeliveryParamsOverrides().setRedeliveryDelay(1800000)
    jmsQueue.getDeliveryFailureParams().setErrorDestination(jmsQueueError)
    print "MBean type UniformDistributedQueue with name SendVoiceActivityDistributedQueue has been created successfully"
        
    try:
        save()
        activate(block="true")
    except Exception, e:
        print e 
        print "Error while trying to save and/or activate!!!"
        dumpStack()
        raise