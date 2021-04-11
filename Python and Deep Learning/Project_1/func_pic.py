# A file contains all the function about image

import tkinter
from tkinter import filedialog
import os
from PIL import Image

def img_open():
    root = tkinter.Tk()
    root.withdraw()
    default_dir = r"Filepath"
    file_path = filedialog.askopenfilename(title=u'Select a picture', initialdir=(os.path.expanduser(default_dir)))
    return file_path

def resize(w, h, w_box, h_box, img_pil):
    f1 = 1.0 * w_box / w
    f2 = 1.0 * h_box / h
    f = min([f1, f2])
    width = int(w * f)
    height = int(h * f)
    return img_pil.resize((width, height), Image.ANTIALIAS)