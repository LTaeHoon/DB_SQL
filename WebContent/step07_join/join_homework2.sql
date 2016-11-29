-- sql_homework.sql

-- 고객 아이디를 위한 시퀀스 생성
create sequence seq_sid increment by 1 start with 1000;
-- 고객 정보 테이블
create table user_data(
user_id number primary key,
gender number(1) not null,
age number(3),
house_type number(1),
resident varchar(10),
job number(1)
);

insert into user_data values(seq_sid.nextval,1,35,1,'전북',6);
insert into user_data values(seq_sid.nextval,2,45,3,'경남',2);
insert into user_data values(seq_sid.nextval,1,55,3,'경기',6);
insert into user_data values(seq_sid.nextval,1,43,3,'대전',1);
insert into user_data values(seq_sid.nextval,2,55,4,'경기',2);
insert into user_data values(seq_sid.nextval,1,45,1,'대구',1);
insert into user_data values(seq_sid.nextval,2,39,4,'경남',1);
insert into user_data values(seq_sid.nextval,1,55,2,'경기',6);
insert into user_data values(seq_sid.nextval,1,33,4,'인천',3);
insert into user_data values(seq_sid.nextval,2,55,3,'서울',6);

select * from user_data;

drop table pay_data purge;
create table pay_data(
user_id number,
product_type number(1) not null,
pay_method varchar(10) not null,
price number,
foreign key (user_id) references user_data(user_id)
);


insert into pay_data values(1001,1,'1.현금',153000);
insert into pay_data values(1002,2,'2.직불카드',120000);
insert into pay_data values(1003,3,'3.신용카드',780000);
insert into pay_data values(1003,4,'3.신용카드',123000);
insert into pay_data values(1003,5,'1.현금',79000);
insert into pay_data values(1003,1,'3.신용카드',125000);
insert into pay_data values(1007,2,'2.직불카드',150000);
insert into pay_data values(1007,3,'4.상품권',78879);

select * from pay_data;
create table return_data(
user_id number,
return_code number(1),
foreign key (user_id) references user_data(user_id)
);

insert into return_data values(1003,1);
insert into return_data values(1003,4);
insert into return_data values(1007,1);
insert into return_data values(1009,2);

select * from return_data;



-- 문1) 고객정보와 지불정보 테이블을 inner join하여 다음과 같이 출력하시오.
-- 조건1) 고객ID, 성별, 연령, 거주유형, 거주지역, 직업유형, 상품유형, 지불방법, 구매금액 칼럼 출력
-- 조건2) 고객ID 오름차순 정렬
select a.user_id, a.gender, a.age, a.house_type, a.job, b.product_type, b.pay_method, b.price
from user_data a, pay_data b
where a.user_id = b.user_id
order by a.user_id;

-- 문2) 문1)의 결과에 성별이 '여자'이거나 지불방법이 '1.현금'인 경우만 출력하시오.
select a.user_id, a.gender, a.age, a.house_type, a.job, b.product_type, b.pay_method, b.price
from user_data a, pay_data b
where a.user_id = b.user_id
and (a.gender =2 or b.pay_method='1.현금')
order by a.user_id;


-- 문3) 고객정보와 지불정보 테이블을 left outer join하여 다음과 같이 출력하시오.
-- 조건1) 고객ID, 성별, 나이, 상품유형, 지불방법 칼럼 출력
select a.user_id, a.gender, a.age, b.product_type, b.pay_method from user_data a, pay_data b
where a.user_id = b.user_id(+);

-- 문4) 고객정보와 반품정보 테이블을 이용하여 left outer join하여 다음과 같이 출력하시오.
-- 조건1) 고객ID, 성별, 나이, 거주지역, 반품코드 칼럼 출력
-- 조건2) 반품한 고객만 출력
select a.user_id, a.gender, a.age, a.resident, b.return_code from user_data a, return_data b
where a.user_id = b.user_id(+)
and b.return_code is not null;

