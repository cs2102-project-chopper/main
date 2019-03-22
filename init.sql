drop table if exists Restaurants, Outlets, Ratings, Cuisines
cascade;
drop table if exists Reservations, Reserves, Points, Users, Members, Guests
cascade;
drop table if exists  Preferences, Food, Seats
cascade;

create table Members
(
    userid integer,
    primary key (userid)
);

create table Guests
(
    userid integer,
    primary key (userid)
);

create table Cuisines
(
    cuisineType varchar (50),
    primary key (cuisineType)
);

create table Restaurants
(
    rid integer,
    rname varchar (50) not null,
    totalSeats integer not null,
    cuisineType varchar(50) not null,
    primary key (rid),
    foreign key (cuisineType) references Cuisines
);

create table Food
(
    rid integer,
    fname varchar (50) not null,
    price numeric(38, 2) not null,
    primary key (rid,fname),
    foreign key (rid) references Restaurants on delete cascade
);

create table Users
(
    userid integer,
    username varchar(50) unique not null,
    userpassword varchar(100) not null,
    fullName varchar (50) not null,
    phoneNo varchar unique not null,
    primary key (userid)
);

create table Reservations
(
    rsvid integer,
    rsvDate date not null,
    rsvHour time not null,
    numOfPeople integer not null,
    userid integer,
    primary key (rsvid),
    foreign key (userid) references Users
);

create table Points
(
    pid integer,
    pointNumber integer not null,
    rsvid integer references Reservations,
    userid integer references Members,
    primary key (pid),
    unique (pid, userid, rsvid)
);

create table Outlets
(
    outid integer,
    postalCode integer not null,
    unitNo varchar(10) not null,
    area varchar(100) not null,
    openingTime time not null,
    closingTime time not null,
    totalSeats integer not null,
    rid integer not null,
    primary key (outid),
    foreign key (rid) references Restaurants,
    unique (postalCode, unitNo)
);

create table Seats
(
    outid integer not null,
    openingHour time not null,
    openingDate date not null,
    seatsAvailable integer,
    primary key (outid, openingHour, openingDate),
    foreign key (outid) references Outlets
);

create table Reserves
(
    rsvid integer,
	seatsAssigned integer not null,
    outid integer not null,
    openingHour time not null,
    openingDate date not null,
    primary key (rsvid),
    foreign key (rsvid) references Reservations,
    foreign key (outid, openingHour, openingDate) references Seats (outid, openingHour, openingDate)
);

create table Ratings
(
    ratingid integer,
    review varchar(255),
    userid integer,
    rid integer,
    ratingscore integer not null,
    primary key (ratingid),
    foreign key (userid) references Users,
    foreign key (rid) references Restaurants
);

create table Preferences
(
    prefid integer,
    area varchar(50) not null,
    maxPrice integer not null,
    minScore integer not null,
    userid integer not null,
    cuisineType varchar(50) not null,
    primary key (prefid),
    foreign key (cuisineType) references Cuisines,
    foreign key (userid) references Members,
    unique (prefid, userid, area)
); 
