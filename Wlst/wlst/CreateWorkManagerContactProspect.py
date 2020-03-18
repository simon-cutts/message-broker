
if __name__ == '__main__': 
    from wlstModule import *#@UnusedWildImport

"""
Creates following items:

    ContactProspectWorkManager
    ContactProspectMaxThreadsConstraint

Author: Lakshminadh
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

print 'Creating WorkManager ContactProspectWorkManager '

cd('/SelfTuning/' + domain)
cmo.createWorkManager('ContactProspectWorkManager')

cd('/SelfTuning/' + domain + '/WorkManagers/ContactProspectWorkManager')

" Normally targeted to the cluster, except on developer machines "
if clusterName == "OSB_Cluster":
    set('Targets',jarray.array([ObjectName('com.bea:Name=OSB_Cluster,Type=Cluster')], ObjectName))
else:
    set('Targets',jarray.array([ObjectName('com.bea:Name=AdminServer,Type=Server')], ObjectName))

print 'Creating MaxThreadsConstraints ContactProspectMaxThreadsConstraint '

cd('/SelfTuning/' + domain)
cmo.createMaxThreadsConstraint('ContactProspectMaxThreadsConstraint')

cd('/SelfTuning/' + domain + '/MaxThreadsConstraints/ContactProspectMaxThreadsConstraint')

" Normally targeted to the cluster, except on developer machines "
if clusterName == "OSB_Cluster":
    set('Targets',jarray.array([ObjectName('com.bea:Name=OSB_Cluster,Type=Cluster')], ObjectName))
else:
    set('Targets',jarray.array([ObjectName('com.bea:Name=AdminServer,Type=Server')], ObjectName))
    
cmo.setCount(2)
cmo.unSet('ConnectionPoolName')

cd('/SelfTuning/' + domain + '/WorkManagers/ContactProspectWorkManager')
cmo.setMaxThreadsConstraint(getMBean('/SelfTuning/' + domain + '/MaxThreadsConstraints/ContactProspectMaxThreadsConstraint'))

try:
    save()
    activate(block="true")
except Exception, e:
    print e 
    print "Error while trying to save and/or activate!!!"
    dumpStack()
    raise