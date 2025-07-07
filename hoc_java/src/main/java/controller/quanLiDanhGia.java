package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import entity.DanhGia;
import model.DanhGiaDao;

/**
 * Servlet implementation class quanLiDanhGia
 */
@WebServlet("/quanLiDanhGia")
public class quanLiDanhGia extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public quanLiDanhGia() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ArrayList<DanhGia> arr = (ArrayList<DanhGia>) DanhGiaDao.getDanhGia();
		request.setAttribute("dg", arr);
		request.getRequestDispatcher("QuanLiDanhGia.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String action = request.getParameter("action");
            int reviewId = Integer.parseInt(request.getParameter("reviewId"));

            if ("edit".equals(action)) {
                // Lấy dữ liệu từ form
                int rating = Integer.parseInt(request.getParameter("rating"));
                String comment = request.getParameter("comment");
                // Tạo đối tượng DanhGia để cập nhật
                DanhGia updatedReview = new DanhGia();
                updatedReview.setId(reviewId);
                updatedReview.setDiem(rating);
                updatedReview.setBinhLuan(comment);
                updatedReview.setNgayDanhGia(new Timestamp(System.currentTimeMillis()));

                // Gọi phương thức cập nhật trong DAO
                boolean isUpdated = DanhGiaDao.updateDanhGia(updatedReview);

                // Trả về JSON phản hồi
                JSONObject jsonResponse = new JSONObject();
                if (isUpdated) {
                    jsonResponse.put("success", true);
                    jsonResponse.put("message", "Đánh giá đã được cập nhật!");
                } else {
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Không thể cập nhật đánh giá");
                }
                out.print(jsonResponse.toString());
            } else {
                // Xử lý xóa đánh giá
                boolean isDeleted = DanhGiaDao.xoaDanhGia(reviewId);

                JSONObject jsonResponse = new JSONObject();
                if (isDeleted) {
                    jsonResponse.put("success", true);
                    jsonResponse.put("message", "Đánh giá đã được xóa!");
                } else {
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Không thể xóa đánh giá");
                }
                out.print(jsonResponse.toString());
            }
        } catch (Exception e) {
            JSONObject jsonResponse = new JSONObject();
            try {
            	jsonResponse.put("success", false);
                jsonResponse.put("message", "Lỗi server: " + e.getMessage());
			} catch (JSONException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
            out.print(jsonResponse.toString());
        } finally {
            out.close();
        }
    }
	

}
