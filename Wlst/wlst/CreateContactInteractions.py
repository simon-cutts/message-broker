
if __name__ == '__main__': 
    from wlstModule import *#@UnusedWildImport

"""
Creates following JMS items:

    ContactInteractionsModule
    
    ContactInteractionsSubDeployment
    
     
    ContactProspectDistributedQueue
    ContactProspectDistributedQueueError
    
    ContactInteractionDistributedQueue
    ContactInteractionDistributedQueueError
    
    ContactFulfillmentDistributedQueue
    ContactFulfillmentDistributedQueueError
    
    WeedInteractionDistributedQueue
    WeedInteractionDistributedQueueError
    
Assumes the JMSServer-OSB1 and JMSServer-OSB2 JMS servers already present

Sets the RedeliveryLimit 5 and RedeliveryDelay to 3600000 (1 hour)

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

" Create JMS UniformDistributedQueue from the jmsReource for the queueName"
def createJmsUdq(jmsResource,queueName):
    jmsQueueError = jmsResource.createUniformDistributedQueue(queueName + 'DistributedQueueError')
    jmsQueueError.setJNDIName('jms.' + queueName + 'DistributedQueueError')
    jmsQueueError.setSubDeploymentName('ContactInteractionsSubDeployment')
    print "MBean type UniformDistributedQueue " + queueName + "Error has been created successfully"
    
    jmsQueue = jmsResource.createUniformDistributedQueue(queueName + 'DistributedQueue')
    jmsQueue.setJNDIName('jms.' + queueName + 'DistributedQueue')
    jmsQueue.setSubDeploymentName('ContactInteractionsSubDeployment')
    jmsQueue.getDeliveryFailureParams().setRedeliveryLimit(5)
    jmsQueue.getDeliveryParamsOverrides().setRedeliveryDelay(3600000)
    jmsQueue.getDeliveryFailureParams().setErrorDestination(jmsQueueError)
    print "MBean type UniformDistributedQueue " + queueName + " has been created successfully"
        
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
    jmsModule = create('ContactInteractionsModule','JMSSystemResource')
    jmsModule.addTarget(server1)

    " Target the sub-deployment to the JMS server"
    subDeployment = jmsModule.createSubDeployment('ContactInteractionsSubDeployment')
    subDeployment.addTarget(jmsServer1)
    
    " Create the second JMS server, if present, with the file store "
    server2=getMBean(servername2)
    if server2 is not None:
        
        cd("/JMSServers")
        jmsServer2 = getMBean("JMSServer-OSB2")
        cd("/")

        "Target to the module and sub deployment"
        jmsModule.addTarget(server2)
        subDeployment.addTarget(jmsServer2)
    
    jmsResource = jmsModule.getJMSResource()
    
    " Create the JMS UDQ queues "
    createJmsUdq(jmsResource,'ContactProspect')
    createJmsUdq(jmsResource,'ContactInteraction')
    createJmsUdq(jmsResource,'ContactFulfillment')
    createJmsUdq(jmsResource,'WeedInteraction')
       
    try:
        save()
        activate(block="true")
    except Exception, e:
        print e 
        print "Error while trying to save and/or activate!!!"
        dumpStack()
        raise