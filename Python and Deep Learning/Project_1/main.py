

import func_api
import func_pic

key = func_api.get_token()
if key != 0:
    file = func_pic.img_open()
    result = func_api.get_result_bankcard(file=file, key=key)
    if result != 0:
        result_dict = result['result']
        print(result_dict)


