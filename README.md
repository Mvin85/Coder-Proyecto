Proyecto: Plataforma de trazabilidad de contratos

Alumno: Martin Viñas

Docente: Anderson Michel Torres


Introducción

Me propongo crear una base de datos para una organizacion donde pueda llevar de manera confibale las transacciones que impactan en los distintos contratos de la misma y sus ingresos, con el fin de unificar y obtener metricas rapidamente de costos por geografia o distintos margenes de contratos por cantidad de empleados, piramides de costos por contrato, entre otros-

Se relacionan de la siguiente manera:


![image](https://github.com/user-attachments/assets/7da298e6-7d0d-4df8-bf8a-651b2499c085)


Tablas
Mi base de datos cuenta con 7 tablas relacionadas entre si:

1) Employees_Table : tabla donde se almacenan los datos de los empleados de la organizaicon como su ID (EmployeeID) , costo por hora (LCR) y las horas maximas que pueden cargar en el mes (Hours_month), entre otros valores. Su fin es tener de manera segura y organizacada almacenado los datos criticos de empleados que despues migraran a otras tablas. Ademas, contiene el pais del empleado y el tipo de impuesto que este tributa.

	Primary Key: EmployeeID

	Foreign key: tax_employee_id reference taxes(tax_id)

2) Contract_Table: tabla donde se almacena informacion de los contratos de la organizacion, como el Contract_ID (ID del contrato unico), fecha de inicio y finalizacion del contrato, su status (en curso, finalizado o en espera) como tambien el pais al que tributa el contrato, su ingreso, costo y por ultimo margen operativo.

    Primary Key: Contract_ID
   
    Foreign key: tax_contract_id reference taxes(tax_id)
   
    foreign key: (contract_location) references country(ID_country)

3) Contract_hours: tabla donde se almacena las horas cargadas por cada empleado en determinado contrato a determinada fecha para determinado mes, con el fin de contabilizar el costo mensual de nomina por contrato por mes, cuenta con el contract ID, empleado ID, y compara entre el impuesto del contrato vs el del empleado, si estos son diferentes se aplica un aumento en el costo del empleado.

	  primary key: (ID_hours)
   
	  foreign key: (EmployeeID) references employees_table(EmployeeID)
   
	  foreign key: (Contract_Id) references Contract_Table(Contract_ID)
   
	  foreign key: (Country_tax) references taxes(tax_id)
   
	  foreign key: (Employee_tax) references taxes(tax_id)


4) Contract_Other_Costs: tabla que almacena otros costos que no entran por nomina, tiene un id unico por registro ingresado y utiliza el Contract ID para detallar a que contrato se carga dicho costo, es importante de igual manera la fecha.

    primary key: (ID_Other_Costs)
   
    foreign key: (Contract_ID) references Contract_Table(Contract_ID)
   


5) Contract_Revenues: tabla que detalla registros de ingresos percibidos por contratos, utiliza el contract ID para identificar que contrato recibe ese ingreso y en que fecha (mes).

	primary key (ID_Revenues)
   
	foreign key: (Contract_ID) references Contract_Table(Contract_ID)
   
6) country: tabla simple que almacena los distintos paises que opera la organizacion de manera que con un simple Country_ID se pueda identificar el pais sin necesidad de gastar caracteres en el resto de las tablas, almacena de igual manera el tax para cada pais.

    primary key : (ID_Country)
    
    foreign key: (taxes) references taxes(tax_id)
    


7) taxes: la tabla taxes almacena cada taxID unico para identificar que tax (numero) aplica para cada pais con el fin de diferenciar y poner un porcentaje de incremento en el costo del empleado si no coincide con el pais del tax.

     primary key: (tax_id)




