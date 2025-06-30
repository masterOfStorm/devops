import requests

response = requests.get("http://app1:5000/")
print("Response from App 1:", response.text)
