create database QLSV_Hieu_de12
go
use QLSV_Hieu_de12

create table sinhvien
(
	masv char(6) primary key check (masv like 'SV[0-9][0-9][0-9][0-9]'),
	hoten varchar(30),
	ngaysinh datetime,
	gioitinh varchar(10),
	hocbong int,
	lop varchar(10) not null
)
create table monhoc
(
	mamh char(6) primary key,
	tenmh varchar(30),
	soTC int
)

create table KQTHI
(
	masv char(6)  check (masv like 'SV[0-9][0-9][0-9][0-9]'),
	mamh char(6),
	diem float
	primary key (masv,mamh)
)
--2
alter table kqthi
add constraint fk_sinhvien_kqthi foreign key (masv) references sinhvien(masv)

alter table kqthi
add constraint fk_monhoc_kqthi foreign key (mamh) references monhoc(mamh)

--3
insert into sinhvien values ('SV0001','a','01-01-1998','nam',1000,'AT01')
insert into sinhvien values ('SV0002','b','02-01-1998','nam',1000,'AT01')
insert into sinhvien values ('SV0003','c','03-01-1998','nu',1000,'AT02')
insert into sinhvien values ('SV0004','d','03-01-1998','nu',2000,'AT03')

insert into monhoc values('MH0001','toana1',3)
insert into monhoc values('MH0002','toana2',2)
insert into monhoc values('MH0003','He QTCSDL',3)

insert into KQTHI values('SV0001','MH0001',9)
insert into KQTHI values('SV0001','MH0002',9)
insert into KQTHI values('SV0001','MH0003',9)
insert into KQTHI values('SV0002','MH0001',7)
insert into KQTHI values('SV0002','MH0002',6)
insert into KQTHI values('SV0002','MH0003',8)
insert into KQTHI values('SV0003','MH0001',4)
insert into KQTHI values('SV0003','MH0002',5)
insert into KQTHI values('SV0003','MH0003',3)
insert into KQTHI values('SV0004','MH0001',1)
insert into KQTHI values('SV0004','MH0002',2)
insert into KQTHI values('SV0004','MH0003',3)

--4
select hoten,ngaysinh,gioitinh from sinhvien
where lop='AT01' or lop ='AT02'
order by hoten asc
--5
select * from monhoc
where soTc in
(select max(soTc) from monhoc)
--6
select tenmh,diem from KQTHI
join monhoc on monhoc.mamh = kqthi.mamh
where kqthi.masv ='SV0001'

--7 
select sinhvien.masv,hoten,lop,sum(diem)/count(kqthi.mamh) as diemTB from sinhvien
inner join kqthi on sinhvien.masv = kqthi.masv
group by sinhvien.masv,hoten,lop
having sum(diem)/count(kqthi.mamh) < 5
order by lop,hoten asc

--8
alter proc display_QTCSDL
@tenlop varchar(10)
as
begin
	select sinhvien.masv,hoten,diem from sinhvien
	inner join kqthi on sinhvien.masv = kqthi.masv
	inner join monhoc on monhoc.mamh = kqthi.mamh
	where tenmh = 'He QTCSDL'
	and @tenlop = lop 
end

exec display_QTCSDL @tenlop ='AT02'


