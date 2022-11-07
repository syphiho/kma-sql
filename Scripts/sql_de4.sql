create database QLLUANVAN_hiu
go

use QLLUANVAN_hiu
go

create table SinhVien
(
	MaSV char(6) primary key,
	HoTen varchar(30),
	Ngaysinh date,
	GioiTinh varchar(6),
	Diachi varchar(30)
)
create table Luanvan
(
	MaLV char(6) primary key,
	TenLV varchar(30) not null,
	LoaiDetai varchar(30),
	GVHuongdan char(6),
	MaSV char(6)
)
create table GiaoVien
(
	MaGV char(6) primary key,
	TenGV varchar(30),
	Trinhdo varchar(30) default 'Tien sy'
)
go
--2
alter table Luanvan
add constraint fk_luanvan_masv foreign key (MaSv)
references SinhVien(MaSv)

alter table Luanvan
add constraint fk_luanvan_maGv foreign key (GVHuongdan)
references GiaoVien(MaGV)

--3
insert into SinhVien values ('SV0001','hieu','07-04-1998','nam','na')
insert into SinhVien values ('SV0002','quang','08-04-1998','nam','na')
insert into SinhVien values ('SV0003','ahihi','09-04-1998','nu','na')
insert into SinhVien values ('SV0004','del thich dang ky','10-04-1998','nu','na')

insert into GiaoVien values ('GV0001','Nguyen Ngoc Lan','giao su')
insert into GiaoVien values ('GV0002','doan','tien sy')
insert into GiaoVien values ('GV0003','uyen','thac si')

insert into Luanvan values ('LV0001','java','web','GV0001','SV0001')
insert into Luanvan values ('LV0002','lol','game','GV0002','SV0002')
insert into Luanvan values ('LV0003','fa','gau cho','GV0003','SV0003')
insert into Luanvan values ('LV0004','angry bird','cong nghe phan mem','GV0003','SV0003')
insert into Luanvan values ('LV0005','ch play','cong nghe phan mem','GV0002','SV0002')
--4
select tenLV from luanvan
where LoaiDetai = 'cong nghe phan mem'
order by tenlv asc
--5
select hoten from sinhvien
inner join luanvan on sinhvien.MaSV = Luanvan.MaSV
inner join giaovien on luanvan.GVHuongdan = GiaoVien.MaGV
where tengv = 'Nguyen Ngoc Lan'

--6
select hoten from sinhvien
where masv not in
(
select masv from Luanvan
)
--7
alter proc GV_HDLuanvan 
@tenGV varchar(30),@tenLV varchar(30)
as
begin
	if(@tenGV ='*' and @tenLV ='*')
		begin
			select tengv,tenlv,loaidetai from giaovien join luanvan on giaovien.MaGV = luanvan.GVHuongdan
		end
	else if (@tenGV ='*')
		begin
			select tengv,tenlv,loaidetai from giaovien join luanvan on giaovien.MaGV = luanvan.GVHuongdan where @tenLV =TenLV
		end
	else if (@tenLV ='*')
		begin
			select tenlv,loaidetai,tengv from luanvan join giaovien on giaovien.MaGV = luanvan.GVHuongdan where @tengv = tengv
		end
	else
		begin
			select distinct tengv,tenlv,loaidetai from giaovien join luanvan on giaovien.MaGV = luanvan.GVHuongdan
		where @tengv = TenGV and @tenLV = TenLV
	end
end

exec GV_HDLuanvan @tenGV ='*',@tenlv='*'