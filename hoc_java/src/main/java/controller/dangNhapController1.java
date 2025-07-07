package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.NguoiDung;
import model.DangKiDao;

/**
 * Servlet implementation class dangNhapController1
 */
@WebServlet("/dangNhap")
public class dangNhapController1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public dangNhapController1() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false); // lấy session hiện tại, không tạo mới
        if (session != null) {
            session.invalidate(); // hủy toàn bộ session
        }
        response.sendRedirect("login.jsp"); // chuyển hướng về trang đăng nhập
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String tdn = request.getParameter("username");
		String mk = request.getParameter("password");
		NguoiDung acc = new NguoiDung(tdn,mk,"","","","");
		acc = DangKiDao.dangNhap(acc);
		if(acc!=null) {
			HttpSession session = request.getSession();
			session.setAttribute("user", acc);
			response.sendRedirect("sanPhamController");
		}
		else {
			request.setAttribute("error","sai tên đăng nhập hoặc mật khẩu");
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}

}
