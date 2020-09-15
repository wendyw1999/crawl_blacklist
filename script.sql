/*drop table bad_website;
drop table NMG;
drop table stock_peishou;
drop table cwpzpt;
DROP TABLE zdwfwggdmd;
DROP TABLE YHWGSQSFAL;
drop table rlzycxfw;
drop table aqcxhkgshxmd;
DROP TABLE MEDICINE_BLACKLIST;
drop table environment_blacklist;
drop table travel_blacklist;*/


create table bad_website(
  table_index integer,
  publish_date varchar(64),
  bad_type varchar2(500),
  full_description varchar(400)
  );

create table stock_peishou(
row_index integer,
stock_number varchar(200),
iname varchar2(200),
start_date varchar2(64),
end_date varchar2(64));


create table NMG(
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
LRRQ  varchar2(100),
RDBM  VARCHAR2(100),
WSH VARCHAR2(100),
TCMDYY  VARCHAR2(100),
TCRQ  date,
XYPT_Q_DB_TIME_DXP  TIMESTAMP

);

create table cwpzpt(
xh integer,
pt_name varchar(200),
bad_url varchar2(200),
wx_app_name varchar(1000),
jg_name varchar(200),
area varchar(64));

create table zdwfwggdmd(
xh integer,
iname varchar(200),
publish_date varchar2(200),
POST_BY VARCHAR2(64));

create table YHWGSQSFAL/*银行违规涉企收费案例的通报*/
(
XH integer,
INAME varchar2(200),
REG_DATE varchar2(64),
FULL_DESCRIPTION VARCHAR2(1000),
FEE VARCHAR2(64),
PUBLISH_DATE VARCHAR2(64),
POST_BY VARCHAR2(64));


create table rlzycxfw(
XH integer,
iname varchar(200),
publish_date varchar(200),
post_by varchar(200));


create table aqcxhkgshxmd(
XH integer,
iname varchar(200),
in_out varchar(200),
publish_date varchar(200),
post_by varchar(200));




create table medicine_blacklist(
type_name varchar(200),
medicine_size varchar(200),
product_name varchar(200),
batch_number varchar(200),
iname varchar(200),
gist_code varchar(200),
TEST_RESULT VARCHAR2(200),
REASON VARCHAR2(1000),
GIST_UNIT VARCHAR(200),
REMARK VARCHAR(1000),
PUBLISH_DATE VARCHAR(200),
POST_BY VARCHAR(200));



create table environment_blacklist(
xh integer,
iname varchar2(200),
full_description varchar(1000),
card_type varchar2(64),
card_num varchar2(200),
REG_DATE varchar2(64),
PUBLISH_DATE varchar2(64),
POST_BY varchar2(200));



create table travel_blacklist(
xh integer,
iname varchar2(200),
card_num varchar(200),
card_type varchar(200),
reason varchar(1000),
gist_cid varchar(500),
reg_date varchar(100),
to_date varchar(100));

insert into travel_blacklist values
('1','冯辉','6101031986****1213','身份证','违反《中华人民共和国旅游法》第三十五条、第四十一条、第五十七条之规定；违反《旅行社条例》第二十八条、第三十三条之规定，其担任主要负责人的旅行社被吊销业务经营许可证。','桂林市文化广电和旅游局行政处罚决定书(市旅罚字[2019]8号',
'2019-07-09','2022-07-08');

insert into travel_blacklist values
('2','赵媛媛','5315211980****6168','身份证','违反《中华人民共和国旅游法》第四十一条之规定；违反《导游管理办法》第二十三条之规定,被吊 销导游证。','桂林市文化广电和旅游局行政处罚决定书(市旅罚字[2019]9号',
'2019-07-09','2022-07-08');
