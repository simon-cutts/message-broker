
if __name__ == '__main__': 
    from wlstModule import *#@UnusedWildImport

"""

THIS IS NOT USED AND IS HERE FOR REFERENCE PURPOSES ONLY

CreateDistributedQueue ContactInteractionDistributedQueue

Author: Simon Cutts
"""

import sys
from java.lang import System

" Pass the parameters using system arguments"
sys.argv = ['CreateDistributedQueue.py','ContactInteraction']
execfile('CreateDistributedQueue.py')