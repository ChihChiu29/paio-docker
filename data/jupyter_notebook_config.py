import os
from IPython.lib import passwd

# See: https://github.com/jupyter/notebook/issues/3946
c.NotebookApp.ip = '0.0.0.0'
c.NotebookApp.port = int(os.getenv('PORT', 8888))
c.NotebookApp.open_browser = False
