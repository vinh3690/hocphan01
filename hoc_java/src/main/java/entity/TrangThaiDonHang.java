package entity;

public class TrangThaiDonHang {
	private String trangThai;
	private int donHang;
	private int soLuong;
	public TrangThaiDonHang(String trangThai, int donHang, int soLuong) {
		super();
		this.trangThai = trangThai;
		this.donHang = donHang;
		this.soLuong = soLuong;
	}
	public TrangThaiDonHang() {
		super();
	}
	public String getTrangThai() {
		return trangThai;
	}
	public void setTrangThai(String trangThai) {
		this.trangThai = trangThai;
	}
	public int getDonHang() {
		return donHang;
	}
	public void setDonHang(int donHang) {
		this.donHang = donHang;
	}
	public int getSoLuong() {
		return soLuong;
	}
	public void setSoLuong(int soLuong) {
		this.soLuong = soLuong;
	}
	
	
}
