create table coupon (
	idx int not null auto_increment, 	  	/* 회원 고유번호 */
	orderIdx    varchar(15) not null,       	  	/* 비밀번호(SHA암호화 처리) */
	mid varchar(20) not null,        	  	/* 회원 아이디(중복불허) */
	qrCode varchar(200) not null,        	  	/* 회원 아이디(중복불허) */
	couponName varchar(30) not null,      	/* 회원 성명 */
	discount  int not null,
	storeName varchar(30) not null,
	receiveDate datetime  default now(),   	/* 생일 */
	useDate datetime  default now(),   	/* 생일 */
	used varchar(2)  default 'X',   	/* 생일 */
	
	foreign key(storeName) references store(storeName),
	primary key(idx)           		  	/* 주키: idx(고유번호), mid(아이디) */
);

show tables;



/* 가게 리뷰/평점 */
create table rating (
	idx int not null auto_increment,						/* 평점 고유번호 */
	orderIdx  varchar(15) not null,
	mid  varchar(20) not null,
	storeName varchar(30) not null,											/* 가게 고유번호 */
	reviewStar int not null,												/* 평점 */
	content text not null, 									/* 평점 내용 */
	reportRating int not null default 0,				/* 신고횟수 */
	foreign key(storeName) references store(storeName),
	primary key(idx)     
);


create table ratingReply (
  idx		int not null auto_increment,	/* 댓글의 고유번호 */
  ratingIdx int not null,							/* 원본글의 고유번호(외래키로 지정) */
  mid			 varchar(20) not null,			/* 댓글 올린이의 아이디 */
  nickName varchar(20) not null,			/* 댓글 올린이의 닉네임 */
  writeDate		 datetime default now(),		/* 댓글 올린 날짜 */
  content  text not null,							/* 댓글 내용 */
  replylevel int not null default 0,	/* 댓글 레벨 기본댓글 0 / 대댓글 1 */
  replyidx int,		/* 대댓글을 달고자하는 댓글의 idx */
  primary key(idx),
  foreign key(ratingIdx) references rating(idx)
  /* on update cascade */
  /* on delete restrict */
);

insert into store values (default,	"BBQ치킨 청주사창점",	"치킨",	"010-1212-3232",	"store9",	"$2a$10$AHRRjKRt/9CoNb28qKtzku9kZhTenoZ.eHn9K3UJoiAQjuqBDMJs6",	"천해찬",	"충북 청주시 서원구 내수동로 97 / 청주 ",	"8dfe4c8c-d337-4082-8a0f-0359ee496f97_b1e160ae79754ead961ac6f54dcf4331.jpg",	"haetom@naver.com",	"36.6355555975964",	"127.458023655454",	"NO",	"09:00~00:00"	,"3000",	"15000",	"2023-02-27 01:13:24")
insert into store values (default,	"BBQ치킨 논산점",	"치킨",	"010-1212-3232",	"store10",	"$2a$10$AHRRjKRt/9CoNb28qKtzku9kZhTenoZ.eHn9K3UJoiAQjuqBDMJs6",	"김해찬",	"충북 청주시 97 / ",	"8dfe4c8c-d337-4082-8a0f-0359ee496f97_b1e160ae79754ead961ac6f54dcf4331.jpg",	"haetom@naver.com",	"36.6355555975964",	"127.458023655554",	"NO",	"09:00~00:00"	,"3000",	"15000",	"2023-02-27 01:13:24")
insert into store values (default,	"BBQ치킨 오송역지점",	"치킨",	"010-8558-2525",	"store11",	"$2a$10$AHRRjKRt/9CoNb28qKtzku9kZhTenoZ.eHn9K3UJoiAQjuqBDMJs6",	"박정광",	"충북 청주시 서원구 내수동로 97 / 대전",	"8dfe4c8c-d337-4082-8a0f-0359ee496f97_b1e160ae79754ead961ac6f54dcf4331.jpg",	"haetom@naver.com",	"36.6355656575964",	"127.458023655554",	"NO",	"09:00~00:00"	,"3000",	"15000",	"2023-02-27 01:13:24")
insert into store values (default,	"BBQ치킨 청주시청점",	"치킨",	"010-57575-1414",	"store12",	"$2a$10$AHRRjKRt/9CoNb28qKtzku9kZhTenoZ.eHn9K3UJoiAQjuqBDMJs6",	"이정광",	"충북 청주시 서원구 내수동로 97 / 몰라",	"8dfe4c8c-d337-4082-8a0f-0359ee496f97_b1e160ae79754ead961ac6f54dcf4331.jpg",	"haetom@naver.com",	"36.6355455975964",	"127.458023655554",	"NO",	"09:00~00:00"	,"3000",	"15000",	"2023-02-27 01:13:24")
insert into store values (default,	"BBQ치킨 청주공항점",	"치킨",	"010-7712-7757",	"store13",	"$2a$10$AHRRjKRt/9CoNb28qKtzku9kZhTenoZ.eHn9K3UJoiAQjuqBDMJs6",	"새뜸길",	"충북 청주시 서원구 내수동로 97 / 서원구",	"8dfe4c8c-d337-4082-8a0f-0359ee496f97_b1e160ae79754ead961ac6f54dcf4331.jpg",	"haetom@naver.com",	"36.6355585975964",	"127.458023665554",	"NO",	"09:00~00:00"	,"3000",	"15000",	"2023-02-27 01:13:24")

insert into rating values (default,	"1213123",	"haetom12",	"BBQ치킨 청주사창점",	"4",	"마시서요",	"<p>진짜 꿀맛이엿습니다</p>",	0, null,"해이럼", "2023-02-17 00:56:05")
insert into rating values (default,	"123112323",	"haetom12",	"BBQ치킨 논산점",	"3",	"별로였어요",	"<p>진짜 별로였어요</p>",	0, null,"해이럼","2023-02-17 00:56:05")
insert into rating values (default,	"12312324353",	"haetom12",	"BBQ치킨 오송역지점",	"2",	"한조각이 사라졋어요",	"<p>진짜 사라졋어요</p>",0, null,"해이럼", "2023-02-28 00:56:05")
insert into rating values (default,	"23462621",	"haetom12",	"BBQ치킨 청주시청점",	"2",	"배달이 늦어요",	"<p>진짜 늦어요</p>",0, null,"해이럼" , "2023-02-10 00:56:05")
insert into rating values (default,	"26346575",	"haetom12",	"BBQ치킨 청주공항점",	"5",	"최고였어요!",	"<p>진짜 최고였어요</p>",0, null,"해이럼" , "2023-02-05 00:56:05")








desc ratingReply;
drop table ratingReply;
select * from boardReply2;