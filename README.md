# crawl_blacklist
## 准备
- 需要下载dependencies（selenium等）

- sql语句中包括两个table的创建：
### stock_peishou:公开发行股票配售对象黑名单
- table_index: 序号 integer
- publish_date: 发现时间 varchar(64)
- bad_url:网站url varchar2(400)
- bad_type: 违规信息类别 varchar2(200)
- full_description: 非法仿冒机构网站、含有非法内容的网页、博客名称 varchar(400)


### bad_website:非法仿冒证券公司、证券投资咨询公司等
机构黑名单
- row_index:序号 integer
- stock_number:配售对象代码 varchar(200)
- iname:配售对象名称 varchar2(200)
- start_date 开始日期 varchar2(64)
- end_date: 结束日期 varchar2(64)

## 思路
- 如果网页有docx下载链接，下载，并将其命名为index.docx，存放在docx文件夹路径下。
- 其中 0，1，2，14-25 是同一类数据，13是一类数据（含有固定格式的表格的docx文件），其他的网页都需要特殊处理（部分网页无法下载，部分网页是图片形式，可能无法抓取）
