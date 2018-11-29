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
_EXCLUDE_PREFIXES = ('__', '_', '.')
_PYTHON_SUFFIX = '.py'


def ReloadProject(project_name: str) -> None:
  """Loads and reloads all modules for a project.

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
  
  project_root_len = len(project_root)
  python_suffix_len = len(_PYTHON_SUFFIX)
  for current_dir, dirnames, filenames in os.walk(
      project_root, followlinks=False):
    dirnames[:] = [
        dirname for dirname in dirnames 
        if not dirname.startswith(_EXCLUDE_PREFIXES)]
    filenames[:] = [
        filename for filename in filenames 
        if not filename.startswith(_EXCLUDE_PREFIXES) and 
        filename.endswith(_PYTHON_SUFFIX)]

    if filenames:
      package_name = current_dir[project_root_len+1:].replace('/', '.')
      if package_name:
        importlib.import_module(name=package_name)

    for filename in filenames:
      # This is the full module name, including packages.
      module_name = package_name + '.' + filename[:-python_suffix_len]
      try:
        if module_name in sys.modules:
          importlib.reload(sys.modules.get(module_name))
          print('reloaded: ' + module_name)
        else:
          importlib.import_module(name=module_name)
          print('imported: ' + module_name)
      except Exception as e:
        print('error loading module %s: %s' % (module_name, e))
