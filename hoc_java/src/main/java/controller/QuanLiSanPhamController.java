package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.DanhMuc;
import entity.SanPham;
import model.DanhMucDao;
import model.SanPhamDao;

/**
 * Servlet implementation class quanLiSanPhamController
 */
@WebServlet("/quanLiSanPhamController")
public class QuanLiSanPhamController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public QuanLiSanPhamController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String pageParam = request.getParameter("page");
		int index = 1; // trang mặc định là 1
		if (pageParam != null) {
			try {
				index = Integer.parseInt(pageParam);
			} catch (NumberFormatException e) {
				index = 1; // fallback nếu người dùng nhập sai
			}
		}

		int count = SanPhamDao.total();
		int endPage = count / 5;
		if (count % 5 != 0) {
			endPage++;
		}
		HttpSession session = request.getSession();
		String message = (String) session.getAttribute("message");
		String error = (String) session.getAttribute("error");

		if (message != null) {
		    request.setAttribute("message", message);
		    session.removeAttribute("message"); // xóa sau khi dùng
		}

		if (error != null) {
		    request.setAttribute("error", error);
		    session.removeAttribute("error");
		}
		ArrayList<SanPham> arr = SanPhamDao.loadSanPham5(index);
		ArrayList<DanhMuc> arrDm = DanhMucDao.loadDanhMuc();
		request.setAttribute("pagedSanPham", arr);
		request.setAttribute("currentPage", index);
		request.setAttribute("totalPages", endPage);
		request.setAttribute("danhMuc", arrDm);
		request.getRequestDispatcher("quanLiSanPham.jsp").forward(request, response);
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
