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

create table YHWGSQSFAL/*����Υ�������շѰ�����ͨ��*/
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
('1','���','6101031986****1213','���֤','Υ�����л����񹲺͹����η�������ʮ����������ʮһ��������ʮ����֮�涨��Υ�����������������ڶ�ʮ����������ʮ����֮�涨���䵣����Ҫ�����˵������类����ҵ��Ӫ���֤��','�������Ļ��������ξ���������������(���÷���[2019]8��',
'2019-07-09','2022-07-08');

insert into travel_blacklist values
('2','������','5315211980****6168','���֤','Υ�����л����񹲺͹����η�������ʮһ��֮�涨��Υ�������ι���취���ڶ�ʮ����֮�涨,���� ������֤��','�������Ļ��������ξ���������������(���÷���[2019]9��',
'2019-07-09','2022-07-08');
