drop database webshoppen;
create database webshoppen;
use webshoppen;

-- Vill inte ha Null värden här
CREATE TABLE kund(
                     id int primary key auto_increment,
                     förnamn varchar(50) not null,
                     efternamn varchar(50) not null,
                     adress varchar(100) not null);



CREATE TABLE beställning(
                            id int auto_increment primary key,
                            datum timestamp default CURRENT_TIMESTAMP,
                            kundId int not null,
                            foreign key (kundId) references kund(id) on delete cascade); -- Tar jag bort en kund så ska även dess beställning och produktbeställning försvinna


-- Vill inte ha Null värden här
CREATE TABLE produktNamn(
                            id int auto_increment primary key,
                            namn varchar(75) unique not null);
CREATE TABLE produktStorlek(
                               id int auto_increment primary key,
                               namn varchar(30) unique not null);
CREATE TABLE produktFärg(
                            id int auto_increment primary key,
                            namn varchar(30) unique not null);
CREATE TABLE produktMärke(
                             id int auto_increment primary key,
                             namn varchar(75) unique not null);

-- Tar jag bort någon produkt del av produktEntiteterna så rensas produktBeroendet samt produkten
CREATE TABLE produktBeroenden(
                                 id int auto_increment primary key,
                                 produktNamnId int,
                                 produktStorlekId int,
                                 produktFärgId int,
                                 produktMärkeId int,
                                 foreign key(produktNamnId) references produktNamn(id) on delete cascade,
                                 foreign key(produktStorlekId) references produktStorlek(id) on delete cascade,
                                 foreign key(produktFärgId) references produktFärg(id) on delete cascade,
                                 foreign key(produktMärkeId) references produktMärke(id) on delete cascade);

CREATE TABLE produkt(
                        id int auto_increment primary key,
                        lagerStatus int,
                        pris int not null,
                        produktBeroendeId int not null,
                        foreign key(produktBeroendeId) references produktBeroenden(id) on delete cascade);

CREATE TABLE produktBeställning(
                                   id int auto_increment primary key,
                                   antal int not null default 1,
                                   beställningsId int not null,
                                   produktId int not null,
                                   foreign key(beställningsId) references beställning(id) on delete cascade,
                                   foreign key(produktId) references produkt(Id) on delete cascade);

CREATE TABLE kategori(
                         id int auto_increment primary key,
                         namn varchar(100) unique not null);

CREATE TABLE produktKategori(
                                id int auto_increment primary key,
                                kategoriId int not null,
                                produktId int not null,
                                foreign key (kategoriId) references kategori(id) on delete cascade,-- om kategorin tas bort rensas prodKategorin
                                foreign key (produktId) references produkt(id)on delete cascade); -- om produkten tas bort rensas prodKategorin

create index IX_pris on produkt(pris); -- Eftersom mysql redan verkar ha skapat index på de kolumnerna jag först ville ha, produktNamn osv som det antagligen söks efter mycket i en webshop så valde jag istället pris.

insert into kund(förnamn, efternamn, adress) VALUES
                                                 ('John', 'Johansson','Solna'),
                                                 ('Björn', 'Larsson','Solna'),
                                                 ('Per', 'Pettersson','Sumpan'),
                                                 ('Anna', 'Andersson','Sumpan'),
                                                 ('Kalle', 'Svensson','Bromma');

insert into beställning(kundId,datum) VALUES (1,'2023-09-04 22:05:45');
insert into beställning(kundId,datum) VALUES (5,'2023-08-04 22:05:45');
insert into beställning(kundId,datum) VALUES (3,'2023-08-04 22:05:45');
insert into beställning(kundId,datum) VALUES (2,'2023-07-04 22:05:45');
insert into beställning(kundId,datum) VALUES (4,'2023-06-04 22:05:45');
insert into beställning(kundId,datum) VALUES (4,'2023-06-03 22:05:45');

INSERT INTO produktNamn(namn) VALUES ('Långbralla'),('Finbyxor'),('Lång Strumpa'),('Blomming klänning'),('Vanlig klänning'),('Fräsig T-shirt'),('Kavaj'),('Mössa');
INSERT INTO produktStorlek(namn) VALUES ('XL'),('38'),('M'),('S'),('L'),('XS'),('37'),('36');
INSERT INTO produktFärg(namn) VALUES ('Blå'),('Svart'),('Vit'),('Gul'),('Grön'),('Röd');
INSERT INTO produktMärke(namn) VALUES ('Nike'),('SweetPants'),('Björn Borg'),('H&M'),('Sara'),('Adidas'),('Tiger');
INSERT INTO produktBeroenden(produktNamnId,produktStorlekId,produktFärgId,produktMärkeId) VALUES (1,1,1,1),(2,2,2,2),(3,3,3,3),(4,4,1,4),(5,1,1,5),(8,6,6,6),(7,4,5,7),(6,2,6,1),(2,7,2,2),(2,8,2,2);
INSERT INTO produkt(lagerStatus,pris,produktBeroendeId) VALUES (4,175,1),(2,500,2),(20,125,3),(11,600,4),(3,780,5),(1,199,6),(1,1500,7),(33,99,8),(4,500,9),(4,500,10);
INSERT INTO kategori(namn) VALUES ('Byxor'),('Strumpor'),('Klänningar'),('T-shirts'),('Kavajer'),('Mössor'),('Kostym');
INSERT INTO produktKategori(kategoriId,produktId) VALUES (1,1),(1,2),(2,3),(3,4),(3,5),(6,6),(5,7),(4,8),(1,9),(1,10),(7,7);
INSERT INTO produktBeställning(beställningsId, produktId,antal) VALUES (1,1,1),(2,1,1),(2,10,1),(5,3,1),(6,3,1),(3,3,1),(3,2,1),(3,1,1),(4,1,1),(4,9,1),(4,3,1),(4,4,1),(2,8,1);

