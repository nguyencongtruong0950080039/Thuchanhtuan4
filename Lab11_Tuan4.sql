
---------Bai1

CREATE TABLE Khoa (
Makhoa VARCHAR(10) PRIMARY KEY,
Tenkhoa NVARCHAR(50)NOT NULL ,
Dienthoai VARCHAR(20)NOT NULL
);

CREATE TABLE Lop (
Malop VARCHAR(10) PRIMARY KEY,
Tenlop NVARCHAR(50)NOT NULL,
Khoa VARCHAR(10)NOT NULL,
Hedt NVARCHAR(50)NOT NULL,
Namnhaphoc INT NOT NULL,
Makhoa VARCHAR(10) NOT NULL,
FOREIGN KEY (Khoa) REFERENCES Khoa(Makhoa),
FOREIGN KEY (Makhoa) REFERENCES Khoa(Makhoa)
);
--------Cau1
GO
CREATE PROCEDURE ThemKhoa
    @MaKhoa VARCHAR(10),
    @TenKhoa NVARCHAR(100),
    @DienThoai VARCHAR(20)
AS
BEGIN
    IF EXISTS (SELECT * FROM KHOA WHERE TenKhoa = @TenKhoa)
    BEGIN
        PRINT N'Tên khoa đã tồn tại'
        RETURN
    END
    INSERT INTO KHOA(MaKhoa, TenKhoa, DienThoai) VALUES (@MaKhoa, @TenKhoa, @DienThoai)
    
    PRINT N'Thêm khoa thành công'
END
GO
EXEC ThemKhoa 'K01', N'Khoa CNTT1', '0123456789'
EXEC ThemKhoa 'K02', N'Khoa HTTT1', '0123456789'
--------Câu 2-------
GO
CREATE PROCEDURE ThemLop
    @Malop nvarchar(10),
    @Tenlop nvarchar(50),
    @Khoa nvarchar(50),
    @Hedt nvarchar(50),
    @Namnhaphoc int,
    @Makhoa nvarchar(10)
AS
BEGIN
    IF EXISTS (SELECT * FROM Lop WHERE Tenlop = @Tenlop)
    BEGIN
	-- Kiểm tra xem tên lớp đã có trước đó chưa nếu có thì thông báo
        PRINT N'Lớp đã tồn tại'
        RETURN
    END   
    IF NOT EXISTS (SELECT * FROM Khoa WHERE Makhoa = @Makhoa)
    BEGIN
	  -- Kiểm tra xem makhoa này có trong bảng khoa hay không nếu không có thì thông báo
        PRINT N'Mã khoa không tồn tại'
        RETURN
    END
    INSERT INTO Lop(Malop, Tenlop, Khoa, Hedt, Namnhaphoc, Makhoa)
	VALUES(@Malop, @Tenlop, @Khoa, @Hedt, @Namnhaphoc, @Makhoa)  
	    -- Nếu đầy đủ thông tin thì cho nhập
    PRINT N'Nhập thành công'
END
GO
EXEC ThemLop 'L01', N'Lớp CNPM1', 'Khoa CNTT', N'Đại Học', 2023, 'K01'

--------Cau3
GO
CREATE PROCEDURE InsertKhoa
    @MaKhoa VARCHAR(10),
    @TenKhoa NVARCHAR(100),
    @DienThoai VARCHAR(20),
    @Exists BIT OUTPUT
AS
BEGIN
    IF EXISTS (SELECT * FROM KHOA WHERE TenKhoa = @TenKhoa)
    BEGIN
        SET @Exists = 0
        RETURN
    END    
    INSERT INTO KHOA(MaKhoa, TenKhoa, DienThoai) VALUES (@MaKhoa, @TenKhoa, @DienThoai)    
    SET @Exists = 1
END
DECLARE @MyExists BIT
	EXEC InsertKhoa 'K01', N'Khoa CNTT', '0123456789', @MyExists OUTPUT
		IF @MyExists = 1
BEGIN
    PRINT N'Thêm khoa thành công'
END
ELSE
BEGIN
    PRINT N'Tên khoa đã tồn tại'
END
GO
--------Cau4
GO
CREATE PROCEDURE Cau4
    @MaLop VARCHAR(10),
    @TenLop NVARCHAR(50),
    @Khoa NVARCHAR(10),
    @HeDT NVARCHAR(50),
    @NamNhapHoc INT,
    @MaKhoa VARCHAR(10)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Lop WHERE Tenlop = @TenLop)
    BEGIN
        RETURN 0
    END
		IF NOT EXISTS (SELECT 1 FROM Khoa WHERE Makhoa = @MaKhoa)
    BEGIN
        RETURN 1
    END

    INSERT INTO Lop(Malop, Tenlop, Khoa, Hedt, Namnhaphoc, Makhoa) VALUES(@MaLop, @TenLop, @Khoa, @HeDT, @NamNhapHoc, @MaKhoa)   
		RETURN 2
END
DECLARE @Result INT

EXEC @Result = Cau4 'L03', N'Lớp đất đai', N'Khoa Địa Chính', N'Đại Học', 2020, 'K09'

IF @Result = 0
BEGIN
    PRINT N'Tên lớp đã có trước đó'
END
ELSE IF @Result = 1
BEGIN
    PRINT N'Mã khoa không tồn tại'
END
ELSE IF @Result = 2
BEGIN
    PRINT N'Nhập dữ liệu thành công'
END
GO



