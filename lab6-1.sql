
--bài 1.1
create trigger check_themnv on nhanvien for update as
if (select luong from inserted) < 15000
begin
print'Tien luong toi thieu phai hon 15000'
rollback transaction
end
go
-- bài 1.2
create trigger check_themnv ON NHANVIEN for insert as 
declare @tuoi int
set @tuoi=year(getdate()) - (select year(NGSINH) from inserted)
if (@tuoi < 18 or @tuoi > 65 )
begin
print'Yêu cầu nhập tuổi từ 18 đến 65'
rollback transaction 
end
go

-- bài 1.3
create trigger update_NV on NHANVIEN for update as
IF (SELECT DCHI FROM inserted ) like '%TP HCM%'
begin
print'Không thể cập nhật'
rollback transaction
end
go

--bài 2.1

--bài 2.2

--bài 2.3
