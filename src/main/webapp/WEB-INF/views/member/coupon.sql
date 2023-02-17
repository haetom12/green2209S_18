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