import requests

data = {
    "wetland": {
        "name": "Barotse"
    },
    "indicator": {
        "name": "LULC"
    }
}

response = requests.post("http://127.0.0.1:8000/sld_name/", json=data)
print(response.status_code)
print(response.json())