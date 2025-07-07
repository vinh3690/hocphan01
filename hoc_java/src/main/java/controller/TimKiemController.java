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
 * Servlet implementation class timKiemController
 */
@WebServlet("/timKiemController")
public class TimKiemController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TimKiemController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String txt = request.getParameter("query");
		ArrayList<SanPham> arr = SanPhamDao.searchSanPham(txt);
		ArrayList<DanhMuc> arr1 = DanhMucDao.loadDanhMuc();
		request.setAttribute("sp", arr);
		request.setAttribute("dm", arr1);
		request.getRequestDispatcher("timKiem.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
