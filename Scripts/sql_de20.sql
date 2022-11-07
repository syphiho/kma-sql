create database QLLop_Hiu
go
use QLLop_Hiu
go

create table Lop
(
	malop char(6) primary key,
	tenlop varchar(50),
	siso int,
	MaK char(6),
	MaGv char(6)
)
create table sinhvien
(
	MaSV char(6) primary key,
	tenSV varchar(50),
	ngaysinh datetime check (ngaysinh<getdate()),
	GT varchar(10),
	malop char(6)
)
create table giaovien 
(
	magv char(6) primary key,
	tengv varchar(50) not null,
	ngaysinh datetime,
	trinhdo varchar(50)

)

alter table lop
add constraint fk_lop_gv foreign key (magv)
references giaovien(magv)

alter table sinhvien
add constraint fk_lop_sv foreign key (malop)
references lop(malop)

--3
insert into lop values ('ML0001','AT13D',63,'AT13','GV0001')
insert into lop values ('ML0002','AT13E',63,'AT13','GV0001')
insert into lop values ('ML0003','AT12C',63,'AT12','GV0002')

insert into sinhvien values('SV0001','hieu','07/04/1998','nam','ML0001')
insert into sinhvien values('SV0002','dao','08/04/1998','nam','ML0002')
insert into sinhvien values('SV0003','back','07/05/1998','nu','ML0003')
insert into sinhvien values('SV0004','girl','12/05/1998','nu','ML0001')
insert into sinhvien values('SV0005','a','07/04/1998','nam','ML0001')

insert into Giaovien values('GV0001','an','01/01/1984','thac sy')
insert into Giaovien values('GV0002','doan','01/01/1984','tien sy')
insert into Giaovien values('GV0003','van','01/01/1984','giao su')

--4
select * from sinhvien
where gt like 'nu'
and month(ngaysinh)=12

--5
select tenlop,tengv from lop
inner join giaovien on lop.magv = giaovien.magv

--6
select trinhdo,count(magv) as soluong from giaovien
group by trinhdo

--7
select lop.malop,lop.tenlop,count(masv) as soluong from lop
inner join sinhvien on lop.malop=sinhvien.malop
group by lop.malop,lop.tenlop
having count(masv) >= all(
select count(masv) from lop
inner join sinhvien on lop.malop=sinhvien.malop
group by lop.malop)
--8
alter proc compare_ngaysinh
@masv1 char(6),@masv2 char(6)
as
begin
	declare @ngaysinh1 datetime
	declare @ngaysinh2 datetime
	select @ngaysinh1 = (select ngaysinh from sinhvien where @masv1 = masv)
	select @ngaysinh2 = (select ngaysinh from sinhvien where @masv2 = masv)
	if(@ngaysinh1=@ngaysinh2)
		print 'trung ngay sinh'
	else 
		print 'khong trung'
end

exec compare_ngaysinh @masv1 = 'SV0001',@masv2='SV0002'


