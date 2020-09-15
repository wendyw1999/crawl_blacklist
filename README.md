# crawl_blacklist
## 准备
- 需要下载dependencies pip install -r requirements.txt
- 如果没有下载所有的docx，并且需要在另一个机子下载，请参考：https://editor.csdn.net/md/?articleId=107414953 下载chrome driver
- 运行sql file。通过cmd进入文件路径，输入sqlplus并且登陆自己的用户名密码。输入@script.sql 并按回车键可创建所有表。
- 使用的是oracle-client，如果要用其他的db可进行修改
- notebook共有四个block，第一个是import所有的dependencies（初始化），第二个是下载网页上的文档（如果直接用GitHub的文件夹就不需要），第三个是所有的methods，第四个是main function。
- excel_urls.csv中，详细记录了需要爬取的网站url、发布机构、平台以及对应的db表单名。其中有五个无法识别的图片网站。
- type_dict 包含bad_website库需要的类别字典。

- sql语句中包括多个table的创建：
### bad_website:非法仿冒证券公司、证券投资咨询公司等
机构黑名单
- row_index:序号 integer
- stock_number:配售对象代码 varchar(200)
- iname:配售对象名称 varchar2(200)
- start_date 开始日期 varchar2(64)
- end_date: 结束日期 varchar2(64)


### stock_peishou:公开发行股票配售对象黑名单
- table_index: 序号 integer
- publish_date: 发现时间 varchar(64)
- bad_url:网站url varchar2(400)
- bad_type: 违规信息类别 varchar2(200)
- full_description: 非法仿冒机构网站、含有非法内容的网页、博客名称 varchar(400)

### NMG:拖欠农名工工资
和公司提供的字典相似，但是值得注意的是，其中LRRQ因为我的操作原因是varchar而不是date
XH  integer,
DXMC  VARCHAR2(200),
DXLB  VARCHAR2(50),
ZJLX  VARCHAR2(50),
ZJHM  VARCHAR2(50),
FRDB  VARCHAR2(50),
FRDBZJLX  VARCHAR2(50),
FRDBZJHM  VARCHAR2(200),
MDMC  VARCHAR2(200),
LYSY  VARCHAR2(500),
SJJE  VARCHAR(100),
_LRRQ  varchar2(100)_,
RDBM  VARCHAR2(100),
WSH VARCHAR2(100),
TCMDYY  VARCHAR2(100),
TCRQ  date,
XYPT_Q_DB_TIME_DXP  TIMESTAMP


### cwpzpt:非法从事场外配资平台名单
xh integer 序号,
pt_name varchar(200) 平台名称,
bad_url varchar2(200) 网址,
wx_app_name varchar(1000) 配资APP、微信公众号、小程序名称,
jg_name varchar(200) 运营机构名称,
area varchar(64) 运营机构注册地)

### zdwfwggdmd 银行保险机构重大违法违规股东名单
xh integer 序号,
iname varchar(200) 公司名称,
publish_date varchar2(200) 发布日期,
POST_BY VARCHAR2(64) 发布机构

### YHWGSQSFAL 银行违规涉企收费案例的通报
XH integer 序号,
INAME varchar2(200) 公司/银行名称,
REG_DATE varchar2(64) 案发日期,
FULL_DESCRIPTION VARCHAR2(1000) 具体情形,
FEE VARCHAR2(64) 多收取费用,
PUBLISH_DATE VARCHAR2(64) 发布日期,
POST_BY VARCHAR2(64) 发布机构

### rlzycxfw 全国人力资源诚信服务示范机构候选名单
XH integer 序号,
iname varchar(200) 公司名称,
from_date varchar(200) 公示日期起始日,
to_date varchar(200) 公示日期结束日

### aqcxhkgshxmd 2019年度安全诚信航运公司候选名单公示
XH integer 序号,
iname varchar(200) 公司名称,
in_out varchar(200) 进入/保持/推出名单,
publish_date varchar(200) 发布日期,
post_by varchar(200)) 发布机构;

### medicine_blacklist药品质量抽检不合格名单
type_name varchar(200) 药品通用名称,
medicine_size varchar(200) 包装规格,
product_name varchar(200) 标示生产企业名称,
batch_number varchar(200) 药品批号,
iname varchar(200) 被抽样单位名称,
gist_code varchar(200) 检验依据,
TEST_RESULT VARCHAR2(200) 检验结果,
REASON VARCHAR2(1000) 不合格检验项,
GIST_UNIT VARCHAR(200) 检验单位,
REMARK VARCHAR(1000) 备注,
PUBLISH_DATE VARCHAR(200) 发布日期,
POST_BY VARCHAR(200)) 发布机构 ;


### environment_blacklist 环评信用平台失信黑名单
xh integer 序号,
iname varchar2(200) 公司名称/姓名,
full_description varchar(1000) 具体情形,
card_type varchar2(64) 证件类型,
card_num varchar2(200) 证件号码,
REG_DATE varchar2(64) 列入黑名单日期,
PUBLISH_DATE varchar2(64) 发布日期,
POST_BY varchar2(200)) 发布机构;

### travel_blacklist 全国旅游市场黑名单的公告(
xh integer 序号,
iname varchar2(200) 姓名,
card_num varchar(200) 证件号码,
card_type varchar(200) 证件类型,
reason varchar(1000) 列入事由,
gist_cid varchar(500) 列入依据,
reg_date varchar(100) 列入日期,
to_date varchar(100)) 有效期至;






## 思路
- 对于部分图片网站，我使用了baidu api 表单识别功能，因为超过一定次数需要付费，我没有在notebook中包括具体的代码。请直接使用已经转换完毕的excel（在img_output_forms文件夹中）
- 对于所有数据都在docx附件，并需要下载的网站，通过爬取含有docx字样的<a> tag并获取href链接下载，如果不需要新下载，不用运行第二个block
- 对于全国旅游市场黑名单公告因为只有两条，且是图片类型，百度api识别失败，所以直接使用了SQL语句insert
- 其中 0，1，2，14-25 是同一类数据，13是一类数据（含有固定格式的表格的docx文件），其他的网页都需要特殊处理，属于hardcode（无法通用）。在第三个block中，基本上每一个function对应一个url

