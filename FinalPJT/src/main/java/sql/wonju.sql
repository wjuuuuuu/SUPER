﻿-- # 프로젝트 테이블
DROP TABLE project;

CREATE TABLE project (
	prjno	number		PRIMARY key,
	regdte	varchar2(50)	NOT NULL,
	deadline	varchar2(50)	NOT NULL,
	subject	varchar2(500)		NOT NULL,
	tlid	varchar2(50)		NOT NULL,
	deptid	varchar2(30)		NOT NULL,
	openStatus	char(1)		NOT NULL,
	foreign key(deptid) references dept777(deptid)
    on delete CASCADE,
    foreign key(tlid) references emp777(id)
    on delete CASCADE
);
	SELECT p.*,e.ename FROM project p,emp777 e 
	WHERE 1=1 AND p.tlid=e.ID  
	AND TO_date(to_char(sysdate,'yyyy-mm-dd'),'yyyy-mm-dd')>=to_date(p.deadline,'yyyy-mm-dd');
	
	SELECT TO_date(sysdate,'yyyy-mm-dd') FROM dual;

	SELECT p.*,e.ename FROM project p,emp777 e 
	WHERE 1=1 and openstatus='0' AND e.id=p.tlid
	and to_date(p.deadline,'yyyy-mm-dd')>=TO_date(to_char(sysdate,'yyyy-mm-dd'),'yyyy-mm-dd') 
	AND (subject LIKE '%'||''||'%'
	or ename LIKE '%'||''||'%');

	-- 나의 업무 조회
	SELECT d.DNAME,p.SUBJECT ,p.PRJNO,m.PART,m.OWNER , c.cnt
	FROM  PROJECT p, PROJECTMEMBER m, dept777 d,(SELECT prjno,COUNT(*)+1 cnt FROM projectmember GROUP BY prjno) c
	WHERE 1=1 AND p.PRJNO =m.PRJNO AND m.OWNER ='emp1@gmail.com'
	AND d.DEPTID =p.DEPTID
	AND c.prjno=p.PRJNO ;
	
	SELECT prjno,COUNT(*)+1 FROM projectmember GROUP BY prjno; 
	
	SELECT p.prjno,p.subject,p.tlid,p.deptid
	FROM project p,PROJECTMEMBER m
	WHERE m.PRJNO =p.PRJNO ;
-- 프로젝트별 진행률	(23년 3월에 종료되는 프로젝트별 간트차트 업무 진행률)
SELECT DISTINCT a.avgs,p.subject, substr(p.deadline,6,5) AS deadline FROM (SELECT ROUND(Avg(PROGRESS)*100,1) AS avgs ,prjno FROM gantt GROUP BY prjno) a, project p
WHERE a.prjno=p.prjno AND TO_NUMBER(substr(p.DEADLINE,0,4))=2023 --AND TO_NUMBER(SUBSTR(p.deadline,6,2))=4
ORDER BY deadline desc
;
-- 현재 진행중인 프로젝트의 카테고리별 갯수
SELECT ppp.*, d.dname FROM (SELECT count(*) AS cnts, pp.deptid 
FROM (SELECT * FROM PROJECT p WHERE p.deadline>=to_char(sysdate,'yyyy-mm-dd')) pp GROUP BY pp.deptid) ppp, dept d
WHERE ppp.deptid=d.deptid;

SELECT * FROM CALENDAR;
-- 프로젝트

