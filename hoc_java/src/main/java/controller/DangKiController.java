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
 * Servlet implementation class dangKiController
 */
@WebServlet("/dangKiController")
public class DangKiController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DangKiController() {
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
		String hoTen = request.getParameter("fullname");
		String email =request.getParameter("email");
		String sdt = request.getParameter("phone");
		String tenDangNhap=request.getParameter("username");
		String matKhau= request.getParameter("password");
		String diaChi= request.getParameter("diaChi");
		String confirm = request.getParameter("confirm_password");
		String mess="";
		if(!matKhau.equals(confirm)) {
			mess="Không trùng";
			request.setAttribute("mess", mess);
			request.getRequestDispatcher("dangKi.jsp").forward(request, response);
		}else {
			NguoiDung dk = new NguoiDung(tenDangNhap, matKhau, hoTen, email, sdt,diaChi);
			boolean check = DangKiDao.dangKi(dk);
			if(check) {
				mess="Đăng kí thành công!";
				request.setAttribute("mess", mess);
				request.getRequestDispatcher("dangKi.jsp").forward(request, response);
			}else {
				mess="Thử lại";
				request.setAttribute("mess", mess);
				request.getRequestDispatcher("dangKi.jsp").forward(request, response);
			}
		}
	}

}
