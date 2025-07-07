package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.DanhMuc;
import model.DanhMucDao;
/**
 * Servlet implementation class danhMucController
 */
@WebServlet("/danhMucController")
public class DanhMucController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DanhMucController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<DanhMuc> arr = DanhMucDao.loadDanhMuc();
		request.setAttribute("danhMuc", arr);
		request.getRequestDispatcher("quanLiDanhMuc.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		if(action.equals("them")) {
			String ten = request.getParameter("tenDanhMuc");
			DanhMuc d = new DanhMuc(ten);
			boolean check = DanhMucDao.themDanhMuc(d);
			if(check) {
				request.setAttribute("activeTab", "category");
				request.setAttribute("message", "Thêm danh mục thành công!");
				ArrayList<DanhMuc> arr = DanhMucDao.loadDanhMuc();
				request.setAttribute("danhMuc", arr);
				request.getRequestDispatcher("quanLiDanhMuc.jsp").forward(request, response);
			}
			else {
				 request.setAttribute("error", "Thêm thất bại!");
				    request.getRequestDispatcher("quanLiDanhMuc.jsp").forward(request, response);
			}
		}
		else if(action.equals("xoa")) {
			int id = Integer.parseInt(request.getParameter("id"));
			boolean check = DanhMucDao.xoaDanhMuc(id);
			if(check) {
				ArrayList<DanhMuc> arr = DanhMucDao.loadDanhMuc();
				request.setAttribute("danhMuc", arr);
				request.setAttribute("message", "Xóa sản phẩm thành công!");
				request.getRequestDispatcher("quanLiDanhMuc.jsp").forward(request, response);
			}else {
				request.setAttribute("error", "Xóa thất bại!");
				 request.getRequestDispatcher("quanLiDanhMuc.jsp").forward(request, response);
			}
		}
		else if (action.equals("sua")) {
			int id = Integer.parseInt(request.getParameter("id"));
			String ten = request.getParameter("tenDanhMuc");
			DanhMuc dm = new DanhMuc(id, ten);
			boolean check = DanhMucDao.suaDanhMuc(dm);
			if(check) {
				request.setAttribute("activeTab", "category");
				request.setAttribute("message", "Sửa danh mục thành công!");
				ArrayList<DanhMuc> arr = DanhMucDao.loadDanhMuc();
				request.setAttribute("danhMuc", arr);
				request.getRequestDispatcher("quanLiDanhMuc.jsp").forward(request, response);
			}
		}
	}

}
