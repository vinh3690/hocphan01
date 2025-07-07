package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import model.ChiTietDonHangDao;

/**
 * Servlet implementation class XoaDonHang
 */
@WebServlet("/XoaDonHang")
public class XoaDonHang extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public XoaDonHang() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JSONObject json = new JSONObject();
        boolean success = false;

        try {
            int maDonHang = Integer.parseInt(request.getParameter("id"));
            success = ChiTietDonHangDao.xoaDonHang(maDonHang);
            System.out.println("Xóa đơn hàng #" + maDonHang + ": " + success);
            json.put("success", success);
            response.setStatus(HttpServletResponse.SC_OK); // 200
        } catch (Exception e) {
            e.printStackTrace();
            try {
            	  json.put("success", false);
                  json.put("error", e.getMessage());
			} catch (JSONException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500
        }

        PrintWriter out = response.getWriter();
        out.print(json.toString());
        System.out.println("JSON response: " + json.toString());
        out.flush();
    }
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
