
if __name__ == '__main__': 
    from wlstModule import *#@UnusedWildImport

"""
Drop JMS module NamedTeachingSupportModule

Author: Simon Cutts
"""

import sys
from java.lang import System

" Pass the parameters using system arguments"
sys.argv = ['DropJmsModule.py','NamedTeachingSupportModule']
execfile('DropJmsModule.py')