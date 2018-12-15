# PAIO
Python-All-In-One Docker image for text-based ML tasks.

## Tech Details

### OpenAi Gym
Atari and classics are supported.

### Chrome WebDriver

Chrome needs to be started under headless mode. Example:

```
from selenium import webdriver

options = webdriver.ChromeOptions()
options.add_argument('--headless')
options.add_argument('--disable-gpu')
options.add_argument('--no-sandbox')
driver = webdriver.Chrome(chrome_options=options)

driver.get('https://www.w3schools.com/')
print(driver.find_element_by_css_selector('h1').text)

driver.quit()
```

You should see output "HTML".

### Chrome Version

Google Chrome 63.0.3239.84             
