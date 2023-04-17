-------bai3
GO
CREATE PROCEDURE ThemHangSX 
    @MaHangSX NCHAR(10),
    @TenHang NVARCHAR(20),
    @DiaChi NVARCHAR(30),
    @SoDT NVARCHAR(20),
    @Email NVARCHAR(30)
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM HangSX WHERE TenHang = @TenHang)
    BEGIN
        INSERT INTO HangSX VALUES (@MaHangSX, @TenHang, @DiaChi, @SoDT, @Email)
        PRINT N'Đã thêm thành công!'
    END
    ELSE
        PRINT N'Tên hãng sản xuất này đã tồn tại. Vui lòng kiểm tra lại!'
END
GO
EXEC ThemHangSX 'H04', 'Apple', 'USA', '0123456789', 'apple@gmail.com'

-----Câu B
GO
CREATE PROCEDURE NhapSanPham
(
    @MaSP INT,
    @MaHangSX NVARCHAR(50),
    @TenSP NVARCHAR(50),
    @SoLuong INT,
    @MauSac NVARCHAR(20),
    @GiaBan MONEY,
    @DonViTinh NVARCHAR(10),
    @MoTa NVARCHAR(MAX)
)
AS
BEGIN
    IF EXISTS (SELECT * FROM SanPham WHERE MaSP = @MaSP)
    BEGIN
        UPDATE SanPham
        SET MaHangSX = @MaHangSX,
            TenSP = @TenSP,
            SoLuong = @SoLuong,
            MauSac = @MauSac,
            GiaBan = @GiaBan,
            DonViTinh = @DonViTinh,
            MoTa = @MoTa
        WHERE MaSP = @MaSP
    END
    ELSE
    BEGIN
        INSERT INTO SanPham (MaSP, MaHangSX, TenSP, SoLuong, MauSac, GiaBan, DonViTinh, MoTa)
        VALUES (@MaSP, @MaHangSX, @TenSP, @SoLuong, @MauSac, @GiaBan, @DonViTinh, @MoTa)
    END
END
GO
-----Câu C
GO
CREATE PROCEDURE XoaHangSX
    @TenHang nvarchar(50)
AS
BEGIN

    IF NOT EXISTS (SELECT * FROM HangSX WHERE TenHang = @TenHang)
    BEGIN
        PRINT N'Không tìm thấy hãng sản xuất ' + @TenHang
        RETURN
    END
    DELETE FROM SanPham WHERE MaHangSX IN (SELECT MaHangSX FROM HangSX WHERE TenHang = @TenHang)

    DELETE FROM HangSX WHERE TenHang = @TenHang

    PRINT N'Đã xóa hãng sản xuất ' + @TenHang + N' và các sản phẩm liên quan.'
END
GO
-----Câu D
GO
CREATE PROCEDURE NhapLieuNhanVien
    @manv INT,
    @TenNV NVARCHAR(50),
    @GioiTinh NVARCHAR(5),
    @DiaChi NVARCHAR(100),
    @SoDT NVARCHAR(20),
    @Email NVARCHAR(50),
    @Phong NVARCHAR(50),
    @Flag BIT
AS
BEGIN
    SET NOCOUNT ON;

    IF(@Flag = 0) 
    BEGIN
        UPDATE NhanVien
        SET TenNV = @TenNV,
            GioiTinh = @GioiTinh,
            DiaChi = @DiaChi,
            SoDT = @SoDT,
            Email = @Email,
            Phong = @Phong
        WHERE manv = @manv
    END
    ELSE
    BEGIN
        INSERT INTO NhanVien(manv, TenNV, GioiTinh, DiaChi, SoDT, Email, Phong)
        VALUES (@manv, @TenNV, @GioiTinh, @DiaChi, @SoDT, @Email, @Phong)
    END
END
-----Câu E
GO
CREATE PROCEDURE NhapHang
    @SoHDN int,
    @MaSP varchar(10),
    @manv varchar(10),
    @NgayNhap date,
    @SoLuongN int,
    @DonGiaN decimal(18,2)
