create database QLBH_hiu_de18
go 
use QLBH_hiu_de18
go

create table HOADON
(
	soHD char(6) primary key,
	ngayHD datetime,
	tenKH varchar(5) not null,
	diachi varchar(50),
	dienthoai char(11) check (dienthoai like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)
create table HANG
(
	mahang char(6) primary key,
	tenhang varchar(50),
	donvitinh varchar(20),
	dongia int,
	soluong int
)
create table CHITIETHD
(
	soHD char(6),
	mahang char(6),
	giaban int,
	soluong int,
	mucgiamgia float
	primary key(soHD,mahang)
)


alter table chitiethd add constraint fk_HD_hoadon
foreign key (soHD) references HOADON(soHD)

alter table chitiethd add constraint fk_HD_HAng
foreign key (mahang) references HANG(mahang)
--3
insert into hoadon values ('HD0001','10/10/2018','hieu','na','01234567891')
insert into hoadon values ('HD0002','9/10/2018','thao','ht','01234567882')
insert into hoadon values ('HD0003','8/10/2018','quang','hp','01234567873')
insert into hoadon values ('HD0004','10/10/2018','hieu','na','01234567894')

insert into hang values('MH0001','AK47','chiec',1000000,100)
insert into hang values('MH0002','nade','chiec',400000,30)
insert into hang values('MH0003','bazoka','chiec',5000000,40)
insert into hang values('MH0004','AWM','chiec',1000,200)

insert into CHITIETHD values('HD0001','MH0001',1200000,10,0.01)
insert into CHITIETHD values('HD0001','MH0002',450000,10,0.02)
insert into CHITIETHD values('HD0002','MH0003',6000000,2,0.01)
insert into CHITIETHD values('HD0003','MH0002',450000,2,0.01)
insert into CHITIETHD values('HD0004','MH0003',6000000,2,0.01)

--4
select hang.mahang,tenhang from hang
where dongia > 500
and soluong < 50
--5
select * from hang
where mahang not in
(select mahang from CHITIETHD)
--6

select chitiethd.mahang,tenhang,
sum(CHITIETHD.soluong*chitiethd.giaban-CHITIETHD.soluong*giaban*mucgiamgia-CHITIETHD.soluong*dongia) as tienlai
from chitiethd
inner join hang on hang.mahang = CHITIETHD.mahang
group by chitiethd.mahang,tenhang

--7 không hiểu đề là giảm đơn giá hay giá bán hay mức giảm giá ???
--ở đây set đơn giá
update hang set dongia = 0.5*dongia
where mahang in
(select CHITIETHD.mahang as tongslban from CHITIETHD
inner join hang on hang.mahang = CHITIETHD.mahang 
group by CHITIETHD.mahang
having sum(chitiethd.soluong) <= all
(select sum(chitiethd.soluong) as tongslban from CHITIETHD
inner join hang on hang.mahang = CHITIETHD.mahang 
group by CHITIETHD.mahang))

--8

create function fun_sum_money(@tenKH varchar(50))
returns table as return
(
	select tenKH,sum(CHITIETHD.soluong*chitiethd.giaban-CHITIETHD.soluong*giaban*mucgiamgia) as tongtien
	from CHITIETHD
	inner join hoadon on hoadon.sohd = CHITIETHD.soHD
	group by tenKH
	having @tenKH = tenKH
)

select * from fun_sum_money('hieu')

