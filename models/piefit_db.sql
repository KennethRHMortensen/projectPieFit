/* Piefit Database */

-- Create piefit database
drop database if exists piefit;
create database piefit;
use piefit;

-- Create user table (Combined setting table with user table)
drop table if exists user;
create table user (
	userid serial,
	username varchar(20) not null unique,
	email varchar(65) not null unique,
	password varchar(30) not null,
	role boolean not null default false,
	theme enum('Standard', 'Dark mode') not null default 'Standard', -- More themes can be added later
	primary key(userid)
);

-- Insert data into user table (For test purposes)
insert into user values(null, 'Admin', 'admin@email.dk', '1234', true, 'Standard');
insert into user values(null, 'User', 'user@email.dk', '1234', false, 'Dark mode');

-- Create personal table

drop table if exists personal;
create table personal (
	personalid bigint unsigned not null,
	realname varchar(65) not null,
	gender enum('Male', 'Female', 'Non-binary', 'Other') not null,
	bio varchar(200) not null,
	primary key(personalid),
	foreign key(personalid) references user(userid) on delete cascade
);

-- Insert data into personal table (For test purposes)
insert into personal values(1, 'John Doe', 'Male', 'I''m so cool!');
insert into personal values(2, 'Jane Doe', 'Female', 'I''m awesome!');

-- Create image table
drop table if exists image;
create table image (
	imageid bigint unsigned not null,
	image blob not null,
	primary key(imageid),
	foreign key(imageid) references user(userid) on delete cascade
);

-- Create payment table
drop table if exists payment;
create table payment (
	paymentid bigint unsigned not null,
	creditcardinfo varchar(65) not null,
	cardholder varchar(65) not null,
	primary key(paymentid),
	foreign key(paymentid) references user(userid) on delete cascade
);

-- Create box table
drop table if exists box;
create table box (
	boxid serial,
	edition varchar(20) not null,
	difficultylevel decimal(2,1) not null,
	isdraft boolean not null default true,
	primary key(edition)
);

-- Insert data into box table
insert into box values(null, 'HOME EDITION', 2.8, false);
insert into box values(null, 'HIIT EDITION', 2.5, false);
insert into box values(null, 'POWER EDITION', 3.6, false);

-- Create subscribebox table (relationship)
drop table if exists subscribebox;
create table subscribebox (
	userid bigint unsigned not null,
	edition varchar(20) not null,
	primary key(userid, edition),
	foreign key(userid) references user(userid),
	foreign key(edition) references box(edition)
);

-- Create collection table
drop table if exists collection;
create table collection (
	collectionid serial,
	edition varchar(20) not null,
	musclecategory varchar(20) not null,
	difficultylevel decimal(10,1) not null,
	isdraft boolean not null default true,
	primary key(edition, musclecategory),
	foreign key(edition) references box(edition)
);

-- Insert data into collection table
insert into collection values(null, 'HOME EDITION', 'CORE', 2.7, false);
insert into collection values(null, 'HOME EDITION', 'LOWERBODY', 3, false);
insert into collection values(null, 'HOME EDITION', 'UPPERBODY', 2.8, false);
insert into collection values(null, 'HOME EDITION', 'FULLBODY', 2.7, false);
insert into collection values(null, 'HIIT EDITION', 'CORE', 3, false);
insert into collection values(null, 'HIIT EDITION', 'LOWERBODY', 3, false);
insert into collection values(null, 'HIIT EDITION', 'UPPERBODY', 3, false);
insert into collection values(null, 'HIIT EDITION', 'FULLBODY', 3, false);
insert into collection values(null, 'POWER EDITION', 'CORE', 3, false);
insert into collection values(null, 'POWER EDITION', 'LOWERBODY', 3, false);
insert into collection values(null, 'POWER EDITION', 'UPPERBODY', 3, false);
insert into collection values(null, 'POWER EDITION', 'FULLBODY', 3, false);

-- Create card table
drop table if exists card;
create table card (
	cardid serial,
	edition varchar(20) not null,
	musclecategory varchar(20) not null,
	hashtag varchar(20) not null,
	method varchar(20) not null,
	exercisename varchar(20) not null default 'Exercises',
	worktypeheading varchar(20) not null,
	difficultyheading varchar(20)  not null default 'Difficulty Level',
	difficultylevel int not null,
	backheading varchar(20) not null,
	backsubheading varchar(30) not null,
	isdraft boolean not null default true,
	primary key(hashtag),
	foreign key(edition, musclecategory) references collection(edition, musclecategory)
);

