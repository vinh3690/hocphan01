package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import entity.ThongKe;
import entity.ThongKeDonHang;
import entity.ThongKeSanPhamBanChay;
import entity.ThongKeTongQuat;
import entity.TrangThaiDonHang;
public class ThongKeModel {
	public static ArrayList<ThongKe> getDoanhThuTheoThang(String fromDate, String toDate) {
	    ArrayList<ThongKe> arr = new ArrayList<>();
	    try {
	        Connection c = Database.connect();
	        String sql = "SELECT \r\n"
	                + "    MONTH(ngay_tao) AS thang,\r\n"
	                + "    YEAR(ngay_tao) AS nam,\r\n"
	                + "    SUM(tong_tien) AS tong_doanh_thu\r\n"
	                + "FROM \r\n"
	                + "    DonHang\r\n"
	                + "WHERE \r\n"
	                + "    ngay_tao BETWEEN ? AND ?\r\n"
	                + "GROUP BY \r\n"
	                + "    YEAR(ngay_tao), MONTH(ngay_tao)\r\n"
	                + "ORDER BY \r\n"
	                + "    nam, thang;";
	        
	        PreparedStatement pstmt = c.prepareStatement(sql);
	        pstmt.setString(1, fromDate);  // Set the fromDate parameter
	        pstmt.setString(2, toDate);    // Set the toDate parameter

	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {
	            ThongKe tk = new ThongKe(); // Create an object of thongKe
	            tk.setThang(rs.getInt("thang"));    // Map the "thang" from the ResultSet to thongKe object
	            tk.setNam(rs.getInt("nam"));        // Map the "nam" from the ResultSet to thongKe object
	            tk.setDoanhThu(rs.getFloat("tong_doanh_thu"));  // Map the revenue value

	            arr.add(tk);  // Add to the list
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return arr;
	}
	public static ArrayList<ThongKeDonHang> getDonHangTheoThang(String fromDate, String toDate) {
	    ArrayList<ThongKeDonHang> arr = new ArrayList<>();
	    try {
	        Connection c = Database.connect();
	        String sql = "	SELECT \r\n"
	        		+ "    MONTH(dh.ngay_tao) AS thang,\r\n"
	        		+ "    YEAR(dh.ngay_tao) AS nam,\r\n"
	        		+ "    COUNT(dh.id) AS so_luong_don_hang\r\n"
	        		+ "FROM \r\n"
	        		+ "    DonHang dh\r\n"
	        		+ "WHERE \r\n"
	        		+ "    dh.ngay_tao BETWEEN ? AND ? \r\n"
	        		+ "GROUP BY \r\n"
	        		+ "    YEAR(dh.ngay_tao), MONTH(dh.ngay_tao)\r\n"
	        		+ "ORDER BY \r\n"
	        		+ "    nam, thang;\r\n"
	        		+ "";
	        
	        PreparedStatement pstmt = c.prepareStatement(sql);
	        pstmt.setString(1, fromDate);  // Set the fromDate parameter
	        pstmt.setString(2, toDate);    // Set the toDate parameter

	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {
	        	ThongKeDonHang tk = new ThongKeDonHang(); // Create an object of thongKe
	            tk.setThang(rs.getInt("thang"));    // Map the "thang" from the ResultSet to thongKe object
	            tk.setNam(rs.getInt("nam"));        // Map the "nam" from the ResultSet to thongKe object
	            tk.setSoDonHang(rs.getInt("so_luong_don_hang"));  // Map the revenue value

	            arr.add(tk);  // Add to the list
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return arr;
	}
	public static ArrayList<ThongKeSanPhamBanChay> getSanPham(String fromDate, String toDate) {
	    ArrayList<ThongKeSanPhamBanChay> arr = new ArrayList<>();
	    try {
	        Connection c = Database.connect();
	        String sql = "SELECT TOP 8 \r\n"
	        		+ "    sp.id, \r\n"
	        		+ "    sp.tenSanPham, \r\n"
	        		+ "    SUM(ct.so_luong) AS tong_ban\r\n"
	        		+ "FROM \r\n"
	        		+ "    sanPham sp\r\n"
	        		+ "INNER JOIN \r\n"
	        		+ "    ChiTietDonHang ct ON sp.id = ct.san_pham_id\r\n"
	        		+ "INNER JOIN \r\n"
	        		+ "    DonHang dh ON ct.don_hang_id = dh.id\r\n"
	        		+ "WHERE \r\n"
	        		+" dh.ngay_tao BETWEEN ? AND ? \r\n"
	        		+ "GROUP BY \r\n"
	        		+ "    sp.id, sp.tenSanPham\r\n"
	        		+ "ORDER BY \r\n"
	        		+ "    tong_ban DESC;";
	        
	        PreparedStatement pstmt = c.prepareStatement(sql);
	        pstmt.setString(1, fromDate);  // Set the fromDate parameter
	        pstmt.setString(2, toDate);    // Set the toDate parameter

	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {
	        	ThongKeSanPhamBanChay tk = new ThongKeSanPhamBanChay(); 
	            tk.setTenSanPham(rs.getString("tenSanPham"));    
	            tk.setTong(rs.getInt("tong_ban"));       
	            arr.add(tk);  
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return arr;
	    
	}
	
	
	public static ArrayList<TrangThaiDonHang> getTrangThai(String fromDate, String toDate) {
	    ArrayList<TrangThaiDonHang> arr = new ArrayList<>();
	    try {
	        Connection c = Database.connect();
	        String sql = "SELECT \r\n"
	        	    + "    dh.trang_thai,\r\n"
	        	    + "    COUNT(DISTINCT dh.id) AS so_don_hang,\r\n"
	        	    + "    SUM(ct.so_luong) AS tong_san_pham\r\n"
	        	    + "FROM \r\n"
	        	    + "    ChiTietDonHang ct\r\n"
	        	    + "JOIN \r\n"
	        	    + "    DonHang dh ON ct.don_hang_id = dh.id\r\n"
	        	    + "WHERE \r\n"
	        	    + "    dh.trang_thai IN (N'Đã thanh toán', N'Đang xử lí')\r\n"
	        	    + "    AND dh.ngay_tao BETWEEN ? AND ? \r\n"   // <== thêm dấu cách ở đây
	        	    + "GROUP BY \r\n"
	        	    + "    dh.trang_thai;\r\n";

	        
	        PreparedStatement pstmt = c.prepareStatement(sql);
	        pstmt.setString(1, fromDate);  // Set the fromDate parameter
	        pstmt.setString(2, toDate);    // Set the toDate parameter

	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {
	        	TrangThaiDonHang tk = new TrangThaiDonHang(); 
	            tk.setTrangThai(rs.getString("trang_thai"));    
	            tk.setDonHang(rs.getInt("so_don_hang"));     
	            tk.setSoLuong(rs.getInt("tong_san_pham"));
	            arr.add(tk);  
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return arr;
	}
	public static ArrayList<ThongKeTongQuat> getThongKe() {
	    ArrayList<ThongKeTongQuat> dsThongKe = new ArrayList<>();

	    try {
	        Connection conn = Database.connect();
	        String sql = "SELECT " +
	                     "COUNT(DISTINCT dh.id) AS tongDonHang, " +
	                     "SUM(ctdh.so_luong) AS tongSanPhamDaBan, " +
	                     "SUM(ctdh.so_luong * ctdh.don_gia) AS tongDoanhThu " +
	                     "FROM DonHang dh " +
	                     "JOIN ChiTietDonHang ctdh ON dh.id = ctdh.don_hang_id";

	        PreparedStatement pstmt = conn.prepareStatement(sql);
	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {
	            int tongDonHang = rs.getInt("tongDonHang");
	            int tongSanPhamDaBan = rs.getInt("tongSanPhamDaBan");
	            double tongDoanhThu = rs.getDouble("tongDoanhThu");
	            ThongKeTongQuat thongKe = new ThongKeTongQuat(tongDonHang, tongSanPhamDaBan, tongDoanhThu);
	            dsThongKe.add(thongKe);
	        }

	        rs.close();
	        pstmt.close();
	        conn.close();

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return dsThongKe;
	}

}
