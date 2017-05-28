--CREARE TABELE

CREATE TABLE clienti(
cnp_client varchar2(13) constraint pk_cnp_client primary key,
nume varchar2(30),
email varchar2(30),
localitate varchar2(20),
strada varchar2(20),
numar varchar2(4));


CREATE TABLE autori(
id_autor number(5) constraint pk_id_autor primary key,
nume_autor varchar2(20),
prenume_autor varchar2(20),
ISBN number(8),
constraint fk_isbn foreign key(ISBN) references carti(ISBN));


CREATE TABLE carti(
ISBN number(8) constraint pk_isbn primary key,
nume_carte varchar2(50),
editura varchar2(20),
data_publicare date,
disponibilitate varchar2(2) check(disponibilitate in ('DA','NU')),
bucati_existente number(3));


CREATE TABLE imprumuturi(
id_imprumut varchar2(4) constraint pk_id_imprumut primary key,
cnp_client varchar2(13),
data_imprumut date,
data_returnare date,
constraint fk_cnp_client foreign key(cnp_client) references clienti(cnp_client));


CREATE TABLE rand_imprumuturi(
id_imprumut varchar2(4),
ISBN number(8),
constraint pk_id_rand_imprumut PRIMARY KEY(id_imprumut,ISBN),
constraint fk_r_id_imprumut FOREIGN KEY(id_imprumut) references imprumuturi(id_imprumut),
constraint fk_r_isbn FOREIGN KEY(ISBN) references carti(ISBN));

--POPULARE TABELE

insert into clienti(cnp_client,nume,email,localitate,strada,numar) values('2345678587648','Andrei Popescu','a.popescu@gmail.com','Bucuresti','Chibzuintei','15');
insert into clienti(cnp_client,nume,email,localitate,strada,numar) values('1245646768688','Maria Ion','maria.ion@yahoo.com','Bucuresti','Marasti','988');
insert into clienti(cnp_client,nume,email,localitate,strada,numar) values('2435823729423','Viorel Apostu','apostu_v@gmail.com','Ploiesti','Tache Popescu','78');
insert into clienti(cnp_client,nume,email,localitate,strada,numar) values('1245644346576','Veronica Mara','vera.mara@yahoo.com','Bucuresti','Moxa','43B');
insert into clienti(cnp_client,nume,email,localitate,strada,numar) values('1365897554567','Roxana Ion','ion.roxana@gmail.com','Bacau','Expozitiei','567');
insert into clienti(cnp_client,nume,email,localitate,strada,numar) values('1435647457567','Maria Elena','elena.maria@gmail.com','Bucuresti','Basarab','67');

insert into carti(ISBN,nume_carte,editura,data_publicare,disponibilitate,bucati_existente) values(00098764,'Macroeconmie cantitativa','Economica',TO_DATE('13.11.2010','DD.MM.YYYY'),'DA',7);
insert into carti(ISBN,nume_carte,editura,data_publicare,disponibilitate,bucati_existente) values(98638748,'Alchimistul','Humanitas',TO_DATE('24.04.1985','dd.mm.yyyy'),'DA',12);
insert into carti(ISBN,nume_carte,editura,data_publicare,disponibilitate,bucati_existente) values(56783579,'Dama cu camelii','Humanitas',TO_DATE('15.12.1848','dd.mm.yyyy'),'NU',0);
insert into carti(ISBN,nume_carte,editura,data_publicare,disponibilitate,bucati_existente) values(42557689,'Poezii','Litera',TO_DATE('15.12.1890','dd.mm.yyyy'),'DA',17);
insert into carti(ISBN,nume_carte,editura,data_publicare,disponibilitate,bucati_existente) values(45768893,'Culegere matematica','Educativa',TO_DATE('15.12.2016','dd.mm.yyyy'),'DA',15);

insert into autori(id_autor,nume_autor,prenume_autor,ISBN) values (1,'Eminescu','Mihai',42557689);
insert into autori(id_autor,nume_autor,prenume_autor,ISBN) values (2,'Coelho','Paulo',98638748);
insert into autori(id_autor,nume_autor,prenume_autor,ISBN) values (3,'Dumas','Alexandre',56783579);
insert into autori(id_autor,nume_autor,prenume_autor,ISBN) values (4,'Tiganescu','Eugen',00098764);
insert into autori(id_autor,nume_autor,prenume_autor,ISBN) values (5,'Roman','Mihai',00098764);
insert into autori(id_autor,nume_autor,prenume_autor,ISBN) values (6,'Buzduga','Nicolae',45768893);



CREATE SEQUENCE seq_id_imprumut
START WITH 10 INCREMENT BY 10
MAXVALUE 5000 NOCYCLE;

