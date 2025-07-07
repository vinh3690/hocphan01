package entity;

public class ThongKeSanPhamBanChay {
	private String tenSanPham;
	private int tong;
	
	public ThongKeSanPhamBanChay(String tenSanPham, int tong) {
		super();
		this.tenSanPham = tenSanPham;
		this.tong = tong;
	}
	public ThongKeSanPhamBanChay() {
		
	}
	public String getTenSanPham() {
		return tenSanPham;
	}
	public void setTenSanPham(String tenSanPham) {
		this.tenSanPham = tenSanPham;
	}
	public int getTong() {
		return tong;
	}
	public void setTong(int tong) {
		this.tong = tong;
	}
	@Override
	public String toString() {
		return "ThongKeSanPhamBanChay [tenSanPham=" + tenSanPham + ", tong=" + tong + "]";
	}
	
}
