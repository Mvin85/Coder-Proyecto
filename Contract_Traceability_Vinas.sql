CREATE table employees_table (
	EmployeeID int NOT null auto_increment
,	Last_Name varchar(255) not NULL
,	First_Name varchar(255) not null
-- costo del empleado por hora
,	LCR float
,	Home_Location varchar(30) not null
,	Work_Location varchar(30) not null
-- total de horas cargadas por el empleado en un mes
,	Hours_month decimal (3,2) default (160) -- max hours in a month 744
,	tax_employee_id int not null

,	primary key (EmployeeID)
,	foreign key (tax_employee_id) references taxes(tax_id)
);



CREATE table Contract_Table (
	Contract_ID int not null auto_increment
,	Contract_Name varchar (255) not null
,	start_Date date default (CURRENT_DATE()) not NULL
,	Finish_Date date not NULL
,	Status varchar (255) not null -- example: on going, finished, on hold
,	Total_Contract_Revenue float
,	Total_Contract_cost float  -- sumar los registros con sus respectivas horas submitidas en la tabla contract_hours
,	Total_Contract_Margin decimal (5,3) -- as (Total_Contract_Revenue - Total_Contract_cost) / Total_Contract_Revenue
,	Contract_Location int not null
,	tax_contract_id int
,	primary key (Contract_ID)
,	foreign key (tax_contract_id) references taxes(tax_id)
,	foreign key (contract_location) references country(ID_country)
);



create table Contract_hours (
--	entrada de empleado añadiendo hora
	ID_hours int not null auto_increment
-- fecha que el empleado subio las horas
,	hour_date date default (CURRENT_DATE()) not NULL
,	EmployeeID int not null
,	Employee_LCR float not null
,	Employee_tax int not null
,	Employee_Contract_Hours decimal (10,2) -- amount of hours employee is submitting
,	Contract_Id int not null
,	Contract_Name varchar (255) not null
,	Country_Location varchar (255) not null
,	Country_tax int not null
-- ,	check (Employee_tax==Country_tax) else (Employee_LCR as Employee_LCR*taxes.tax_increase) -- check tax location diference and if different apply cost increment
,	primary key (ID_hours)
,	foreign key (EmployeeID) references employees_table(EmployeeID)
,	foreign key (Contract_Id) references Contract_Table(Contract_ID)
,	foreign key (Country_tax) references taxes(tax_id)
,	foreign key (Employee_tax) references taxes(tax_id)
)

create table Contract_Other_Costs(
-- other costs a contract can incur apart from payroll
	ID_Other_Costs int not null auto_increment
,	Other_Cost_Name varchar (200) not null
,	Other_Cost_cost float
,	Other_Cost_date date default (CURRENT_DATE()) not NULL
,	Contract_ID int not null
,	Contract_Name varchar(250)
,	primary key (ID_Other_Costs)
,	foreign key (Contract_ID) references Contract_Table(Contract_ID)
)



create table Contract_Revenues(
	ID_Revenues int not null auto_increment-- revenues a contract can recognize
,	Revenues_Name varchar (200) not null
,	Revenues_Recognized float
,	Revenue_date date default (CURRENT_DATE()) not NULL
,	Contract_ID int not null
,	Contract_Name varchar(250)
,	primary key (ID_Revenues)
,	foreign key (Contract_ID) references Contract_Table(Contract_ID)
)

create table country (
	ID_Country int not null auto_increment
,	Country_Name varchar (30)
,	taxes int not null
,	primary key (ID_Country)
,	foreign key (taxes) references taxes(tax_id)
)


create table taxes (
-- tax id representa el pais que paga impuestos,
-- 1: Argeninta, 2: Colombia, 3: Chile , 4: USA
-- si el tax id empleado no coincide con el tax id contract se cobrara un impuesto, caso contrario ya esta incluido en el costo del empleado.
	tax_id int not null auto_increment
,	tax_name varchar (200) not null -- ej: argentina
,	tax_increase decimal (3,2) not null check (tax_increase <=100)  -- ej: 30% es el porcentaje que paga el employee por trabajar en este pais siendo de otro
,	primary key (tax_id)
);








