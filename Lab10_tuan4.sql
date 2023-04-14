---------câu1-----------------
-----a. Thêm dữ liệu cho bảng

INSERT INTO NhanVien (manv, tennv, gioitinh, diachi, sodt, email, phong)
VALUES ('NV04', 'Nguyễn Thị Tí', 'Nữ', 'Ha Noi', '0982623123', 'ntt@example.com', 'Kế toán')

BACKUP DATABASE [QLBanHang] TO DISK = 'D:\QLBH.bak' WITH INIT
------b.Thêm dữ liệu cho bảng 
INSERT INTO NhanVien (manv, tennv, gioitinh, diachi, sodt, email, phong)
VALUES ('NV05', 'Nguyễn Thị Tú', 'Nữ', 'Ha Noi', '098467528', 'nt@example.com', 'Vật tư')
BACKUP DATABASE [QLBanHang] TO DISK = 'D:\QLBanHang.bak' WITH DIFFERENTIAL
-----c.-----------
INSERT INTO NhanVien (manv, tennv, gioitinh, diachi, sodt, email, phong)
VALUES ('NV06', 'Nguyễn Văn Tú', 'Nam', 'Ha Tinh', '0967851740', 'nvt@example.com', 'Vật tư')
BACKUP LOG [QLBanHang] TO DISK = 'D:\qlbh.bak' WITH INIT
-----d-------------
INSERT INTO NhanVien (manv, tennv, gioitinh, diachi, sodt, email, phong)
VALUES ('NV07', 'Nguyễn Văn Tuấn', 'Nam', 'Ha Tinh', '09547634201', 'vt@example.com', 'Kế toán')
BACKUP LOG [QLBanHang] TO DISK = 'D:\qlbh.bak' WITH NOINIT


------------------câu2-------------------