AS
BEGIN
    IF NOT EXISTS(SELECT * FROM SanPham WHERE MaSP = @MaSP)
    BEGIN
        PRINT 'Mã sản phẩm không tồn tại trong bảng SanPham'
        RETURN
    END
    IF NOT EXISTS(SELECT * FROM NhanVien WHERE manv = @manv)
    BEGIN
        PRINT 'Mã nhân viên không tồn tại trong bảng NhanVien'
        RETURN
    END

    IF EXISTS(SELECT * FROM Nhap WHERE SoHDN = @SoHDN)
    BEGIN
        UPDATE Nhap
        SET MaSP = @MaSP,
            manv = @manv,
            NgayNhap = @NgayNhap,
            SoLuongN = @SoLuongN,
            dongiaN = @DonGiaN
        WHERE SoHDN = @SoHDN
        PRINT N'Đã cập nhật bảng Nhap thành công'
    END
    ELSE
    BEGIN
        -- Ngược lại thêm mới bảng Nhap
        INSERT INTO Nhap(SoHDN, MaSP, manv, NgayNhap, SoLuongN, dongiaN)
        VALUES(@SoHDN, @MaSP, @manv, @NgayNhap, @SoLuongN, @DonGiaN)
        PRINT N'Đã thêm mới bảng Nhap thành công'
    END
END
GO
-----Câu F
GO
CREATE PROCEDURE ThemXuat @SoHDX INT, @MaSP INT, @manv INT, @NgayXuat DATE, @SoLuongX INT
AS
BEGIN

    IF NOT EXISTS(SELECT 1 FROM SanPham WHERE MaSP = @MaSP)
    BEGIN
        PRINT N'MaSP không tồn tại trong bảng SanPham'
        RETURN
    END

    IF NOT EXISTS(SELECT 1 FROM NhanVien WHERE manv = @manv)
    BEGIN
        PRINT N'manv không tồn tại trong bảng NhanVien'
        RETURN
    END

    IF @SoLuongX > (SELECT SoLuong FROM SanPham WHERE MaSP = @MaSP)
    BEGIN
        PRINT N'SoLuongX lớn hơn SoLuong trong bảng SanPham'
        RETURN
    END

    IF EXISTS(SELECT 1 FROM Xuat WHERE SoHDX = @SoHDX)
    BEGIN
        UPDATE Xuat
        SET MaSP = @MaSP, manv = @manv, NgayXuat = @NgayXuat, SoLuongX = @SoLuongX
        WHERE SoHDX = @SoHDX
        PRINT N'Đã cập nhật thành công bảng Xuat'
    END
    ELSE
    BEGIN
        INSERT INTO Xuat(SoHDX, MaSP, manv, NgayXuat, SoLuongX)
        VALUES (@SoHDX, @MaSP, @manv, @NgayXuat, @SoLuongX)
        PRINT N'Đã thêm thành công bảng Xuat'
    END
END
GO
-----Câu G
GO
CREATE PROCEDURE DeleteNhanVien @manv varchar(10)
AS
BEGIN
    -- Kiểm tra xem nhân viên có tồn tại trong bảng NhanVien hay không
    IF NOT EXISTS(SELECT * FROM NhanVien WHERE manv = @manv)
    BEGIN
        PRINT N'Không tìm thấy nhân viên có mã ' + @manv + N' trong bảng NhanVien'
        RETURN
    END

    BEGIN TRANSACTION 
    DELETE FROM Nhap WHERE manv = @manv
    DELETE FROM Xuat WHERE manv = @manv
    DELETE FROM NhanVien WHERE manv = @manv

    COMMIT 

    PRINT N'Đã xóa nhân viên có mã ' + @manv + N' thành công'
END
GO
-----Câu H
GO
CREATE PROCEDURE XoaSanPham (@MaSP VARCHAR(10))
AS
BEGIN

    IF NOT EXISTS (SELECT * FROM SanPham WHERE MaSP = @MaSP)
    BEGIN
        PRINT N'Sản phẩm không tồn tại trong bảng SanPham.'
        RETURN
    END
    DELETE FROM Nhap WHERE MaSP = @MaSP
    DELETE FROM Xuat WHERE MaSP = @MaSP
    DELETE FROM SanPham WHERE MaSP = @MaSP
    
    PRINT N'Xóa sản phẩm thành công.'
END
GO