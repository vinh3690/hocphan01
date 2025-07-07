package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.ChiTietDonHang;
import entity.DonHang;
import entity.SanPham;
import model.ChiTietDonHangDao;
import model.DonHangDao;

/**
 * Servlet implementation class thanhToanController1
 */
@WebServlet("/thanhToanController1")
public class ThanhToanController1 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ThanhToanController1() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		int nguoiDungId = Integer.parseInt(request.getParameter("nguoiDungId"));
		String hoTen = request.getParameter("hoTen");
		String email = request.getParameter("email");
		String diaChi = request.getParameter("diaChi");
		String soDienThoai = request.getParameter("soDienThoai");
		String ghiChu = request.getParameter("ghiChu");
		String tongTienStr = request.getParameter("totalAmount");
		float tongTien = 0f;
		if (tongTienStr != null && !tongTienStr.trim().isEmpty()) {
			tongTien = Float.parseFloat(tongTienStr.trim());
		} else {
			tongTien = 0f; // Hoặc xử lý lỗi
		}
		request.setAttribute("totalAmount", tongTien); // Đặt giá trị vào request để JSP nhận được

		DonHang donHang = new DonHang();
		donHang.setNguoiDungId(nguoiDungId);
		donHang.setHoTen(hoTen);
		donHang.setEmail(email);
		donHang.setNgayTao(new Timestamp(System.currentTimeMillis()));
		donHang.setDiaChi(diaChi);
		donHang.setSoDienThoai(soDienThoai);
		donHang.setGhiChu(ghiChu);
		donHang.setTongTien(tongTien);
		try {
			int maDonHang = DonHangDao.insertDonHang(donHang);
			if (maDonHang > 0) {
				HttpSession session = request.getSession();
				List<SanPham> cart = (List<SanPham>) session.getAttribute("cart");
				List<ChiTietDonHang> dsChiTiet = new ArrayList<>();
				for (SanPham sp : cart) {
					ChiTietDonHang ct = new ChiTietDonHang(maDonHang, sp.getId(), sp.getSoLuong(), sp.getGia());
					dsChiTiet.add(ct);
				}
				boolean check = ChiTietDonHangDao.insertChiTietDonHang(dsChiTiet);
				if(check) {
					request.setAttribute("activeTab", "message");
					request.setAttribute("message", "Thanh toán thành công!");
					request.getRequestDispatcher("thanhToan.jsp").forward(request, response);
				}
			}
			

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