SELECT * FROM emp;
SELECT ename, id, dname FROM emp e, dept d WHERE e.DEPTID =d.DEPTID AND d.DNAME LIKE '%'||'개발'||'%';
SELECT * FROM project;
SELECT DISTINCT OWNER, ename FROM PROJECTMEMBER m, emp e WHERE e.id=m.OWNER;
SELECT * FROM gantt;
-- 프로젝트별 투입된 인원표시
SELECT prjno,count(owner) AS cnt FROM PROJECTMEMBER GROUP BY prjno;
-- 개발자 전체 인원(pm제외)
SELECT count(id) AS cnt FROM emp e, dept d 
WHERE NOT e.AUTH IN 2 and d.DEPTID =e.DEPTID AND d.DNAME LIKE '%'||'개발'||'%';
-- 현재 프로젝트에 참여중인 개발자 인원수(pm제외)
SELECT count(DISTINCT id) AS cnt FROM emp e, dept d, PROJECT p, PROJECTMEMBER m 
WHERE NOT e.AUTH IN 2 and d.DEPTID =e.DEPTID AND d.DNAME LIKE '%'||'개발'||'%'
AND p.PRJNO =m.PRJNO AND m.OWNER =e.ID AND p.DEADLINE >=TO_CHAR(sysdate,'yyyy-mm-dd');
-- 전체 pm의 숫자
SELECT count(*) AS cnt FROM emp WHERE AUTH =2;
-- 현재 프로젝트 진행중인 pm 숫자
SELECT count(DISTINCT tlid) AS cnt FROM PROJECT p WHERE p.DEADLINE >=TO_CHAR(sysdate,'yyyy-mm-dd'); 

SELECT 'totPM' AS subject, count(*) AS cnt FROM emp WHERE AUTH = 2
UNION ALL
SELECT 'proPM' AS subject, count(DISTINCT tlid) AS cnt FROM PROJECT p WHERE p.DEADLINE >= TO_CHAR(sysdate,'yyyy-mm-dd');

SELECT 'totEmp' AS subject, count(id) AS cnt FROM emp e, dept d 
WHERE NOT e.AUTH IN 2 and d.DEPTID =e.DEPTID AND d.DNAME LIKE '%'||'개발'||'%'
UNION ALL 
SELECT 'proEmp' AS subject, count(DISTINCT id) AS cnt FROM emp e, dept d, PROJECT p, PROJECTMEMBER m 
WHERE NOT e.AUTH IN 2 and d.DEPTID =e.DEPTID AND d.DNAME LIKE '%'||'개발'||'%'
AND p.PRJNO =m.PRJNO AND m.OWNER =e.ID AND p.DEADLINE >=TO_CHAR(sysdate,'yyyy-mm-dd');

SELECT DISTINCT a.avgs,p.subject, substr(p.deadline,6,5) AS deadline
	FROM (SELECT ROUND(Avg(PROGRESS)*100,1) AS avgs ,prjno FROM gantt GROUP BY prjno) a, 
	project p
	WHERE a.prjno=p.prjno AND TO_NUMBER(substr(p.DEADLINE,0,4))=2023 ORDER BY deadline desc ;

-- 현재 프로젝트 진행중인 직원 명(PM도 포함)
SELECT count(DISTINCT m.OWNER) AS cnt  FROM PROJECTmember m, project p 
WHERE p.DEADLINE >=TO_CHAR(sysdate,'yyyy-mm-dd') AND p.PRJNO =m.PRJNO ;
-- 전체 직원수 (ceo 제외)
SELECT count(*)-1 AS cnt FROM emp;
-- 개발자 숫자
SELECT count(*) AS cnt FROM emp e, dept d WHERE e.DEPTID =d.DEPTID and d.DNAME LIKE '%'||'개발'||'%';

-- 올해 매출(단위 백만원)
SELECT sum(amount) AS tot FROM PROJECT WHERE TO_NUMBER(substr(deadline,0,4))=2023;

-- 월별 매출(단위 백만원)+ 진행중인 프로젝트 갯수
SELECT d.MONTH,p.tot,p.cnt FROM (SELECT TO_NUMBER(substr(deadline,6,2)) AS months ,sum(amount) AS tot,count(prjno) AS cnt 
FROM PROJECT WHERE TO_NUMBER(substr(deadline,0,4))=2023
GROUP BY TO_NUMBER(substr(deadline,6,2))) p, (SELECT ROWNUM month FROM DUAL CONNECT BY LEVEL <= 12) d
WHERE d.month =p.months(+) ORDER BY d.month;

SELECT * FROM risk WHERE RISKSTATE !='해결';
SELECT count(*) AS cnt FROM risk WHERE RISKSTATE!='해결' GROUP BY RISKPRIORITY ORDER BY RISKPRIORITY; 


