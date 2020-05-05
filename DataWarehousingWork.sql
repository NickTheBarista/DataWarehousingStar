CREATE TABLE time
(
time_code     INT,
order_date    DATE,
month_code    SMALLINT,
month_name    CHAR(10),
quarter_code  SMALLINT,
quarter_name  CHAR(10),
year INTEGER
);

CREATE TABLE geography 
(
district_code  SERIAL,
district_name  CHAR(15),
state_code     CHAR(2),
state_name     CHAR(18),
region         SMALLINT
);

CREATE TABLE product (
product_code   INTEGER,
product_name   CHAR(31),
vendor_code    CHAR(3),
vendor_name    CHAR(15),
product_line_code  SMALLINT,
product_line_name  CHAR(15)
);
/
CREATE TABLE customer (
customer_code  INTEGER,
customer_name  CHAR(31),
company_name   CHAR(20)
);


CREATE TABLE geography 
(
district_code  SERIAL,
district_name  CHAR(15),
state_code     CHAR(2),
state_name     CHAR(18),
region         SMALLINT
);

CREATE TABLE DIM_PRODUCT(
PRODUCT_KEY   INTEGER,
PRODUCT_ID   INTEGER,
PRODUCT_NAME  CHAR(31),
PRODUCT_TYPE    CHAR(3),
PRODUCT_CATEGORY   CHAR(15),
PRODUCT_SUB_CATEGORY  SMALLINT,
PRODUCT_SIZE  CHAR(15),
PRODUCT_WEIGHT  CHAR(31),
PRODUCT_UNIT_COST   CHAR(3),
PRODUCT_LIST_PRICE   CHAR(15),
PRODUCT_ACTV_RCRD_FL  DATE,
PRODUCT_ACTV_RCRD_START_DT_KEY DATE,
PRODUCT_ACTV_RCRD_END_DT_KEY  DATE,
PRODUCT_INSERT_DTM  CHAR(15),
  CONSTRAINT supplier_pk PRIMARY KEY (PRODUCT_KEY )
    ,CONSTRAINT supplier_pk PRIMARY KEY (PRODUCT_ID)
     
);
CREATE TABLE FACT_SALE (
SALE_MONTH_KEY   INTEGER,
SALE_PRODUCT_KEY INTEGER,
SALE_STORE_KEY  INTEGER,
SALE_QTY    INTEGER,
SALE_AMT  INTEGER
, CONSTRAINT supplier_pk PRIMARY KEY (SALE_MONTH_KEY,SALE_PRODUCT_KEY,SALE_STORE_KEY)
, CONSTRAINT supplier_pk FOREIGN KEY (SALE_STORE_KEY)
, CONSTRAINT supplier_pk FOREIGN KEY (SALE_MONTH_KEY)
, CONSTRAINT supplier_pk FOREIGN KEY (SALE_PRODUCT_KEY)
);

