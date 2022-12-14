```sql
# DB 생성
DROP DATABASE IF EXISTS SBTest;
DROP TABLE SBTest;
CREATE DATABASE SBTest;
USE SBTest;
# 게시물 테이블 생성
CREATE TABLE article (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    title CHAR(100) NOT NULL,
    `body` TEXT NOT NULL
);
# 게시물 테스트 데이터 생성
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목1',
`body` = '내용1';
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목2',
`body` = '내용2';
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목3',
`body` = '내용3';
SELECT * 
FROM article;
SELECT LAST_INSERT_ID()
# 회원 테이블 생성
CREATE TABLE `member` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    loginId CHAR(20) NOT NULL,
    loginPw CHAR(60) NOT NULL,
    `authLevel` SMALLINT(2) UNSIGNED NOT NULL DEFAULT 3 COMMENT '권한레벨(3=일반,7=관리자)',
    `name` CHAR(20) NOT NULL,
    `nickname` CHAR(20) NOT NULL,
    cellphoneNum CHAR(20) NOT NULL,
    email CHAR(50) NOT NULL,
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '탈퇴여부(0=탈퇴전,1=탈퇴)',
    delDate DATETIME COMMENT '탈퇴날짜'
);
# 회원 테스트 데이터 생성(관리자 회원)
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'admin',
loginPw = 'admin',
`authLevel` = 7,
`name` = '관리자',
`nickname` = '관리자',
cellphoneNum = '01012341234',
email = 'abcdef@gmail.com';
# 회원 테스트 데이터 생성(일반 회원)
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'user1',
loginPw = 'user1',
`name` = '사용자1',
`nickname` = '사용자1',
cellphoneNum = '01043214321',
email = 'fedcba@gmail.com';
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'user2',
loginPw = 'user2',
`name` = '사용자2',
`nickname` = '사용자2',
cellphoneNum = '01098769876',
email = 'zxcvbnm@gmail.com';
SELECT*FROM `member`
#게시물테이블에 회원정보(memberId)추가
ALTER TABLE article ADD COLUMN memberId INT(10) UNSIGNED NOT NULL AFTER updateDate;
#기존 게시물의 작성자를 2번으로 수정
UPDATE article SET memberId = 2 WHERE memberId=0

#게시글에 작성자명 표시(extra_writerName 추가)

SELECT article.*,`member`.nickname AS extra_writerName 
FROM article LEFT JOIN `member` ON article.memberId = `member`.Id

# 게시판 테이블 생성
CREATE TABLE board (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `code` CHAR(50) NOT NULL UNIQUE COMMENT 'notice(공지사항), free1(자유게시판1), free2(자유게시판2),..',
    `name` CHAR(50) NOT NULL UNIQUE COMMENT '게시판 이름',
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제여부 (0=삭제 전,1=삭제 후)',
    delDate DATETIME COMMENT '삭제날짜'
);

# 기본 게시판 생성
INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'notice',
`name` = '공지사항';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'free1',
`name` = '자유게시판';

# 게시물 테이블에 boardId컬럼 추가
ALTER TABLE article
ADD COLUMN boardId INT(10) NOT NULL AFTER `memberId`;

#1,2번 게시물을 공지사항 게시물(boardId=1)로수정
UPDATE article 
SET boardId=1
WHERE id IN (1,2)

#3번 게시물을 공지사항 게시물(boardId=2)로수정
UPDATE article 
SET boardId=2
WHERE id IN (3)

# WHERE 1=1(참)을 이용해 boardId에 해당하는 게시글목록만 가져오기
SELECT article.*,`member`.nickname AS extra_writerName 
FROM article LEFT JOIN `member` 
ON article.memberId = `member`.Id
WHERE 1=1 
AND article.boardId = 1
ORDER BY article.id DESC

SELECT * FROM board;

#SELECT FLOOR(RAND()*2)+1 FLOOR 소수점버리기

#게시물갯수늘리기
INSERT INTO article
(
regDate,updateDate,title,`body`,memberId,boardId
)
SELECT NOW(),NOW(),CONCAT('제목_',RAND()),CONCAT('내용_',RAND()),FLOOR(RAND()*2)+1 ,FLOOR(RAND()*2)+1
FROM article;


```