-- Insert data into card table
insert into card values(
	null,
	'HOME EDITION',
	'CORE',
	'#PiefitWashingtonDC',
	'WORK/REST',
	'Exercises',
	'25/10 SEC',
	'Difficulty Level',
	1,
	'REFERENCES',
	'BEGINNER - WARM UP - FINISHER',
	false
);

insert into card values(
	null,
	'HOME EDITION',
	'CORE',
	'#PiefitSanJose',
	'REPS/ROUNDS',
	'Exercises',
	'REPS',
	'Difficulty Level',
	2,
	'BENCHMARK',
	'BEGINNER - WARM UP - FINISHER',
	false
);

insert into card values(
	null,
	'HOME EDITION',
	'CORE',
	'#PiefitHavana',
	'AMRAP 14',
	'Exercises',
	'REPS',
	'Difficulty Level',
	2,
	'BENCHMARK',
	'BEGINNER - WARM UP - FINISHER',
	false
);

insert into card values(
	null,
	'HOME EDITION',
	'LOWERBODY',
	'#PiefitBangkok',
	'WORK/REST',
	'Exercises',
	'25/10 SEC',
	'Difficulty Level',
	1,
	'REFERENCES',
	'BEGINNER - WARM UP - FINISHER',
	false
);

insert into card values(
	null,
	'HOME EDITION',
	'LOWERBODY',
	'#PiefitTokyo',
	'REPS/ROUNDS',
	'Exercises',
	'REPS',
	'Difficulty Level',
	3,
	'BENCHMARK',
	'BEGINNER - WARM UP - FINISHER',
	false
);

insert into card values(
	null,
	'HOME EDITION',
	'LOWERBODY',
	'#PiefitJakarta',
	'AMRAP 12',
	'Exercises',
	'REPS',
	'Difficulty Level',
	3,
	'BENCHMARK',
	'BEGINNER - WARM UP - FINISHER',
	false
);

insert into card values(
	null,
	'HOME EDITION',
	'UPPERBODY',
	'#PiefitOslo',
	'WORK/REST',
	'Exercises',
	'30/10 SEC',
	'Difficulty Level',
	2,
	'REFERENCES',
	'BEGINNER - WARM UP - FINISHER',
	false
);

insert into card values(
	null,
	'HOME EDITION',
	'UPPERBODY',
	'#PiefitBucharest',
	'REPS/ROUNDS',
	'Exercises',
	'REPS',
	'Difficulty Level',
	4,
	'BENCHMARK',
	'BEGINNER - WARM UP - FINISHER',
	false
);

insert into card values(
	null,
	'HOME EDITION',
	'UPPERBODY',
	'#PiefitAmsterdam',
	'AMRAP 12',
	'Exercises',
	'REPS',
	'Difficulty Level',
	3,
	'BENCHMARK',
	'BEGINNER - WARM UP - FINISHER',
	false
);

insert into card values(
	null,
	'HOME EDITION',
	'FULLBODY',
	'#PiefitGuyana',
	'WORK/REST',
	'Exercises',
	'20/5 SEC',
	'Difficulty Level',
	4,
	'REFERENCES',
	'BEGINNER - WARM UP - FINISHER',
	false
);

insert into card values(
	null,
	'HOME EDITION',
	'FULLBODY',
	'#PiefitSweden',
	'REPS/ROUNDS',
	'Exercises',
	'REPS',
	'Difficulty Level',
	2,
	'BENCHMARK',
	'BEGINNER - WARM UP - FINISHER',
	false
);

insert into card values(
	null,
	'HOME EDITION',
	'FULLBODY',
	'#PiefitNetherlands',
	'AMRAP 12',
	'Exercises',
	'REPS',
	'Difficulty Level',
	3,
	'BENCHMARK',
	'BEGINNER - WARM UP - FINISHER',
	false
);

-- Create exercise table
drop table if exists exercise;
create table exercise (
	exerciseid serial,
	name varchar(20) not null unique,
	description varchar(65) not null,
	difficultylevel int not null,
	video varchar(100) not null, -- Video links instead of storing the actual videos
	primary key(exerciseid)
);

