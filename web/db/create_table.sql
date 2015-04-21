CREATE TABLE Event
(
OrganizerId int not null,
EventId int not null AUTO_INCREMENT,
EventTitle varchar(100) not null,
EventStartTime DATETIME not null,
EventEndTime DATETIME not null,
EventDescription varchar(1000) not null,
EventLogo varchar(100),
Privacy tinyint not null,
PRIMARY KEY (EventId)
);