INSERT INTO PROJECTMEMBER VALUES(62,'himan@gmail.com','담당PM');
	SELECT d.dname,e.job, m.part, e.ename, e.id FROM dept d, emp e, projectmember m
	WHERE m.prjno=41 AND m.owner=e.id AND e.deptid=d.deptid
	ORDER BY 
	  CASE 
	    WHEN m.part LIKE '담당PM' THEN 0 
	    ELSE 1
	  END,
	  m.part ASC;
SELECT rownum rm, d.DNAME,p.SUBJECT,p.tlid ,p.PRJNO,m.PART, c.cnt
	FROM  PROJECT p, PROJECTMEMBER m, dept d,
	(SELECT prjno,COUNT(*)+1 cnt FROM projectmember GROUP BY prjno) c
	WHERE 1=1 AND p.PRJNO =m.PRJNO AND m.OWNER ='monsta@gmail.com' OR p.tlid='monsta@gmail.com'
	AND d.DEPTID =p.DEPTID AND c.prjno=p.PRJNO;

SELECT DISTINCT p.REGDTE,p.DEADLINE,p.SUBJECT FROM project p, PROJECTMEMBER m WHERE p.prjno=m.PRJNO 
AND owner='admin1@gmail.com' OR p.tlid='admin1@gmail.com';
SELECT p.REGDTE,p.DEADLINE,p.SUBJECT FROM project p WHERE p.TLID ='admin1@gmail.com';

SELECT * FROM PROJECTMEMBER;
SELECT * FROM PROJECT;
SELECT * from gantt;
SELECT * FROM dept;	
SELECT * FROM PROJECt WHERE SUBSTR(DEADLINE,6,2)='02';

	SELECT DISTINCT a.avgs,p.subject, substr(p.deadline,6,5) AS deadline
	FROM (SELECT ROUND(Avg(PROGRESS)*100,1) AS avgs ,prjno FROM gantt GROUP BY prjno) a, 
	project p
	WHERE a.prjno=p.prjno AND TO_NUMBER(substr(p.DEADLINE,0,4))=2023
	AND TO_NUMBER(SUBSTR(p.deadline,6,2))=4;

-- 프로젝트 멤버별 업무 진행률
SELECT owner, round(avg(PROGRESS)*100,1) AS avgs FROM gantt WHERE prjno=23 GROUP BY owner ORDER BY avgs DESC;
-- 프로젝트 전체 업무 진행률
SELECT round(avg(progress)*100,0) AS avgs FROM gantt WHERE prjno=23;
-- openStatus 0이면 전체 공개 1이면 멤버공개
INSERT INTO project values(pro_seq.nextval,sysdate,to_date('2023-03-30','yyyy-mm-dd'),'첫번째 프로젝트','admin1@gmail.com','10','0');
INSERT INTO project values(pro_seq.nextval,'2023-02-01','2023-02-25','지난 프로젝트3','admin1@gmail.com','10','0');
SELECT * FROM project;
-- 전체 프로젝트(전체공개) & 진행중인 프로젝트 검색
SELECT p.*,e.ename FROM project p,emp777 e 
WHERE openstatus='0' AND e.id=p.tlid AND to_date(p.deadline,'yyyy-mm-dd')>=sysdate
AND (subject LIKE '%'||'리'||'%'
or ename LIKE '%'||'리'||'%')
;
CREATE SEQUENCE pro_seq
START WITH 1
MINVALUE 1;
SELECT PRO_SEQ.CURRVAL FROM DUAL;
COMMENT ON COLUMN project.openStatus IS 0/1;
DELETE FROM project;
-- # 프로젝트 멤버 테이블
DROP TABLE projectMember;

CREATE TABLE projectMember (
	prjno	number		NOT NULL,
	owner	varchar2(50)		NOT NULL,
	part	varchar2(100)		NOT NULL,
	foreign key(prjno) references project(prjno)
    on delete CASCADE,
    foreign key(owner) references emp777(id)
    on delete CASCADE
);
SELECT * FROM emp777;
SELECT deptid, dname FROM dept777;
SELECT e.id, e.ename, e.job, d.dname FROM emp777 e, dept777 d;
SELECT * FROM project;

