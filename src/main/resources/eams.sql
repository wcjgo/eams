prompt PL/SQL Developer import file
prompt Created on 2021年6月5日 by Java
set feedback off
set define off
prompt Creating MEMBER...
create table MEMBER
(
  id       VARCHAR2(32) default SYS_GUID() not null,
  name     VARCHAR2(20),
  nickname VARCHAR2(20),
  phonenum VARCHAR2(20),
  email    VARCHAR2(20)
)
;
alter table MEMBER
  add primary key (ID);

prompt Creating PRODUCT...
create table PRODUCT
(
  id            VARCHAR2(32) default SYS_GUID() not null,
  productnum    VARCHAR2(50) not null,
  productname   VARCHAR2(50),
  cityname      VARCHAR2(50),
  departuretime TIMESTAMP(6),
  productprice  NUMBER,
  productdesc   VARCHAR2(500),
  productstatus INTEGER
)
;
alter table PRODUCT
  add primary key (ID);
alter table PRODUCT
  add constraint PRODUCT unique (ID, PRODUCTNUM);

prompt Creating ORDERS...
create table ORDERS
(
  id          VARCHAR2(32) default SYS_GUID() not null,
  ordernum    VARCHAR2(20) not null,
  ordertime   TIMESTAMP(6),
  peoplecount INTEGER,
  orderdesc   VARCHAR2(500),
  paytype     INTEGER,
  orderstatus INTEGER,
  productid   VARCHAR2(32),
  memberid    VARCHAR2(32)
)
;
alter table ORDERS
  add primary key (ID);
alter table ORDERS
  add unique (ORDERNUM);
alter table ORDERS
  add foreign key (PRODUCTID)
  references PRODUCT (ID);
alter table ORDERS
  add foreign key (MEMBERID)
  references MEMBER (ID);

prompt Creating TRAVELLER...
create table TRAVELLER
(
  id              VARCHAR2(32) default SYS_GUID() not null,
  name            VARCHAR2(20),
  sex             VARCHAR2(20),
  phonenum        VARCHAR2(20),
  credentialstype INTEGER,
  credentialsnum  VARCHAR2(50),
  travellertype   INTEGER
)
;
alter table TRAVELLER
  add primary key (ID);

prompt Creating ORDER_TRAVELLER...
create table ORDER_TRAVELLER
(
  orderid     VARCHAR2(32) not null,
  travellerid VARCHAR2(32) not null
)
;
alter table ORDER_TRAVELLER
  add primary key (ORDERID, TRAVELLERID);
alter table ORDER_TRAVELLER
  add foreign key (ORDERID)
  references ORDERS (ID);
alter table ORDER_TRAVELLER
  add foreign key (TRAVELLERID)
  references TRAVELLER (ID);

prompt Creating PERMISSION...
create table PERMISSION
(
  id             VARCHAR2(32) default SYS_GUID() not null,
  permissionname VARCHAR2(50),
  url            VARCHAR2(50)
)
;
alter table PERMISSION
  add primary key (ID);

prompt Creating ROLE...
create table ROLE
(
  id       VARCHAR2(32) default SYS_GUID() not null,
  rolename VARCHAR2(50),
  roledesc VARCHAR2(50)
)
;
alter table ROLE
  add primary key (ID);

prompt Creating ROLE_PERMISSION...
create table ROLE_PERMISSION
(
  permissionid VARCHAR2(32) not null,
  roleid       VARCHAR2(32) not null
)
;
alter table ROLE_PERMISSION
  add primary key (PERMISSIONID, ROLEID);
alter table ROLE_PERMISSION
  add foreign key (PERMISSIONID)
  references PERMISSION (ID);
alter table ROLE_PERMISSION
  add foreign key (ROLEID)
  references ROLE (ID);

prompt Creating SYSLOG...
create table SYSLOG
(
  id            VARCHAR2(32) default SYS_GUID() not null,
  visittime     TIMESTAMP(6),
  username      VARCHAR2(50),
  ip            VARCHAR2(30),
  url           VARCHAR2(50),
  executiontime INTEGER,
  method        VARCHAR2(200)
)
;
alter table SYSLOG
  add primary key (ID);

