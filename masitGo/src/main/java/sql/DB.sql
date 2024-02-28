-- 회원 테이블 만들기
CREATE TABLE member  (
	name varchar2(50) NOT NULL, -- 회원 이름 NOT NULL 
	id varchar2(50) PRIMARY KEY, -- 회원 아이디 PK
	password varchar2(50) NOT NULL, -- 회원 비밀번호 NOT NULL
	birthday date, -- 회원 생년월일 ex) 1998-05-30
	email varchar2(50), -- 회원 email
	hp varchar2(30), -- 휴대폰번호
	authority varchar2(10) DEFAULT 'user', -- 권한 기본은 user
	CONSTRAINT chk_authority CHECK (authority IN ('user', 'admin')); -- 권한 종류는 user랑 admin 
	
	
);
-- member table에 권한 컬럼 추가
ALTER TABLE MEMBER
ADD authority varchar2(10) DEFAULT 'user'
CONSTRAINT chk_authority CHECK (authority IN ('user', 'admin')); 

-- 회원정보 입력하기
INSERT INTO MEMBER values ('최명신','audtlsdl12', 'java1234', to_date('1998-05-30', 'YYYY-MM-DD'), 'audtsldl56@naver.com', '010-1234-1234');
-- 주의) YY-DD-MM으로 했더니 내 생년월일이 2098년이 되었다.
-- 회원 정보 수정하기
UPDATE MEMBER SET id='audtlsdl12' WHERE id = 'audtlsdl32';

-- 회원정보 조회하기
SELECT * FROM MEMBER;

-- 회원 정보 삭제하기
DELETE MEMBER WHERE id = 'audtlsdl32';

-- 회원 테이블 삭제하기 실행하지 말 것..
DROP TABLE MEMBER;

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

-- 댓글 테이블 만들기
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

-- 신고 테이블 만들기 (report임 reports는 쌍용도서관꺼)
CREATE TABLE report(
post_id number(5,0), -- 신고하는 게시글 아이디
id varchar2(50), -- 신고자 id
reason varchar2(100), -- 신고 사유
report_date date -- 신고 날짜
isProcess char(1) check (isProcess in ('Y', 'N')) -- 신고 처리여부  Y,N만 가능
CONSTRAINT fk_member_re FOREIGN KEY(id) -- 회원정보가 삭제되면 신고도 삭제된다.
REFERENCES member(id) ON DELETE CASCADE,
CONSTRAINT fk_repost_id FOREIGN KEY(post_id) -- 게시글이 삭제되면 신고도 삭제된다.
REFERENCES post(post_id) ON DELETE CASCADE
);

-- 별점 테이블 만들기
CREATE TABLE rating(
	post_id number(5,0), -- 별점 주는 게시글 아이디
	id varchar2(50), -- 별점주는 사람 id
	score number(1),
	CONSTRAINT SCORE_CK CHECK (score BETWEEN 0 AND 6) -- 별점은 0~5점
);

-- 게시글 등록
SELECT * FROM post;
INSERT INTO post VALUES
(post_seq.nextval, '야 이 돈까스 먹어봤냐? 존맛임', 'ㅈㄱㄴ', 
sysdate, NULL, 0, 0, 'audtlsdl12', '잡담');
-- 게시글 삭제
DELETE FROM post WHERE POST_ID = 2;





