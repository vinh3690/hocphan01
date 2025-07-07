package entity;

public class ThongKeTongQuat {
	 private int tongDonHang;
	    private int tongSanPhamDaBan;
	    private double tongDoanhThu;

	    // Constructors
	    public ThongKeTongQuat() {}

	    public ThongKeTongQuat(int tongDonHang, int tongSanPhamDaBan, double tongDoanhThu) {
	        this.tongDonHang = tongDonHang;
	        this.tongSanPhamDaBan = tongSanPhamDaBan;
	        this.tongDoanhThu = tongDoanhThu;
	    }

	    // Getters and Setters
	    public int getTongDonHang() {
	        return tongDonHang;
	    }

	    public void setTongDonHang(int tongDonHang) {
	        this.tongDonHang = tongDonHang;
	    }

	    public int getTongSanPhamDaBan() {
	        return tongSanPhamDaBan;
	    }

	    public void setTongSanPhamDaBan(int tongSanPhamDaBan) {
	        this.tongSanPhamDaBan = tongSanPhamDaBan;
	    }

	    public double getTongDoanhThu() {
	        return tongDoanhThu;
	    }

	    public void setTongDoanhThu(double tongDoanhThu) {
	        this.tongDoanhThu = tongDoanhThu;
	    }
}
