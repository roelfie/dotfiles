# Use pync (python wrapper around terminal-notifier) for macOS notifications.
# This offers some features that oscascript -e 'display notification ...' doesn't.
# https://stackoverflow.com/questions/17651017/python-post-osx-notification

import os
import sys
from pync import Notifier


def notify(title, message, open_file, image_uri):
    Notifier.notify(message=message, 
                    title=title, 
                    group=os.getpid(), 
                    open=open_file,
                    sound='Sosumi', # /System/Library/Sounds (Frog, Sosumi, Tink, ..)
                    contentImage=image_uri)


if __name__ == "__main__":
    title = sys.argv[1]
    message = sys.argv[2]
    open_file = sys.argv[3]
    image = sys.argv[4]

    notify(title, message, open_file, image)