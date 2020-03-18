
if __name__ == '__main__': 
    from wlstModule import *#@UnusedWildImport

"""
Drops the following items:

    ContactProspectWorkManager
    ContactProspectMaxThreadsConstraint

Author: Lakshminadh
"""

import sys
from java.lang import System
from java.io import FileInputStream

" Load the properties file"
propInputStream = FileInputStream("build.properties")
configProps = Properties()
configProps.load(propInputStream)

" Set the properties"
username = configProps.get("username")
password = configProps.get("password")
adminUrl=configProps.get("adminUrl")
domain = configProps.get("domain")

" Connect to the server "
connect(userConfigFile=username,userKeyFile=password,url=adminUrl)

edit()
startEdit()
editService.getConfigurationManager().removeReferencesToBean(getMBean('/SelfTuning/' + domain + '/MaxThreadsConstraints/ContactProspectMaxThreadsConstraint'))

cd('/SelfTuning/' + domain)
cmo.destroyMaxThreadsConstraint(getMBean('/SelfTuning/' + domain + '/MaxThreadsConstraints/ContactProspectMaxThreadsConstraint'))

editService.getConfigurationManager().removeReferencesToBean(getMBean('/SelfTuning/' + domain + '/WorkManagers/ContactProspectWorkManager'))
cmo.destroyWorkManager(getMBean('/SelfTuning/' + domain + '/WorkManagers/ContactProspectWorkManager'))

try:
    save()
    activate(block="true")
except Exception, e:
    print e 
    print "Error while trying to save and/or activate!!!"
    dumpStack()
    raise