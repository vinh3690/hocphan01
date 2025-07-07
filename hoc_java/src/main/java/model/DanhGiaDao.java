package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entity.DanhGia;
import entity.NguoiDung;
import entity.SanPham;

public class DanhGiaDao {
	public static boolean danhGia(DanhGia dh) {
		try {
			String sql = "INSERT INTO danhGia (nguoi_dung_id,san_pham_id,diem,binh_luan,ngay_danh_gia) VALUES (?,?,?,?,?)";
			Connection c = Database.connect();
			PreparedStatement pstm = c.prepareStatement(sql);
			pstm.setInt(1, dh.getNguoiDungId());
			pstm.setInt(2, dh.getSanPhamId());
			pstm.setInt(3, dh.getDiem());
			pstm.setString(4, dh.getBinhLuan());
			pstm.setTimestamp(5, dh.getNgayDanhGia());
			pstm.executeUpdate();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public static ArrayList<DanhGia> loadDanhGia(int maSanPham) {
		ArrayList<DanhGia> arr = new ArrayList<DanhGia>();
		try {
			Connection c = Database.connect();
			String sql = "SELECT \r\n" + "    nguoiDung.hoTen AS tenNguoiDung,\r\n" + "    sanPham.tenSanPham,\r\n"
					+ "    danhGia.diem,\r\n" + "    danhGia.binh_luan,\r\n" + "    danhGia.ngay_danh_gia,\r\n"
					+ "    danhGia.san_pham_id,\r\n" + "    danhGia.nguoi_dung_id,\r\n" + "    danhGia.id\r\n"
					+ "FROM \r\n" + "    danhGia\r\n" + "JOIN \r\n"
					+ "    nguoiDung ON danhGia.nguoi_dung_id = nguoiDung.id\r\n" + "JOIN \r\n"
					+ "    sanPham ON danhGia.san_pham_id = sanPham.id\r\n" + "WHERE danhGia.san_pham_id = ?";

			PreparedStatement pstmt = c.prepareStatement(sql);
			pstmt.setInt(1, maSanPham);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				DanhGia p1 = new DanhGia();
				NguoiDung nd = new NguoiDung();
				SanPham sp = new SanPham();

				nd.setHoTen(rs.getString("tenNguoiDung"));
				sp.setTenSanPham(rs.getString("tenSanPham"));

				p1.setId(rs.getInt("id"));
				p1.setNguoiDungId(rs.getInt("nguoi_dung_id"));
				p1.setSanPhamId(rs.getInt("san_pham_id"));
				p1.setDiem(rs.getInt("diem"));
				p1.setBinhLuan(rs.getString("binh_luan"));
				p1.setNgayDanhGia(rs.getTimestamp("ngay_danh_gia"));
				p1.setNguoiDung(nd);
				p1.setSanPham(sp);

				arr.add(p1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return arr;
	}
	public static boolean isExistingReview(int userId, int productId) {
	    boolean isExisted = false;
	    Connection c = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    try {
	        // Kết nối cơ sở dữ liệu
	        c = Database.connect();

	        // Câu truy vấn kiểm tra nếu đánh giá đã tồn tại
	        String sql = "SELECT COUNT(*) FROM DanhGia WHERE nguoi_dung_id = ? AND san_pham_id = ?";
	        pstmt = c.prepareStatement(sql);
	        pstmt.setInt(1, userId);      // Gán giá trị userId
	        pstmt.setInt(2, productId);   // Gán giá trị productId

	        // Thực thi truy vấn và nhận kết quả
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            isExisted = rs.getInt(1) > 0; // Nếu có kết quả trả về > 0, có nghĩa là người dùng đã đánh giá
	        }
	    } catch (SQLException e) {
	        e.printStackTrace(); // In ra lỗi nếu có vấn đề khi kết nối hoặc truy vấn
	    } finally {
	        try {
	            // Đóng kết nối và các đối tượng PreparedStatement, ResultSet để giải phóng tài nguyên
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (c != null) c.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }

	    return isExisted;
	}
	 public static boolean xoaDanhGia(int reviewId) {
	        boolean isDeleted = false;
	        Connection connection = Database.connect();
	        String sql = "DELETE FROM DanhGia WHERE id = ?";

	        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
	            pstmt.setInt(1, reviewId);
	            int rowsAffected = pstmt.executeUpdate();
	            if (rowsAffected > 0) {
	                isDeleted = true;
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return isDeleted;
	    }
	 public static boolean updateDanhGia(DanhGia danhGia) {
		    boolean success = false;
		    String sql = "UPDATE DanhGia SET diem = ?, binh_luan = ?, ngay_danh_gia = ? WHERE nguoi_dung_id = ? AND san_pham_id = ?";
		    
		    try (Connection conn = Database.connect();
		         PreparedStatement pstmt = conn.prepareStatement(sql)) {

		        pstmt.setInt(1, danhGia.getDiem());
		        pstmt.setString(2, danhGia.getBinhLuan());
		        pstmt.setTimestamp(3, danhGia.getNgayDanhGia());
		        pstmt.setInt(4, danhGia.getNguoiDungId());
		        pstmt.setInt(5, danhGia.getSanPhamId());

		        int rowsAffected = pstmt.executeUpdate();
		        success = rowsAffected > 0;

		    } catch (SQLException e) {
		        e.printStackTrace();
		    }

		    return success;
		}
	 public static List<DanhGia> getDanhGia() {
		    List<DanhGia> danhSach = new ArrayList<>();
		    String sql = "SELECT dg.*, nd.hoTen AS ten_nguoi_dung, sp.tenSanPham AS ten_san_pham,sp.anh\r\n"
		    		+ "FROM danhGia dg\r\n"
		    		+ "JOIN nguoiDung nd ON dg.nguoi_dung_id = nd.id\r\n"
		    		+ "JOIN sanPham sp ON dg.san_pham_id = sp.id;\r\n"
		    		+ "";

		    try (Connection conn = Database.connect();
		         PreparedStatement pstmt = conn.prepareStatement(sql);
		         ResultSet rs = pstmt.executeQuery()) {

		        while (rs.next()) {
		            DanhGia dg = new DanhGia();
		            dg.setId(rs.getInt("id"));
		            dg.setDiem(rs.getInt("diem"));
		            dg.setBinhLuan(rs.getString("binh_luan"));
		            dg.setNgayDanhGia(rs.getTimestamp("ngay_danh_gia"));
		            dg.setNguoiDungId(rs.getInt("nguoi_dung_id"));
		            dg.setSanPhamId(rs.getInt("san_pham_id"));

		            NguoiDung nd = new NguoiDung();
		            nd.setHoTen(rs.getString("ten_nguoi_dung"));
		            dg.setNguoiDung(nd); // giả sử có setter setNguoiDung()
		            SanPham sp = new SanPham();
		            sp.setTenSanPham(rs.getString("ten_san_pham"));
		            sp.setAnh(rs.getString("anh"));
		            dg.setSanPham(sp); // giả sử có setter setSanPham()

		            danhSach.add(dg);
		        }

		    } catch (SQLException e) {
		        e.printStackTrace();
		    }

		    return danhSach;
		}




}
