# -*- coding: utf-8 -*-
import scrapy
import re
import time
from tutorial.items import CaseItem
from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait

class DmozSpider(scrapy.Spider):
    handle_httpstatus_list = [404]
    name = "shanghai"
    #allowed_domains = ["dmoz.org"]
    
    def __init__(self):
        self.page = 1
        self.start_urls = [
        "http://www.hshfy.sh.cn/shfy/gweb2017/channel_zx_list.jsp?pa=aemw9c3gPdcssz"
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
        while page < 4:
            sel_list = self.driver.find_elements_by_xpath("//div[@class = 'list_a']/ul/li/a")
            li = []
            for i in sel_list:
                name = i.text
                if bool(pattern.search(name)) == False:
                    continue
                href = i.get_attribute("href")
                
                
                
                li.append(href)
                print(href)
                
            
            #with open("bj_url_set.txt","a+") as f:
                
                #f.write(repr(li))
                #f.write("\n")
            for url in li:
                print(url)
                if url in url_set:
                    continue
                yield scrapy.Request(url, callback=self.parse_details)
            url_set |= set(li)
            try:
                page +=1
                to_click_page = page
                if page%10 == 1:
                    to_click_page = ">"
                    
                next_element = self.driver.find_element_by_class_name("meneame")
                
                next_page =next_element.find_element_by_link_text(str(to_click_page))
                next_page.click() #模拟点击下一页
                print("going_to_next_page")
                time.sleep(1)
                    
                
            except:
                self.driver.back()
                print("Retry going back")
                page -= 1
           
                       
        
        
               
        
    def parse_details(self,response):
        time.sleep(1)
        if response.status in self.handle_httpstatus_list:
            time.sleep(2)
            print("Retrying")
            yield scrapy.Request(response.url,callback=self.parse_details,dont_filter=True)
            return
        item = CaseItem()
        trs = response.xpath("//td[@class='tdnr']/text()").extract()
        trs = [i.replace(u'\xa0', u'') for i in trs]
        item["INAME"] = trs[1]
        item["CARDNUM"] = trs[3]
        item["BUESINESSENTITY"] = trs[5]
        item["DUTY"] = trs[7]
        item["PERFORMANCE"] = trs[9]
        item["DISREPUT_TYPE_NAME"] = trs[11]
        item["GIST_UNIT"] = trs[13]
        item["GIST_CID"] = trs[15]
        item["CASE_CODE"] = trs[17]
        item["REG_DATE"] = trs[19]
        item["COURT_NAME"] = trs[21]
        item["AREA_NAME"] = "上海"
        
        yield item
            
           

            
                
    
