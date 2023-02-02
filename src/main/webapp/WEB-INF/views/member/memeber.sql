show tables;

create table member (
	idx int not null auto_increment, 	  	/* 회원 고유번호 */
	mid varchar(20) not null,        	  	/* 회원 아이디(중복불허) */
	pwd varchar(100) not null,       	  	/* 비밀번호(SHA암호화 처리) */
	memberName varchar(20) not null,      	/* 회원 성명 */
	birthday datetime  default now(),   	/* 생일 */
	tel		varchar(15),            		  	/* 전화번호(010-1234-5678) */
	address varchar(100),							  	/* 회원주소 (상품 배달시 기본주소로 사용) */
	email varchar(50) not null,				  	/* 이메일(아이디/비밀번호 분실시 사용) - 형식체크필수 */
	userDel  char(2)  default 'NO',   		/* 회원 탈퇴 신청 여부(OK:탈퇴신청한회원, NO:현재가입중인회원) */
	point int default 0, 								/* 결제포인트 */
	report int default 0, 								/* 신고누적 */
	orderCnt int default 0,								/* 오늘 방문한 횟수 */
	level int default 3,									/* 0: 관리자, 1: 우수회원 2: 정회원 3: 준회원 */
	memberLatitude double not null, 				/* 위도 */
	memberLongitude double not null,				/* 경도 */
	memberNickName varchar(20) not null,      	/* 회원 성명 */
	primary key(idx,mid)           		  	/* 주키: idx(고유번호), mid(아이디) */
);

ALTER TABLE member ADD memberLatitude double not null;
ALTER TABLE member ADD memberLongitude double not null;
ALTER TABLE member ADD memberNickName varchar(20) not null;

select * from member;

desc member;

--drop table member;
--delete from member where idx=19;


alter table member add level int default 0;


insert into member values (default, 'admin', '1234', '관리맨','관리자', default, default, '010-5718-5014', '세종특별자치시', 'haetom@naver.com', 'https://www.naver.com', '학생', '볼링/게임', default, '관리자입니다.', default,default,default,0,default,default,default,default );
insert into member values (default, 'haetom', '1454', '해찬들','천해찬', default, default, '010-5718-5014', '세종특별자치시', 'haetom@naver.com', 'https://www.naver.com', '학생', '볼링/게임', default, '관리자입니다.', default,default,default,2,default,default,default,default );
insert into member values (default, 'haetom12', '1454', '해찬들','천해찬', default, default, '010-5718-5014', '세종특별자치시', 'haetom@naver.com', 'https://www.naver.com', '학생', '볼링/게임', default, '관리자입니다.', default,default,default,4,default,default,default,default );