INSERT INTO projectMember values(20,'emp2@gmail.com','마케팅');
SELECT * FROM projectMember;
ALTER TABLE projectMember ADD CONSTRAINT PK_ProjectMember PRIMARY KEY (
	prjno,owner
);
SELECT * FROM project p, projectmember m WHERE p.prjno=m.prjno;
-- # 사원 테이블
DROP TABLE emp777;
--emp auth 1이면 사원
INSERT INTO emp777 values('emp1@gmail.com','emp1','홍사원','010-2222-1111','1','10',sysdate,'사원');
INSERT INTO emp777 values('emp2@gmail.com','emp2','박사원','010-2124-1111','1','10',sysdate,'사원');
INSERT INTO emp777 values('emp3@gmail.com','emp3','금사원','010-3435-1111','1','10',sysdate,'사원');
INSERT INTO emp777 values('admin1@gmail.com','admin1','김관리','010-1111-2222','1','10',sysdate,'PM');
INSERT INTO emp777 values('admin2@gmail.com','admin2','고관리','010-1211-2222','1','20',sysdate,'PM');
INSERT INTO emp777 values('emp4@gmail.com','emp4','김대리','010-1111-2222','1','20',sysdate,'대리');
INSERT INTO emp777 values('emp5@gmail.com','emp5','송대리','010-1111-2222','1','20',sysdate,'대리');
INSERT INTO emp777 values('emp6@gmail.com','emp6','구과장','010-1111-2222','1','30',sysdate,'과장');
INSERT INTO emp777 values('emp7@gmail.com','emp7','주대리','010-1111-2222','1','30',sysdate,'대리');
UPDATE emp777 SET ename='이민지' WHERE pass='emp7';
DELETE FROM emp777 WHERE ename='김관리';

select * FROM emp777;
CREATE TABLE emp777 (
	id	varchar2(50)	PRIMARY key,
	pass	varchar2(15)		NULL,
	ename	varchar2(30)		NOT NULL,
	cell	varchar2(15)		NULL,
	auth	char(1)		NULL,
	deptid	varchar2(30)		NOT NULL,
	hiredate	date		NULL,
	job	varchar2(30)		NULL,
	foreign key(deptid) references dept777(deptid)
    on delete cascade
);
-- # 부서 테이블
DROP TABLE dept777;
INSERT INTO dept777 VALUES('10','개발','');
INSERT INTO dept777 VALUES('20','마케팅','');
INSERT INTO dept777 VALUES('30','디자인','');
UPDATE dept777 SET dname='개발' WHERE deptid='10';
CREATE TABLE dept777 (
	deptid	varchar2(30)		PRIMARY key,
	dname	varchar2(100)		NULL,
	parentDept	varchar2(30)		NULL
);
SELECT * FROM dept777;


-- ##간트차트
DROP TABLE gantt;
CREATE TABLE gantt(
	id varchar2(100) PRIMARY KEY,
	text varchar2(500),
	type varchar2(100),
	start_date varchar2(100),
	progress NUMBER,
	owner varchar2(100),
	parent varchar2(100),
	duration NUMBER,
	OPEN char(1),	--1이면 TRUE, 0 이면 false
	prjno NUMBER,
	description varchar2(4000),
	foreign key(prjno) references project(prjno)
    on delete CASCADE
);
ALTER TABLE gantt ADD (description varchar2(4000));
-- 업무내용 추가함
ALTER TABLE gantt MODIFY parent varchar2(100);
ALTER TABLE gantt RENAME COLUMN startDate TO start_date;
INSERT INTO gantt values(gantt_seq.nextval,'테스트프로젝트1','gantt.config.types.project','2023-03-01',0,NULL,NULL,NULL,1,55);
INSERT INTO gantt values(gantt_seq.nextval,'테스트업무1','gantt.config.types.task','2023-03-01',0,'홍사원',23,8,null,55);
INSERT INTO gantt values(gantt_seq.nextval,'테스트업무2','gantt.config.types.task','2023-03-05',0,'금사원',23,7,null,55);
INSERT INTO gantt values(gantt_seq.nextval,'테스트업무3','gantt.config.types.task','2023-03-07',0,'금사원',23,5,null,55);

SELECT * FROM gantt;
SELECT * FROM link;
SELECT * FROM gantt g, link l WHERE g.id=