CREATE TABLE DIM_STORE (
STORE_KEY   INTEGER,
STORE_ID INTEGER,
STORE_NAME  CHAR(31),
STORE_CITY    CHAR(31),
STORE_POSTAL_CODE   CHAR(2),
STORE_COUNTRY CHAR(31),
STORE_DISTRICT  CHAR(31),
STORE_ACTV_RCRD_FL    DATE,
STORE_ACTV_RCRD_START_DT_KEY DATE,
STORE_ACTV_RCRD_END_DT_KEY  DATE,
STORE_INSERT_DTM DATE,
, CONSTRAINT supplier_pk PRIMARY KEY (STORE_KEY)
);
CREATE TABLE Customer (
customer_code  INTEGER,
customer_name  CHAR(31),
company_name   CHAR(20)
);
CREATE TABLE BABY_NAMES_RF (
customer_code  INTEGER,
customer_name  CHAR(31),
company_name   CHAR(20)
);
CREATE TABLE DEFINITION (
TABLE_NAME  INTEGER,
COULMN_Name  CHAR(31),
DESCRITION_NAME   CHAR(20),
COMMENTS   CHAR(20)
);
CREATE TABLE POPULTAION_RF (
PLACE   CHAR(31),
POPULTAION  INTEGER,
lat   NUMBER(7,-2),
longt NUMBER(7,-2)
);
CREATE TABLE LIFE_SPAN_RF (
REF_DATE   DATE,
GEO   NUMBER(7,-2,
SEX CHAR(2),AGE CHAR(31),VECTOR NUMBER(7,-2),	
COORDINATES NUMBER(7,-2),
LIFE_SPAN_RF NUMBER(7,-2)
);

CREATE TABLE Employee (
Employee_key   INTEGER,
Employee_Name  CHAR(31),
Employee_Title CHAR(31),	
Employee_Manager CHAR(31)
);
CREATE TABLE EMPLOYEES 
(Emp# NUMBER(5), 
 Lastname VARCHAR(30), 
 Firstname VARCHAR(30), 
 Job_class CHAR(4));
CREATE TABLE Payment_Type (
Payment_Type_Key   CHAR(31),
Payment_Type_Description  CHAR(100),
Payment_Type_Category CHAR(10)
);
CREATE TABLE Promotion (
Promotion_Key   CHAR(31),
Promotion_Description  CHAR(100),
Promotion_Category CHAR(10)
);
/*Index*/


CREATE BITMAP INDEX sales_cust_gender_ms_bjix
ON sales(customers.cust_gender, customers.cust_marital_status)
FROM sales, customers
WHERE sales.cust_id = customers.cust_id
LOCAL NOLOGGING COMPUTE STATISTICS;

CREATE BITMAP INDEX sales_c_gender_p_cat_bjix
ON sales(customers.cust_gender, products.prod_category)
FROM sales, customers, products
WHERE sales.cust_id = customers.cust_id
AND sales.prod_id = products.prod_id
LOCAL NOLOGGING COMPUTE STATISTICS;

/*Integrity Constraints*/
ALTER TABLE sales ADD CONSTRAINT sales_uk
UNIQUE (prod_id, cust_id, promo_id, channel_id, time_id);
ALTER TABLE sales ADD CONSTRAINT sales_time_fk
FOREIGN KEY (time_id) REFERENCES times (time_id) 
RELY DISABLE NOVALIDATE;
/*data Compresion*/
CREATE TABLE costs_demo (
   prod_id     NUMBER(6),    time_id     DATE, 
   unit_cost   NUMBER(10,2), unit_price  NUMBER(10,2))
PARTITION BY RANGE (time_id)
   (PARTITION costs_old 
       VALUES LESS THAN (TO_DATE('01-JAN-2003', 'DD-MON-YYYY')) COMPRESS,
    PARTITION costs_q1_2003 
       VALUES LESS THAN (TO_DATE('01-APR-2003', 'DD-MON-YYYY')),
    PARTITION costs_q2_2003
       VALUES LESS THAN (TO_DATE('01-JUN-2003', 'DD-MON-YYYY')),
    PARTITION costs_recent VALUES LESS THAN (MAXVALUE));
/*Summary TABLE*/
CREATE TABLE Employee (
department   INTEGER,
region  CHAR(31),
quarter CHAR(31),	
Month CHAR(31),Count_Sales,
Count_Profit
,Count_Unit_Sales
,Sum_Sales
,Sum_Cost,
,Sum_Profit,Sum_Unit_Sales

);


CREATE TABLE FACT_SALE (
SALE_PRODUCT_KEY INTEGER,
SALE_MONTH_KEY   INTEGER,
SALE_STORE_KEY  INTEGER,
SALE_QTY    INTEGER,
SALE_AMT  INTEGER
, CONSTRAINT supplier_pk PRIMARY KEY (SALE_MONTH_KEY,SALE_PRODUCT_KEY,SALE_STORE_KEY)
, CONSTRAINT supplier_pk FOREIGN KEY (SALE_STORE_KEY)
, CONSTRAINT supplier_pk FOREIGN KEY (SALE_MONTH_KEY)
, CONSTRAINT supplier_pk FOREIGN KEY (SALE_PRODUCT_KEY)
);

CREATE TABLE SALES ( 
SALES_ID NUMBER(7,0) PRIMARY KEY, 
COUNTRY_ID NUMBER(7,0) REFERENCES COUNTRY NOT NULL, 
SALES_OUTLET_ID NUMBER(7,0) REFERENCES SALES_OUTLET NOT NULL, 
DISTRIBUTION_CHANNEL_ID NUMBER(7,0) REFERENCES DISTRIBUTION_CHANNEL NOT NULL, 
PRODUCT_CATEGORY_ID NUMBER(7,0) REFERENCES PRODUCT_CATEGORY NOT NULL, 
PRODUCT_ID NUMBER(7,0) REFERENCES PRODUCT NOT NULL, 
SALES_YEAR NUMBER(4) NOT NULL,  
SALES_MONTH VARCHAR(3) NOT NULL, 
SALES_REVENUE NUMBER(20,0) NOT NULL, 
SALES_QUANTITY NUMBER (20) NOT NULL 
)

