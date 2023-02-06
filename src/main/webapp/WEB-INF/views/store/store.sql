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
desc categoryStore;

create table store (
	idx int not null auto_increment, 	  	/* 가게 고유번호 */
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
	storeTime varchar(50) not null,	/* 삭제요청 */
	rateAvg double not null default 0.0,	/* 삭제요청 */
	foreign key(storePart) references categoryStore(storePart),
	primary key(idx,storeMid)           	/* 주키: idx(고유번호), mid(아이디) */
);

ALTER TABLE store ADD rateAvg double not null default 0.0;

select * from store;

desc store;

drop table categoryStore;
drop table store;
--delete from store where idx=19;
insert into member values (default, 'haetom12', '1454', '해찬들','천해찬', default, default, '010-5718-5014', '세종특별자치시', 'haetom@naver.com', 'https://www.naver.com', '학생', '볼링/게임', default, '관리자입니다.', default,default,default,4,default,default,default,default );

/* 가게 리뷰/평점 */
create table rating (
	idx int not null auto_increment,						/* 평점 고유번호 */
	storeIdx int not null,											/* 가게 고유번호 */
	rating int not null,												/* 평점 */
	rateComment text not null, 									/* 평점 내용 */
	reportRating int not null default 0,				/* 신고횟수 */
	foreign key(storeIdx) references store(idx),
	primary key(idx)     
);

insert into rating values (default, 5, 2, "마싯어요", 0);

--drop table rating;

--alter table member add level int default 0;
--ALTER TABLE store DROP COLUMN rateAvg;

select s.*, round(AVG(r.rating),1) as rateAvg from store s, rating 
r where s.idx = r.storeIdx and s.storePart = '치킨';
select s.*, round(AVG(r.rating),1) as rateAvg from store s, rating r where s.idx = r.storeIdx and s.storePart = '치킨' group by s.storeName order by rateAvg desc;


select s.*, (select round(AVG(r.rating), 1) from rating r where s.idx = r.storeIdx) as rateAvg from store s where s.storePart = '치킨';

select s.*, (select round(AVG(r.rating), 1) from rating r where s.idx = r.storeIdx) as rateAvg from store s where s.storePart = '치킨'order by rateAvg desc;

--

/* 가게 음식 카테고리  */
create table storeTag (
	idx int not null auto_increment,						/* 푸드카테고리 고유번호 */
	brandName varchar(30) not null,							/* 가게 고유번호 */
	foodTag varchar(100) not null,
	admintag varchar(1)	NOT NULL default 'O',	
	primary key(idx)
);
--ALTER TABLE storeTag ADD admintag varchar(1)	NOT NULL default 'O';
-- drop table storeTag;
-- drop table foodMenu;
-- drop table foodsubMenu;
 
	-- 주 메뉴 테이블
	CREATE TABLE storeFoodMenu (
		menuIdx	int	NOT NULL auto_increment,  		/* 메뉴 고유번호 */
		storeName varchar(30) not null,								/* 해당 프랜차이즈 이름 */
		foodName	varchar(30)	NOT NULL, 					/* 메뉴 이름 */
		foodTag	varchar(20)	NOT NULL, 					/* 메뉴 카테고리*/
		price	int	NOT NULL,												/* 가격 */
		runOut	varchar(1)	NOT NULL default 'X',	/* 품절여부 */
		sale	varchar(20)	NOT NULL default 'X',		/* 세일여부 */
		salePrice	int	NOT NULL default 0,					/* 할인율 */
		foodPhoto	varchar(100)	NOT NULL,						/* 음식사진 */
		subMenu varchar(1)	NOT NULL default 'X',	/* 추가옵션 여부 */ 
		foodInfo varchar(100),	/* 음식 설명 */ 
		admintag varchar(1)	NOT NULL default 'O',	/* 어드민에서 가져온 음식인지 여부 */

		primary key(menuIdx)    
	);
	
	desc foodMenu;
	
	ALTER TABLE storeFoodMenu ADD foodInfo varchar(100);
	ALTER TABLE storeFoodMenu ADD subMenu varchar(1) not null default 'X';
	ALTER TABLE storeFoodMenu ADD updateAndDelete varchar(1) not null default 'X';
	
	ALTER TABLE 테이블명 DROP COLUMN 컬럼명
		
	-- 각 메뉴에 추가 옵션
	CREATE TABLE storeFoodSubMenu (
		storeName varchar(30) not null,       /* 가게 이름(중복불허) */
		subMenuIdx	int	NOT NULL auto_increment,
		foodTag varchar(100) not null,
		sMenuName	varchar(20)	NOT NULL,
		price	int	NOT NULL,
		runOut	varchar(20)	NOT NULL,
	  admintag varchar(1)	NOT NULL default 'O',	/* 어드민에서 가져온 음식인지 여부 */
		
		primary key(subMenuIdx)  
	);
	
--	drop table storeFoodSubMenu
	
	
