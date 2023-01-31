show tables;

/* 음식 분류 */
create table categoryStore (
	categoryStoreCode char(1) not null,			/* 대분류코드(A,B,C) 영문 대문자 1자 */
	storePart varchar(20) not null,		/* 대분류명(회사명 : 삼성/LG/현대) 영문 대문자 1자 */
	categoryPhoto varchar(100) not null,
	primary key(categoryStoreCode),
	unique key(storePart)
);

insert into categoryStore values ('A','치킨','noimages.jpg');
insert into categoryStore values ('B','피자','noimages.jpg');
insert into categoryStore values ('C','중식','noimages.jpg');
insert into categoryStore values ('D','패스트푸드','noimages.jpg');
insert into categoryStore values ('E','족발/보쌈','noimages.jpg');
insert into categoryStore values ('F','양식','noimages.jpg');
insert into categoryStore values ('G','일식','noimages.jpg');
insert into categoryStore values ('H','분식','noimages.jpg');
insert into categoryStore values ('I','카페','noimages.jpg');

select * from categoryStore;

create table store (
	idx int not null auto_increment, 	  	/* 회원 고유번호 */
	storeName varchar(30) not null,       /* 가게 이름(중복불허) */
	storePart varchar(20) not null,       /* 가게 분류 */
	storeNumber varchar(15) not null,     /* 가게 전화번호 */
	storeMid varchar(20) not null,        /* 사장님 아이디(중복불허) */
	storePwd varchar(100) not null,       /* 비밀번호(암호화 처리) */
	HostName varchar(20) not null,      	/* 사장님 성명 */
	storeAddress varchar(100) not null,   	/* 회원주소 (상품 배달시 기본주소로 사용) */
	logoPhoto varchar(100) not null,   		/* 가게 로고 사진 */
	storeEmail varchar(50) not null,			/* 이메일(아이디/비밀번호 분실시 사용) - 형식체크필수 */
	storeLatitude double not null, 				/* 위도 */
	storeLongitude double not null,				/* 경도 */
	storeDel varchar(5) not null default 'NO',	/* 삭제요청 */
	foreign key(storePart) references categoryStore(storePart),
	primary key(idx,storeMid)           	/* 주키: idx(고유번호), mid(아이디) */
);


select * from store;

desc store;

drop table categoryStore;
drop table store;
--delete from store where idx=19;


alter table member add level int default 0;

insert into member values (default, 'haetom12', '1454', '해찬들','천해찬', default, default, '010-5718-5014', '세종특별자치시', 'haetom@naver.com', 'https://www.naver.com', '학생', '볼링/게임', default, '관리자입니다.', default,default,default,4,default,default,default,default );

