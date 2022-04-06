<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠폰 사용 페이지</title>
</head>
<body>
<%
	/* 쿠폰 사용 페이지  */
	try {
		String number = request.getParameter("number");
		String phone = request.getParameter("phone");
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con = DriverManager.getConnection(url,"hr","hr");
	String sql2 = "select c_coupon from coupon2 where phone =?";
	PreparedStatement pstmt2 = con.prepareStatement(sql2);
	pstmt2.setString(1, phone);
	pstmt2.executeUpdate();
	ResultSet rs = pstmt2.executeQuery();
	rs.next();
	int coupon = rs.getInt(1); /* 방문횟수 */
	pstmt2.close();
%>
<%
	if (coupon>=9) {
%>
<%
	String sql = "update coupon2 set c_coupon=c_coupon-9 where phone =?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, phone);
	pstmt.executeUpdate();
	pstmt.close();
%>
<%
	String sql3 = "update coupon2 set c_count=c_count+1, c_date = sysdate where phone =?";
	PreparedStatement pstmt3 = con.prepareStatement(sql3);
	pstmt3.setString(1, phone);
	pstmt3.executeUpdate();
	pstmt3.close();
	rs.close();
%>
<script>
alert("쿠폰 사용이 완료되었습니다.");
history.go(-1);
</script>
<%} else {%>
<script>
alert("10회 미만 손님으로 쿠폰 사용에 실패했습니다.")
history.back();
</script>
<%}} catch (Exception e) {%>
<script>
alert("쿠폰을 사용할수 없습니다.")
history.back();
</script>
<%} %>

</body>
</html>