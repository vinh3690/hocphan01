package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entity.NguoiDung;
public class NguoiDungDao {
	    public static ArrayList<NguoiDung> loadNguoiDung() {
	        ArrayList<NguoiDung> arr = new ArrayList<NguoiDung>();
	        try {
	            Connection c = Database.connect();
	            String sql = "SELECT * FROM nguoiDung";
	            PreparedStatement pstmt = c.prepareStatement(sql);
	            ResultSet rs = pstmt.executeQuery();

	            // Duyệt qua các bản ghi trong kết quả truy vấn
	            while (rs.next()) {
	                // Tạo đối tượng nguoiDung
	                NguoiDung p1 = new NguoiDung();

	                p1.setId(rs.getInt("id"));
	                p1.setHoTen(rs.getString("hoTen")); // Lấy Họ tên
	                p1.setTenDangNhap(rs.getString("tenDangNhap")); // Lấy ảnh
	                p1.setMatKhau(rs.getString("matKhau")); // Lấy mô tả
	                p1.setEmail(rs.getString("email")); // Lấy giá
	                p1.setPhone(rs.getString("phone")); // Lấy số lượng
	                arr.add(p1);
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        
	        return arr;
	    }
	    public static boolean xoaNguoiDung(int id) {
	        boolean deleted = false;
	        try {
	            Connection c = Database.connect();
	            String sql = "DELETE FROM nguoiDung WHERE id = ?";
	            PreparedStatement pstmt = c.prepareStatement(sql);
	            pstmt.setInt(1, id);

	            int rowsAffected = pstmt.executeUpdate();
	            deleted = rowsAffected > 0;

	            pstmt.close();
	            c.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return deleted;
	    }

		public static ArrayList<NguoiDung> loadNguoiDung(int index) {
		    ArrayList<NguoiDung> arr = new ArrayList<>();
		    String sql = "select * from nguoiDung ORDER BY id\r\n"
		    		+ "OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY;";
		    try (Connection conn = Database.connect(); 
		    	PreparedStatement ps = conn.prepareStatement(sql)) {
		        ps.setInt(1, (index-1)*3);
		        ResultSet rs = ps.executeQuery();
		        while (rs.next()) {
		            NguoiDung p1 = new NguoiDung();
	                p1.setId(rs.getInt("id"));
	                p1.setHoTen(rs.getString("hoTen")); // Lấy Họ tên
	                p1.setTenDangNhap(rs.getString("tenDangNhap")); // Lấy ảnh
	                p1.setMatKhau(rs.getString("matKhau")); // Lấy mô tả
	                p1.setEmail(rs.getString("email")); // Lấy giá
	                p1.setPhone(rs.getString("phone")); // Lấy số lượng
	                p1.setDiaChi(rs.getString("diaChi"));
	                p1.setPhanQuyen(rs.getInt("phanQuyen"));
	                arr.add(p1);
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }
		    return arr;
		}
		public static int total() {
		    try {
		        String sql = "SELECT COUNT(*) FROM nguoiDung";
		        Connection c = Database.connect();
		        PreparedStatement pstm = c.prepareStatement(sql);
		        ResultSet rs = pstm.executeQuery();
		        if (rs.next()) {
		            return rs.getInt(1); 
		        }
		        c.close();
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }
		    return 0;
		}
		public static boolean updateNguoiDung(NguoiDung a) {
		    try {
		        String sql = "UPDATE nguoiDung SET matKhau = ?, hoTen = ?, email = ?, phone = ?, phanQuyen = ?, diaChi = ? WHERE tenDangNhap = ?";
		        Connection c = Database.connect();
		        PreparedStatement pstm = c.prepareStatement(sql);

		        pstm.setString(1, a.getMatKhau());
		        pstm.setString(2, a.getHoTen());
		        pstm.setString(3, a.getEmail());
		        pstm.setString(4, a.getPhone());
		        pstm.setInt(5, a.getPhanQuyen());
		        pstm.setString(6, a.getDiaChi()); 
		        pstm.setString(7, a.getTenDangNhap()); // WHERE

		        System.out.println("Tên đăng nhập update: " + a.getTenDangNhap());

		        int rowsUpdated = pstm.executeUpdate();
		        return rowsUpdated > 0;
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return false;
		}



	}



