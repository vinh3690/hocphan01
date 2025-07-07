package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entity.SanPham;

public class SanPhamDao {
	public static boolean themSanPham(SanPham a) {
		try {
			String sql = "INSERT INTO sanPham (tenSanPham,gia,moTa,anh,danhMuc_id,soLuong) VALUES (?,?,?,?,?,?)";
			Connection c = Database.connect();
			PreparedStatement pstm = c.prepareStatement(sql);
			pstm.setString(1, a.getTenSanPham());
			pstm.setFloat(2, a.getGia());
			pstm.setString(3, a.getMoTa());
			pstm.setString(4, a.getAnh());
			pstm.setInt(5, a.getDanhMucId());
			pstm.setInt(6, a.getSoLuong());
			pstm.executeUpdate();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	public static int total() {
	    try {
	        String sql = "SELECT COUNT(*) FROM sanPham";
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
	public static ArrayList<SanPham> loadSanPham5(int index) {
	    ArrayList<SanPham> list = new ArrayList<>();
	    String sql = "SELECT sp.*, dm.tenDanhMuc\r\n"
	    		+ "FROM sanPham sp\r\n"
	    		+ "JOIN danhMuc dm ON sp.danhMuc_id = dm.id\r\n"
	    		+ "ORDER BY sp.id\r\n"
	    		+ "OFFSET ? ROWS\r\n"
	    		+ "FETCH NEXT 5 ROWS ONLY;\r\n"
	    		+ ";\r\n";
	    try (Connection conn = Database.connect(); 
	    	PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setInt(1, (index-1)*5);
	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            SanPham sp = new SanPham();
	            sp.setId(rs.getInt("id"));
	            sp.setTenSanPham(rs.getString("tenSanPham"));
	            sp.setGia(rs.getFloat("gia"));
	            sp.setMoTa(rs.getString("moTa"));
	            sp.setAnh(rs.getString("anh"));
	            sp.setDanhMucId(rs.getInt("danhMuc_id"));
	            sp.setSoLuong(rs.getInt("soLuong"));
	            sp.setTenDanhMuc(rs.getString("tenDanhMuc"));
	            list.add(sp);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	public static ArrayList<SanPham> loadSanPham() {
		ArrayList<SanPham> arr = new ArrayList<SanPham>();
		try {
			Connection c = Database.connect();
			String sql = "SELECT sp.*, dm.tenDanhMuc\r\n"
					+ "FROM sanPham sp\r\n"
					+ "JOIN danhMuc dm ON sp.danhMuc_id = dm.id\r\n"
					+ "ORDER BY sp.id DESC;\r\n"
					+ "";
			PreparedStatement pstmt = c.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				SanPham p1 = new SanPham();
				p1.setId(rs.getInt("id"));
				p1.setTenSanPham(rs.getString("tenSanPham")); // ✅ sửa ở đây
				p1.setAnh(rs.getString("anh")); // ✅ sửa ở đây
				p1.setMoTa(rs.getString("moTa")); // ✅ sửa ở đây
				p1.setGia(rs.getFloat("gia"));
				p1.setSoLuong(rs.getInt("soLuong"));
				p1.setDanhMucId(rs.getInt("danhMuc_id"));
				p1.setTenDanhMuc(rs.getString("tenDanhMuc"));
				arr.add(p1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return arr;
	}
	public static ArrayList<SanPham> searchSanPham(String txt) {
	    ArrayList<SanPham> arr = new ArrayList<>();
	    try {
	        Connection c = Database.connect();
	        String sql = "SELECT * FROM sanPham WHERE tenSanPham COLLATE Vietnamese_CI_AI LIKE ?";
	        PreparedStatement pstmt = c.prepareStatement(sql);
	        pstmt.setString(1, "%" + txt + "%"); 
	        ResultSet rs = pstmt.executeQuery();
	        while (rs.next()) {
	            SanPham p1 = new SanPham();
	            p1.setId(rs.getInt("id"));
	            p1.setTenSanPham(rs.getString("tenSanPham"));
	            p1.setAnh(rs.getString("anh"));
	            p1.setMoTa(rs.getString("moTa"));
	            p1.setGia(rs.getFloat("gia"));
	            p1.setSoLuong(rs.getInt("soLuong"));
	            p1.setDanhMucId(rs.getInt("danhMuc_id"));
	            arr.add(p1);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return arr;
	}

	public static ArrayList<SanPham> selectSanPhamBanChay() {
	    ArrayList<SanPham> arr = new ArrayList<SanPham>();
	    try {
	        Connection c = Database.connect();
	        String sql = "SELECT sp.*, SUM(ctdh.so_luong) AS tong_ban " +
	                     "FROM SanPham sp " +
	                     "JOIN ChiTietDonHang ctdh ON sp.id = ctdh.san_pham_id " +
	                     "GROUP BY sp.id, sp.tenSanPham, sp.gia, sp.moTa, sp.anh, sp.danhMuc_id, sp.soLuong " +
	                     "ORDER BY tong_ban DESC;";
	        PreparedStatement pstmt = c.prepareStatement(sql);
	        ResultSet rs = pstmt.executeQuery();
	        while (rs.next()) {
	            SanPham p1 = new SanPham();
	            p1.setId(rs.getInt("id"));
	            p1.setTenSanPham(rs.getString("tenSanPham"));
	            p1.setAnh(rs.getString("anh"));
	            p1.setMoTa(rs.getString("moTa"));
	            p1.setGia(rs.getFloat("gia"));
	            p1.setSoLuong(rs.getInt("soLuong"));
	            p1.setDanhMucId(rs.getInt("danhMuc_id"));
	            
	            arr.add(p1);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return arr;
	}

	public static ArrayList<SanPham> selectRanDom() {
		ArrayList<SanPham> arr = new ArrayList<SanPham>();
		try {
			Connection c = Database.connect();
			String sql = "SELECT TOP 5 * FROM SanPham ORDER BY NEWID();\r\n"
					+ "";
			PreparedStatement pstmt = c.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				SanPham p1 = new SanPham();
				p1.setId(rs.getInt("id"));
				p1.setTenSanPham(rs.getString("tenSanPham")); // ✅ sửa ở đây
				p1.setAnh(rs.getString("anh")); // ✅ sửa ở đây
				p1.setMoTa(rs.getString("moTa")); // ✅ sửa ở đây
				p1.setGia(rs.getFloat("gia"));
				p1.setSoLuong(rs.getInt("soLuong"));
				p1.setDanhMucId(rs.getInt("danhMuc_id"));
				arr.add(p1);
			}
			System.out.println(arr);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return arr;
	}
	public static ArrayList<SanPham> selectRanDom1() {
		ArrayList<SanPham> arr = new ArrayList<SanPham>();
		try {
			Connection c = Database.connect();
			String sql = "SELECT TOP 8* FROM SanPham ORDER BY NEWID();\r\n"
					+ "";
			PreparedStatement pstmt = c.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				SanPham p1 = new SanPham();
				p1.setId(rs.getInt("id"));
				p1.setTenSanPham(rs.getString("tenSanPham")); // ✅ sửa ở đây
				p1.setAnh(rs.getString("anh")); // ✅ sửa ở đây
				p1.setMoTa(rs.getString("moTa")); // ✅ sửa ở đây
				p1.setGia(rs.getFloat("gia"));
				p1.setSoLuong(rs.getInt("soLuong"));
				p1.setDanhMucId(rs.getInt("danhMuc_id"));
				arr.add(p1);
			}
			System.out.println(arr);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return arr;
	}
	public static SanPham chiTiet(int id) {
	    SanPham p1 = null;
	    try {
	        Connection c = Database.connect();
	        String sql = "SELECT * FROM SanPham WHERE id = ?";
	        PreparedStatement pstmt = c.prepareStatement(sql);
	        pstmt.setInt(1, id);
	        ResultSet rs = pstmt.executeQuery();

	        if (rs.next()) {
	            p1 = new SanPham();
	            p1.setId(rs.getInt("id"));
	            p1.setTenSanPham(rs.getString("tenSanPham"));
	            p1.setAnh(rs.getString("anh"));
	            p1.setMoTa(rs.getString("moTa"));
	            p1.setGia(rs.getFloat("gia"));
	            p1.setSoLuong(rs.getInt("soLuong"));
	            p1.setDanhMucId(rs.getInt("danhMuc_id"));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return p1;
	}
	public static ArrayList<SanPham> danMucSanPham(int id) {
		ArrayList<SanPham> arr = new ArrayList<SanPham>();
	    try {
	        Connection c = Database.connect();
	        String sql = "SELECT * FROM SanPham WHERE danhMuc_id = ?";
	        PreparedStatement pstmt = c.prepareStatement(sql);
	        pstmt.setInt(1, id);
	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {
	        	SanPham p1 = new SanPham();
				p1.setId(rs.getInt("id"));
				p1.setTenSanPham(rs.getString("tenSanPham")); // ✅ sửa ở đây
				p1.setAnh(rs.getString("anh")); // ✅ sửa ở đây
				p1.setMoTa(rs.getString("moTa")); // ✅ sửa ở đây
				p1.setGia(rs.getFloat("gia"));
				p1.setSoLuong(rs.getInt("soLuong"));
				p1.setDanhMucId(rs.getInt("danhMuc_id"));
				arr.add(p1);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return arr;
	}
	public static ArrayList<SanPham> locGia(String ten, float gia1, float gia2) {
	    ArrayList<SanPham> arr = new ArrayList<>();
	    try {
	        Connection c = Database.connect();
	        String sql = "SELECT * FROM SanPham " +
	                     "WHERE tenSanPham LIKE ? AND gia BETWEEN ? AND ?";
	        PreparedStatement pstmt = c.prepareStatement(sql);

	        pstmt.setString(1, "%" + ten + "%");  // Tìm tên gần đúng
	        pstmt.setFloat(2, gia1);              // Giá từ
	        pstmt.setFloat(3, gia2);              // Đến giá

	        ResultSet rs = pstmt.executeQuery();
	        while (rs.next()) {
	            SanPham p1 = new SanPham();
	            p1.setId(rs.getInt("id"));
	            p1.setTenSanPham(rs.getString("tenSanPham"));
	            p1.setAnh(rs.getString("anh"));
	            p1.setMoTa(rs.getString("moTa"));
	            p1.setGia(rs.getFloat("gia"));
	            p1.setSoLuong(rs.getInt("soLuong"));
	            p1.setDanhMucId(rs.getInt("danhMuc_id"));
	            arr.add(p1);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return arr;
	}


	public static boolean xoaSanPham(int id) {
		try {
			String sql = "delete from sanPham where id=?";
			Connection c = Database.connect();
			PreparedStatement pstm = c.prepareStatement(sql);
			pstm.setInt(1, id);
			int a = pstm.executeUpdate();
			return a > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public static boolean suaSanPham(SanPham p) {
		try {
			String sql = "update sanPham set tenSanPham=?, anh=?, gia=?, moTa=?, danhMuc_id=?, soLuong=? where id=?";
			Connection c = Database.connect();
			PreparedStatement pstm = c.prepareStatement(sql);

			// Set các giá trị vào PreparedStatement
			pstm.setString(1, p.getTenSanPham());
			pstm.setString(2, p.getAnh());
			pstm.setDouble(3, p.getGia());
			pstm.setString(4, p.getMoTa());
			pstm.setInt(5, p.getDanhMucId());
			pstm.setInt(6, p.getSoLuong());
			pstm.setInt(7, p.getId());
			// Execute update
			int a = pstm.executeUpdate();
			return a > 0;

		} catch (SQLException e) {

			e.printStackTrace(); // In ra stack trace để debug tốt hơn
			return false;
		}
	}
}
