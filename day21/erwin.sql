CREATE TABLE Book
(
	bookname             VARCHAR(40) NOT NULL,
	price                INTEGER NOT NULL,
	bookid               INTEGER NOT NULL,
	pubname              VARCHAR(40) NOT NULL
);

ALTER TABLE Book
ADD PRIMARY KEY (bookid);

CREATE TABLE Customer
(
	name                 VARCHAR(40) NOT NULL,
	address              VARCHAR(40) NOT NULL,
	phone                VARCHAR(30) NOT NULL,
	custid               INTEGER NOT NULL
);

ALTER TABLE Customer
ADD PRIMARY KEY (custid);

CREATE TABLE Orders
(
	orderid              varchar(45) NOT NULL,
	orderdate            DATE NOT NULL,
	saleprice            INTEGER NOT NULL,
	custid               INTEGER NULL,
	bookid               INTEGER NULL
);


ALTER TABLE Orders
ADD PRIMARY KEY (orderid);

CREATE TABLE Publisher
(
	pubname              VARCHAR(40) NOT NULL,
	officephone          VARCHAR(30) NOT NULL,
	stname               VARCHAR(40) NOT NULL
);


ALTER TABLE Publisher
ADD PRIMARY KEY (pubname);


ALTER TABLE Book
ADD FOREIGN KEY R_10 (pubname) REFERENCES Publisher (pubname);



ALTER TABLE Orders
ADD FOREIGN KEY R_8 (custid) REFERENCES Customer (custid);



ALTER TABLE Orders
ADD FOREIGN KEY R_9 (bookid) REFERENCES Book (bookid);



