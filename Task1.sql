###################TASK 1###################

CREATE DATABASE  IF NOT EXISTS warehouse;


CREATE TABLE IF NOT EXISTS warehouse (
	warehouseNumber  INT NOT NULL,
    PRIMARY KEY ( warehouseNumber ),
    warehouseName  VARCHAR ( 15 ),
    streetNumber  VARCHAR ( 20 ),
    streetName  VARCHAR ( 20 ),
    city VARCHAR ( 9 ) CHECK (city IN ( 'Brisbane', 'Melbourne', 'Sydney') ),
    suburb  VARCHAR ( 20 ),
    state  CHAR ( 3 ) CHECK (state IN ( 'QLD', 'NSW', 'SA', 'ACT', 'VIC', 'WA', 'NT' ) ),
    postcode  CHAR ( 4 ),
    warehouseHeadName  VARCHAR( 20 ),
    numberEmployees  INT DEFAULT 1 
);

CREATE TABLE IF NOT EXISTS publisher (
	publisherCode INT NOT NULL,
    PRIMARY KEY ( publisherCode ),
    publisherName VARCHAR ( 20 ) NOT NULL,
    publisherCity VARCHAR ( 20 ),
    publisherState CHAR ( 3 ) CHECK ( publisherState IN ( 'QLD', 'NSW', 'SA', 'ACT', 'VIC', 'WA', 'NT' ) ),
    publisherEmail VARCHAR ( 35 )
);

CREATE TABLE IF NOT EXISTS author (
	authorNumber INT NOT NULL,
    PRIMARY KEY ( authorName ),
    authorName VARCHAR ( 35 ),
    authorEmail VARCHAR ( 35 ) 
);

CREATE TABLE IF NOT EXISTS item (
	itemCode VARCHAR ( 10 ) NOT NULL,
    PRIMARY KEY ( itemCode ),
    itemTitle VARCHAR ( 20 ) NOT NULL,
    publisherCode INT,
    FOREIGN KEY ( publisherCode ) REFERENCES publisher ( publisherCode ), 
    itemType VARCHAR ( 9 ) CHECK ( itemType IN ( 'paperback', 'eBook', 'other' ) ),
    stockPrice DECIMAL ( 16, 2 ),
    ISBN CHAR ( 13 )
); 

CREATE TABLE IF NOT EXISTS itemWriters (
	itemCode VARCHAR ( 10 ) NOT NULL,
    FOREIGN KEY ( itemCode ) REFERENCES item ( itemCode ),
    authorNumber INT NOT NULL,
    FOREIGN KEY ( authorNumber ) REFERENCES author ( authorNumber ),
    writerSequenceNumber VARCHAR ( 35 )
);

CREATE TABLE IF NOT EXISTS inventory (
	itemCode VARCHAR ( 10 ) NOT NULL,
    FOREIGN KEY ( itemCode ) REFERENCES item ( itemCode ),
    warehouseNumber INT NOT NULL,
    FOREIGN KEY ( warehouseNumber ) REFERENCES warehouse ( warehouseNumber ),
    unitsOnHand INT
);