DELETE FROM gantt;
update gantt set text='수정테스트',
start_date='Sun Mar 05 2023 00:00:00 GMT 0900 (한국 표준시)', 
progress=0.6, owner='금사원', 
parent=26 , duration=6 where id=29;
SELECT g.*,p.TLID  FROM gantt g, project p WHERE g.PRJNO =p.PRJNO AND p.prjno=55 ORDER BY START_date;
SELECT g.*,l.*,p.TLID  FROM gantt g, project p,link l WHERE g.PRJNO =p.PRJNO AND l.gid=g.id AND p.prjno=55;
DROP TABLE link;
CREATE TABLE link(
	id varchar2(100) PRIMARY KEY,
	source varchar2(100),
	target varchar2(100),
	type varchar2(1),
	prjno NUMBER,
	foreign key(prjno) references project(prjno)
    on delete CASCADE,
    foreign key(source) references gantt(id)
    on delete CASCADE,
    foreign key(target) references gantt(id)
    on delete CASCADE
);
DELETE FROM link;
SELECT * FROM link;
SELECT * FROM gantt;
SELECT * FROM project p, gantt g, link l WHERE p.PRJNO =g.prjno AND p.prjno=l.prjno;
SELECT * FROM gantt g, link l WHERE g.id=l.gid;
SELECT * FROM PROJECT p, gantt g WHERE p.prjno=g.prjno;
DROP SEQUENCE gantt_seq;
CREATE SEQUENCE gantt_seq
START WITH 1
MINVALUE 1;
CREATE SEQUENCE link_seq
START WITH 1
MINVALUE 1;
SELECT * FROM PROJECTMEMBER;
DELETE FROM projectmember WHERE prjno=66 AND owner='emp7@gmail.com';

SELECT * FROM dept WHERE PARENTDEPT IS null;
SELECT * FROM CALENDAR;
SELECT * FROM PROJECT WHERE lower(subject) LIKE '%'||lower('d')||'%';
SELECT d.dname, e.job, e.ename FROM dept777 d, emp777 e, project p
WHERE p.PRJNO =51 AND e.id=p.TLID AND e.DEPTID =d.DEPTID ;
SELECT d.dname,e.job, m.part, e.ename FROM dept777 d, emp777 e, projectmember m
WHERE m.prjno=51 AND m.owner=e.id AND e.deptid=d.deptid;
SELECT g1.*, g2.TEXT FROM gantt g1, gantt g2, link l WHERE g2.id=l.SOURCE AND g1.id=l.TARGET ;
SELECT g1.*, to_char(to_date(g1.START_DATE,'yyyy-mm-dd') + g1.duration,'yyyy-mm-dd') AS end_date,
g2.text AS parentText from gantt g1 LEFT join gantt g2 ON g1.PARENT =g2.ID where g1.prjno=23 AND g1.id='1678242824344';
SELECT * FROM link;
SELECT * FROM gantt;
UPDATE gantt SET progress=0.5 WHERE id='1678242824344';
SELECT min(START_DATE) AS mindate,
to_char(MAX(to_date(start_date,'yyyy-mm-dd') + duration),'yyyy-mm-dd') AS maxdate 
FROM gantt WHERE PRJNO =61;

SELECT p.*, ename FROM project p, emp777 e WHERE p.tlid=e.ID;
SELECT rownum cnt, p.*,e.ename, d.dname FROM project p,emp777 e, dept777 d 
	WHERE 1=1 and openstatus='0' AND e.id=p.tlid and d.deptid=p.deptid
	and cnt BETWEEN 5 AND 8;
	
	select * from (select rownum, d.dname, e.ename, e.job, e.id from emp e, dept d 
	where 1=1 and  e.deptid = d.deptid AND 
	(e.ename like '%'||''||'%' or d.dname like '%'||''||'%')
	and d.dname NOT LIKE '최고경영진';
	--where rm between #{start} and #{end};
	SELECT d.dname, e.ename, e.job, e.id FROM emp e, dept d WHERE 1=1 AND e.deptid=d.deptid AND (e.ename LIKE '%'||''||'%' OR d.dname LIKE '%'||''||'%')
	AND dname NOT LIKE '최고경영진';