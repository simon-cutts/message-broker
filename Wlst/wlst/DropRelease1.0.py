
if __name__ == '__main__': 
    from wlstModule import *#@UnusedWildImport

"""
Drops Release 1.0 items

Author: Simon Cutts
"""

import sys
from java.lang import System

execfile('DropWorkManagerRaiseVoiceActivity.py')
execfile('DropJmsManageAllocation.py')
execfile('DropJmsRaiseVoiceActivity.py')
execfile('DropOsbJmsServer.py')
execfile('DropNagiosSnmpTrap.py')