package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.ThongKe;
import entity.ThongKeDonHang;
import entity.ThongKeSanPhamBanChay;
import entity.ThongKeTongQuat;
import entity.TrangThaiDonHang;
import model.ThongKeModel;

/**
 * Servlet implementation class thongKeController
 */
@WebServlet("/thongKeController")
public class ThongKeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ThongKeController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String bd = request.getParameter("fromDate");
		String kt = request.getParameter("toDate");
		System.out.println(bd+" "+kt);
		ArrayList<ThongKe> arrDoanhThu = ThongKeModel.getDoanhThuTheoThang(bd, kt);
		ArrayList<ThongKeDonHang> arrDonHang = ThongKeModel.getDonHangTheoThang(bd, kt);
		ArrayList<ThongKeSanPhamBanChay> arrSanPham = ThongKeModel.getSanPham(bd, kt);
		ArrayList<TrangThaiDonHang> arrTrangThai = ThongKeModel.getTrangThai(bd, kt);
		ArrayList<ThongKeTongQuat> arr = ThongKeModel.getThongKe();
		request.setAttribute("arr", arr);
		System.out.println("Số sản phẩm: " + arrSanPham.size());
		for (ThongKeSanPhamBanChay s : arrSanPham) {
		    System.out.println(s.getTenSanPham() + " " + s.getTong());
		}
		request.setAttribute("tt", arrTrangThai);
		request.setAttribute("dt", arrDoanhThu);
		request.setAttribute("dh", arrDonHang);
		request.setAttribute("sp", arrSanPham);
		
		request.getRequestDispatcher("thongKeDoanhThu.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