insert into imprumuturi (id_imprumut,cnp_client,data_imprumut,data_returnare) VALUES (seq_id_imprumut.NEXTVAL,'2345678587648', TO_DATE('17.05.2017','DD.MM.YYYY'), TO_DATE('27.05.2017','DD.MM.YYYY'));
insert into imprumuturi (id_imprumut,cnp_client,data_imprumut,data_returnare) VALUES (seq_id_imprumut.NEXTVAL,'1245646768688', TO_DATE('10.05.2017','DD.MM.YYYY'), TO_DATE('13.05.2017','DD.MM.YYYY'));
insert into imprumuturi (id_imprumut,cnp_client,data_imprumut,data_returnare) VALUES (seq_id_imprumut.NEXTVAL,'2435823729423', TO_DATE('20.05.2017','DD.MM.YYYY'), TO_DATE('29.05.2017','DD.MM.YYYY'));
insert into imprumuturi (id_imprumut,cnp_client,data_imprumut,data_returnare) VALUES (seq_id_imprumut.NEXTVAL,'1245644346576', TO_DATE('22.05.2017','DD.MM.YYYY'), TO_DATE('30.05.2017','DD.MM.YYYY'));
insert into imprumuturi (id_imprumut,cnp_client,data_imprumut,data_returnare) VALUES (seq_id_imprumut.NEXTVAL,'1365897554567', TO_DATE('20.04.2017','DD.MM.YYYY'), TO_DATE('05.05.2017','DD.MM.YYYY'));

insert into rand_imprumuturi(id_imprumut,ISBN) values (20,98638748);
insert into rand_imprumuturi(id_imprumut,ISBN) values (20,56783579);
insert into rand_imprumuturi(id_imprumut,ISBN) values (60,42557689);
insert into rand_imprumuturi(id_imprumut,ISBN) values (30,00098764);
insert into rand_imprumuturi(id_imprumut,ISBN) values (40,00098764);
insert into rand_imprumuturi(id_imprumut,ISBN) values (50,98638748);

select* from clienti;
select* from autori;
select* from carti;
select* from imprumuturi;
select* from rand_imprumuturi;

--INTEROGARI

--afisare cartile care au fost imprumutate 

SELECT distinct c.nume_carte
FROM carti c, rand_imprumuturi r
WHERE c.ISBN=r.ISBN;

--ce carti a imprumutat fiecare client

select cl.nume, c.nume_carte
from clienti cl, carti c, imprumuturi i, rand_imprumuturi r
where cl.cnp_client=i.cnp_client and c.ISBN=r.ISBN and r.id_imprumut=i.id_imprumut;

--clientii care au cumparat cartea Alchimistul

select cl.nume, c.nume_carte
from clienti cl, carti c, imprumuturi i, rand_imprumuturi r
where cl.cnp_client=i.cnp_client and c.ISBN=r.ISBN and r.id_imprumut=i.id_imprumut
and lower(nume_carte)='alchimistul';

--in functie de cate carti a imprumutat, sa se stabileasca tipul clientilor: 
--3 carti:client gold, 2 carti: client silber, 1 carte: client normal

select cl.nume, COUNT(c.ISBN),
DECODE(COUNT(c.ISBN),3,'gold',2,'silver',1,'normal','-')Tip_client
from clienti cl, carti c, rand_imprumuturi r, imprumuturi i
where c.ISBN=r.ISBN and i.id_imprumut=r.id_imprumut and cl.cnp_client=i.cnp_client
group by cl.nume;

--in functie de numarul bucatilor existente din fiecare carte, sa se realizeze stocul acestora:
--mai putin de 5 carti: stoc limitat, intre 5 si 10 carti: stoc mediu, peste 10 carti: stoc superior

select nume_carte,bucati_existente,
case
when bucati_existente < 5 then 'stoc limitat'
when bucati_existente between 5 and 10 then 'stoc mediu'
when bucati_existente > 10 then 'stoc superior'
else '-' end stoc
from carti;

--clientii care au imprumutat o carte, dar nu locuiesc in Bucuresti

select cl.nume, cl.localitate, c.nume_carte
from clienti cl, carti c, imprumuturi i, rand_imprumuturi r
where cl.cnp_client=i.cnp_client and c.ISBN=r.ISBN and r.id_imprumut=i.id_imprumut
and lower(localitate)!='bucuresti';

--cate zile poate tine o carte fiecare client

select distinct cl.nume, i.data_returnare-i.data_imprumut as zile_imprumut
from clienti cl, imprumuturi i, rand_imprumuturi r, carti c
where cl.cnp_client=i.cnp_client and c.ISBN=r.ISBN and r.id_imprumut=i.id_imprumut;

--media zilelor in care clientul poate tine o carte, minimul si maximul

select round(AVG(i.data_returnare-i.data_imprumut),2) as medie_zile_imprumut,MAX(i.data_returnare-i.data_imprumut) as max_zile_imprumut, MIN(i.data_returnare-i.data_imprumut)as min_zile_imprumut
from clienti cl, imprumuturi i, rand_imprumuturi r, carti c
where cl.cnp_client=i.cnp_client and c.ISBN=r.ISBN and r.id_imprumut=i.id_imprumut;

--cartile imprumutate in luna mai

select c.nume_carte, i.data_imprumut
from carti c, imprumuturi i, rand_imprumuturi r
where c.ISBN=r.ISBN and r.id_imprumut=i.id_imprumut and extract(month from i.data_imprumut)=5;


--cartile neimprmutate

SELECT distinct c.nume_carte
FROM carti c, rand_imprumuturi r
WHERE c.ISBN=r.ISBN(+)

minus

SELECT distinct c.nume_carte
FROM carti c, rand_imprumuturi r
WHERE c.ISBN=r.ISBN;


--view: clientii cu emailul - @gmail.com

create or replace view v_gmail
as select * from clienti
where email like '%gmail%';

select* from clienti 
where email like '%gmail%';

