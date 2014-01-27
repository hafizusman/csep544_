CREATE TABLE InsuranceCo(
	name	text PRIMARY KEY,
	phone	varchar(25)
);

CREATE TABLE Vehicle(
	licenceplate	text PRIMARY KEY,
	year		integer,
	maxliability	integer,
	maxlossdamag	integer,
	insurer		name REFERENCES InsuranceCo,
	owner		char(11) REFERENCES Person
);

CREATE TABLE Person(
	ssn		char(11) PRIMARY KEY,
	name		text
);

CREATE TABLE Driver(
	licencenumber	text PRIMARY KEY,
	id		char(11) REFERENCES Person
);

CREATE TABLE Drives(
	licenceplate	text REFERENCES Car,
	licencenumber	text REFERENCES NonProfessionalDriver
);

CREATE TABLE Car(
	plate 		text PRIMARY KEY REFERENCES Vehicle,
	make		text
);

CREATE TABLE Truck(
	plate 		text REFERENCES Vehicle,
	capacity	integer,
	licenceNo	text REFERENCES ProfessionalDriver
);

CREATE TABLE NonProfessionalDriver(
-- NOTE: here the assumption is that a person gets a driver, his/her entry is added to the Driver
--		table. Once the driver owns a car, an entry is created in the NonProfessionalDriver
--		relation since now he/she is eligible to drive.
--	This also gives the flexibility of adding new attributes to the NonProfessionalDriver
--	table without causing update anomalies in Drivers.
--	Finally, a Driver can be both in the NonProfessionalDriver and ProfessionalDriver tables
	licencenum	text PRIMARY KEY REFERENCES Driver

);

CREATE TABLE ProfessionalDriver(
	licencenum	text PRIMARY KEY REFERENCES Driver,
	medicalhistory	text
);
