create table SinhVien(
MaSV char(5) not null primary key,
Hoten nvarchar(20),
Ngaysinh date)
go
create table MonHoc(
MaMH char(5) not null primary key,
TenMH nvarchar(20),
SoTC int)
go
create table Diem(
MaSV char(5) not null constraint fk_MaSV references Sinhvien(MaSV),
MaMH char(5) not null constraint fk_MaMH references MonHoc(MaMH),
DiemThi decimal
)
go

-----Nhập dữ liệu cho bảng-----

insert SinhVien values
('001', 'Dang Tien', '2002-10-5'),
('002', 'Hoang Viet', '2002-12-1'),
('003', 'Tien Dang', '2002-7-5')

insert MonHoc values
('MH1', 'LTHDT', '3'),
('MH2', 'HQTCSDL', '3'),
('MH3', 'TCC3', '2')

insert Diem values
('001', 'MH3', '4'),
('002', 'MH1', '7.5'),
('001', 'MH2', '3'),
('003', 'MH2', '8.5'),
('003', 'MH1', '9')
SELECT *  
FROM Diem;

SELECT   MaSV, MaMH, DiemThi 
FROM     Diem
ORDER BY DiemThi DESC ;

SELECT MaSV, MaMH, DiemThi
FROM   Diem
WHERE  DiemThi BETWEEN 8 AND 9 ;
go

--Câu 2
create function thongke (@tmh nvarchar(20))
returns int
as
begin
 declare @dem int
 set @dem = (select count(@tmh) from Diem join MonHoc on MonHoc.MaMH = Diem.MaMH where Diem.DiemThi<5)
 return @dem
end
go
select dbo.thongke('TCC3')

-- câu 3
go
create procedure nhapDiem(@MaSV char(5),@MaMon char(5), @DiemThi float)
as
insert into Diem(MaSV,MaMH,Diemthi) values(@MaSV,@MaMon,@DiemThi)
go
nhapDiem '003','MH3',9
go
--CÂU 4
create trigger them_sua
on Diem
FOR  INSERT, UPDATE
AS
if(select DiemThi From inserted)>10 and (select DiemThi From inserted)<0
begin
print
'khong cho phep'
rollback transaction
end
insert into Diem
values ('001','MH3','2')




