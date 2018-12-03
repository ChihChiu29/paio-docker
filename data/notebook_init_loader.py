"""Provides an easy to use notebook environment."""
# For notebook setup.
import importlib
import os
import sys

# For actual work.
import numpy as np
import scipy
import pandas as pd
from IPython import display
from matplotlib import pyplot as plt

_EXTERNAL_ROOT = '/workspace/external/'
_NOTEBOOK_INIT = 'notebook_init'


def ReloadProject(project_name: str) -> None:
  """Loads and reloads all modules for a project.
  
  Imports `project_name/notebook_init.py`, then reload it.
  All symbols in this module will be forwarded to the global scope.
  They are then reloaded.

  Args:
    project_name: a project is a directory under `/workspaces/external/`.
  """
  project_root = os.path.join(_EXTERNAL_ROOT, project_name)
  if project_root not in sys.path:
    if os.path.exists(project_root):
      sys.path.append(project_root)
      print('Path %s added to PYTHON_PATH.' % project_root)
    else:
      print('Path %s does not exist.' % project_root)
      return

  if not os.path.exists(os.path.join(project_root, _NOTEBOOK_INIT + '.py')):
    print(_NOTEBOOK_INIT + '.py not found from project directory.')
    return

  import notebook_init
  importlib.reload(notebook_init)
  print(_NOTEBOOK_INIT + '.py imported and reloaded')

  for symbol_name in dir(notebook_init):
    symbol = eval(_NOTEBOOK_INIT + '.' + symbol_name)
    if hasattr(symbol, '__loader__'):
      importlib.reload(symbol)
      exec('global %s; %s = %s.%s' % (
          symbol_name, symbol_name, _NOTEBOOK_INIT, symbol_name))
      print('reloaded: ' + symbol_name)
