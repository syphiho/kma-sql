create database QLSV_2
go
use QLSV_2
--1
go
create table LopHoc
(
Malop varchar(10) primary key,
Tenlop varchar(50) not null,
Diadiem varchar(50),
MaGVQL varchar(10)
)
go
create table SinhVien
(
MaSV varchar(10) primary key,
HoTen varchar(50),
NgaySinh datetime,
GioiTinh char(10) default 'nam',
Diem int,
Malop varchar(10)
)
go
create table GiaoVien
(
MaGV varchar(10) primary key,
TenGV varchar(50),
Diadiem varchar(50),
TrinhdoCM varchar(50),
Malop varchar(10)
)
go
--2
alter table SinhVien add constraint fk_SinhVien_LopHoc foreign key (Malop) references LopHoc(Malop)
alter table GiaoVien add constraint fk_GiaoVien_LopHoc foreign key (Malop) references LopHoc(Malop)
go
alter table SinhVien drop constraint fk_sinhvien_lophoc
alter table giaovien drop constraint fk_giaovien_lophoc1

--3
-- drop table lophoc;
--drop table GiaoVien;
--drop table SinhVien;

go
insert into lophoc values ('CT2A', 'embedded system 1', 'TA1', 'GVQL1')
insert into LopHoc values ('CT2B', 'embedded system 2', 'TA2', 'GVQL2')
insert into LopHoc values ('CT2C', 'Andoroid', 'TA3',	'GVQL3')


go

insert into SinhVien values ('CT020133','PHI', '11/23/1998', 'Nam', 8,'CT2A')
insert into SinhVien values ('CT020134','TOAN', '16/10/1999', 'Nam', 8'CT2B')
insert into SinhVien values ('CT020219','HOANG', '20/11/1999', 'Nam', 9,'CT2C')


go
insert into GiaoVien values ('Teacher001', 'le thi hong van', 'TA3', 'Thuc si', 'CT2A')
insert into GiaoVien values ('Teacher002', 'nguyen dao truong', 'TA1', 'Tien si', 'CT2B')
insert into GiaoVien values ('Teacher003', 'nguyen thuan', 'TA6', 'Giao su', 'CT2C')
insert into GiaoVien values ('Teacher004', 'pham van huong', 'TB', 'Giao su', 'CT2C')
---------------------------------------
select * from LopHoc
select * from SinhVien
select * from GiaoVien
--4
select sv.Hoten , sv.NgaySinh, sv.GioiTinh  from SinhVien as sv join LopHoc as lop
on sv.Malop = lop.Malop
where  sv.Malop='ML03'
order by sv.Hoten asc
--5
select lop.Tenlop, lop.Diadiem  from SinhVien as sv join LopHoc as lop
on sv.Malop = lop.Malop
where  sv.HoTen='Quang'--Éo hieu de , sinh vien dó là sinh vien nào :v 
						--=> ví dụ sinh vien ten Quang oke :D 
--6

select LopHoc.Malop, LopHoc.Tenlop,LopHoc.Diadiem,LopHoc.MaGVQL
from LopHoc, SinhVien 
where SinhVien.Malop = LopHoc.Malop and SinhVien.Diem >=8
group by LopHoc.Malop, LopHoc.Tenlop,LopHoc.Diadiem,LopHoc.MaGVQL
having count(SinhVien.MaSV)>=5


--7
create proc Display_Giaovien
@tengv varchar(50), @tenlop varchar(50)
as 
begin
	if(@tengv like '*' and @tenlop like '*')
		begin
			select * from GiaoVien join LopHoc on GiaoVien.MaGV=LopHoc.MaGVQL 
		end
	else if(@tengv like '*')
		begin
			select * from GiaoVien join LopHoc on GiaoVien.MaGV=LopHoc.MaGVQL where  tenlop=@tenlop 
		end 
	else if(@tenlop like '*')
		begin
			select * from  LopHoc join GiaoVien on GiaoVien.MaGV=LopHoc.MaGVQL where tengv=@tengv
		 end 
	 else
		begin
			select * from GiaoVien join LopHoc on GiaoVien.MaGV=LopHoc.MaGVQL where tengv=@tengv and tenlop=@tenlop 
		end
end

--drop proc Display_Giaovien

  exec Display_Giaovien @tengv='*' , @tenlop='*'


