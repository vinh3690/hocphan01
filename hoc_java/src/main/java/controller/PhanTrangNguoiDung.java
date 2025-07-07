package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.NguoiDung;
import model.DangKiDao;
import model.NguoiDungDao;

/**
 * Servlet implementation class PhanTrangNguoiDung
 */
@WebServlet("/PhanTrangNguoiDung")
public class PhanTrangNguoiDung extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PhanTrangNguoiDung() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pageParam = request.getParameter("page");
        int index = 1;
        if (pageParam != null) {
            try {
                index = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                index = 1;
            }
        }
        int recordsPerPage = 3;
        int count = NguoiDungDao.total();
        int endPage = count / recordsPerPage;
        if (count % recordsPerPage != 0) {
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
		
        ArrayList<NguoiDung> arr = NguoiDungDao.loadNguoiDung(index);
        System.out.println("Danh sách người dùng: " + arr.toString());
        request.setAttribute("userList", arr);
        request.setAttribute("currentPage", index);
        request.setAttribute("totalPages", endPage);
        request.setAttribute("contextPath", request.getContextPath());
        request.getRequestDispatcher("quanLiNguoiDung.jsp").forward(request, response);
        
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
