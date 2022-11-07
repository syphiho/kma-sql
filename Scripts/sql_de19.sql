create database QLVT_hiu_de19
go
use QLVT_hiu_de19
go

create table NCC
(
	MaNCC char(6) primary key,
	TenNCC varchar(50) not null,
	Heso float,
	ThPho varchar(50) default 'Ha noi'
)

create table VATTU
(
	MaVT char(6) primary key,
	TenVT varchar(50),
	Mau varchar(50),
	TrLuong int ,
	ThPho varchar(50) default 'Ha noi'
)
create table CC
(
	MaNCC char(6),
	MaVt char(6),
	Soluong int
	primary key (MaNCC,MaVt)
)

alter table cc
add constraint fk_NCC_CC foreign key (MaNCC)
references NCC(MaNCC)

alter table cc
add constraint fk_VT_CC foreign key (maVT)
references VAttu(maVT)

--3
insert into ncc values ('NCC001','hieu',4,'vinh')
insert into ncc values ('NCC002','quang',2,'hp')
insert into ncc values ('NCC003','thao',1,'ht')
insert into ncc values ('NCC004','zolo',1,'sg')
insert into ncc values ('NCC005','gau gau',1,'dn')

insert into vattu values('VT0001','go','mau1',200,'vinh')
insert into vattu values('VT0002','sat','mau2',500,'hp')
insert into vattu values('VT0003','thep','mau3',700,'ht')

insert into CC values('NCC001','VT0001',700)
insert into CC values('NCC002','VT0002',900)
insert into CC values('NCC003','VT0003',200)
insert into CC values('NCC004','VT0003',100)
--4
select vattu.mavt,tenvt from vattu
inner join cc on vattu.mavt = cc.mavt
where Soluong<300
--5
select vattu.mavt,vattu.tenvt from vattu
inner join cc on vattu.mavt = cc.mavt
inner join ncc on ncc.mancc = cc.mancc
where ncc.ThPho != VATTU.ThPho
--6
	select tenncc,heso from ncc
	where heso in
	(select max(heso) from ncc
	where heso not in
	(select max(heso) from ncc))
--7
select tenvt,sum(soluong) as tongsoluong from vattu
left join cc on cc.mavt = vattu.mavt
group by tenvt
--8
create view view_display
as
select mancc,tenncc,thpho from ncc
where mancc not in
(
select mancc from cc
)

select * from view_display
-- có vì trong view có chứa trường chứa khóa chính của bảng NCC 