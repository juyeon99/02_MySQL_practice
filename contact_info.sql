CREATE DATABASE ogclass_db;
GRANT ALL PRIVILEGES ON ogclass_db.* TO 'juyeon'@'%';
USE ogclass_db;

DROP TABLE IF EXISTS class;
CREATE TABLE IF NOT EXISTS class(
    student_no int PRIMARY KEY AUTO_INCREMENT,
    gender varchar(5) NOT NULL CHECK(gender IN ('남','여')),
    student_name varchar(255) NOT NULL,
    github_id varchar(255) NOT NULL UNIQUE,
    email varchar(255) NOT NULL UNIQUE,
    mbti varchar(10),
    subject_no int,
    FOREIGN KEY (subject_no) REFERENCES favorite_subject (subject_no)
);

DROP TABLE IF EXISTS favorite_subject;
CREATE TABLE IF NOT EXISTS favorite_subject(
    subject_no int PRIMARY KEY AUTO_INCREMENT,
    subject_name varchar(255) NOT NULL UNIQUE
);

DESCRIBE class;
DESCRIBE favorite_subject;

INSERT INTO favorite_subject VALUES
       (1,'JAVA'),
       (2,'MySQL'),
       (3,'JDBC'),
       (4,'MYBATIS'),
       (5,'SPRING'),
       (6,'REACT');

INSERT INTO class (student_no,gender,student_name,github_id,email,mbti,subject_no)
    VALUES (null,'남','박태근','Ohgiraffers-bear','bear.ohgiraffers@gmail.com','ENFJ',5),
           (null,'남','지동현','Bring2it2on','yjkl0516@gmail.com',null,3),
           (null,'남','김강현','kimkinghyeon','modan8199@gmail.com','ISFP',1),
           (null,'남','이득규','MANTISKYU','asdaron44@gmail.com','ESTJ',2),
           (null,'여','홍주연','juyeon99','juyeon0806@gmail.com','ISFP',1),
           (null,'여','양혜연','yanghyeyeon','yhy4058@gmail.com','ISFP',5),
           (null,'남','이규섭','LKS9616','lks609591@gmail.com',null,2),
           (null,'남','전유안','euuuuuuan','euan.may24@gmail.com',null,4),
           (null,'여','박성은','seongeun223','jklun080921@gmail.com','ISTJ',2),
           (null,'여','박하얀','parkhayarn','s0224y92@gmail.com','INFP',null),
           (null,'남','위성민','wdh970616','wdh970616@naver.com',null,null),
           (null,'남','박효찬','qwes5674','qwes5674@gmail.com',null,null),
           (null,'남','이의정','himisterlee','lejlej100418@gmail.com',null,2),
           (null,'여','권은혜','dmsgpk237','a01027947353@gmail.com','ENFP',2),
           (null,'남','권보현','Kwonbohyun','kwon18923@gmail.com',null,2),
           (null,'여','배하은','HEun0420','usialeta@gmail.com','INTJ',2),
           (null,'여','강연진','kangyeonjin','yeonjin917n.n@gmail.com',null,5),
           (null,'남','강진영','weed97','weed9935@gmail.com',null,2);
