package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.NguoiDung;
import model.NguoiDungDao;

/**
 * Servlet implementation class SuaThongTinNguoiDung
 */
@WebServlet("/SuaThongTinNguoiDung")
public class SuaThongTinNguoiDung extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SuaThongTinNguoiDung() {
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
		int maNguoiDung = Integer.parseInt(request.getParameter("id"));
		String ten =request.getParameter("hoTen");
		String diaChi = request.getParameter("diaChi");
		String tenDangNhap = request.getParameter("tenDangNhap");
		String matKhau = request.getParameter("matKhau");
		String sdt =request.getParameter("phone");
		String email = request.getParameter("email");
		NguoiDung nd = new NguoiDung(maNguoiDung, tenDangNhap, matKhau, ten, email, sdt, diaChi,0);
		boolean check = NguoiDungDao.updateNguoiDung(nd);
		if(check) {
			HttpSession session = request.getSession();
			session.setAttribute("user", nd);
			request.setAttribute("message", "Sửa thông tin thành công!");
			request.getRequestDispatcher("CapNhatThongTinn.jsp").forward(request, response);
		}
	}

}
