/* 장바구니 테이블 */
create table cart (
  idx   int not null auto_increment,			/* 장바구니 고유번호 */
  cartDate datetime default now(),				/* 장바구니에 상품을 담은 날짜 */
  mid   varchar(20) not null,							/* 장바구니를 사용한 사용자의 아이디 - 로그인한 회원 아이디이다. */
  menuIdx  int not null,								/* 장바구니에 구입한 상품의 고유번호 */
  storeName varchar(30) not null,				/* 장바구니에 담은 구입한 상품 가게명 */
  foodName varchar(30) not null,				/* 장바구니에 담은 구입한 상품명 */
  mainPrice   int not null,								/* 메인상품의 기본 가격 */
  thumbImg		varchar(100) not null,			/* 서버에 저장된 상품의 메인 이미지 */
  optionIdx	  varchar(50)	 not null,			/* 옵션의 고유번호리스트(여러개가 될수 있기에 문자열 배열로 처리한다.) */
  subMenuName  varchar(100) not null,			/* 옵션명 리스트(배열처리) */
  optionPrice varchar(100) not null,			/* 옵션가격 리스트(배열처리) */
  optionNum		varchar(50)  not null,			/* 옵션수량 리스트(배열처리) */
  totalPrice  int not null,								/* 구매한 모든 항목(상품과 옵션포함)에 따른 총 가격 */
  primary key(idx),
  foreign key(menuIdx) references storefoodmenu(menuIdx) on update cascade on delete restrict
  /* foreign key(mid) references member(mid) on update cascade on delete cascade */		/* 문자 외래키(mid)는 버전에 따라 오류발생 */
);

drop table foodOrder;

show tables; 

/* 주문 테이블 -  */
create table foodOrder (
  idx         int not null auto_increment, /* 고유번호 */
  mid         varchar(20) not null,   /* 주문자 ID */
  orderDate   datetime default now(), /* 실제 주문을 한 날짜 */
  orderIdx    varchar(15) not null,   /* 주문 고유번호(새롭게 만들어 주어야 한다.) */
  menuIdx  int not null,           /* 상품 고유번호 */
  foodName varchar(30) not null,   /* 상품명 */
  mainPrice   int not null,				    /* 메인 상품 가격 */
  thumbImg    varchar(100) not null,   /* 썸네일(서버에 저장된 메인상품 이미지) */
  orderAddress varchar(100) not null,   /* 썸네일(서버에 저장된 메인상품 이미지) */
  subMenuName  varchar(100) not null,  /* 옵션명    리스트 -배열로 넘어온다- */
  optionNum   varchar(50)  not null,  /* 옵션수량  리스트 -배열로 넘어온다- */
  orderMessage   varchar(50),  /* 주문 메세지 */
  orderTotalPrice  int not null,					  /* 구매한 상품 항목(상품과 옵션포함)에 따른 총 가격 */
  /* cartIdx     int not null,	*/		/* 카트(장바구니)의 고유번호 */ 
  primary key(idx, orderIdx)
  /* foreign key(mid) references member(mid), */		/* 문자인경우 외래키 고려~~~ */
--  foreign key(menuIdx) references storefoodmenu(menuIdx) on update cascade on delete restrict
);