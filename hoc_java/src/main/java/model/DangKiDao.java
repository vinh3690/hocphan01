package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import entity.NguoiDung;

public class DangKiDao {
	public static boolean dangKi(NguoiDung a) {
		try {
			String sql = "INSERT INTO nguoiDung (tenDangNhap, matKhau,hoTen,email,phone,phanQuyen,diaChi) VALUES (?, ?, ?, ?, ?, ?,?)";
			Connection c = Database.connect();
			PreparedStatement pstm = c.prepareStatement(sql);
			pstm.setString(1, a.getTenDangNhap());
			pstm.setString(2, a.getMatKhau());
			pstm.setString(3, a.getHoTen());
			pstm.setString(4, a.getEmail());
			pstm.setString(5, a.getPhone());
			if(a.getPhanQuyen()>0) {
				pstm.setInt(6, a.getPhanQuyen());
			}
			else {
			pstm.setInt(6, 0);
			}
			pstm.setString(7, a.getDiaChi());
			pstm.executeUpdate();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	public static NguoiDung dangNhap(NguoiDung a) {
		NguoiDung acc = null;
		try {
			String sql = "select * from nguoiDung where tenDangNhap =? and matKhau=?";
			Connection c = Database.connect();
			PreparedStatement pstm = c.prepareStatement(sql);
			pstm.setString(1, a.getTenDangNhap());
			pstm.setString(2, a.getMatKhau());
			ResultSet rs = pstm.executeQuery();
			if (rs.next()) {
				int id = rs.getInt("id");
				String user = rs.getString("tenDangNhap");
				String pass = rs.getString("matKhau");
				String hoTen = rs.getString("hoTen");
				String sdt = rs.getString("phone");
				String email = rs.getString("email");
				int phanQuyen = rs.getInt("phanQuyen");
				String diaChi = rs.getString("diaChi");
				acc = new NguoiDung(id, user, pass, hoTen, email,sdt,diaChi,phanQuyen);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return acc;
	}
}
