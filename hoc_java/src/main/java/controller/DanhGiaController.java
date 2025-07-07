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

import entity.DanhGia;
import entity.SanPham;
import model.DanhGiaDao;
import model.SanPhamDao;

/**
 * Servlet implementation class DanhGiaController
 */
@WebServlet("/DanhGiaController")
public class DanhGiaController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DanhGiaController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		try {
			// Lấy dữ liệu từ form
			int maNguoiDung = Integer.parseInt(request.getParameter("userId"));
			int maSanPham = Integer.parseInt(request.getParameter("productId"));
			int diem = Integer.parseInt(request.getParameter("rating"));
			String binhLuan = request.getParameter("comment");
			String action = request.getParameter("action");
			// Xử lý yêu cầu non-AJAX
			if(action.equals("edit")) {
				DanhGia dh = new DanhGia(maNguoiDung, maSanPham, diem, binhLuan,
						new Timestamp(System.currentTimeMillis()));
				if(DanhGiaDao.updateDanhGia(dh)) {
					request.setAttribute("tt", "Đánh giá của bạn đã được cập nhật!");
					request.setAttribute("status", "success");
				}else {
					request.setAttribute("tt", "Cập nhật đánh giá thất bại");
					request.setAttribute("status", "error");
				}
			}
			else if (DanhGiaDao.isExistingReview(maNguoiDung, maSanPham)) {
				request.setAttribute("tt", "Bạn đã đánh giá sản phẩm rồi");
				request.setAttribute("status", "error"); // Thiết lập trạng thái lỗi
			} else {
				DanhGia dh = new DanhGia(maNguoiDung, maSanPham, diem, binhLuan,
						new Timestamp(System.currentTimeMillis()));
				boolean check = DanhGiaDao.danhGia(dh);
				if (check) {
					request.setAttribute("tt", "Đánh giá của bạn đã được gửi!");
					request.setAttribute("status", "success"); // Thiết lập trạng thái thành công
				} else {
					request.setAttribute("tt", "Thêm đánh giá thất bại");
					request.setAttribute("status", "error");
				}
			}

			// Tải dữ liệu để hiển thị lại trang
			ArrayList<SanPham> arrRanDom = SanPhamDao.selectRanDom();
			ArrayList<SanPham> arrRanDom1 = SanPhamDao.selectRanDom1();
			ArrayList<DanhGia> arr = DanhGiaDao.loadDanhGia(maSanPham);
			request.setAttribute("dh", arr);
			SanPham sp = SanPhamDao.chiTiet(maSanPham);
			request.setAttribute("ct", sp);
			request.setAttribute("rd", arrRanDom);
			request.setAttribute("rd1", arrRanDom1);

			// Forward tới JSP
			request.getRequestDispatcher("chiTiet1.jsp").forward(request, response);

		} catch (Exception e) {
			out.print("{\"success\": false, \"message\": \"Lỗi server: " + e.getMessage() + "\"}");
			out.close();
		}

	}

}
