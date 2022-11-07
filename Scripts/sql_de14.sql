create database QLDONVI_hiu
go
use QLDONVI_hiu
go
create table NHANVIEN
(
	maNV char(6) primary key check(maNV like 'NV[0-9][0-9][0-9][0-9]'),
	hoten varchar(50),
	ngaysinh datetime,
	gioitinh varchar(10),
	luong int,
	maDV char(6)
)
create table DONVI
(
	maDV char(6) primary key,
	tenDV varchar(50) not null,
	maNQL char(6),
	ngaybatdau datetime
)
create table DUAN
(
	maDA char(6) primary key,
	tenDA varchar(50),
	diadiemDA varchar(50),
	maDV char(6)
)

alter table nhanvien
add constraint fk_nhanvien_donvi foreign key (maDV)
references donvi(maDV)

alter table duan
add constraint fk_duan_donvi foreign key (maDV)
references donvi(maDV)

--3
insert into nhanvien values ('NV0001','hieu','07/04/1998','nam','100000','DV0001')
insert into nhanvien values ('NV0002','quang','08/04/1998','nam','100000','DV0002')
insert into nhanvien values ('NV0003','hien','09/04/1998','nuw','130000','DV0003')
insert into nhanvien values ('NV0004','a','05/04/1998','nam','50000','DV0001')

insert into donvi values('DV0001','kma','NV0001','10/10/2010')
insert into donvi values('DV0002','neu','NV0002','11/10/2010')
insert into donvi values('DV0003','uet','NV0003','12/10/2010')

insert into duan values('DA0001','rampage','kma','DV0001')
insert into duan values('DA0002','ahihi','uet','DV0002')
insert into duan values('DA0003','duan2','uet','DV0002')
insert into duan values('DA0004','duan3','uet','DV0002')
insert into duan values('DA0005','duan4','uet','DV0002')
insert into duan values('DA0006','duan5','uet','DV0002')
insert into duan values('DA0007','duan6','uet','DV0002')

--4
select * from nhanvien
where maDV='DV0002' or maDV='DV0001'
order by hoten asc
--5
select hoten,ngaysinh,gioitinh from nhanvien
inner join donvi on manv = maNQL
--6
select donvi.madv,tendv,sum(luong)/count(maNV) as luongTB from donvi
inner join nhanvien on nhanvien.madv = donvi.madv
group by donvi.madv,tendv
--7
select tendv,count(mada) as soduan from donvi
inner join duan on donvi.madv = duan.madv
group by tendv
having count(mada)>5
--8
create proc sp_DonviDuan
@tenDV varchar(50),@tenDA varchar(50)
as
begin
	if(@tenDV ='*' and @tenDA='*')
		begin
			select * from donvi inner join duan on donvi.madv = duan.madv
		end
	else if(@tenDV ='*')
		begin
			select * from donvi inner join duan on donvi.madv = duan.madv where @tenDA = tenDA
		end
	else if(@tenDA ='*')
		begin
			select * from duan inner join donvi on donvi.madv = duan.madv where @tenDV = tenDV
		end
	else
		begin
			select * from duan inner join donvi on donvi.madv = duan.madv 
			where @tenDV = tenDV and @tenDA = tenDA
		end
end

exec sp_DonviDuan @tendv = 'neu' ,@tenDA='*'