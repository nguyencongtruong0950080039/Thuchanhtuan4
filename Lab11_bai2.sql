
--------Bai2

CREATE TABLE tblChucVu (
  MaCV VARCHAR(10) PRIMARY KEY,
  TenCV NVARCHAR(50)
);

CREATE TABLE tblNhanVien (
  MaNV VARCHAR(10) PRIMARY KEY,
  MaCV VARCHAR(10),
  TenNV NVARCHAR(30),
  NgaySinh DATE,
  LuongCanBan float,
  NgayCong INT,
  PhuCap float,
  FOREIGN KEY (MaCV) REFERENCES tblChucvu(MaCV)
);

INSERT INTO tblChucVu (MaCV, TenCV) VALUES ('GD', N'Giám đốc');
INSERT INTO tblChucVu (MaCV, TenCV) VALUES ('KT', N'Kế toán');
INSERT INTO tblChucVu (MaCV, TenCV) VALUES ('NV', N'Nhân viên');
INSERT INTO tblChucVu (MaCV, TenCV) VALUES ('KT1', N'Kế toán trưởng');
INSERT INTO tblChucVu (MaCV, TenCV) VALUES ('TL', N'Trưởng phòng');

INSERT INTO tblNhanVien (MaNV, MaCV, TenNV, NgaySinh, LuongCanBan, NgayCong, PhuCap)
VALUES ('NV01', 'GD', N'Nguyễn Văn An', '1980-10-10', 9000000, 30, 3000000);

INSERT INTO tblNhanVien (MaNV, MaCV, TenNV, NgaySinh, LuongCanBan, NgayCong, PhuCap)
VALUES ('NV02', 'KT1', N'Trần Thị Bình', '1995-01-01', 6000000, 28, 1000000);

INSERT INTO tblNhanVien (MaNV, MaCV, TenNV, NgaySinh, LuongCanBan, NgayCong, PhuCap)
VALUES ('NV03', 'NV', N'Phạm Thị Yến', '1992-05-15', 5000000, 30, 500000);

INSERT INTO tblNhanVien (MaNV, MaCV, TenNV, NgaySinh, LuongCanBan, NgayCong, PhuCap)
VALUES ('NV04', 'TL', N'Lê Thị Hà', '1990-03-20', 7000000, 28, 1000000);

INSERT INTO tblNhanVien (MaNV, MaCV, TenNV, NgaySinh, LuongCanBan, NgayCong, PhuCap)
VALUES ('NV05', 'KT', N'Nguyễn Thị Kim', '1994-07-08', 5500000, 26, 800000);

-----a
GO
CREATE PROCEDURE ThemNhanVien
    @MaNV VARCHAR(4),
    @MaCV VARCHAR(2),
    @TenNV NVARCHAR(30),
    @NgaySinh DATE,
    @LuongCanBan FLOAT,
    @NgayCong INT,
    @PhuCap FLOAT
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM tblChucVu WHERE MaCV = @MaCV)
    BEGIN
        PRINT N'Mã chức vụ không tồn tại trong bảng tblChucVu!'
        RETURN
    END
    INSERT INTO tblNhanVien (MaNV, MaCV, TenNV, NgaySinh, LuongCanBan, NgayCong, PhuCap)
    VALUES (@MaNV, @MaCV, @TenNV, @NgaySinh, @LuongCanBan, @NgayCong, @PhuCap)    
    PRINT N'Thêm nhân viên thành công!'
END
GO
EXEC ThemNhanVien 'NV06', 'GD1', N'Nguyễn Công Trương', '1990-01-01', 5000000, 22, 1000000

-----b
GO
CREATE PROCEDURE CapNhatNV
  @MaNV VARCHAR(4),
  @MaCV VARCHAR(2),
  @TenNV NVARCHAR(30),
  @NgaySinh DATE,
  @LuongCanBan FLOAT,
  @NgayCong INT,
  @PhuCap FLOAT
AS
BEGIN
  IF EXISTS(SELECT * FROM tblChucVu WHERE MaCV = @MaCV)
  BEGIN
    UPDATE tblNhanVien 
    SET MaCV = @MaCV, 
        TenNV = @TenNV, 
        NgaySinh = @NgaySinh, 
        LuongCanBan = @LuongCanBan, 
        NgayCong = @NgayCong, 
        PhuCap = @PhuCap 
    WHERE MaNV = @MaNV;
    PRINT N'Đã cập nhật thông tin nhân viên.'
  END
  ELSE
  BEGIN
    PRINT N'Mã chức vụ không tồn tại trong bảng chức vụ.'
  END
END
GO
EXEC CapNhatNV 'NV01', 'GD1', 'Nguyễn Công Trường', '2020-09-09', 5000000, 20, 1000000
-----c
GO
CREATE PROCEDURE LuongLNV
AS
BEGIN
  SELECT MaNV, TenNV, LuongCanBan*NgayCong+PhuCap AS Luong
  FROM tblNhanVien;
END
GO
EXEC LuongLNV;

