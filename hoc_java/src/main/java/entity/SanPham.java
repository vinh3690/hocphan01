package entity;

public class SanPham {
    private int id;
    private String tenSanPham;
    private float gia;
    private String moTa;
    private String anh;
    private int danhMucId;
    private int soLuong;
    private String tenDanhMuc;
    public SanPham() {}

    public SanPham(int id, String tenSanPham, float gia, String moTa, String anh, int danhMucId, int soLuong) {
        this.id = id;
        this.tenSanPham = tenSanPham;
        this.gia = gia;
        this.moTa = moTa;
        this.anh = anh;
        this.danhMucId = danhMucId;
        this.soLuong = soLuong;
    }
    public SanPham(String tenSanPham, float gia, String moTa, String anh, int danhMucId, int soLuong) {
        this.tenSanPham = tenSanPham;
        this.gia = gia;
        this.moTa = moTa;
        this.anh = anh;
        this.danhMucId = danhMucId;
        this.soLuong = soLuong;
    }
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTenSanPham() {
		return tenSanPham;
	}

	public void setTenSanPham(String tenSanPham) {
		this.tenSanPham = tenSanPham;
	}

	public float getGia() {
		return gia;
	}

	public void setGia(float gia) {
		this.gia = gia;
	}

	public String getMoTa() {
		return moTa;
	}

	public void setMoTa(String moTa) {
		this.moTa = moTa;
	}

	public String getAnh() {
		return anh;
	}

	public void setAnh(String anh) {
		this.anh = anh;
	}

	public int getDanhMucId() {
		return danhMucId;
	}

	public void setDanhMucId(int danhMucId) {
		this.danhMucId = danhMucId;
	}

	public int getSoLuong() {
		return soLuong;
	}

	public void setSoLuong(int soLuong) {
		this.soLuong = soLuong;
	}

	public String getTenDanhMuc() {
		return tenDanhMuc;
	}

	public void setTenDanhMuc(String tenDanhMuc) {
		this.tenDanhMuc = tenDanhMuc;
	}

	@Override
	public String toString() {
		return "SanPham [id=" + id + ", tenSanPham=" + tenSanPham + ", gia=" + gia + ", moTa=" + moTa + ", anh=" + anh
				+ ", danhMucId=" + danhMucId + ", soLuong=" + soLuong + ", tenDanhMuc=" + tenDanhMuc + "]";
	}
	

    
}
