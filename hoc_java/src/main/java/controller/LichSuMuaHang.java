package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.DonHang;
import entity.NguoiDung;
import model.ChiTietDonHangDao;

/**
 * Servlet implementation class LichSuMuaHang
 */
@WebServlet("/LichSuMuaHang")
public class LichSuMuaHang extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LichSuMuaHang() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		NguoiDung user = (NguoiDung) session.getAttribute("user");
		if(user ==null) {
			response.sendRedirect("login.jsp");
			return;
		}
		int id = user.getId();
		ArrayList<DonHang> dh = ChiTietDonHangDao.gettDonHang(id);
		request.setAttribute("ct", dh);
		request.getRequestDispatcher("DonHang.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
