package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.DanhGia;
import entity.SanPham;
import model.DanhGiaDao;
import model.SanPhamDao;

/**
 * Servlet implementation class chiTietSanPham
 */
@WebServlet("/chiTietSanPham")
public class ChiTietSanPham extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ChiTietSanPham() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int maSanPham = Integer.parseInt(request.getParameter("id"));
		ArrayList<SanPham> arrRanDom = SanPhamDao.selectRanDom();
		ArrayList<SanPham> arrRanDom1 = SanPhamDao.selectRanDom1();
		ArrayList<DanhGia> arr = DanhGiaDao.loadDanhGia(maSanPham);
		request.setAttribute("dh", arr);
		SanPham sp = SanPhamDao.chiTiet(maSanPham);
		request.setAttribute("ct", sp);
		request.setAttribute("rd", arrRanDom);
		request.setAttribute("rd1", arrRanDom1);
		request.getRequestDispatcher("chiTiet1.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
