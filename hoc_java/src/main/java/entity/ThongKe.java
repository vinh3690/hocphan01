package entity;

public class ThongKe {
	private int thang;
	private int nam;
	private float doanhThu;
	public ThongKe() {
		
	}
	public ThongKe(int thang, int nam, float doanhThu) {
		super();
		this.thang = thang;
		this.nam = nam;
		this.doanhThu = doanhThu;
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
	public float getDoanhThu() {
		return doanhThu;
	}
	public void setDoanhThu(float doanhThu) {
		this.doanhThu = doanhThu;
	}
	
}