prompt Creating USERS...
create table USERS
(
  id       VARCHAR2(32) default SYS_GUID() not null,
  email    VARCHAR2(50) not null,
  username VARCHAR2(50),
  password VARCHAR2(70),
  phonenum VARCHAR2(20),
  status   INTEGER
)
;
alter table USERS
  add primary key (ID);
alter table USERS
  add unique (EMAIL);

prompt Creating USERS_ROLE...
create table USERS_ROLE
(
  userid VARCHAR2(32) not null,
  roleid VARCHAR2(32) not null
)
;
alter table USERS_ROLE
  add primary key (USERID, ROLEID);
alter table USERS_ROLE
  add foreign key (USERID)
  references USERS (ID);
alter table USERS_ROLE
  add foreign key (ROLEID)
  references ROLE (ID);

prompt Loading MEMBER...
insert into MEMBER (id, name, nickname, phonenum, email)
values ('E61D65F673D54F68B0861025C69773DB', '张三', '小三', '18888888888', 'zs@163.com');
commit;
prompt 1 records loaded
prompt Loading PRODUCT...
insert into PRODUCT (id, productnum, productname, cityname, departuretime, productprice, productdesc, productstatus)
values ('676C5BD1D35E429A8C2E114939C5685A', 'itcast-002', '北京三日游', '北京', to_timestamp('10-10-2018 10:10:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1200, '不错的旅行', 1);
insert into PRODUCT (id, productnum, productname, cityname, departuretime, productprice, productdesc, productstatus)
values ('12B7ABF2A4C544568B0A7C69F36BF8B7', 'itcast-003', '上海五日游', '上海', to_timestamp('25-04-2018 14:30:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1800, '魔都我来了', 0);
insert into PRODUCT (id, productnum, productname, cityname, departuretime, productprice, productdesc, productstatus)
values ('9F71F01CB448476DAFB309AA6DF9497F', 'itcast-001', '北京三日游', '北京', to_timestamp('10-10-2018 10:10:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1200, '不错的旅行', 1);
commit;
prompt 3 records loaded
prompt Loading ORDERS...
insert into ORDERS (id, ordernum, ordertime, peoplecount, orderdesc, paytype, orderstatus, productid, memberid)
values ('0E7231DC797C486290E8713CA3C6ECCC', '12345', to_timestamp('02-03-2018 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 2, '没什么', 0, 1, '676C5BD1D35E429A8C2E114939C5685A', 'E61D65F673D54F68B0861025C69773DB');
insert into ORDERS (id, ordernum, ordertime, peoplecount, orderdesc, paytype, orderstatus, productid, memberid)
values ('5DC6A48DD4E94592AE904930EA866AFA', '54321', to_timestamp('02-03-2018 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 2, '没什么', 0, 1, '676C5BD1D35E429A8C2E114939C5685A', 'E61D65F673D54F68B0861025C69773DB');
insert into ORDERS (id, ordernum, ordertime, peoplecount, orderdesc, paytype, orderstatus, productid, memberid)
values ('2FF351C4AC744E2092DCF08CFD314420', '67890', to_timestamp('02-03-2018 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 2, '没什么', 0, 1, '12B7ABF2A4C544568B0A7C69F36BF8B7', 'E61D65F673D54F68B0861025C69773DB');
insert into ORDERS (id, ordernum, ordertime, peoplecount, orderdesc, paytype, orderstatus, productid, memberid)
values ('A0657832D93E4B10AE88A2D4B70B1A28', '98765', to_timestamp('02-03-2018 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 2, '没什么', 0, 1, '12B7ABF2A4C544568B0A7C69F36BF8B7', 'E61D65F673D54F68B0861025C69773DB');
insert into ORDERS (id, ordernum, ordertime, peoplecount, orderdesc, paytype, orderstatus, productid, memberid)
values ('E4DD4C45EED84870ABA83574A801083E', '11111', to_timestamp('02-03-2018 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 2, '没什么', 0, 1, '12B7ABF2A4C544568B0A7C69F36BF8B7', 'E61D65F673D54F68B0861025C69773DB');
insert into ORDERS (id, ordernum, ordertime, peoplecount, orderdesc, paytype, orderstatus, productid, memberid)
values ('96CC8BD43C734CC2ACBFF09501B4DD5D', '22222', to_timestamp('02-03-2018 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 2, '没什么', 0, 1, '12B7ABF2A4C544568B0A7C69F36BF8B7', 'E61D65F673D54F68B0861025C69773DB');
insert into ORDERS (id, ordernum, ordertime, peoplecount, orderdesc, paytype, orderstatus, productid, memberid)
values ('55F9AF582D5A4DB28FB4EC3199385762', '33333', to_timestamp('02-03-2018 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 2, '没什么', 0, 1, '9F71F01CB448476DAFB309AA6DF9497F', 'E61D65F673D54F68B0861025C69773DB');
insert into ORDERS (id, ordernum, ordertime, peoplecount, orderdesc, paytype, orderstatus, productid, memberid)
values ('CA005CF1BE3C4EF68F88ABC7DF30E976', '44444', to_timestamp('02-03-2018 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 2, '没什么', 0, 1, '9F71F01CB448476DAFB309AA6DF9497F', 'E61D65F673D54F68B0861025C69773DB');
insert into ORDERS (id, ordernum, ordertime, peoplecount, orderdesc, paytype, orderstatus, productid, memberid)
values ('3081770BC3984EF092D9E99760FDABDE', '55555', to_timestamp('02-03-2018 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 2, '没什么', 0, 1, '9F71F01CB448476DAFB309AA6DF9497F', 'E61D65F673D54F68B0861025C69773DB');
commit;
prompt 9 records loaded
prompt Loading TRAVELLER...
insert into TRAVELLER (id, name, sex, phonenum, credentialstype, credentialsnum, travellertype)
values ('3FE27DF2A4E44A6DBC5D0FE4651D3D3E', '张龙', '男', '13333333333', 0, '123456789009876543', 0);
insert into TRAVELLER (id, name, sex, phonenum, credentialstype, credentialsnum, travellertype)
values ('EE7A71FB6945483FBF91543DBE851960', '张小龙', '男', '15555555555', 0, '987654321123456789', 1);
commit;
prompt 2 records loaded
prompt Loading ORDER_TRAVELLER...
insert into ORDER_TRAVELLER (orderid, travellerid)
values ('0E7231DC797C486290E8713CA3C6ECCC', '3FE27DF2A4E44A6DBC5D0FE4651D3D3E');
insert into ORDER_TRAVELLER (orderid, travellerid)
values ('2FF351C4AC744E2092DCF08CFD314420', '3FE27DF2A4E44A6DBC5D0FE4651D3D3E');
insert into ORDER_TRAVELLER (orderid, travellerid)
values ('3081770BC3984EF092D9E99760FDABDE', 'EE7A71FB6945483FBF91543DBE851960');
insert into ORDER_TRAVELLER (orderid, travellerid)
values ('55F9AF582D5A4DB28FB4EC3199385762', 'EE7A71FB6945483FBF91543DBE851960');
insert into ORDER_TRAVELLER (orderid, travellerid)
values ('5DC6A48DD4E94592AE904930EA866AFA', '3FE27DF2A4E44A6DBC5D0FE4651D3D3E');
insert into ORDER_TRAVELLER (orderid, travellerid)
values ('96CC8BD43C734CC2ACBFF09501B4DD5D', 'EE7A71FB6945483FBF91543DBE851960');
insert into ORDER_TRAVELLER (orderid, travellerid)
values ('A0657832D93E4B10AE88A2D4B70B1A28', '3FE27DF2A4E44A6DBC5D0FE4651D3D3E');
insert into ORDER_TRAVELLER (orderid, travellerid)
values ('CA005CF1BE3C4EF68F88ABC7DF30E976', 'EE7A71FB6945483FBF91543DBE851960');
insert into ORDER_TRAVELLER (orderid, travellerid)
values ('E4DD4C45EED84870ABA83574A801083E', 'EE7A71FB6945483FBF91543DBE851960');
commit;
prompt 9 records loaded
prompt Loading PERMISSION...
insert into PERMISSION (id, permissionname, url)
values ('36170A89A5CA4FF0A6F37D6A899965C1', 'user findAll', '/user/findAll.do');
insert into PERMISSION (id, permissionname, url)
values ('58E239BEFEAC4D8586E71D8F6D75D3E8', 'user findById', '/user/findById.do');
commit;
prompt 2 records loaded
prompt Loading ROLE...
insert into ROLE (id, rolename, roledesc)
values ('4865D27B499F4C9AA05BA3BB2EDE92C6', 'ADMIN', '管理员');
insert into ROLE (id, rolename, roledesc)
values ('681417CD56DE4BBE8A7450616A33375B', 'USER', '普通用户');
insert into ROLE (id, rolename, roledesc)
values ('7F3C3BD35A614D9C877988CADC8879DD', 'ROOT', '超级管理员');
commit;
prompt 3 records loaded
prompt Loading ROLE_PERMISSION...
insert into ROLE_PERMISSION (permissionid, roleid)
values ('36170A89A5CA4FF0A6F37D6A899965C1', '4865D27B499F4C9AA05BA3BB2EDE92C6');
insert into ROLE_PERMISSION (permissionid, roleid)
values ('36170A89A5CA4FF0A6F37D6A899965C1', '681417CD56DE4BBE8A7450616A33375B');
insert into ROLE_PERMISSION (permissionid, roleid)
values ('58E239BEFEAC4D8586E71D8F6D75D3E8', '681417CD56DE4BBE8A7450616A33375B');
commit;
prompt 3 records loaded
prompt Loading SYSLOG...
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('86A51298312D4247B863B8CC516115D3', to_timestamp('25-04-2021 23:16:54.003000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj', '0:0:0:0:0:0:0:1', '/role/findAll.do', 27, '[类名] cn.neu.ssm.controller.RoleController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('DEDACEC0139946FEA25C6E7B187DD37B', to_timestamp('25-04-2021 23:17:03.452000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj', '0:0:0:0:0:0:0:1', '/permission/findAll.do', 9, '[类名] cn.neu.ssm.controller.PermissionController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('5A934776007A434883990341D36CDF82', to_timestamp('25-04-2021 23:17:06.610000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj', '0:0:0:0:0:0:0:1', '/sysLog/findAll.do', 11, '[类名] cn.neu.ssm.controller.SysLogController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('C0819FD8C24C482E9307AE8898328EE0', to_timestamp('25-04-2021 23:17:17.468000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj', '0:0:0:0:0:0:0:1', '/sysLog/findAll.do', 2, '[类名] cn.neu.ssm.controller.SysLogController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('12C2896332324BF58E9096BF33AA4106', to_timestamp('25-04-2021 23:17:20.829000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj', '0:0:0:0:0:0:0:1', '/sysLog/findAll.do', 4, '[类名] cn.neu.ssm.controller.SysLogController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('BE207F74ADC1460DBA82DDDC8583BAEF', to_timestamp('25-04-2021 23:17:25.841000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj', '0:0:0:0:0:0:0:1', '/sysLog/findAll.do', 4, '[类名] cn.neu.ssm.controller.SysLogController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('CBEE09F1A647475BB16397B517C6892C', to_timestamp('25-04-2021 23:17:57.705000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj', '0:0:0:0:0:0:0:1', '/role/findAll.do', 3, '[类名] cn.neu.ssm.controller.RoleController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('EEB2074BB8C845D5B5CE3D3CE024C2C9', to_timestamp('25-04-2021 23:18:15.169000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj', '0:0:0:0:0:0:0:1', '/permission/findAll.do', 2, '[类名] cn.neu.ssm.controller.PermissionController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('4CCE1E73F4A74F4EBA3B4E6610169C93', to_timestamp('25-04-2021 23:18:25.414000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj', '0:0:0:0:0:0:0:1', '/sysLog/findAll.do', 4, '[类名] cn.neu.ssm.controller.SysLogController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('88409E891119444A8F7B7FEE7E561FB1', to_timestamp('26-04-2021 14:57:23.289000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/user/findAll.do', 9, '[类名] cn.neu.ssm.controller.UserController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('D2AA52CF1D31416DB6D958F6EE706C66', to_timestamp('26-04-2021 14:57:28.312000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/role/findAll.do', 8, '[类名] cn.neu.ssm.controller.RoleController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('DC285E8D18364104A1D1A920BAAC6B8C', to_timestamp('26-04-2021 14:57:36.915000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/permission/findAll.do', 6, '[类名] cn.neu.ssm.controller.PermissionController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('C86935ADB97D4D69B7C3665C269A3B47', to_timestamp('26-04-2021 14:57:44.087000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/permission/findAll.do', 5, '[类名] cn.neu.ssm.controller.PermissionController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('349433CC6C55445FAC62BD26C57F7667', to_timestamp('26-04-2021 14:57:48.142000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/permission/findAll.do', 2, '[类名] cn.neu.ssm.controller.PermissionController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('D9E74C5EEE234AB1AE5B46A669E34C01', to_timestamp('26-04-2021 14:58:02.861000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/user/findAll.do', 2, '[类名] cn.neu.ssm.controller.UserController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('9CA18A459DF2466DA0FE4C345E39C959', to_timestamp('26-04-2021 14:59:27.936000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/sysLog/findAll.do', 30, '[类名] cn.neu.ssm.controller.SysLogController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('F4295C082AC7414BA3D6E4A7641BE3D7', to_timestamp('26-04-2021 14:59:52.384000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 62, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('89728EB4249343F29214D28F55AF4457', to_timestamp('26-04-2021 14:59:52.464000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 6, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('D256A0E2FA2E4FC49ECB38ED0DCFAE6F', to_timestamp('26-04-2021 14:59:55.659000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 5, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('EC630F0DBE0645C984F2CA84AAC49FA9', to_timestamp('26-04-2021 14:59:59.667000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 7, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('4B9D161D304A4B258D3C50DC7918071B', to_timestamp('26-04-2021 15:00:01.290000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 4, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('69A5A9CC526D4123943405EB49BC9931', to_timestamp('26-04-2021 15:00:02.321000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 6, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('1E0D25F929F940FCAE03BB35C39B2764', to_timestamp('26-04-2021 15:00:03.870000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 6, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('82F2AA8649FD472181A28C19324F1B7B', to_timestamp('26-04-2021 15:01:01.866000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 5, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('7A5D442C235449188AE08430C61BDA7C', to_timestamp('26-04-2021 15:01:07.483000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 5, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('4384A290F8D343D5A6F64A5748AC9872', to_timestamp('26-04-2021 15:01:12.987000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 4, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('B835AF44424C4D84A1B358D5DA0DDDF4', to_timestamp('26-04-2021 15:01:18.773000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 3, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('047E0713705749F0869F8A9CE31034D2', to_timestamp('26-04-2021 15:01:26.190000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 4, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('FD8488DBD3514C9CBB2E5DCEA8B1CFDB', to_timestamp('26-04-2021 15:01:32.135000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 3, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('9051E060C1324AC18ED45258064E98D3', to_timestamp('26-04-2021 15:01:33.333000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 3, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('70A4278CD4C04E69927C19D12EB21850', to_timestamp('26-04-2021 15:01:37.847000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 3, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('E14EC5B91A8E4D4CB429BDFF0E52A90D', to_timestamp('26-04-2021 15:01:38.954000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 4, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('042D6E89028F424CB97C9D7268171955', to_timestamp('26-04-2021 15:01:40.236000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 3, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('7165DCD883A546A9A868E8B1FEBFCDA8', to_timestamp('26-04-2021 15:01:41.232000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 3, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('89C3BD9FB194464FA4C602B5ADAA2E48', to_timestamp('26-04-2021 15:01:44.319000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 4, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('80950E676F93432BB28D0CFB9928E3CF', to_timestamp('26-04-2021 15:01:45.473000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 3, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('356C99C32819436A8ECE5CC966B309F4', to_timestamp('26-04-2021 15:01:46.533000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 3, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('3E4DB65D3650419394B499532AD6982F', to_timestamp('26-04-2021 15:01:48.369000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 3, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('237FE3E6877B4974AD1A1B57691BD96C', to_timestamp('26-04-2021 15:01:49.792000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 4, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('DDC95991EA6543388BD8E1B002F0B8C7', to_timestamp('26-04-2021 15:01:50.791000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 4, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('60FDE6A6E62D4B3D93FBFB148CD85798', to_timestamp('26-04-2021 15:01:52.007000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 3, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('5C22488D854A4A44B96902518E78F14D', to_timestamp('26-04-2021 15:01:52.746000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 3, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('E6C194AD38E8452185801B3C47D77826', to_timestamp('26-04-2021 15:01:53.310000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 4, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('24E37CDD2CB84CABAC0FE2DCC504D652', to_timestamp('26-04-2021 15:01:53.792000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 3, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('B1810F86BCCA4533AAF9ECF7F84B8B0A', to_timestamp('26-04-2021 15:01:54.215000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 3, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('6EC88E7BF839423890FDC41DC75E5C4D', to_timestamp('26-04-2021 15:01:54.747000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 3, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('43A2BB2DE7994859BD3A134D11A5BE03', to_timestamp('26-04-2021 15:01:55.275000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 4, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('6C4E53CF39B3456A9D56D1035CC73FA3', to_timestamp('26-04-2021 15:01:55.832000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 2, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('C102A59418B54AB5BDDB853FE6EBB2F1', to_timestamp('26-04-2021 15:01:56.518000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 3, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('AE61DBE4EB2043A2B49A0F2B7622D7E8', to_timestamp('26-04-2021 15:01:57.002000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 3, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('C11D7113FF2D427192EC94CACD35AD44', to_timestamp('26-04-2021 15:01:57.502000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 3, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('340C55F8B267411F8A81485772141B63', to_timestamp('26-04-2021 15:02:14.716000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 4, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('9EBF451E72104D8DAC54B24B5BA9D7A1', to_timestamp('26-04-2021 15:02:16.723000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 4, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('60EE3FBE26F344D5B55D3CB7C90C58F0', to_timestamp('26-04-2021 15:02:18.623000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 3, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('20AE73F0F85F4B719FCEA2CC4DAC7CD9', to_timestamp('26-04-2021 15:02:23.108000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 3, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('CBF83B02EACB4502852EBB13369DAE66', to_timestamp('26-04-2021 15:03:13.842000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 3, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('235A0C9591504D28ABD73973C24ABB8B', to_timestamp('26-04-2021 15:03:16.680000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 4, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('6FD80269EBB64AD0A60E0882AD3A10DA', to_timestamp('26-04-2021 15:03:41.713000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/orders/findAll.do', 16, '[类名] cn.neu.ssm.controller.OrdersController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('DC4B82E2B4F94E48AAAD2CF387054ABF', to_timestamp('26-04-2021 15:03:49.663000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 3, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('85C15394C78A42ACAD853E257853ACBB', to_timestamp('26-04-2021 15:04:45.341000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 6, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('8CB203DBDDE541AABCB4C5045B9CED01', to_timestamp('26-04-2021 15:11:58.619000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/user/findAll.do', 9, '[类名] cn.neu.ssm.controller.UserController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('C289980F51044BF3A86D17A7A036AB44', to_timestamp('26-04-2021 15:16:20.737000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/role/findAll.do', 13, '[类名] cn.neu.ssm.controller.RoleController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('B85D3EA854A9447BBF0B8621C56F0B05', to_timestamp('26-04-2021 15:18:33.190000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/permission/findAll.do', 7, '[类名] cn.neu.ssm.controller.PermissionController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('1B5DA0125C2247C38F8AC0033F5FD2CD', to_timestamp('26-04-2021 15:18:43.383000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/sysLog/findAll.do', 15, '[类名] cn.neu.ssm.controller.SysLogController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('668E8A9D2DE34DD5862FA66DB50537EB', to_timestamp('26-04-2021 14:31:03.146000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj', '0:0:0:0:0:0:0:1', '/role/findAll.do', 22, '[类名] cn.neu.ssm.controller.RoleController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('838351AAF6D94308B7995B440398B806', to_timestamp('26-04-2021 14:31:06.073000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj', '0:0:0:0:0:0:0:1', '/role/findAll.do', 2, '[类名] cn.neu.ssm.controller.RoleController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('E531536F584D4E488671B70DE2C2C11D', to_timestamp('26-04-2021 14:31:07.823000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj', '0:0:0:0:0:0:0:1', '/permission/findAll.do', 8, '[类名] cn.neu.ssm.controller.PermissionController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('3E5C2F8E78EF4ED48000EA54473A42EE', to_timestamp('26-04-2021 14:32:23.294000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/user/findAll.do', 15, '[类名] cn.neu.ssm.controller.UserController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('D7395BA1E6C74857A6954429CF906BD6', to_timestamp('26-04-2021 14:32:25.765000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 70, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('5C35D7C86CE24EE58B4AFD1935912C57', to_timestamp('26-04-2021 14:32:35.581000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/orders/findAll.do', 22, '[类名] cn.neu.ssm.controller.OrdersController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('E7FE3054D9A940B6AC5F30C06647D7F5', to_timestamp('26-04-2021 14:33:12.152000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 4, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('F995117FC2B6400C89024A3EE1FA7E4B', to_timestamp('26-04-2021 14:33:13.885000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 4, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('1088016F41B4491F8500C0D61F2001FB', to_timestamp('26-04-2021 14:33:23.429000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/product/findAll.do', 4, '[类名] cn.neu.ssm.controller.ProductController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('A3F5015CEB8A4652B991C64C9B0C8137', to_timestamp('26-04-2021 14:33:32.405000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/orders/findAll.do', 5, '[类名] cn.neu.ssm.controller.OrdersController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('E5E6FF62400147B6ABE9DF025EF11055', to_timestamp('26-04-2021 14:37:18.405000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/orders/findAll.do', 4, '[类名] cn.neu.ssm.controller.OrdersController[方法名] findAll');
insert into SYSLOG (id, visittime, username, ip, url, executiontime, method)
values ('8D739C4BE3DF46A39212DFCD2BE5E38E', to_timestamp('26-04-2021 14:37:27.653000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'wcj2', '0:0:0:0:0:0:0:1', '/orders/findAll.do', 4, '[类名] cn.neu.ssm.controller.OrdersController[方法名] findAll');
commit;
prompt 76 records loaded
prompt Loading USERS...
insert into USERS (id, email, username, password, phonenum, status)
values ('F3E910E7E2C94E4EB44A1A6D99834333', '10001@qq.com', 'wcj', '$2a$10$jo3H6zd3Sa2KSqBUJeP5PO52WC8CRkl3S0N30L0mHHziRD0kqCiYq', '18811112222', 1);
insert into USERS (id, email, username, password, phonenum, status)
values ('80E7B0C3370A4B44A8DF5AAE6434E23B', '10051@qq.com', 'wcj2', '$2a$10$j31VTPxELRbDumFUjFpxY.RyAIe6aLLZclNBu969qRP1AS43Huztq', '18811113322', 1);
insert into USERS (id, email, username, password, phonenum, status)
values ('8DC772F01C644F9CA7C287F6682E8147', '10066@qq.com', 'wcj88', '$2a$10$ZxKfz2Z00/bfiVNiU1nUwu5TfS/DRzBCIfCokQBaI9stpq7l./He6', '18811118822', 1);
insert into USERS (id, email, username, password, phonenum, status)
values ('0B1D6CECA0F84FC98815AB062F5F3318', '18801@qq.com', 'wcj66', '$2a$10$CZ2fCV36wyNtV.wx3RInEOE4XHU4h7GFrcBnWyGaRYhkQNxH3fjMu', '18811177222', 1);
commit;
prompt 4 records loaded
prompt Loading USERS_ROLE...
insert into USERS_ROLE (userid, roleid)
values ('0B1D6CECA0F84FC98815AB062F5F3318', '681417CD56DE4BBE8A7450616A33375B');
insert into USERS_ROLE (userid, roleid)
values ('80E7B0C3370A4B44A8DF5AAE6434E23B', '4865D27B499F4C9AA05BA3BB2EDE92C6');
insert into USERS_ROLE (userid, roleid)
values ('80E7B0C3370A4B44A8DF5AAE6434E23B', '7F3C3BD35A614D9C877988CADC8879DD');
insert into USERS_ROLE (userid, roleid)
values ('8DC772F01C644F9CA7C287F6682E8147', '4865D27B499F4C9AA05BA3BB2EDE92C6');
insert into USERS_ROLE (userid, roleid)
values ('F3E910E7E2C94E4EB44A1A6D99834333', '681417CD56DE4BBE8A7450616A33375B');
commit;
prompt 5 records loaded
set feedback on
set define on
prompt Done.
