#! /bin/bash

# The following commands are needed by XQuartz to support xautomation package.
# See: https://stackoverflow.com/questions/1264210/does-mac-x11-have-the-xtest-extension
defaults write org.x.X11 enable_test_extensions -boolean true
defaults write org.macosforge.xquartz.X11 enable_test_extensions -boolean true
echo "Done -- now you need to restart XQuartz server."