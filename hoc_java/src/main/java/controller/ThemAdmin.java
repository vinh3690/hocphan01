package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.NguoiDung;
import model.DangKiDao;

/**
 * Servlet implementation class ThemAdmin
 */
@WebServlet("/ThemAdmin")
public class ThemAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ThemAdmin() {
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
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String ten = request.getParameter("ho_ten");
		String tenDangNhap = request.getParameter("ten_dang_nhap");
		String matKhau = request.getParameter("mat_khau");
		String email = request.getParameter("email");
		String sdt = request.getParameter("so_dien_thoai");
		int phanQuyen = 1;
		NguoiDung nd = new NguoiDung(tenDangNhap, matKhau, ten, email, sdt, phanQuyen);
		boolean check = DangKiDao.dangKi(nd);
		if (check) {
			response.sendRedirect("PhanTrangNguoiDung");
		} else {
			response.sendRedirect("PhanTrangNguoiDung");
		}

	}

}
