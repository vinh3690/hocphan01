package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.NguoiDung;

/**
 * Servlet implementation class ThanhToanController
 */
@WebServlet("/ThanhToanController")
public class ThanhToanController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ThanhToanController() {
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
		 HttpSession session = request.getSession(false);
	     NguoiDung user = (NguoiDung) session.getAttribute("user");

	        if (user == null) {
	            response.sendRedirect("login.jsp?error=login_required");
	            return;
	        }
		String totalAmount = request.getParameter("totalAmount");
		request.setAttribute("totalAmount", totalAmount);
		request.getRequestDispatcher("/thanhToan.jsp").forward(request, response);
	}

}