-- Insert data into exercise table
insert into exercise values(null, 'BUTT KICK', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'SHOULDER TAP', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'REVERSE CRUNCH', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'WALK OUT', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'BIG JACK', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'SIDE V UP (L)', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'SIDE V UP (R)', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, '1/2 BURPEE', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'PLANK TOE TAP', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'BUTT UP', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'BICYCLE', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'SPRINT STEPS', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'SPRINT', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'ISOMETRIC SQUAT', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'PLANK', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'GLUTE BRIDGE', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'POWER JACK', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'SOVIET KICK', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'ROCKET CRUNCH', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'REVERSE LUNGE', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'DOUBLE SQUAT', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'REVERSE LUNGE (E)', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'V UP', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'FAST FEET', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'T PUSH UP', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'FLUTTER KICK', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'WALKING PUSH UP', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'BURPEE JACK', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'DIAMOND PUSH UP', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'CROSS 2 FEET', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'TOE TOUCH', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'BURPEE', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'PLANK KNEE CHECK', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'TRICEPS PUSH UP', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'PRISONER SQUAT PULL', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'SIDE PLANK (L)', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'SIDE PLANK (R)', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'OVER KNEE REACH', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'SQUAT KICK', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'MT. CLIMBER', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'BACK EXTENSION', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'RUNNING MAN', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'SUMO SQUAT', 'Lorem Ipsum', 2, 'www.');
insert into exercise values(null, 'MILITARY DRILL', 'Lorem Ipsum', 2, 'www.');

-- Create has table (relationship) 
drop table if exists has;
create table has (
	hashtag varchar(20) not null,
	exerciseid serial,
	primary key(hashtag, exerciseid),
	foreign key(hashtag) references card(hashtag),
	foreign key(exerciseid) references exercise(exerciseid)
);

-- Create text table
drop table if exists text;
create table text (
	textid bigint unsigned not null,
	frontsubheading varchar(30) not null,
	primary key(textid),
	foreign key(textid) references card(cardid) on delete cascade
);

-- Create workrest table
drop table if exists workrest;
create table workrest (
	workrestid bigint unsigned not null,
	workrestnumber int not null,
	worktime int not null,
	resttime int not null,
	referencetime int not null,
	primary key(workrestid, workrestnumber),
	foreign key(workrestid) references card(cardid) on delete cascade
);

-- Create amrap table
drop table if exists amrap;
create table amrap(
	amrapid bigint unsigned not null auto_increment,
	reps int not null,
	rounds int not null,
	level enum('Beginner', 'Intermediate', 'Advanced', 'Elite') not null default 'Beginner',
	primary key(amrapid),
	foreign key(amrapid) references card(cardid) on delete cascade
);

-- Create repsrounds table
drop table if exists repsrounds;
create table repsrounds (
	repsroundsid bigint unsigned not null auto_increment,
	reps int not null,
	time int not null,
	level enum('Beginner', 'Intermediate', 'Advanced', 'Elite') not null default 'Beginner',
	primary key(repsroundsid),
	foreign key(repsroundsid) references card(cardid) on delete cascade
);

-- Create statistic table
drop table if exists statistic;
create table statistic (
	statisticid bigint unsigned not null auto_increment,
	point int not null default 0,
	completedcard boolean not null default false,
	primary key(statisticid)
);

-- Create hasstats table (relationship)
drop table if exists hasstats;
create table hasstats (
	userid bigint unsigned not null,
	cardid serial,
	statisticid bigint unsigned not null,
	primary key(userid, cardid, statisticid),
	foreign key(userid) references user(userid),
	foreign key(cardid) references card(cardid),
	foreign key(statisticid) references statistic(statisticid)
);

-- Create workreststat table
drop table if exists workreststat;
create table workreststat (
	userid bigint unsigned not null,
	workrestid serial,
	referencetimestat int not null,
	primary key(userid, workrestid),
	foreign key(userid) references user(userid),
	foreign key(workrestid) references workrest(workrestid)
);

-- Create amrapstat table
drop table if exists amrapstat;
create table amrapstat (
	userid bigint unsigned not null,
	amrapid serial,
	levelstat enum('Beginner', 'Intermediate', 'Advanced', 'Elite') not null default 'Beginner',
	roundsstat int not null,
	primary key(userid, amrapid),
	foreign key(userid) references user(userid),
	foreign key(amrapid) references amrap(amrapid)
);

-- Create repsroundsstat table
drop table if exists repsroundsstat;
create table repsroundsstat (
	userid bigint unsigned not null,
	repsroundsid serial,
	levelstat enum('Beginner', 'Intermediate', 'Advanced', 'Elite') not null default 'Beginner',
	timestat int not null,
	primary key(userid, repsroundsid),
	foreign key(userid) references user(userid),
	foreign key(repsroundsid) references repsrounds(repsroundsid)
);
