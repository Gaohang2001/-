#练习一
CREATE TABLE student(
`name` VARCHAR (20),
chinese INT,
english INT,
math INT
);
INSERT INTO student VALUES (1,'张小明',89,78,90);
INSERT INTO student VALUES(2,'李进',67,53,95);
INSERT INTO student VALUES(3,'王五',87,78,77);
INSERT INTO student VALUES(4,'李一',88,98,92);
INSERT INTO student VALUES(5,'李来财',82,84,67);
INSERT INTO student VALUES(6,'张进宝',55,85,45);
INSERT INTO student VALUES(7,'黄蓉',75,65,30); 

-- 1、 查询表中所有学生的信息。
SELECT * FROM student;
-- 2、 查询表中所有学生的姓名和对应的英语成绩。;
SELECT NAME,english FROM student;
-- 3、 统计每个学生的总分。
SELECT NAME,(chinese+english+math)'总分' FROM student;
-- 4、 在所有学生总分数上加10分特长分。
SELECT NAME,(chinese+english+math+10)'总分+特长分' FROM student;
-- 5、 使用别名表示学生分数。
SELECT NAME'姓名',chinese '语文',english '英语',math '数学' FROM student;
-- 6、 查询姓名为李一的学生成绩
SELECT * FROM student WHERE NAME='李一';
-- 7、 查询英语成绩大于90分的同学
SELECT * FROM student WHERE english ='90';
-- 8、 查询总分大于200分的所有同学
SELECT *,(chinese+english+math) FROM student WHERE(chinese+english+math)>200;
-- 9、 查询英语分数在 80－90之间的同学
SELECT * FROM student WHERE english BETWEEN 80 AND 90;




#练习二

-- 部门表
CREATE TABLE DEPT(
    DEPTNO INT PRIMARY KEY,
    DNAME VARCHAR(14), -- 部门名称
    LOC VARCHAR(13)-- 部门地址
) ;
INSERT INTO DEPT VALUES    (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES    (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES    (40,'OPERATIONS','BOSTON');


-- 员工表
DROP TABLE EMP;
CREATE TABLE EMP(
    EMPNO INT  PRIMARY KEY, -- 员工编号
    ENAME VARCHAR(10), -- 员工姓名
    JOB VARCHAR(9), -- 员工工作
    MGR INT, -- 员工直属领导编号
    HIREDATE DATE, -- 入职时间
    SAL DOUBLE, -- 工资
    COMM DOUBLE, -- 奖金
    DEPTNO INT,  -- 所在部门
    FOREIGN KEY (DEPTNO) REFERENCES DEPT(DEPTNO));  -- 关联dept表

-- ALTER TABLE EMP ADD FOREIGN KEY (DEPTNO) REFERENCES DEPT(DEPTNO);
INSERT INTO EMP VALUES(7369,'SMITH','职员',7566,"1980-12-17",800,NULL,20);
INSERT INTO EMP VALUES(7499,'ALLEN','销售员',7698,'1981-02-20',1600,300,30);
INSERT INTO EMP VALUES(7521,'WARD','销售员',7698,'1981-02-22',1250,500,30);
INSERT INTO EMP VALUES(7566,'JONES','经理',7839,'1981-04-02',2975,NULL,20);
INSERT INTO EMP VALUES(7654,'MARTIN','销售员',7698,'1981-09-28',1250,1400,30);
INSERT INTO EMP VALUES(7698,'BLAKE','经理',7839,'1981-05-01',2850,NULL,30);
INSERT INTO EMP VALUES(7782,'CLARK','经理',7839,'1981-06-09',2450,NULL,10);
INSERT INTO EMP VALUES(7788,'SCOTT','职员',7566,'1987-07-03',3000,2000,20);
INSERT INTO EMP VALUES(7839,'KING','董事长',NULL,'1981-11-17',5000,NULL,10);
INSERT INTO EMP VALUES(7844,'TURNERS','销售员',7698,'1981-09-08',1500,50,30);
INSERT INTO EMP VALUES(7876,'ADAMS','职员',7566,'1987-07-13',1100,NULL,20);
INSERT INTO EMP VALUES(7900,'JAMES','职员',7698,'1981-12-03',1250,NULL,30);
INSERT INTO EMP VALUES(7902,'FORD','销售员',7566,'1981-12-03',3000,NULL,20);
INSERT INTO EMP VALUES(7934,'MILLER','职员',7782,'1981-01-23',1300,NULL,10);

-- 工资等级表
CREATE TABLE SALGRADE(
    GRADE INT,-- 等级
    LOSAL DOUBLE, -- 最低工资
    HISAL DOUBLE ); -- 最高工资

INSERT INTO SALGRADE VALUES (1,500,1000);
INSERT INTO SALGRADE VALUES (2,1001,1500);
INSERT INTO SALGRADE VALUES (3,1501,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);

-- 1、查找部门30中员工的详细信息。
SELECT * FROM emp WHERE deptno = 30;
-- 2、找出从事职员工作的员工的编号、姓名、部门号。
SELECT ename,empno,deptno FROM emp WHERE job = '职员';
-- 3、检索出奖金多于基本工资的员工信息。
SELECT *  FROM emp WHERE comm>sal;
-- 4、检索出奖金多于基本工资60%的员工信息。
SELECT * FROM emp WHERE sal*0.6<comm;
-- 5、找出姓名中包含A的员工信息。
SELECT * FROM emp WHERE ename LIKE '%A%';
-- 6、找出姓名以A、B、S开始的员工信息。
SELECT *FROM emp WHERE ename LIKE'A%'OR ename LIKE'B%'OR ename LIKE'S%';
-- 7、找到名字长度为7个字符的员工信息。
SELECT * FROM emp WHERE ename LIKE '_______';
-- 8、名字中不包e符的员工信息。
SELECT * FROM emp WHERE eanme NOT LIKE'%E%';
-- 9、返回员工的详细信息并按姓名升序排序。
SELECT * FROM emp ORDER BY ename ASC;
-- 10、返回员工的信息并按姓名降序,工资升序排列。
SELECT * FROM emp ORDER BY ename DESC , sal ASC; 
-- 11、计算员工的日薪(按30天)。
SELECT ename,sal/30 AS '日薪' FROM emp;
-- 12、找出获得奖金的员工的工作。
SELECT ename,job FROM emp WHERE comm ;
-- 13、找出奖金少于100或者没有获得奖金的员工的信息。
SELECT * FROM emp WHERE comm<100 OR comm IS NULL;
-- 14、找出10部门的经理、20部门的职员 的员工信息。
SELECT * FROM EMP WHERE deptno IN(10,20) AND job IN('经理','职员');
-- 15、找出10部门的经理、20部门的职员 或者既不是经理也不是职员但是工资高于2000元的员工信息。
SELECT * FROM EMP WHERE deptno IN(10,20) AND job IN('经理','职员') OR  sal>2000 ;


