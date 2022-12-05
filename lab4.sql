--Bai 1
select IIF (luong>=LTB , 'khong tang luong', 'tang luong')
as THUONG, TENNV, LUONG, LTB
FROM
(SELECT TENNV, LUONG, LTB FROM NHANVIEN,

(SELECT PHG, AVG(luong) as "ltb" from NHANVIEN GROUP BY PHG) AS TEMP
WHERE NHANVIEN.PHG=TEMP.PHG) AS ABC
go

select IIF (luong>=LTB , 'trưởng phòng', 'nhân viên')
as THUONG, TENNV, LUONG, LTB
FROM
(SELECT TENNV, LUONG, LTB FROM NHANVIEN,

(SELECT PHG, AVG(luong) as "ltb" from NHANVIEN GROUP BY PHG) AS TEMP
WHERE NHANVIEN.PHG=TEMP.PHG) AS ABC
go

select tenv =case phai
	when 'nam' then 'Mr. '+ tennv
	when N'Nữ' then 'Ms. '+ tennv
end
from NHANVIEN
go

select tennv,luong, thue = case
	when luong between 0 and 25000 then luong*0.1
	when luong between 25000 and 30000 then luong*0.12
	when luong between 30000 and 40000 then luong*0.15
	when luong between 40000 and 50000 then luong*0.2
else luong*0.25 end
from NHANVIEN
-- bài 2
select manv, honv, tenlot, tennv from NHANVIEN 
where manv %2=0 and manv!=4

--bài 3

begin try
	insert PHONGBAN
	values(799, 'ZXK-799', '2008-07-01', '0197-05-22')
	print 'success: record was inserted '
end try
begin catch
	print 'Failure: record was not inserted'
	print 'error '+ convert(varchar, error_number(),1)
		+': '+ error_message()
end catch
--bai 4
--khong dung raserror
begin try
	declare @result int
--divinde by zero
set @result = 55/0
end try
begin catch 
declare 
	@ermessage nvarchar(2048),
	@erseverity int,
	@erstate int
select
	@ermessage = error_message(),
	@erseverity = ERROR_SEVERITY(),
	@erstate = ERROR_STATE()
end catch

--su dung raiserror
begin try
	declare @result int
	set @result =55/0
end try
begin catch
	declare
		@ermessage nvarchar(2048),
		@erseverity int,
		@erstate int
	select
		@ermessage = error_message(),
		@erseverity = ERROR_SEVERITY(),
		@erstate = ERROR_STATE()
	raiserror (@ermessage, @erseverity,@erstate)
end catch