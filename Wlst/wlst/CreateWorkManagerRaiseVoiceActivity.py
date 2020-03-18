
if __name__ == '__main__': 
    from wlstModule import *#@UnusedWildImport

"""
Creates following items:

    RaiseVoiceActivityWorkManager
    RaiseVoiceActivityMaxThreadsConstraint

Author: Simon Cutts
"""

import sys
from java.lang import System
from java.io import FileInputStream
from java.lang import String

" Load the properties file"
propInputStream = FileInputStream("build.properties")
configProps = Properties()
configProps.load(propInputStream)

" Set the properties"
username = configProps.get("username")
password = configProps.get("password")
adminUrl=configProps.get("adminUrl")
domain = configProps.get("domain")
clusterName = configProps.get("cluster")

" Connect to the server "
connect(userConfigFile=username,userKeyFile=password,url=adminUrl)

edit()
startEdit()

print 'Creating WorkManager RaiseVoiceActivityWorkManager '

cd('/SelfTuning/' + domain)
cmo.createWorkManager('RaiseVoiceActivityWorkManager')

cd('/SelfTuning/' + domain + '/WorkManagers/RaiseVoiceActivityWorkManager')

" Normally targeted to the cluster, except on developer machines "
if clusterName == "OSB_Cluster":
    set('Targets',jarray.array([ObjectName('com.bea:Name=OSB_Cluster,Type=Cluster')], ObjectName))
else:
    set('Targets',jarray.array([ObjectName('com.bea:Name=AdminServer,Type=Server')], ObjectName))

print 'Creating MaxThreadsConstraints RaiseVoiceActivityMaxThreadsConstraint '

cd('/SelfTuning/' + domain)
cmo.createMaxThreadsConstraint('RaiseVoiceActivityMaxThreadsConstraint')

cd('/SelfTuning/' + domain + '/MaxThreadsConstraints/RaiseVoiceActivityMaxThreadsConstraint')

" Normally targeted to the cluster, except on developer machines "
if clusterName == "OSB_Cluster":
    set('Targets',jarray.array([ObjectName('com.bea:Name=OSB_Cluster,Type=Cluster')], ObjectName))
else:
    set('Targets',jarray.array([ObjectName('com.bea:Name=AdminServer,Type=Server')], ObjectName))
    
cmo.setCount(2)
cmo.unSet('ConnectionPoolName')

cd('/SelfTuning/' + domain + '/WorkManagers/RaiseVoiceActivityWorkManager')
cmo.setMaxThreadsConstraint(getMBean('/SelfTuning/' + domain + '/MaxThreadsConstraints/RaiseVoiceActivityMaxThreadsConstraint'))

try:
    save()
    activate(block="true")
except Exception, e:
    print e 
    print "Error while trying to save and/or activate!!!"
    dumpStack()
    raise