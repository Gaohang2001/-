-- 创建部门表
CREATE TABLE dept(
 id INT PRIMARY KEY AUTO_INCREMENT,
 NAME VARCHAR(20)
);

INSERT INTO dept (NAME) VALUES ('开发部'),('市场部'),('财务部');

-- 创建员工表
CREATE TABLE emp (
 id INT PRIMARY KEY AUTO_INCREMENT,
 NAME VARCHAR(10),
 gender CHAR(1), -- 性别
 salary DOUBLE, -- 工资
 join_date DATE, -- 入职日期
 dept_id INT,
 FOREIGN KEY (dept_id) REFERENCES dept(id) -- 外键，关联部门表(部门表的主键)
);

INSERT INTO emp(NAME,gender,salary,join_date,dept_id) VALUES('孙悟空','男',7200,'2013-02-24',1);
INSERT INTO emp(NAME,gender,salary,join_date,dept_id) VALUES('猪八戒','男',3600,'2010-12-02',2);

INSERT INTO emp(NAME,gender,salary,join_date,dept_id) VALUES('唐僧','男',9000,'2008-08-08',2);
INSERT INTO emp(NAME,gender,salary,join_date,dept_id) VALUES('白骨精','女',5000,'2015-10-07',3);
INSERT INTO emp(NAME,gender,salary,join_date,dept_id) VALUES('蜘蛛精','女',4500,'2011-03-14',1);


-- 1、查询所有的员工信息 和对应的部门信息
SELECT emp.*,dept.* FROM  emp  LEFT JOIN dept ON emp.dept_id = dept.id;	
-- 2、查询员工表的名称,性别,部门表的名称
SELECT emp.NAME,emp.gender,dept.NAME FROM emp,dept WHERE emp.dept_id=dept.id;
-- 3、内连接(取交集)
SELECT dept.NAME,emp.NAME FROM dept,emp FROM dept.id=emp.dept_id; 

SELECT e.NAME,e.gender,d.NAME 'dept ' FROM emp e, dept d WHERE e.dept_id = d.id
-- 4、添加一个新的职工 小明
INSERT INTO emp VALUE(6,'小明','男',1000,'2020-01-01',3);
-- 5、左连接查询
SELECT e.*,d.* FROM emp AS e LEFT JOIN dept AS d ON e.dept_id=d.id; MAX(sal)
-- 6、右连接查询
SELECT e.*,d.* FROM emp AS e RIGHT JOIN dept AS d ON e.dept_id=d.id; 
-- 7、添加一个新的部门emp
INSERT INTO dept VALUE (4,'EMP');
-- 8、查询工资最高的员工信息
SELECT * FROM emp WHERE salary = (SELECT MAX(salary) FROM emp);
-- 9、查询最高的工资是多少 9000
SELECT MAX(salary) FROM emp ;
-- 10、查询员工的信息,并且工资等于9000
SELECT * FROM emp  WHERE salary =9000;
-- 11、查询员工的工资小于平均工资的人  单行单列
SELECT NAME FROM emp WHERE salary<(SELECT AVG(salary) FROM emp);
-- 12、查询财务部所有的员工信息
SELECT dept.NAME,emp.* FROM emp RIGHT JOIN dept ON dept.id=emp.dept_id WHERE  dept.NAME= '财务部';

-- 13、查询财务部所有的员工信息 和 市场部的员工信息  多行单列
SELECT emp.* ,dept.name FROM dept JOIN emp ON dept.id = emp.dept_id WHERE dept.name = '市场部' OR dept.name ='财务部';
-- 14、查询 员工的入职日期是2011-11-11 之后的员工信息 和 部门信息 .多行多列
SELECT emp.*,dept.name FROM dept JOIN emp ON dept.id = emp.dept_id WHERE emp.join_date>'2011-11-11';
-----------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE  book (
  BID CHAR(10) NOT NULL,
  title CHAR(50) DEFAULT NULL,
  author CHAR(20) DEFAULT NULL,
  PRIMARY KEY (BID)
);
INSERT INTO book VALUES ('B001', '人生若只如初见', '安意如');
INSERT INTO book VALUES ('B002', '入学那天遇见你', '晴空');
INSERT INTO book VALUES ('B003', '感谢折磨你的人', '如娜');
INSERT INTO book VALUES ('B004', '我不是教你诈', '刘庸');
INSERT INTO book VALUES ('B005', '英语四级', '白雪');
CREATE TABLE  borrow (
  borrowID CHAR(10) NOT NULL,
  stuID CHAR(10) DEFAULT NULL,
  BID CHAR(10) DEFAULT NULL,
  T_time VARCHAR(50) DEFAULT NULL,
  B_time VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (borrowID)
) ;
INSERT INTO borrow VALUES ('T001', '1001', 'B001', '2007-12-26 00:00:00', NULL);
INSERT INTO borrow VALUES ('T002', '1004', 'B003', '2008-01-05 00:00:00', NULL);
INSERT INTO borrow VALUES ('T003', '1005', 'B001', '2007-10-08 00:00:00', '2007-12-25 00:00:00');
INSERT INTO borrow VALUES ('T004', '1005', 'B002', '2007-12-16 00:00:00', '2008-01-07 00:00:00');
INSERT INTO borrow VALUES ('T005', '1002', 'B004', '2007-12-22 00:00:00', NULL);
INSERT INTO borrow VALUES ('T006', '1005', 'B005', '2008-01-06 00:00:00', NULL);
INSERT INTO borrow VALUES ('T007', '1002', 'B001', '2007-09-11 00:00:00', NULL);
INSERT INTO borrow VALUES ('T008', '1005', 'B004', '2007-12-10 00:00:00', NULL);
INSERT INTO borrow VALUES ('T009', '1004', 'B005', '2007-10-16 00:00:00', '2007-12-18 00:00:00');
INSERT INTO borrow VALUES ('T010', '1002', 'B002', '2007-09-15 00:00:00', '2008-01-05 00:00:00');
INSERT INTO borrow VALUES ('T011', '1004', 'B003', '2007-12-28 00:00:00', NULL);
INSERT INTO borrow VALUES ('T012', '1002', 'B003', '2007-12-30 00:00:00', NULL);

