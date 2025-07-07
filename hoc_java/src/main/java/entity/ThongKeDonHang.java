package entity;

public class ThongKeDonHang {
	private int thang;
	private int nam;
	private int soDonHang;
	public ThongKeDonHang() {
		
	}
	public ThongKeDonHang(int thang, int nam, int soDonHang) {
		super();
		this.thang = thang;
		this.nam = nam;
		this.soDonHang = soDonHang;
	}
	public int getThang() {
		return thang;
	}
	public void setThang(int thang) {
		this.thang = thang;
	}
	public int getNam() {
		return nam;
	}
	public void setNam(int nam) {
		this.nam = nam;
	}
	public int getSoDonHang() {
		return soDonHang;
	}
	public void setSoDonHang(int soDonHang) {
		this.soDonHang = soDonHang;
	}
	
}
