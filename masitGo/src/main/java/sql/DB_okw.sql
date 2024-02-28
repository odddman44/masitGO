/* 맛있GO 모든 테이블 조회 (컬럼들 전부 보여주기용) */
-- 1. POST
SELECT POST_ID, TITLE, CONTENT, POST_DATE, UPT_DATE, LIKE_CNT, VIEWS, ID, BOARD_NAME
FROM POST;
-- 2. MEMBER
SELECT *
FROM GROUP4."MEMBER";
-- 3. COMMENTS
SELECT POST_ID, ID, CONTENT, REG_DATE
FROM GROUP4.COMMENTS;
-- 4. REPORT 
SELECT POST_ID, ID, REASON, REPORT_DATE, ISPROCESS
FROM GROUP4.REPORT;

-- 5. LOCATION
SELECT LOCATION_ID, POST_ID, LATITUDE, LONGITUDE
FROM GROUP4.LOCATION;

-- 6. Location 연동된 POST 조회
SELECT p.post_id, p.title, m.name, p.post_date, p.like_cnt, p.views, l.latitude, l.longitude, p.content
FROM post p
JOIN member m ON p.id = m.id
LEFT JOIN location l ON p.post_id = l.post_id
WHERE p.post_id = 48;

-- 7. RATING
SELECT * FROM RATING;
/* 테이블 생성 (CREATE) */
-- 1. Location 
CREATE TABLE location (
    location_id number PRIMARY KEY,
    post_id number(5,0),
    latitude number, -- 위도
    longitude number, -- 경도
    CONSTRAINT fk_post_location FOREIGN KEY(post_id)
    REFERENCES post(post_id) ON DELETE CASCADE
);
-- location 시퀀스
CREATE SEQUENCE location_seq
START WITH 1
INCREMENT BY 1;
----------------------------------------------------------------
-- 2. Post 
CREATE TABLE post(
    post_id number(5,0) PRIMARY KEY, -- 게시글 번호 PRIMARY KEY
    title varchar2(200) NOT NULL, -- 게시글 제목 NOT NULL
    content clob, -- 게시글 내용
    post_date DATE, -- 등록일자
    upt_date DATE, -- 수정일자
    like_cnt number(5,0),-- 좋아요 수
    views number(10,0), -- 조회수
    id varchar2(50), -- 회원 아이디(회원 테이블 외래키)
    board_name varchar2(100) -- 게시판 이름
    CONSTRAINT fk_member_id FOREIGN KEY(id) -- 회원정보가 삭제되면 게시글도 삭제된다.
    REFERENCES member(id) ON DELETE CASCADE
);
-- 게시글 시퀀스 만들기
CREATE SEQUENCE post_seq
START WITH 1;
-- 3. Member
CREATE TABLE member  (
	name varchar2(50) NOT NULL, -- 회원 이름 NOT NULL 
	id varchar2(50) PRIMARY KEY, -- 회원 아이디 PK
	password varchar2(50) NOT NULL, -- 회원 비밀번호 NOT NULL
	birthday date, -- 회원 생년월일 ex) 1998-05-30
	email varchar2(50), -- 회원 email
	hp varchar2(30), -- 휴대폰번호
	authority varchar2(10) DEFAULT 'user', -- 권한 기본은 user
	CONSTRAINT chk_authority CHECK (authority IN ('user', 'admin'))-- 권한 종류는 user랑 admin 
); 
--4. Comments
CREATE TABLE comments(
post_id number(5,0), -- 게시글 번호
id varchar2(50), -- 회원 아이디
content varchar2(600),
reg_date DATE, -- 등록 날짜
CONSTRAINT fk_member FOREIGN KEY(id) -- 회원정보가 삭제되면 댓글도 삭제된다.
REFERENCES member(id) ON DELETE CASCADE,
CONSTRAINT fk_post_id FOREIGN KEY(post_id) -- 게시글이 삭제되면 댓글도 삭제된다.
REFERENCES post(post_id) ON DELETE CASCADE
);

-- 5. 별점 테이블 만들기
CREATE TABLE rating(
	post_id number(5,0), -- 별점 주는 게시글 아이디
	id varchar2(50), -- 별점주는 사람 id
	score number(1),
	CONSTRAINT SCORE_CK CHECK (score BETWEEN 0 AND 6) -- 별점은 0~5점
);
----------------------------------------------------------------
/*테이블에 예시로 데이터 추가하기*/
-- 1. Member
INSERT INTO member (name, id, password, birthday, email, hp, authority)
VALUES ('관리자', 'admin', 'admin',
TO_DATE('2023-12-20', 'YYYY-MM-DD'), 'admin@masitgo.com', '010-1234-5678', 'admin');
INSERT INTO member (name, id, password, birthday, email, hp)
VALUES ('오근우', 'okw9344', '9344',
TO_DATE('1993-04-04', 'YYYY-MM-DD'), 'okw934@4gmail.com', '010-9027-7345');
-- 2. POST (공지글 추가하기)
INSERT INTO post (post_id, title, content, post_date, upt_date, like_cnt, views, id, board_name)
VALUES (post_seq.NEXTVAL, 
'게시판의 성격과 맞는 글을 작성해 주시기 바랍니다.',
'안녕하세요, 모두가 함께하는 행복한 맛집 탐방, ''맛있GO''의 관리자 입니다!
각 게시판에는 게시판의 성격이 있습니다. 여러분께서 소중한 시간을 내어 글을 작성해 주실 때는
게시판 성격의 맞는 글을 작성해주시길 부탁드립니다.
게시판의 성격과 맞지 않는 글을 작성 시, 이는 사전의 경고 없이 관리자 조치로 ''삭제'' 처리
될 수 있음을 미리 알려드립니다.
감사합니다. 모두 즐거운 커뮤니티 이용 되시길 바랍니다!',
SYSDATE, SYSDATE, 0, 0, 'admin', '공지');

SELECT p.post_id, p.board_name, p.title, m.name, p.post_date, p.like_cnt, p.views
FROM post p
JOIN member m ON p.id = m.id
WHERE p.board_name = '맛집정보공유' OR p.board_name = '공지'
ORDER BY p.post_date DESC;

DELETE FROM post WHERE post_id = 104;