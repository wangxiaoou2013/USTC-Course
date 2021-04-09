# A file contains all the function about image

import tkinter
from tkinter import filedialog
import os


def img_open():
    root = tkinter.Tk()
    root.withdraw()
    default_dir = r"Filepath"
    file_path = filedialog.askopenfilename(title=u'Select a picture', initialdir=(os.path.expanduser(default_dir)))
    return file_path