CREATE TABLE  student (
  stuID CHAR(10) NOT NULL,
  stuName VARCHAR(10) DEFAULT NULL,
  major VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (stuID)
);

INSERT INTO student VALUES ('1001', '林林', '计算机');
INSERT INTO student VALUES ('1002', '白杨', '计算机');
INSERT INTO student VALUES ('1003', '虎子', '英语');
INSERT INTO student VALUES ('1004', '北漂的雪', '工商管理');
INSERT INTO student VALUES ('1005', '五月', '数学');

-- 1、查询“计算机”专业学生在“2007-12-15”至“2008-1-8”时间段内借书的学生编号、学生名称、图书编号、图书名称、借出日期；
SELECT s.stuID,s.stuname,b.title,b.BID,bo.T_time FROM book AS b,student AS s,borrow AS bo 
WHERE s.stuID = bo.stuID AND b.BID = bo.BID AND 
s.major = '计算机' AND bo.T_time>='2007-12-15' AND bo.B_time<='2008-1-8';

-- 2、查询所有借过图书的学生编号、学生名称、专业；
SELECT  DISTINCT stu.stuID ,stu.stuName,stu.major FROM student AS stu, borrow AS bor 
WHERE stu.stuID  = bor.stuID ;


-- 3、查询没有借过图书的学生编号、学生名称、专业；
SELECT  DISTINCT stu.stuID ,stu.stuName,stu.major FROM student AS stu, borrow AS bor 
WHERE stu.stuID  <> bor.stuID ;

SELECT DISTINCT student.stuID,student.stuName,student.major FROM student,borrow WHERE student.stuID 
NOT IN(SELECT DISTINCT borrow.stuID FROM borrow);


-- 4、查询借过作者为“安意如”的图书的学生姓名、图书名称、借出日期、归还日期；
SELECT stu.stuName,b.title,bor.T_time,bor.B_time FROM student AS stu, borrow AS bor ,book AS b
WHERE stu.stuID = bor.stuID AND b.BID = bor.BID AND b.author = '安意如' ;
-- 5、查询借过书但有书未归还的学生编号、学生名称、图书编号、图书名称、借出日期
SELECT student.stuID ,student.stuname,b.BID,b.title,bor.T_time 
FROM student, book AS b, borrow AS bor
WHERE student.stuID = bor.stuID 
AND b.BID = bor.BID 
AND bor.B_time IS NULL 
AND bor.T_time IS NOT NULL;



SELECT student.stuID,student.stuName,book.BID,book.title,borrow.T_time FROM student,borrow,book
WHERE NOT ISNULL(borrow.T_time) AND ISNULL(borrow.B_time) AND book.BID = borrow.BID AND student.stuID = borrow.stuID;


-- 6、查询目前借书但未归还图书的学生名称及未还图书数量；
SELECT student.stuName,COUNT(1)AS '未还数量' FROM student,borrow
WHERE student.stuID = borrow.stuID 
AND borrow.B_time IS NULL 
AND borrow.T_time IS NOT NULL 
GROUP BY student.stuname;

----------------------------------
#主观题
1、Mysql 中有哪几种锁？
   行级锁
   表级锁
   页级锁

2、数据库事务的四大特征ACID是什么？
   一致性  隔离性 持久性 原子性

3、什么是脏读，不可重复读，幻读？
  1.脏读。是指当一个事务正在访问数据，并且对数据进行了修改，
    而这种修改还没有提交(COMMIT)到数据库中，这时，另外一个事务也访问这个数据，然后使用了这个数据。
    因为这个数据是还没有提交的数据，那么另外一个事务读到的这个数据是脏数据，依据脏数据所做的操作可能是不正确的。
  2.不可重复读。是指在数据库访问中，一个事务范围内两个相同的查询却返回了不同数据。这是由于查询时系统中其他事务修改的提交而引起的
  3.幻读。指同一个事务内多次查询返回的结果集不一样（比如增加了或者减少了行记录）。
    比如同一个事务A内第一次查询时候有n条记录，但是第二次同等条件下查询却又n+1条记录，这就好像产生了幻觉。
  

4、数据库的隔离级别有哪些？
        1.读未提交

        2.读已提交

        3.可重复读 数据库默认开启

        4.串行化