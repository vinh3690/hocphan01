<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="review-list">
    <c:forEach var="review" items="${dh}">
        <div class="review-item">
            <div class="review-header">
                <span class="reviewer">${fn:escapeXml(review.nguoiDung.hoTen)}</span>
                <span class="review-date">
                    <fmt:formatDate value="${review.ngayDanhGia}" pattern="dd/MM/yyyy HH:mm"/>
                </span>
            </div>
            <div class="review-rating">
                <c:forEach begin="1" end="${review.diem}">★</c:forEach>
                <c:forEach begin="${review.diem + 1}" end="5">☆</c:forEach>
            </div>
            <div class="review-comment">${fn:escapeXml(review.binhLuan)}</div>
        </div>
    </c:forEach>
</div>
