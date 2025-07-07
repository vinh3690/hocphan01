package controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.DanhGia;
import model.DanhGiaDao;

/**
 * Servlet implementation class ChinhSuaDanhGia
 */
@WebServlet("/ChinhSuaDanhGia")
public class ChinhSuaDanhGia extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ChinhSuaDanhGia() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String idParam = request.getParameter("id");
		int reviewId = Integer.parseInt(idParam);
		boolean deleted = DanhGiaDao.xoaDanhGia(reviewId);
		if (deleted) {
			request.setAttribute("activeTab", "danhGia");
			request.setAttribute("message", "Xóa đánh giá thành công!");
			ArrayList<DanhGia> arr = (ArrayList<DanhGia>) DanhGiaDao.getDanhGia();
			request.setAttribute("dg", arr);
			request.getRequestDispatcher("QuanLiDanhGia.jsp").forward(request, response);
		} else {
			request.setAttribute("activeTab", "danhGia");
			request.setAttribute("message", "Có lỗi xảy ra khi xóa đánh giá!");
			request.setAttribute("messageType", "danger"); // để đổi màu sang đỏ
			
			request.getRequestDispatcher("QuanLiDanhGia.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int maDanhGia = Integer.parseInt(request.getParameter("id"));
		int maNguoiDung = Integer.parseInt(request.getParameter("idNguoiDung"));
		int maSanPham = Integer.parseInt(request.getParameter("idSanPham"));
		int diem = Integer.parseInt(request.getParameter("diem"));
		String binhLuan = request.getParameter("binhLuan");
		DanhGia dg = new DanhGia(maDanhGia, maSanPham, maNguoiDung, diem, binhLuan,
				new Timestamp(System.currentTimeMillis()));
		boolean check = DanhGiaDao.updateDanhGia(dg);
		if (check) {
			request.setAttribute("activeTab", "danhGia");
			request.setAttribute("message", "Sửa đánh giá thành công!");
			ArrayList<DanhGia> arr = (ArrayList<DanhGia>) DanhGiaDao.getDanhGia();
			request.setAttribute("dg", arr);
			request.getRequestDispatcher("QuanLiDanhGia.jsp").forward(request, response);
		} else {
			request.setAttribute("activeTab", "danhGia");
			request.setAttribute("message", "Có lỗi xảy ra khi sửa đánh giá!");
			request.setAttribute("messageType", "danger"); // để đổi màu sang đỏ
			request.getRequestDispatcher("QuanLiDanhGia.jsp").forward(request, response);
		}

	}

}
