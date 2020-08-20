path = 'C:\Program Files (x86)\Google\Chrome\chromedriver.exe'
link='https://www.google.com/'
import xml.etree.ElementTree as ET
tree=ET.parse('n_xm.xml')
root= tree.getroot()
print(root.tag)
print(root.attrib)
l=[]
for mov in root.iter('Key'):
                     #print(mov.text)
                     l.append(mov.text)
print(len(l))
l=l[316:328]
import selenium
from selenium import webdriver
driver = webdriver.Chrome(path)
driver.get(link)
ind=1
for i in l:
    driver.execute_script("window.open('');")
    driver.switch_to.window(driver.window_handles[ind])
    driver.get('https://datacamp-community-prod.s3.amazonaws.com/'+str(i))
    ind = ind+1
    #driver.execute_script("window.open('https://datacamp-community-prod.s3.amazonaws.com/9f0f2ae1-8bd8-4302-a67b-e17f3059d9e8');")
    #driver.get('https://datacamp-community-prod.s3.amazonaws.com/'+str(i))
    #but=driver.find_element_by_id('download')
    #but.click()'''
