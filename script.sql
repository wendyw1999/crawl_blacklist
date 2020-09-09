/*delete from bad_website*/
create table bad_website(
  table_index integer,
  publish_date varchar(64),
  bad_url varchar2(400),
  bad_type varchar2(200),
  full_description varchar(400)
  )

/*delete from stock_peishou*/
create table stock_peishou(
row_index integer,
stock_number varchar(200),
iname varchar2(200),
start_date varchar2(64),
end_date varchar2(64))

/*select * from bad_website*/
/*select * from stock_peishou*/
