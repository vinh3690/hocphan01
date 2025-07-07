package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.DanhMuc;
import entity.SanPham;
import model.DanhMucDao;
import model.SanPhamDao;

/**
 * Servlet implementation class LocController
 */
@WebServlet("/LocController")
public class LocController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LocController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  request.setCharacterEncoding("UTF-8");
		    response.setCharacterEncoding("UTF-8");
		    response.setContentType("text/html;charset=UTF-8");
		String ten = request.getParameter("query");
		float gia1 = Float.parseFloat(request.getParameter("minPrice"));
		float gia2 = Float.parseFloat(request.getParameter("maxPrice"));
		ArrayList<SanPham> arr = SanPhamDao.locGia(ten, gia1, gia2);
		ArrayList<DanhMuc> arr1 = DanhMucDao.loadDanhMuc();
		request.setAttribute("sp", arr);
		request.setAttribute("dm", arr1);
		request.getRequestDispatcher("timKiem.jsp").forward(request, response);
	}

}
