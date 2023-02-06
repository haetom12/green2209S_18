show tables;

/* 음식 분류 */
create table categoryStore (
	categoryStoreCode char(1) not null,			/* 카테고리 코드*/
	storePart varchar(20) not null,		/* 카테고리명(음식점 분류) */
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


--drop table storeBrand;

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


--drop table rating;

--alter table member add level int default 0;
--ALTER TABLE store DROP COLUMN rateAvg;

select s.*, round(AVG(r.rating),1) as rateAvg from store s, rating 
r where s.idx = r.storeIdx and s.storePart = '치킨';
select s.*, round(AVG(r.rating),1) as rateAvg from store s, rating r where s.idx = r.storeIdx and s.storePart = '치킨' group by s.storeName order by rateAvg desc;


select s.*, (select round(AVG(r.rating), 1) from rating r where s.idx = r.storeIdx) as rateAvg from store s where s.storePart = '치킨';

select s.*, (select round(AVG(r.rating), 1) from rating r where s.idx = r.storeIdx) as rateAvg from store s where s.storePart = '치킨'order by rateAvg desc;




/* 음식 프랜차이즈 추가 */
create table adminStoreBrand (
	idx int not null auto_increment,  	/* 브랜드 고유번호 */
	storePart varchar(20) not null, 		/* 치킨,피자 */
	brandName varchar(30) not null,     /* 브랜드 이름(중복불허) */
	foreign key(storePart) references categoryStore(storePart),
	unique key(brandName),
	primary key(idx)
);


/* 가게 음식 카테고리  */
create table adminStoreTag (
	idx int not null auto_increment,						/* 푸드카테고리 고유번호 */
	brandName varchar(30) not null,							/* 가게 고유번호 */
	foodTag varchar(100) not null,
	primary key(idx),
	unique key(foodTag)
);

-- drop table storeTag;
-- drop table foodMenu;
-- drop table foodsubMenu;
 
	-- 주 메뉴 테이블
	CREATE TABLE adminFoodMenu (
		menuIdx	int	NOT NULL auto_increment,  		/* 메뉴 고유번호 */
		brandName varchar(30) not null,								/* 해당 프랜차이즈 이름 */
		foodName	varchar(30)	NOT NULL, 					/* 메뉴 이름 */
		foodTag	varchar(20)	NOT NULL, 					/* 메뉴 카테고리*/
		price	int	NOT NULL,												/* 가격 */
		runOut	varchar(1)	NOT NULL default 'X',	/* 품절여부 */
		sale	varchar(20)	NOT NULL default 'X',		/* 세일여부 */
		salePrice	int	NOT NULL default 0,					/* 할인율 */
		foodPhoto	varchar(100)	NOT NULL,						/* 음식사진 */
		subMenu varchar(1)	NOT NULL default 'X',	/* 추가옵션 여부 */ 
		foodInfo varchar(100),	/* 음식 설명 */ 

		foreign key(brandName) references storeBrand(brandName),
		primary key(menuIdx)    
	);
	
	desc foodMenu;
	
	ALTER TABLE foodMenu ADD foodInfo varchar(100);
	ALTER TABLE foodMenu ADD subMenu varchar(1) not null default 'X';
		
	-- 각 메뉴에 추가 옵션
	CREATE TABLE adminFoodSubMenu (
		brandName varchar(30) not null,								/* 해당 프랜차이즈 이름 */
		subMenuIdx	int	NOT NULL auto_increment,
		foodTag varchar(100) not null,
		sMenuName	varchar(20)	NOT NULL,
		price	int	NOT NULL,
		runOut	varchar(20)	NOT NULL,
		
		primary key(subMenuIdx)
	);
	
	
--	drop table adminFoodSubMenu
	
	
	
