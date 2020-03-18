
if __name__ == '__main__': 
    from wlstModule import *#@UnusedWildImport

"""
Creates Release 1.0 items

Author: Simon Cutts
"""

import sys
from java.lang import System

execfile('CreateOsbJmsServer.py')
execfile('CreateJmsRaiseVoiceActivity.py')
execfile('CreateJmsManageAllocation.py')
execfile('CreateWorkManagerRaiseVoiceActivity.py')
execfile('CreateNagiosSnmpTrap.py')
