show tables;

create table weborder (
  idx  int  not null auto_increment primary key,
  mid  varchar(20) not null,			/* 아이디 */
  foodMenu  varchar(20) not null,	/* 상품명 */
  address  varchar(100) not null,	/* 배달주소 */
  price    int  not null,					/* 상품가격(배달료포함) */
  rider    varchar(20) not null default '미배정',	/* 배달자 */
  progress varchar(20) not null default '주문완료',	/* 현재 진행상황(주문완료-배달채택-배달완료) */
  orderDate    datetime not null default now(),	/* 주문완료 시간 */
  assignDate   datetime not null default now(), /* 배달자선정시간 */
  completeDate datetime not null default now(),  /* 배달완료시간 */
  checkStr  varchar(100) not null	default 'X' /* 배달주소 */
  /* foreign key(mid) references member2(mid) */
);

desc webOrder;

drop table weborder;
