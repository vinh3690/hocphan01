package entity;

import java.sql.Timestamp;

public class DanhGia {
	private int id;
	private int sanPhamId;
	private int nguoiDungId;
	private int diem;
	private String binhLuan;
	private Timestamp ngayDanhGia;
	private NguoiDung nguoiDung;
	private SanPham sanPham;
	public DanhGia(int id, int sanPhamId, int nguoiDungId, int diem, String binhLuan, Timestamp ngayDanhGia) {
		super();
		this.id = id;
		this.sanPhamId = sanPhamId;
		this.nguoiDungId = nguoiDungId;
		this.diem = diem;
		this.binhLuan = binhLuan;
		this.ngayDanhGia = ngayDanhGia;
	}
	public DanhGia() {}
	public DanhGia(int nguoiDungId,int sanPhamId, int diem, String binhLuan, Timestamp ngayDanhGia) {
		super();
		this.sanPhamId = sanPhamId;
		this.nguoiDungId = nguoiDungId;
		this.diem = diem;
		this.binhLuan = binhLuan;
		this.ngayDanhGia = ngayDanhGia;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSanPhamId() {
		return sanPhamId;
	}
	public void setSanPhamId(int sanPhamId) {
		this.sanPhamId = sanPhamId;
	}
	public int getNguoiDungId() {
		return nguoiDungId;
	}
	public void setNguoiDungId(int nguoiDungId) {
		this.nguoiDungId = nguoiDungId;
	}
	public int getDiem() {
		return diem;
	}
	public void setDiem(int diem) {
		this.diem = diem;
	}
	public String getBinhLuan() {
		return binhLuan;
	}
	public void setBinhLuan(String binhLuan) {
		this.binhLuan = binhLuan;
	}
	public Timestamp getNgayDanhGia() {
		return ngayDanhGia;
	}
	public void setNgayDanhGia(Timestamp ngayDanhGia) {
		this.ngayDanhGia = ngayDanhGia;
	}
	public NguoiDung getNguoiDung() {
		return nguoiDung;
	}
	public void setNguoiDung(NguoiDung nguoiDung) {
		this.nguoiDung = nguoiDung;
	}
	public SanPham getSanPham() {
		return sanPham;
	}
	public void setSanPham(SanPham sanPham) {
		this.sanPham = sanPham;
	}
	
	
	
}
