package controller;

import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import entity.DanhMuc;
import entity.SanPham;
import model.DanhMucDao;
import model.SanPhamDao;

/**
 * Servlet implementation class sanPhamController
 */

@WebServlet("/sanPhamController")
@MultipartConfig
public class SanPhamController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SanPhamController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ArrayList<SanPham> arr = SanPhamDao.loadSanPham();
		ArrayList<SanPham> arr1 = SanPhamDao.selectSanPhamBanChay();
		ArrayList<DanhMuc> arr2 = DanhMucDao.loadDanhMuc();
		request.setAttribute("sanPham", arr);
		request.setAttribute("sanPham1", arr1);
		request.setAttribute("danhMuc", arr2);
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		if (action.equals("them")) {
			String ten = request.getParameter("tenSanPham");
			float gia = Float.parseFloat(request.getParameter("gia"));
			String moTa = request.getParameter("moTa");
			Part filePart = request.getPart("anh"); 
			String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
			int soLuong = Integer.parseInt(request.getParameter("soLuong"));
			int danhMucId = Integer.parseInt(request.getParameter("danhMucId"));
			SanPham sp = new SanPham(ten, gia, moTa, fileName, danhMucId, soLuong);
			boolean check = SanPhamDao.themSanPham(sp);
			if (check) {
//				request.setAttribute("activeTab", "product");
//				request.setAttribute("message", "Thêm sản phẩm thành công!");
				request.getSession().setAttribute("message", "Thêm sản phẩm thành công!");
				request.getRequestDispatcher("quanLiSanPhamController").forward(request, response);
			} else {
				request.setAttribute("error", "Thêm thất bại!");
				request.getRequestDispatcher("quanLiSanPhamController").forward(request, response);
			}
		} else if (action.equals("xoa")) {
			int id = Integer.parseInt(request.getParameter("productId"));
			boolean check = SanPhamDao.xoaSanPham(id);
			if (check) {
				//ArrayList<SanPham> arr = SanPhamDao.loadSanPham();
				request.getSession().setAttribute("message", "Xóa sản phẩm thành công!");
				request.getRequestDispatcher("quanLiSanPhamController").forward(request, response);
			} else {
				request.getSession().setAttribute("errot", "Xóa sản phẩm thất bại!");
				request.getRequestDispatcher("quanLiSanPhamController").forward(request, response);
			}

		} else if (action.equals("sua")) {
			int id = Integer.parseInt(request.getParameter("id"));
			String ten = request.getParameter("tenSanPham");
			float gia = Float.parseFloat(request.getParameter("gia"));
			String moTa = request.getParameter("moTa");
			String anhMoi = "";

			Part filePart = request.getPart("anh"); // Lấy file input
			String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

			if (fileName == null || fileName.isEmpty()) {
				// Nếu người dùng không chọn ảnh mới
				anhMoi = request.getParameter("anhCu");
			} else {
				anhMoi = fileName;
			}
			int soLuong = Integer.parseInt(request.getParameter("soLuong"));
			int danhMucId = Integer.parseInt(request.getParameter("danhMuc"));
			SanPham sp = new SanPham(id, ten, gia, moTa, anhMoi, danhMucId, soLuong);
			boolean check = SanPhamDao.suaSanPham(sp);
			if (check) {
				request.getSession().setAttribute("message", "Sửa sản phẩm thành công!");
				request.getRequestDispatcher("quanLiSanPhamController").forward(request, response);
			} else {
				request.getSession().setAttribute("error", "Xóa sản phẩm không thành công!");
				request.getRequestDispatcher("quanLiSanPhamController").forward(request, response);
			}
		}
	}

}
