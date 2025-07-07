package entity;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class DonHang {
	private int id;
	private int nguoiDungId;
	private Timestamp ngayTao;
	private float tongTien;
	private String trangThai;
	private String hoTen;
	private String diaChi;
	private String soDienThoai;
	private String email;
	private String ghiChu;
	private String hinhThuc;
	private NguoiDung nguoiDung;
	private List<ChiTietDonHang> chiTietDonHangList; // Thay thế SanPham và ChiTietDonHang

	public DonHang() {
		this.chiTietDonHangList = new ArrayList<>();
	}

	public DonHang(int id, int nguoiDungId, Timestamp ngayTao, float tongTien, String trangThai, String hoTen,
			String diaChi, String soDienThoai, String email, String ghiChu, String hinhThuc) {
		this.id = id;
		this.nguoiDungId = nguoiDungId;
		this.ngayTao = ngayTao;
		this.tongTien = tongTien;
		this.trangThai = trangThai;
		this.hoTen = hoTen;
		this.diaChi = diaChi;
		this.soDienThoai = soDienThoai;
		this.email = email;
		this.ghiChu = ghiChu;
		this.hinhThuc = hinhThuc;
		this.chiTietDonHangList = new ArrayList<>();
	}

	// Getters and setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getNguoiDungId() {
		return nguoiDungId;
	}

	public void setNguoiDungId(int nguoiDungId) {
		this.nguoiDungId = nguoiDungId;
	}

	public Timestamp getNgayTao() {
		return ngayTao;
	}

	public void setNgayTao(Timestamp ngayTao) {
		this.ngayTao = ngayTao;
	}

	public float getTongTien() {
		return tongTien;
	}

	public void setTongTien(float tongTien) {
		this.tongTien = tongTien;
	}

	public String getTrangThai() {
		return trangThai;
	}

	public void setTrangThai(String trangThai) {
		this.trangThai = trangThai;
	}

	public String getHoTen() {
		return hoTen;
	}

	public void setHoTen(String hoTen) {
		this.hoTen = hoTen;
	}

	public String getDiaChi() {
		return diaChi;
	}

	public void setDiaChi(String diaChi) {
		this.diaChi = diaChi;
	}

	public String getSoDienThoai() {
		return soDienThoai;
	}

	public void setSoDienThoai(String soDienThoai) {
		this.soDienThoai = soDienThoai;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getGhiChu() {
		return ghiChu;
	}

	public void setGhiChu(String ghiChu) {
		this.ghiChu = ghiChu;
	}

	public String getHinhThuc() {
		return hinhThuc;
	}

	public void setHinhThuc(String hinhThuc) {
		this.hinhThuc = hinhThuc;
	}

	public NguoiDung getNguoiDung() {
		return nguoiDung;
	}

	public void setNguoiDung(NguoiDung nguoiDung) {
		this.nguoiDung = nguoiDung;
	}

	public List<ChiTietDonHang> getChiTietDonHangList() {
		return chiTietDonHangList;
	}

	public void setChiTietDonHangList(List<ChiTietDonHang> chiTietDonHangList) {
		this.chiTietDonHangList = chiTietDonHangList;
	}
}