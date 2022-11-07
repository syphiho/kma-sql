--0
create database QLMB_hiu
use QLMB_hiu
--1
create table chuyenbay
(
macb char(6) primary key,
gadi nvarchar(50),
gaden nvarchar(50),
dodai int,
giodi datetime,
gioden datetime,
chiphi int
)
create table maybay
(
mamb char(6) primary key,
hieu char(30),
tambay int
)
create table phicong 
(
manv char(6),
mamb char(6),
tennv char(6),
luong int,
ngaysinh date check (ngaysinh < getDate())
primary key(manv, mamb)
)
--2
alter table phicong add constraint fk_Phicong_maybay foreign key (mamb) references maybay(mamb) 
--3
insert into chuyenbay values ('VN320', N'HN',N'HP', 1000, '10/09/2018 10:00:00', '10/09/2018 10:20:00', 2000)
insert into chuyenbay values ('VN321', N'HP',N'HN', 1200, '10/08/2018 10:00:00', '10/08/2018 11:20:00', 3000)
insert into chuyenbay values ('VN322', N'HN',N'NA', 1400, '10/07/2018 10:00:00', '10/07/2018 12:20:00', 3000)

insert into maybay values ('MB0001','vietjack',1000)
insert into maybay values ('MB0002','airline',1000)
insert into maybay values ('MB0003','jetstar',1200)
insert into maybay values ('MB0004','jetstar',1500)
insert into maybay values ('MB0005','jetstar',1200)

insert into phicong values ('NV0001','MB0001','hieu',2000,'07/04/1998')
insert into phicong values ('NV0002','MB0002','quang',2000,'08/04/1998')
insert into phicong values ('NV0003','MB0003','ahihi',1000,'09/04/1998')
insert into phicong values ('NV0004','MB0001','nguyen thi nhi',3000,'10/04/1998')
insert into phicong values ('NV0005','MB0001','ahihi',3000,'10/04/1998')
insert into phicong values ('NV0006','MB0002','roll',4000,'10/04/1998')

--4
select tennv,ngaysinh from phicong
where tennv like '%thi%'
--5
select maybay.* from maybay
join chuyenbay on maybay.tambay = chuyenbay.dodai
where macb ='VN320'
--6
select maybay.mamb,hieu,count(manv) as tong from phicong
join maybay on phicong.mamb = maybay.mamb
group by maybay.mamb,hieu

--7
select tennv,luong,ngaysinh from phicong
where luong =
(select max(luong) from phicong
where luong not in
(select MAX(luong) from phicong))

--8


alter view view_luongPC as
select tennv,luong,ngaysinh from phicong
where luong > 3500
with check option

-- không vì bảng phicong có 2 khóa chính không được null mà view thì không có 2 trường chứa khóa  

