create database QLBH_hiu
go
use QLBH_hiu
go 
create table HOADON
(
	soHD char(6) primary key check (soHD like 'HD[0-9][0-9][0-9][0-9]'),
	ngayHD datetime,
	tenKH varchar(5) not null,
	diachi varchar(50),
	dienthoai char(10)
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
	soHD char(6) check (soHD like 'HD[0-9][0-9][0-9][0-9]'),
	mahang char(6),
	giaban int,
	soluong int,
	mucgiamgia float
	primary key(soHD,mahang)
)
--2
alter table chitiethd add constraint fk_HD_hoadon
foreign key (soHD) references HOADON(soHD)

alter table chitiethd add constraint fk_HD_HAng
foreign key (mahang) references HANG(mahang)

--3
insert into hoadon values ('HD0001','10/10/2018','hieu','na','0123456789')
insert into hoadon values ('HD0002','9/10/2018','thao','ht','0123456788')
insert into hoadon values ('HD0003','8/10/2018','quang','hp','0123456787')
insert into hoadon values ('HD0004','10/10/2018','hieu','na','0123456789')

insert into hang values('MH0001','AK47','chiec',1000000,100)
insert into hang values('MH0002','nade','chiec',400000,50)
insert into hang values('MH0003','bazoka','chiec',5000000,50)
insert into hang values('MH0004','AWM','chiec',1000,200)

insert into CHITIETHD values('HD0001','MH0001',1200000,10,0.1)
insert into CHITIETHD values('HD0001','MH0002',450000,10,0.2)
insert into CHITIETHD values('HD0002','MH0003',6000000,2,0.1)
insert into CHITIETHD values('HD0003','MH0002',450000,2,0.1)
insert into CHITIETHD values('HD0004','MH0003',6000000,2,0.1)

--5
select chitiethd.mahang,tenhang,donvitinh,
giaban,chitiethd.soluong,
(giaban*CHITIETHD.soluong-giaban*CHITIETHD.soluong*mucgiamgia) as thanhtien from CHITIETHD
inner join hang on CHITIETHD.mahang = hang.mahang
where sohd = 'HD0001'
--6
select hang.mahang,tenhang,
isnull(sum(giaban*CHITIETHD.soluong-giaban*CHITIETHD.soluong*mucgiamgia),0) as thanhtien from hang
left join CHITIETHD on CHITIETHD.mahang = hang.mahang
group by hang.mahang,tenhang
--7
select tenKH,diachi,dienthoai,count(tenKH) as solan from hoadon
group by tenKH,diachi,dienthoai
having count(tenKH) >=
all(select count(tenKH) as solan from hoadon
group by tenKH)

--8
create view view_display_hang as
select tenhang,dongia,CHITIETHD.soluong from hang
left join CHITIETHD on hang.mahang=CHITIETHD.mahang
where dongia>500000
with check option

--ko vì 2 bảng có 2 khóa chính không được null mà view này k có trường chứa khóa nên k thêm đươc
