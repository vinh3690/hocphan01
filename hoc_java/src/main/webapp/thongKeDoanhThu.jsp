<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thống kê</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            margin-left:250px;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            background-color: #e9ecef;
        }
        .date-range {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .date-range label {
            font-size: 14px;
            font-weight: bold;
        }
        .date-range input[type="date"] {
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }
        .stats-box {
            display: flex;
            justify-content: space-around;
            margin: 20px 0;
        }
        .stat-card {
            text-align: center;
            padding: 20px;
            width: 150px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 5px rgba(0,0,0,0.1);
        }
        .blue { background-color: #007bff; color: white; }
        .green { background-color: #28a745; color: white; }
        .orange { background-color: #fd7e14; color: white; }
        .red { background-color: #dc3545; color: white; }
        .charts {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .chart {
            width: 45%;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 5px rgba(0,0,0,0.1);
        }
        canvas {
            width: 100%;
            height: 200px;
        }
    </style>
</head>
<body>
<jsp:include page="slierBar.jsp" />
    <div class="container">
        <div class="header">
            <h2>Dữ liệu thống kê</h2>
            <form id="dateForm" action="thongKeController" method="GET">
                <div class="date-range">
                    <label for="fromDate">Từ ngày:</label>
                    <input type="date" id="fromDate" name="fromDate" value="${param.fromDate != null ? param.fromDate : ''}">
                    <label for="toDate">Đến ngày:</label>
                    <input type="date" id="toDate" name="toDate" value="${param.toDate != null ? param.toDate : ''}">
                    <button type="submit">Lọc</button>
                </div>
            </form>
        </div>

        <c:if test="${not empty error}">
            <div style="color: red; text-align: center;">
                ${error}
            </div>
        </c:if>

        <h3>Thống kê từ ${param.fromDate} đến ${param.toDate}</h3>
        <div class="stats-box">
            <div class="stat-card blue">
                <span>Tổng sản phẩm bán</span><br>
                <strong>
                    <c:set var="tongSanPham" value="0"/>
                    <c:forEach var="item" items="${arr}">
                        <c:set var="tongSanPham" value="${item.tongSanPhamDaBan}"/>
                    </c:forEach>
                    ${tongSanPham}
                </strong>
            </div>
            <div class="stat-card green">
                <span>Tổng đơn hàng</span><br>
                <strong>
                    <c:set var="tongDonHang" value="0"/>
                    <c:forEach var="item" items="${arr}">
                        <c:set var="tongDonHang" value="${item.tongDonHang}"/>
                    </c:forEach>
                    ${tongDonHang}
                </strong>
            </div>
            <div class="stat-card orange">
                <span>Tổng doanh thu</span><br>
                <strong>
                    <c:set var="tongDoanhThu" value="0"/>
                    <c:forEach var="item" items="${arr}">
                        <c:set var="tongDoanhThu" value="${item.tongDoanhThu}"/>
                    </c:forEach>
                  <fmt:formatNumber value="${tongDoanhThu}" type="number" groupingUsed="true" maxFractionDigits="0"/> VND

                </strong>
            </div>
            
        </div>

        <div class="charts">
            <div class="chart">
                <h4>Doanh thu theo tháng</h4>
                <canvas id="revenueChart"></canvas>
            </div>
            <div class="chart">
                <h4>Số đơn hàng theo tháng</h4>
                <canvas id="orderChart"></canvas>
            </div>
        </div>

        <div class="charts">
            <div class="chart">
                <h4>Sản phẩm bán chạy nhất</h4>
                <canvas id="topProductsChart"></canvas>
            </div>
            <div class="chart">
                <h4>Phân bố trạng thái đơn hàng</h4>
                <canvas id="orderStatusChart"></canvas>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        // Revenue Chart
        const revenueData = [
            <c:forEach var="i" begin="1" end="12">
                <c:set var="found" value="false"/>
                <c:forEach var="item" items="${dt}">
                    <c:if test="${item.thang == i}">
                        ${item.doanhThu},
                        <c:set var="found" value="true"/>
                    </c:if>
                </c:forEach>
                <c:if test="${!found}">0,</c:if>
            </c:forEach>
        ];

        const revenueChart = new Chart(document.getElementById('revenueChart').getContext('2d'), {
            type: 'bar',
            data: {
                labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 
                         'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'],
                datasets: [{
                    label: 'Doanh thu (VND)',
                    data: revenueData,
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                scales: { 
                    y: { 
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) {
                                return value.toLocaleString('vi-VN') + ' VND';
                            }
                        }
                    } 
                }
            }
        });

        // Order Chart
        const orderData = [
            <c:forEach var="i" begin="1" end="12">
                <c:set var="found" value="false"/>
                <c:forEach var="item" items="${dh}">
                    <c:if test="${item.thang == i}">
                        ${item.soDonHang},
                        <c:set var="found" value="true"/>
                    </c:if>
                </c:forEach>
                <c:if test="${!found}">0,</c:if>
            </c:forEach>
        ];

        const orderChart = new Chart(document.getElementById('orderChart').getContext('2d'), {
            type: 'line',
            data: {
                labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 
                         'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'],
                datasets: [{
                    label: 'Số đơn hàng',
                    data: orderData,
                    fill: false,
                    borderColor: 'rgb(75, 192, 192)',
                    tension: 0.1
                }]
            },
            options: {
                responsive: true,
                scales: { y: { beginAtZero: true } }
            }
        });

        // Top Products Chart (nếu có dữ liệu)
        <c:if test="${not empty sp}">
            const topProductsLabels = [
                <c:forEach var="sp" items="${sp}" varStatus="loop">
                '${fn:escapeXml(sp.tenSanPham).trim()}'<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
            ];
            
            const topProductsData = [
                <c:forEach var="sp" items="${sp}" varStatus="loop">
                    ${sp.tong}<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
            ];
            
            const topProductsChart = new Chart(document.getElementById('topProductsChart').getContext('2d'), {
                type: 'bar',
                data: {
                    labels: topProductsLabels,
                    datasets: [{
                        label: 'Số lượng bán',
                        data: topProductsData,
                        backgroundColor: 'rgba(255, 159, 64, 0.2)',
                        borderColor: 'rgba(255, 159, 64, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    scales: { y: { beginAtZero: true } }
                }
            });
        </c:if>
        <c:if test="${empty sp}">
            const topProductsChart = new Chart(document.getElementById('topProductsChart').getContext('2d'), {
                type: 'bar',
                data: {
                    labels: ['Không có dữ liệu'],
                    datasets: [{
                        label: 'Số lượng bán',
                        data: [0],
                        backgroundColor: 'rgba(255, 159, 64, 0.2)',
                        borderColor: 'rgba(255, 159, 64, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: { y: { beginAtZero: true } },
                    plugins: {
                        title: {
                            display: true,
                            text: 'Không có dữ liệu sản phẩm bán chạy'
                        }
                    }
                }
            });
        </c:if>

        // Order Status Chart (nếu có dữ liệu)
        <c:if test="${not empty tt}">
            const orderStatusLabels = [
                <c:forEach var="tt" items="${tt}" varStatus="loop">
                    '${tt.trangThai}'<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
            ];
            
            const orderStatusData = [
                <c:forEach var="tt" items="${tt}" varStatus="loop">
                    ${tt.donHang}<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
            ];
            
            const orderStatusColors = [
                '#36A2EB', '#FFCE56', '#FF6384', '#4BC0C0', '#9966FF', '#FF9F40'
            ];
            
            const orderStatusChart = new Chart(document.getElementById('orderStatusChart').getContext('2d'), {
                type: 'pie',
                data: {
                    labels: orderStatusLabels,
                    datasets: [{
                        data: orderStatusData,
                        backgroundColor: orderStatusColors,
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true
                }
            });
        </c:if>
        <c:if test="${empty tt}">
            const orderStatusChart = new Chart(document.getElementById('orderStatusChart').getContext('2d'), {
                type: 'pie',
                data: {
                    labels: ['Không có dữ liệu'],
                    datasets: [{
                        data: [100],
                        backgroundColor: ['#36A2EB'],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        title: {
                            display: true,
                            text: 'Không có dữ liệu trạng thái đơn hàng'
                        }
                    }
                }
            });
        </c:if>
    </script>
</body>
</html>