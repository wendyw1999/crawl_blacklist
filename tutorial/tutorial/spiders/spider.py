# -*- coding: utf-8 -*-
import scrapy
import re
import time
from tutorial.items import CaseItem
from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait

class DmozSpider(scrapy.Spider):
    handle_httpstatus_list = [404]
    name = "beijing"
    #allowed_domains = ["dmoz.org"]
    
    def __init__(self):
        self.page = 1
        self.start_urls = [
        "http://www.bjcourt.gov.cn/zxxx/indexOld.htm?st=1&zxxxlx=100013001&bzxrlx=&bzxrxm=&zrr=&frhqtzz=&jbfyId=&ah=&dqxh=14&page=1"
    ]
        
        self.driver = webdriver.Chrome()       
        self.driver.set_page_load_timeout(50)
    def close(self):
        self.driver.quit()
        print("quit")
    def parse(self, response):
        url_set = set()
        self.driver.get(response.url)
        page = 1
        
        pattern = re.compile(r"公司")
        open('bj_url_set.txt', 'w').close()
        while page <3:
            sel_list = self.driver.find_elements_by_xpath("//td[@class = 'td_even']/a")
            li = []
            for i in sel_list:
                name = i.get_attribute("title")
                if bool(pattern.search(name)) == False:
                    continue
                href = i.get_attribute("href")
                
                
                
                li.append(href)
                
            
            #with open("bj_url_set.txt","a+") as f:
                
                #f.write(repr(li))
                #f.write("\n")
            for url in li:
                print(url)
                #if url in url_set:
                    #continue
                #yield scrapy.Request(url, callback=self.parse_details)
            url_set |= set(li)
            try:
                page +=1
                next_element = self.driver.find_element_by_id("smart-paginator")
                
                next_page =next_element.find_element_by_link_text(str(page))
                next_page.click() #模拟点击下一页
                print("going_to_next_page")
                time.sleep(1)
                    
                
            except:
                self.driver.back()
                print("Retry going back")
                page -= 1
           
                       
        
        
               
        
    def parse_details(self,response):
        time.sleep(2)
        if response.status in self.handle_httpstatus_list:
            time.sleep(2)
            print("Retrying")
            yield scrapy.Request(response.url,callback=self.parse_details,dont_filter=True)
            return
        item = CaseItem()
        trs = response.xpath("//table[@class='table_list_03']/tr/td")
        item["INAME"] = trs[1].xpath("./text()").extract_first()
        
        try:
            item["AREA_NAME"] = re.findall(r"（(.+)）",item["INAME"])[0]
        except:
            item["AREA_NAME"] = item["INAME"][:2]
        item["CARDNUM"] = trs[4].xpath("./text()").extract_first()
        item["BUESINESSENTITY"] = trs[8].xpath("./text()").extract_first()
        item["GIST_CID"] = trs[20].xpath("./text()").extract_first()
        item["COURT_NAME"] = trs[22].xpath("./text()").extract_first()
        item["REG_DATE"] = trs[24].xpath("./text()").extract_first()
        item["DISREPUT_TYPE_NAME"] = trs[28].xpath("./text()").extract_first()
        
            
        
        
       
        
        yield item
            
           

            
                
    
