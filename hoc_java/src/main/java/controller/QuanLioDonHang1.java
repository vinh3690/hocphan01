package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.DonHang;
import entity.NguoiDung;
import model.ChiTietDonHangDao;
import model.DonHangDao;

/**
 * Servlet implementation class QuanLioDonHang1
 */
@WebServlet("/QuanLioDonHang1")
public class QuanLioDonHang1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuanLioDonHang1() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    PrintWriter out = response.getWriter();
	    try {
	        int id = Integer.parseInt(request.getParameter("id"));
	        boolean success = ChiTietDonHangDao.xoaDonHang(id); // Assume this method exists
	        if (success) {
	            out.write("{\"success\": true}");
	        } else {
	            out.write("{\"success\": false, \"message\": \"Không thể xóa đơn hàng\"}");
	        }
	    } catch (NumberFormatException e) {
	        out.write("{\"success\": false, \"message\": \"ID không hợp lệ\"}");
	    } catch (Exception e) {
	        out.write("{\"success\": false, \"message\": \"Lỗi server\"}");
	    } finally {
	        out.close();
	    }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		String ten = request.getParameter("hoTen");
		String trangThai =request.getParameter("trangThai");;
		String diaChi=request.getParameter("diaChi");;
		String sdt = request.getParameter("soDienThoai");;
		String ghiChu=request.getParameter("ghiChu");
		String hinhThuc = request.getParameter("hinhThuc");
		String email =request.getParameter("email");
		int maDonHang = Integer.parseInt(request.getParameter("id"));
		float gia = Float.parseFloat(request.getParameter("tongTien"));
		HttpSession session = request.getSession();
		NguoiDung user = (NguoiDung) session.getAttribute("user");
		int maNguoiDung = user.getId();
		DonHang dh =new DonHang(maDonHang, maNguoiDung, new Timestamp(System.currentTimeMillis()), gia, trangThai, ten, diaChi, sdt, email, ghiChu, hinhThuc);
		boolean check = DonHangDao.updateDonHang(dh);
		if(check) {
			ArrayList<DonHang> arr = DonHangDao.getDonHang();
			request.setAttribute("dh", arr);
			request.setAttribute("activeTab", "donHang");
			request.setAttribute("message", "Sửa thông tin đơn hàng thành công!");
			request.getRequestDispatcher("quanLiDonHang").forward(request, response);
		}
	}

}
