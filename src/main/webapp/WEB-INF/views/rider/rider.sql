show tables;

create table rider (
	riderIdx int not null auto_increment, 	  	/* 회원 고유번호 */
	riderMid varchar(20) not null,        	  	/* 회원 아이디(중복불허) */
	riderPwd varchar(100) not null,       	  	/* 비밀번호(SHA암호화 처리) */
	riderName varchar(20) not null,      	/* 회원 성명 */
	age int  not null, 								
	riderPhone	varchar(15),            		  	/* 전화번호(010-1234-5678) */
	riderEmail varchar(50) not null,				  	/* 이메일(아이디/비밀번호 분실시 사용) - 형식체크필수 */
	deleteRequest  char(2)  default 'NO',   		/* 회원 탈퇴 신청 여부(OK:탈퇴신청한회원, NO:현재가입중인회원) */
	reportRider int default 0, 								/* 신고누적 */
	primary key(riderIdx,riderMid)           		  	/* 주키: idx(고유번호), mid(아이디) */
);

ALTER TABLE rider ADD Latitude double not null;
ALTER TABLE rider ADD Longitude double not null;

select * from member;

desc member;

--drop table member;
--delete from member where idx=19;


alter table member add level int default 0;


insert into member values (default, 'admin', '1234', '관리맨','관리자', default, default, '010-5718-5014', '세종특별자치시', 'haetom@naver.com', 'https://www.naver.com', '학생', '볼링/게임', default, '관리자입니다.', default,default,default,0,default,default,default,default );
insert into member values (default, 'haetom', '1454', '해찬들','천해찬', default, default, '010-5718-5014', '세종특별자치시', 'haetom@naver.com', 'https://www.naver.com', '학생', '볼링/게임', default, '관리자입니다.', default,default,default,2,default,default,default,default );
insert into member values (default, 'haetom12', '1454', '해찬들','천해찬', default, default, '010-5718-5014', '세종특별자치시', 'haetom@naver.com', 'https://www.naver.com', '학생', '볼링/게임', default, '관리자입니다.', default,default,default,4,default,default,default,default );
