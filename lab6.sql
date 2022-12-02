
--bài 1.1 Ràng buộc khi thêm mới nhân viên thì mức lương phải lớn hơn 15000, nếu vi phạm thì xuất thông báo “luong phải >15000’
create trigger check_themnv on nhanvien for insert,update as
if (select luong from inserted) < 15000
begin
print'Tien luong toi thieu phai hon 15000'
rollback transaction
end
go
-- bài 1.2 Ràng buộc khi thêm mới nhân viên thì độ tuổi phải nằm trong khoảng 18 <= tuổi <=65.
create trigger check_them ON NHANVIEN for insert as 
declare @tuoi int
set @tuoi=year(getdate()) - (select year(NGSINH) from inserted)
if (@tuoi < 18 or @tuoi > 65 )
begin
print'Yêu cầu nhập tuổi từ 18 đến 65'
rollback transaction 
end
go

-- bài 1.3 Ràng buộc khi cập nhật nhân viên thì không được cập nhật những nhân viên ở TP HCM
create trigger update_NV on NHANVIEN for update as
IF (SELECT DCHI FROM inserted ) like '%TP HCM%'
begin
print'Không thể cập nhật'
rollback transaction
end
go

--bài 2.1 Hiển thị tổng số lượng nhân viên nữ, tổng số lượng nhân viên nam mỗi khi có hành động thêm mới nhân viên.
CREATE TRIGGER trg_SumEmps
   ON NHANVIEN
   AFTER INSERT
AS
   DECLARE @male INT, @female INT;
   SELECT @female = count(Manv) FROM NHANVIEN WHERE PHAI = N'Nữ';
   SELECT @male = count(Manv) FROM NHANVIEN WHERE PHAI = N'Nam';
   PRINT N'Tổng số nhân viên là nữ: ' + cast(@female as varchar);
   PRINT N'Tổng số nhân viên là nam: ' + cast(@male as varchar);

 ----test
INSERT INTO [dbo].[NHANVIEN]([HONV],[TENLOT],[TENNV],[MANV],[NGSINH],[DCHI],[PHAI],[LUONG],[MA_NQL],[PHG])
VALUES ('A','B','C','345','7-12-1999','HCM','Nam',600000,'005',1)


go
--bài 2.2 Hiển thị tổng số lượng nhân viên nữ, tổng số lượng nhân viên nam mỗi khi có hành động cập nhật phần giới tính nhân viên
CREATE TRIGGER trg_SumEmpsForUpdate
ON NHANVIEN
AFTER update
AS
IF (select top 1 PHAI FROM deleted) != (select top 1 PHAI FROM inserted)
   BEGIN
      Declare @male int, @female int;
      SELECT @female = count(Manv) from NHANVIEN where PHAI = N'Nữ';
      SELECT @male = count(Manv) from NHANVIEN where PHAI = N'Nam';
      PRINT N'Tổng số nhân viên là nữ: ' + cast(@female as varchar);
      PRINT N'Tổng số nhân viên là nam: ' + cast(@male as varchar);
   END;

--test
UPDATE [dbo].[NHANVIEN]
   SET [HONV] = 'Tien'
      ,[PHAI] = N'Nam'
 WHERE  MaNV = '221'
go

--bài 2.3 Hiển thị tổng số lượng đề án mà mỗi nhân viên đã làm khi có hành động xóa trên bảng DEAN
CREATE TRIGGER trg_SumForDelete
   on DEAN
   AFTER DELETE
AS
   SELECT MA_NVIEN, COUNT(MaDA) as 'Tổng sô đề án đã tham gia' from PHANCONG
      GROUP BY MA_NVIEN
go

--bài 3.1 Xóa các thân nhân trong bảng thân nhân có liên quan khi thực hiện hành động xóa nhân viên trong bảng nhân viên.

CREATE TRIGGER trg_deleteNT ON NHANVIEN
INSTEAD OF DELETE 
AS
BEGIN
   DELETE FROM THANNHAN WHERE MA_NVIEN IN (SELECT MANV FROM deleted)
   DELETE FROM NHANVIEN WHERE MANV IN (SELECT MANV FROM deleted)
END

DELETE NHANVIEN WHERE MANV='001'
SELECT * FROM THANNHAN
go

--bài 3.2 Khi thêm một nhân viên mới thì tự động phân công cho nhân viên làm đề án có MADA là 1.
CREATE TRIGGER trg_NhanVien3b ON NHANVIEN
ALTER INSERT 
AS 
BEGIN 
INSERT INTO PHANCONG VALUES((SELECT MANV FROM INSERTED),1,1,100)
END
INSERT INTO NHANVIEN
VALUES('Bui','Duc','Danh','098','09-13-2020','Le Duan - HCM','Nam',90000,'005',1)