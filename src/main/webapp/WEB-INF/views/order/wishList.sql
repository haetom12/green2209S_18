	-- 찜 목록 테이블
	CREATE TABLE wishList (
		idx	int	NOT NULL auto_increment,  		/* 찜목록 고유번호 */
		mid varchar(20) not null,								/* 아이디 */
		menuIdx	int	NOT NULL, 					/* 메뉴 이름 */
		storeName varchar(30) not null,						/* 해당 프랜차이즈 이름 */
		primary key(idx),
		foreign key(storeName) references store(storeName),
		foreign key(menuIdx) references storeFoodMenu(menuIdx)
	);

	
	CREATE TABLE wishList (
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
	);