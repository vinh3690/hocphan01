package entity;

public class NguoiDung {
    private int id;
    private String tenDangNhap;
    private String matKhau;
    private String hoTen;
    private String email;
    private String phone;
    private int phanQuyen;
    private String diaChi;
    public NguoiDung() {}

    public NguoiDung(int id, String tenDangNhap, String matKhau, String hoTen, String email, String phone,String diaChi, int phanQuyen) {
        this.id = id;
        this.tenDangNhap = tenDangNhap;
        this.matKhau = matKhau;
        this.hoTen = hoTen;
        this.email = email;
        this.phone = phone;
        this.diaChi=diaChi;
        this.phanQuyen = phanQuyen;
    }
    public NguoiDung( String tenDangNhap, String matKhau, String hoTen, String email, String phone,String diaChi) {
        this.tenDangNhap = tenDangNhap;
        this.matKhau = matKhau;
        this.hoTen = hoTen;
        this.email = email;
        this.phone = phone;
        this.diaChi=diaChi;
    }
    public NguoiDung( String tenDangNhap, String matKhau, String hoTen, String email, String phone,int phanQuyen) {
        this.tenDangNhap = tenDangNhap;
        this.matKhau = matKhau;
        this.hoTen = hoTen;
        this.email = email;
        this.phone = phone;
        this.phanQuyen=phanQuyen;
    }
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTenDangNhap() {
		return tenDangNhap;
	}

	public void setTenDangNhap(String tenDangNhap) {
		this.tenDangNhap = tenDangNhap;
	}

	public String getMatKhau() {
		return matKhau;
	}

	public void setMatKhau(String matKhau) {
		this.matKhau = matKhau;
	}

	public String getHoTen() {
		return hoTen;
	}

	public void setHoTen(String hoTen) {
		this.hoTen = hoTen;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public int getPhanQuyen() {
		return phanQuyen;
	}

	public void setPhanQuyen(int phanQuyen) {
		this.phanQuyen = phanQuyen;
	}
	
	public String getDiaChi() {
		return diaChi;
	}

	public void setDiaChi(String diaChi) {
		this.diaChi = diaChi;
	}

	@Override
	public String toString() {
		return "NguoiDung [id=" + id + ", tenDangNhap=" + tenDangNhap + ", matKhau=" + matKhau + ", hoTen=" + hoTen
				+ ", email=" + email + ", phone=" + phone + ", phanQuyen=" + phanQuyen + "]";
	}
	

	

   
}
