# main program

import tkinter.messagebox

import func_api
import func_pic
import tkinter as tk
from PIL import Image, ImageTk

global file
global img_visible
global date
global number
global name
global tpe


class UI:
    def __init__(self, bankcard_window):
        self.bankcard_window = bankcard_window

    def set_init_window(self):
        self.bankcard_window.title('Bankcard Identification')
        self.bankcard_window.geometry('1000x400')
        self.open_button = tk.Button(self.bankcard_window, text='Select a picture which contains bankcard',
                                     font=('Arial', 12),
                                     width=40,
                                     height=1, command=self.img_open_button).place(x=0, y=0)

    def img_open_button(self):
        global file
        global img_visible
        file = func_pic.img_open()
        if file:
            img_open = Image.open(file)
            w, h = img_open.size
            img_open_resized = func_pic.resize(w, h, 400, 400, img_open)
            img_visible = ImageTk.PhotoImage(img_open_resized)
            label_img = tk.Label(self.bankcard_window, image=img_visible)
            label_img.place(x=0, y=30)
            key = func_api.get_token()
            if key != 0:
                result = func_api.get_result_bankcard(file=file, key=key)
                if result != 0:
                    result_dict = result['result']
                    # print(result_dict)
                    tk.Label(self.bankcard_window, text='Valid Date:', font=('Times New Roman', 12)).place(x=450, y=30)
                    tk.Label(self.bankcard_window, text='Bankcard Number:', font=('Times New Roman', 12)).place(x=450,
                                                                                                                y=90)
                    tk.Label(self.bankcard_window, text='Bank Name:', font=('Times New Roman', 12)).place(x=450, y=150)
                    tk.Label(self.bankcard_window, text='Bankcard Type:', font=('Times New Roman', 12)).place(x=450,
                                                                                                              y=210)
                    text_date = tk.Text(self.bankcard_window, width=50, height=3)  # .place(x=600, y=30)
                    text_number = tk.Text(self.bankcard_window, width=50, height=3)  # .place(x=600, y=90)
                    text_name = tk.Text(self.bankcard_window, width=50, height=3)  # .place(x=600, y=150)
                    text_type = tk.Text(self.bankcard_window, width=50, height=3)  # .place(x=600, y=210)
                    global date
                    global number
                    global name
                    global tpe

                    date = result_dict['valid_date']
                    number = result_dict['bank_card_number']
                    name = result_dict['bank_name']
                    tpe = func_api.bankcard_type(result_dict['bank_card_type'])
                    self.bankcard_window.update()

                    text_date.insert("insert", date)
                    text_number.insert("insert", number)
                    text_name.insert("insert", name)
                    text_type.insert("insert", tpe)

                    text_date.place(x=600, y=30)
                    text_number.place(x=600, y=90)
                    text_name.place(x=600, y=150)
                    text_type.place(x=600, y=210)

                else:
                    tkinter.messagebox.showinfo(title='Error', message='Wrong Picture!')
            else:
                tkinter.messagebox.showinfo(title='Error', message='Wrong Connection!')
        else:
            tkinter.messagebox.showinfo(title='Error', message='Wrong Picture!')


def GUI_start():
    init_window = tk.Tk()
    PORTAL = UI(init_window)
    PORTAL.set_init_window()

    init_window.mainloop()


GUI_start()
