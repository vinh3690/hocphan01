package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import entity.DonHang;
import entity.NguoiDung;

public class DonHangDao {
	public static int insertDonHang(DonHang donHang) throws SQLException {
	    String sql = "INSERT INTO DonHang (nguoi_dung_id, ngay_tao, tong_tien, trang_thai, ho_ten, dia_chi, so_dien_thoai, email, ghi_chu, hinh_thuc) "
	               + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	    try (Connection c = Database.connect();
	         PreparedStatement stmt = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

	        stmt.setInt(1, donHang.getNguoiDungId());
	        donHang.setNgayTao(new java.sql.Timestamp(System.currentTimeMillis()));
	        stmt.setTimestamp(2, donHang.getNgayTao());
	        stmt.setFloat(3, donHang.getTongTien());
	        stmt.setString(4, "Đang xử lí");
	        stmt.setString(5, donHang.getHoTen());
	        stmt.setString(6, donHang.getDiaChi());
	        stmt.setString(7, donHang.getSoDienThoai());
	        stmt.setString(8, donHang.getEmail());
	        stmt.setString(9, donHang.getGhiChu());
	        stmt.setString(10, "COD");

	        int rowsAffected = stmt.executeUpdate();

	        if (rowsAffected > 0) {
	            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
	                if (generatedKeys.next()) {
	                    return generatedKeys.getInt(1); // ✅ Trả về ma_don_hang vừa chèn
	                }
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return -1; // ❌ Lỗi hoặc không chèn được
	}

	public static int insertVnpay(DonHang donHang) throws SQLException {
	    String sql = "INSERT INTO DonHang (nguoi_dung_id, ngay_tao, tong_tien, trang_thai, ho_ten, dia_chi, so_dien_thoai, email, ghi_chu, hinh_thuc) "
	               + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	    try (Connection c = Database.connect();
	         PreparedStatement stmt = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

	        // Gán giá trị cho các trường
	        stmt.setInt(1, donHang.getNguoiDungId());
	        donHang.setNgayTao(new java.sql.Timestamp(System.currentTimeMillis()));
	        stmt.setTimestamp(2, donHang.getNgayTao());
	        stmt.setFloat(3, donHang.getTongTien());
	        stmt.setString(4, donHang.getTrangThai());
	        stmt.setString(5, donHang.getHoTen());
	        stmt.setString(6, donHang.getDiaChi());
	        stmt.setString(7, donHang.getSoDienThoai());
	        stmt.setString(8, donHang.getEmail());
	        stmt.setString(9, donHang.getGhiChu());
	        stmt.setString(10, donHang.getHinhThuc());
	        stmt.executeUpdate();

	        // Lấy ID sinh ra từ cột AUTO_INCREMENT
	        try (ResultSet rs = stmt.getGeneratedKeys()) {
	            if (rs.next()) {
	                int generatedId = rs.getInt(1);
	                return generatedId;  // Trả về ID đơn hàng
	            }
	        }

	        return -1; // Không lấy được ID
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return -1;
	    }
	}
	public static boolean updateTrangThaiThanhToanThanhCong(int donHangId) throws SQLException {
	    String sql = "UPDATE DonHang SET trang_thai = ? WHERE id = ?";

	    try (Connection c = Database.connect();
	         PreparedStatement stmt = c.prepareStatement(sql)) {

	        stmt.setString(1, "Đã thanh toán");  // Cập nhật trạng thái
	        stmt.setInt(2, donHangId);          // Theo ID đơn hàng

	        int rowsAffected = stmt.executeUpdate();
	        return rowsAffected > 0;  // true nếu có bản ghi được cập nhật

	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	public static ArrayList<DonHang> getDonHang() {
	    ArrayList<DonHang> list = new ArrayList<>();

	    String sql = "SELECT \r\n"
	    		+ "    dh.id,\r\n"
	    		+ "    dh.nguoi_dung_id,\r\n"
	    		+ "    nd.hoTen,\r\n"
	    		+ "    dh.tong_tien,\r\n"
	    		+ "    dh.trang_thai,\r\n"
	    		+ "    dh.ho_ten AS ten_khach_hang,\r\n"
	    		+ "    dh.dia_chi,\r\n"
	    		+ "    dh.so_dien_thoai,\r\n"
	    		+ "    dh.ghi_chu,\r\n"
	    		+ "    dh.hinh_thuc,\r\n"
	    		+ "	dh.ngay_tao,\r\n"
	    		+ "	dh.email\r\n"
	    		+ "FROM DonHang dh\r\n"
	    		+ "LEFT JOIN nguoiDung nd ON dh.nguoi_dung_id = nd.id;";

	    try (Connection c = Database.connect();
	         PreparedStatement stmt = c.prepareStatement(sql);
	         ResultSet rs = stmt.executeQuery()) {

	        while (rs.next()) {
	            // Tạo đối tượng NguoiDung
	            NguoiDung nd = new NguoiDung();
	            nd.setHoTen(rs.getString("hoTen"));
	            // Tạo đối tượng donHang
	            DonHang dh = new DonHang();
	            dh.setId(rs.getInt("id"));
	            dh.setNguoiDungId(rs.getInt("nguoi_dung_id"));
	            dh.setNgayTao(rs.getTimestamp("ngay_tao"));
	            dh.setTongTien(rs.getFloat("tong_tien"));
	            dh.setTrangThai(rs.getString("trang_thai"));
	            dh.setHoTen(rs.getString("ten_khach_hang"));
	            dh.setDiaChi(rs.getString("dia_chi"));
	            dh.setSoDienThoai(rs.getString("so_dien_thoai"));
	            dh.setEmail(rs.getString("email"));
	            dh.setGhiChu(rs.getString("ghi_chu"));
	            dh.setHinhThuc(rs.getString("hinh_thuc"));
	            // Gắn người dùng vào đơn hàng
	            dh.setNguoiDung(nd);
	            // Thêm vào danh sách
	            list.add(dh);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}
	public static boolean updateDonHang(DonHang donHang) {
	    String sql = "UPDATE DonHang SET "
	               + "nguoi_dung_id = ?, "
	               + "ngay_tao = ?, "
	               + "tong_tien = ?, "
	               + "trang_thai = ?, "
	               + "ho_ten = ?, "
	               + "dia_chi = ?, "
	               + "so_dien_thoai = ?, "
	               + "email = ?, "
	               + "ghi_chu = ?, "
	               + "hinh_thuc = ? "
	               + "WHERE id = ?";

	    try (Connection c = Database.connect();
	         PreparedStatement stmt = c.prepareStatement(sql)) {

	        stmt.setInt(1, donHang.getNguoiDungId());
	        stmt.setTimestamp(2, donHang.getNgayTao());
	        stmt.setFloat(3, donHang.getTongTien());
	        stmt.setString(4, donHang.getTrangThai());
	        stmt.setString(5, donHang.getHoTen());
	        stmt.setString(6, donHang.getDiaChi());
	        stmt.setString(7, donHang.getSoDienThoai());
	        stmt.setString(8, donHang.getEmail());
	        stmt.setString(9, donHang.getGhiChu());
	        stmt.setString(10, donHang.getHinhThuc());
	        stmt.setInt(11, donHang.getId());  // ID đơn hàng cần update

	        int rowsAffected = stmt.executeUpdate();

	        return rowsAffected > 0;  // true nếu cập nhật thành công

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;  // lỗi hoặc không cập nhật được
	}



}
