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

import entity.SanPham;

/**
 * Servlet implementation class QuanLiGioHang
 */
@WebServlet("/QuanLiGioHang")
public class QuanLiGioHang extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuanLiGioHang() {
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
		HttpSession session = request.getSession();
        String action = request.getParameter("action");
        int productId = Integer.parseInt(request.getParameter("productId"));

        // Get or initialize cart from session
        @SuppressWarnings("unchecked")
        List<SanPham> cart = (List<SanPham>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        if ("updateQuantity".equals(action)) {
            String quantityStr = request.getParameter("quantity");
            try {
                int newQuantity = Integer.parseInt(quantityStr);
                if (newQuantity < 1) {
                    newQuantity = 1; // Enforce minimum quantity
                }

                // Find and update item
                for (SanPham item : cart) {
                	System.out.println(newQuantity);
                    if (item.getId()==productId) {
                        item.setSoLuong(newQuantity);
                        break;
                    }
                }

                // Update session
                session.setAttribute("cart", cart);
                response.setContentType("text/plain");
                response.getWriter().write("Quantity updated successfully");
            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Invalid quantity");
            }
        } else if ("remove".equals(action)) {
            // Remove item from cart
            cart.removeIf(item -> item.getId()==productId);
            
            // Update session
            session.setAttribute("cart", cart);
            response.setContentType("text/plain");
            response.getWriter().write("Item removed successfully");
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid action");
        }
    }
	}


