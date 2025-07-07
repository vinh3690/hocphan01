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
 * Servlet implementation class ChinhSuaNguoiDung
 */
@WebServlet("/ChinhSuaNguoiDung")
public class ChinhSuaNguoiDung extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChinhSuaNguoiDung() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int maNguoiDung = Integer.parseInt(request.getParameter("id"));
		Boolean check = NguoiDungDao.xoaNguoiDung(maNguoiDung);
		if(check) {
			request.getSession().setAttribute("message", "Xóa người dùng thành công!");
			request.getRequestDispatcher("PhanTrangNguoiDung").forward(request, response);
		}
		else {
			request.getSession().setAttribute("error", "Xóa người dùng thất bại!");
			request.getRequestDispatcher("PhanTrangNguoiDung").forward(request, response);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
		    request.setCharacterEncoding("UTF-8");
		    response.setCharacterEncoding("UTF-8");
		    response.setContentType("text/html;charset=UTF-8");
		    int maNguoiDung = Integer.parseInt(request.getParameter("id"));
		    String ten = request.getParameter("hoTen");
		    String diaChi = request.getParameter("diaChi");
		    
		    String tenDangNhap = request.getParameter("tenDangNhap");
		    String matKhau = request.getParameter("matKhau");
		    String sdt = request.getParameter("phone");
		    String email = request.getParameter("email");
		    int phanQuyen = Integer.parseInt(request.getParameter("phanQuyen"));
		    NguoiDung nd = new NguoiDung(maNguoiDung, tenDangNhap, matKhau, ten, email, sdt, diaChi, phanQuyen);
		    boolean check = NguoiDungDao.updateNguoiDung(nd);
		    if (check) {
		    	HttpSession session = request.getSession();
		    	session.setAttribute("message", "Sửa thành công");
		    	response.sendRedirect("PhanTrangNguoiDung");

		    } else {
		        request.getSession().setAttribute("error", "Sửa thông tin người dùng thất bại!");
		    }
		    //request.getRequestDispatcher("quanLiSanPhamController").forward(request, response);

		} catch (Exception e) {
		    e.printStackTrace();
		}}

}
