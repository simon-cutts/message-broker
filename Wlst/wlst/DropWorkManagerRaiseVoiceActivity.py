
if __name__ == '__main__': 
    from wlstModule import *#@UnusedWildImport

"""
Drops the following items:

    RaiseVoiceActivityWorkManager
    RaiseVoiceActivityMaxThreadsConstraint

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
username = configProps.get("username")
password = configProps.get("password")
adminUrl=configProps.get("adminUrl")
domain = configProps.get("domain")

" Connect to the server "
connect(userConfigFile=username,userKeyFile=password,url=adminUrl)

edit()
startEdit()
editService.getConfigurationManager().removeReferencesToBean(getMBean('/SelfTuning/' + domain + '/MaxThreadsConstraints/RaiseVoiceActivityMaxThreadsConstraint'))

cd('/SelfTuning/' + domain)
cmo.destroyMaxThreadsConstraint(getMBean('/SelfTuning/' + domain + '/MaxThreadsConstraints/RaiseVoiceActivityMaxThreadsConstraint'))

editService.getConfigurationManager().removeReferencesToBean(getMBean('/SelfTuning/' + domain + '/WorkManagers/RaiseVoiceActivityWorkManager'))
cmo.destroyWorkManager(getMBean('/SelfTuning/' + domain + '/WorkManagers/RaiseVoiceActivityWorkManager'))

try:
    save()
    activate(block="true")
except Exception, e:
    print e 
    print "Error while trying to save and/or activate!!!"
    dumpStack()
    raise