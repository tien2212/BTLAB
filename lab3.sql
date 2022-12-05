--Bài 1--
select TENDEAN,cast(sum(thoigian) as decimal(5,2)) as'Tổng số giờ làm việc' from CONGVIEC
inner join DEAN on CONGVIEC.MADA=DEAN.MADA
inner join PHANCONG on CONGVIEC.MADA=PHANCONG.MADA
group by TENDEAN
go
select TENDEAN,convert(varchar,sum(thoigian)) as'Tổng số giờ làm việc' from CONGVIEC
inner join DEAN on CONGVIEC.MADA=DEAN.MADA
inner join PHANCONG on CONGVIEC.MADA=PHANCONG.MADA
group by TENDEAN
go   
select tenphg,cast(avg(luong) as decimal(9,2)) as 'lương trung bình' from NHANVIEN
inner join PHONGBAN on NHANVIEN.PHG=PHONGBAN.MAPHG
group by tenphg
go
select tenphg,left(cast(avg(luong) as varchar(9)) ,3)+','
+REPLACE(cast(avg(luong) as varchar(9)),left(cast(avg(luong) as varchar(9)) ,3),',') as 'lương trung bình' from NHANVIEN
inner join PHONGBAN on NHANVIEN.PHG=PHONGBAN.MAPHG
group by tenphg
go

--Bài 2--
select TENDEAN,ceiling(cast(sum(thoigian) as decimal(5,2))) as'Tổng số giờ làm việc' from CONGVIEC
inner join DEAN on CONGVIEC.MADA=DEAN.MADA
inner join PHANCONG on CONGVIEC.MADA=PHANCONG.MADA
group by TENDEAN
go
select TENDEAN,floor(cast(sum(thoigian) as decimal(5,2))) as'Tổng số giờ làm việc' from CONGVIEC
inner join DEAN on CONGVIEC.MADA=DEAN.MADA
inner join PHANCONG on CONGVIEC.MADA=PHANCONG.MADA
group by TENDEAN
go

select honv+' '+tenlot+' '+tennv, luong from NHANVIEN
where luong> (select round(avg(luong),2) from NHANVIEN where PHG=(select maphg from PHONGBAN where TENPHG=N'Nghiên cứu'))
go

--Bài 3--
select (upper(NHANVIEN.HONV) + ' ' + NHANVIEN.TENLOT + ' '+ NHANVIEN.TENNV) as 'Họ tên nhân viên có trên 2 thân nhân',NHANVIEN.DCHI as 'Địa chỉ'
	from NHANVIEN, THANNHAN
	where NHANVIEN.MANV= THANNHAN.MA_NVIEN
	group by (upper(NHANVIEN.HONV) + ' ' + NHANVIEN.TENLOT + ' '+ NHANVIEN.TENNV), NHANVIEN.DCHI
	having count(THANNHAN.MA_NVIEN) > 2
go

select (NHANVIEN.HONV + ' ' + lower(NHANVIEN.TENLOT) + ' '+ NHANVIEN.TENNV) as 'Họ tên nhân viên có trên 2 thân nhân',NHANVIEN.DCHI as 'Địa chỉ'
	from NHANVIEN, THANNHAN
	where NHANVIEN.MANV= THANNHAN.MA_NVIEN
	group by (NHANVIEN.HONV + ' ' +lower(NHANVIEN.TENLOT) + ' '+ NHANVIEN.TENNV), NHANVIEN.DCHI
	having count(THANNHAN.MA_NVIEN) > 2
go




--Bài 4
SELECT (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' '+ NHANVIEN.TENNV) as 'Họ và Tên', NGSINH
	FROM NHANVIEN
	WHERE YEAR(NHANVIEN.NGSINH) BETWEEN 1960 AND 1965
go

SELECT (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' '+ NHANVIEN.TENNV) as 'Họ và Tên', (YEAR(GETDATE()) - YEAR(NHANVIEN.NGSINH)) AS 'Tuổi'
	FROM NHANVIEN
go


