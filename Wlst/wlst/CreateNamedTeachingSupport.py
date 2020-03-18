
if __name__ == '__main__': 
    from wlstModule import *#@UnusedWildImport

"""
Creates following JMS items:

    NamedTeachingSupportModule
    
    NamedTeachingSupportSubDeployment
    
    CaptureStudentModuleQueue
    CaptureStudentModuleQueueError
    
The queue is pinned only to JMSServer-OSB1

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

" Create JMS UniformQueue from the jmsReource for the queueName"
def createJmsUdq(jmsResource,queueName):
    jmsQueueError = jmsResource.createUniformDistributedQueue(queueName + 'QueueError')
    jmsQueueError.setJNDIName('jms.' + queueName + 'QueueError')
    jmsQueueError.setSubDeploymentName('NamedTeachingSupportSubDeployment')
    print "MBean type UniformQueue " + queueName + "Error has been created successfully"
    
    jmsQueue = jmsResource.createUniformDistributedQueue(queueName + 'Queue')
    jmsQueue.setJNDIName('jms.' + queueName + 'Queue')
    jmsQueue.setSubDeploymentName('NamedTeachingSupportSubDeployment')
    jmsQueue.getDeliveryFailureParams().setRedeliveryLimit(3)
    jmsQueue.getDeliveryParamsOverrides().setRedeliveryDelay(1800000)
    jmsQueue.getDeliveryFailureParams().setErrorDestination(jmsQueueError)
    print "MBean type UniformQueue " + queueName + " has been created successfully"
        
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
    jmsModule = create('NamedTeachingSupportModule','JMSSystemResource')
    jmsModule.addTarget(server1)

    " Target the sub-deployment to the JMS server"
    subDeployment = jmsModule.createSubDeployment('NamedTeachingSupportSubDeployment')
    subDeployment.addTarget(jmsServer1)
    
    jmsResource = jmsModule.getJMSResource()
    
    " Create the JMS UDQ queues "
    createJmsUdq(jmsResource,'CaptureStudentModule')
       
    try:
        save()
        activate(block="true")
    except Exception, e:
        print e 
        print "Error while trying to save and/or activate!!!"
        dumpStack()
        raise