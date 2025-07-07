package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import entity.ChiTietDonHang;
import entity.DonHang;
import entity.SanPham;
import entity.TrangThaiDonHang;

public class ChiTietDonHangDao {

	public static boolean insertChiTietDonHang(List<ChiTietDonHang> chiTietList) {
	    String insertSql = "INSERT INTO ChiTietDonHang (don_hang_id, san_pham_id, so_luong, don_gia) VALUES (?, ?, ?, ?)";
	    String updateSql = "UPDATE sanPham SET soLuong = soLuong - ? WHERE id = ?";

	    try (Connection conn = Database.connect();
	         PreparedStatement insertPs = conn.prepareStatement(insertSql);
	         PreparedStatement updatePs = conn.prepareStatement(updateSql)) {

	        // Bắt đầu transaction
	        conn.setAutoCommit(false);

	        for (ChiTietDonHang ct : chiTietList) {
	            // Batch insert chi tiết đơn hàng
	            insertPs.setInt(1, ct.getDonHangId());
	            insertPs.setInt(2, ct.getSanPhamId());
	            insertPs.setInt(3, ct.getSoLuong());
	            insertPs.setDouble(4, ct.getDonGia());
	            insertPs.addBatch();

	            // Batch update tồn kho
	            updatePs.setInt(1, ct.getSoLuong());
	            updatePs.setInt(2, ct.getSanPhamId());
	            updatePs.addBatch();
	        }

	        // Thực thi batch
	        insertPs.executeBatch();
	        updatePs.executeBatch();

	        conn.commit(); // Ghi nhận transaction
	        return true;

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;
	}

    public static ArrayList<DonHang> gettDonHang(int maNguoiDung) {
        ArrayList<DonHang> arr = new ArrayList<>();
        try {
            Connection c = Database.connect();
            String sql = "SELECT dh.ngay_tao AS ngayDat, dh.id AS maDonHang, sp.tenSanPham, sp.anh, "
                       + "ctdh.so_luong, ctdh.don_gia, dh.trang_thai, dh.hinh_thuc, dh.tong_tien, "
                       + "dh.ho_ten, dh.dia_chi, dh.so_dien_thoai, dh.email, dh.ghi_chu "
                       + "FROM DonHang dh "
                       + "JOIN ChiTietDonHang ctdh ON dh.id = ctdh.don_hang_id "
                       + "JOIN sanPham sp ON ctdh.san_pham_id = sp.id "
                       + "WHERE dh.nguoi_dung_id = ?";
            PreparedStatement pstmt = c.prepareStatement(sql);
            pstmt.setInt(1, maNguoiDung);
            ResultSet rs = pstmt.executeQuery();
            Map<Integer, DonHang> donHangMap = new HashMap<>();
            while (rs.next()) {
                int maDonHang = rs.getInt("maDonHang");
                DonHang dh = donHangMap.getOrDefault(maDonHang, new DonHang());
                if (!donHangMap.containsKey(maDonHang)) {
                    dh.setId(maDonHang);
                    dh.setNgayTao(rs.getTimestamp("ngayDat"));
                    dh.setTrangThai(rs.getString("trang_thai"));
                    dh.setHinhThuc(rs.getString("hinh_thuc"));
                    dh.setTongTien(rs.getFloat("tong_tien"));
                    dh.setHoTen(rs.getString("ho_ten"));
                    dh.setDiaChi(rs.getString("dia_chi"));
                    dh.setSoDienThoai(rs.getString("so_dien_thoai"));
                    dh.setEmail(rs.getString("email"));
                    dh.setGhiChu(rs.getString("ghi_chu"));
                    dh.setChiTietDonHangList(new ArrayList<>());
                    donHangMap.put(maDonHang, dh);
                }
                SanPham sp = new SanPham();
                sp.setAnh(rs.getString("anh"));
                sp.setTenSanPham(rs.getString("tenSanPham"));
                ChiTietDonHang ct = new ChiTietDonHang();
                ct.setSanPham(sp);
                ct.setDonGia(rs.getDouble("don_gia"));
                ct.setSoLuong(rs.getInt("so_luong"));
                dh.getChiTietDonHangList().add(ct);
            }
            arr.addAll(donHangMap.values());
            c.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return arr;
    }
    public static boolean xoaDonHang(int idDonHang) {
        Connection c = null;
        try {
            c = Database.connect();
            c.setAutoCommit(false); // Bắt đầu transaction

            // 1. Lấy danh sách sản phẩm và số lượng
            PreparedStatement pstmt0 = c.prepareStatement(
                "SELECT san_pham_id, so_luong FROM ChiTietDonHang WHERE don_hang_id = ?"
            );
            pstmt0.setInt(1, idDonHang);
            ResultSet rs = pstmt0.executeQuery();

            while (rs.next()) {
                int sanPhamId = rs.getInt("san_pham_id");
                int soLuong = rs.getInt("so_luong");

                // 2. Cập nhật tồn kho
                PreparedStatement updateStmt = c.prepareStatement(
                    "UPDATE sanPham SET soLuong = soLuong + ? WHERE id = ?"
                );
                updateStmt.setInt(1, soLuong);
                updateStmt.setInt(2, sanPhamId);
                updateStmt.executeUpdate();
            }

            // 3. Xóa chi tiết đơn hàng
            PreparedStatement pstmt1 = c.prepareStatement(
                "DELETE FROM ChiTietDonHang WHERE don_hang_id = ?"
            );
            pstmt1.setInt(1, idDonHang);
            pstmt1.executeUpdate();

            // 4. Xóa đơn hàng
            PreparedStatement pstmt2 = c.prepareStatement(
                "DELETE FROM DonHang WHERE id = ?"
            );
            pstmt2.setInt(1, idDonHang);
            int rows = pstmt2.executeUpdate();

            c.commit(); // Giao dịch thành công
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (c != null) c.rollback(); // Nếu có lỗi → rollback
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            return false;
        } finally {
            try {
                if (c != null) c.setAutoCommit(true); // Trả về mặc định
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }


}
