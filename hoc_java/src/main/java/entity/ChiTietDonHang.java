package entity;

public class ChiTietDonHang {
    private int id;
    private int donHangId;
    private int sanPhamId;
    private int soLuong;
    private double donGia;
    private SanPham sanPham;
    public ChiTietDonHang() {}

    public ChiTietDonHang(int id, int donHangId, int sanPhamId, int soLuong, double donGia) {
        this.id = id;
        this.donHangId = donHangId;
        this.sanPhamId = sanPhamId;
        this.soLuong = soLuong;
        this.donGia = donGia;
    }
    public ChiTietDonHang(int donHangId, int sanPhamId, int soLuong, double donGia) {
        this.donHangId = donHangId;
        this.sanPhamId = sanPhamId;
        this.soLuong = soLuong;
        this.donGia = donGia;
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getDonHangId() {
		return donHangId;
	}

	public void setDonHangId(int donHangId) {
		this.donHangId = donHangId;
	}

	public int getSanPhamId() {
		return sanPhamId;
	}

	public void setSanPhamId(int sanPhamId) {
		this.sanPhamId = sanPhamId;
	}

	public int getSoLuong() {
		return soLuong;
	}

	public void setSoLuong(int soLuong) {
		this.soLuong = soLuong;
	}

	public double getDonGia() {
		return donGia;
	}

	public void setDonGia(double donGia) {
		this.donGia = donGia;
	}

	public SanPham getSanPham() {
		return sanPham;
	}

	public void setSanPham(SanPham sanPham) {
		this.sanPham = sanPham;
	}
	
    
}
