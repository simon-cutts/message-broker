
if __name__ == '__main__': 
    from wlstModule import *#@UnusedWildImport

"""
Drop JMS module ContactInteractionsModule

Author: Simon Cutts
"""

import sys
from java.lang import System

" Pass the parameters using system arguments"
sys.argv = ['DropJmsModule.py','ContactInteractionsModule']
execfile('DropJmsModule.py')