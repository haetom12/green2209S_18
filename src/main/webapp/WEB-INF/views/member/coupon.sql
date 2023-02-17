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
  primary key(idx),
  foreign key(ratingIdx) references rating(idx)
  /* on update cascade */
  /* on delete restrict */
);


desc ratingReply;
drop table boardReply2;
select * from boardReply2;