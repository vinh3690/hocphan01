package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONException;
import org.json.JSONObject;

import entity.SanPham;

/**
 * Servlet implementation class gioHangController
 */
@WebServlet("/gioHangController")
public class GioHangController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GioHangController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		int id = Integer.parseInt(request.getParameter("id"));
        String tenSanPham = request.getParameter("name");
        float gia = Float.parseFloat(request.getParameter("price"));
        String anh = request.getParameter("anh");
        String soLuong = request.getParameter("quantity");
        int sl=1;
        if(soLuong!=null) {
        	sl = Integer.parseInt(soLuong);
        }
        @SuppressWarnings("unchecked")
        List<SanPham> cart = (List<SanPham>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        // Kiểm tra và cập nhật giỏ hàng
        boolean found = false;
        for (SanPham p : cart) {
            if (p.getId() == id) {
                p.setSoLuong(p.getSoLuong() + sl);
                found = true;
                break;
            }
        }

        if (!found) {
            SanPham p = new SanPham();
            p.setId(id);
            p.setTenSanPham(tenSanPham);
            p.setGia(gia);
            p.setSoLuong(sl);
            p.setAnh(anh);
            cart.add(p);
        }

        session.setAttribute("cart", cart);

        // Tính tổng số lượng sản phẩm trong giỏ hàng
        int totalQuantity = 0;
        for (SanPham p : cart) {
            totalQuantity += p.getSoLuong();
        }
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONObject json = new JSONObject();
        try {
			json.put("cartCount", totalQuantity);
			
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        response.getWriter().write(json.toString());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}
