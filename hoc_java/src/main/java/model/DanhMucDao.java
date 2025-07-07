package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entity.DanhMuc;


public class DanhMucDao {
	public static boolean themDanhMuc(DanhMuc a) {
		try {
			String sql = "INSERT INTO danhMuc (tenDanhMuc) VALUES (?)";
			Connection c = Database.connect();
			PreparedStatement pstm = c.prepareStatement(sql);
			pstm.setString(1, a.getTenDanhMuc());
			pstm.executeUpdate();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	public static ArrayList<DanhMuc> loadDanhMuc() {
		ArrayList<DanhMuc> arr = new ArrayList<DanhMuc>();
		try {
			Connection c = Database.connect();
			String sql = "select * from danhMuc";
			PreparedStatement pstmt = c.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				 DanhMuc p1 = new DanhMuc();
				 p1.setId(rs.getInt("id"));
		         p1.setTenDanhMuc(rs.getString("tenDanhMuc")); 
				 arr.add(p1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return arr;
}
	public static boolean xoaDanhMuc(int id) {
		try {
			String sql ="delete from danhMuc where id=?";
			Connection c = Database.connect();
			PreparedStatement pstm = c.prepareStatement(sql);
			pstm.setInt(1, id);
			int a = pstm.executeUpdate();
			return a>0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	public static boolean suaDanhMuc(DanhMuc d) {
		try {
			String sql = "update danhMuc set tenDanhMuc=?where id=?";
			Connection c = Database.connect();
			PreparedStatement pstm = c.prepareStatement(sql);
			pstm.setString(1, d.getTenDanhMuc());
			pstm.setInt(2, d.getId());		
			// Execute update
			int a = pstm.executeUpdate();
			return a > 0;
		} catch (SQLException e) {
			e.printStackTrace(); 
			return false;
		}
	}
}
