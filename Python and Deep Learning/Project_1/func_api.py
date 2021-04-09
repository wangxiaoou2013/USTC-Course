# A file contains all the function to connect with API
import requests
import json
import base64


def get_token():
    #get the access token from API
    API_key = 'aCK8irrzhG9PA3XVR0MDgnvH'
    Secret_key = 'PVIf0ZBpwr2Em8BxbBQW2ECKD5YgYwpq'
    host = 'https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials&client_id=' + API_key + '&client_secret=' + Secret_key
    response = requests.get(host)
    if response:
        # print(response.json())
        response_result = response.json()
        key = response_result['access_token']
        if key:
            return key
        else:
            return 0
    else:
        return 0


def get_result_bankcard(file, key):
    #recognition of bankcard
    request_url = "https://aip.baidubce.com/rest/2.0/ocr/v1/bankcard"
    f = open(file, 'rb')
    img = base64.b64encode(f.read())
    params = {"image": img}
    access_token = key
    request_url = request_url + "?access_token=" + access_token
    headers = {'content-type': 'application/x-www-form-urlencoded'}
    response = requests.post(request_url, data=params, headers=headers)
    if response:
        result = response.json()
        return result
    else:
        return 0
