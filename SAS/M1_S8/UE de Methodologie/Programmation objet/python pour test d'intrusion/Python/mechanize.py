import mechanize

browser = mechanize.Browser()
browser.open("http://127.0.0.1/DVWA/login.php")

browser.select_form(nr=0)
browser["username"] = "admin"
browser["password"] = "password"

browser.submit()

response = browser.response().read()  
if "Welcome" in response:  
    print("Login successful!")
else:
    print("Login failed.")