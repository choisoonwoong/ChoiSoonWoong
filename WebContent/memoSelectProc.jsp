<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<style>
start { letter-spacing:-7px; color:red; font-size:20px;}
stop { letter-spacing:-7px; color:red; font-size:20px;}
page { color:#3f48cc; font-size:20px;}
</style>
<meta charset="UTF-8">
<title>고객검색 page</title>
<body>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ include file ="header.jsp" %>
</head>
<%@include file="nav.jsp" %>
<table width = "1000" height ="180" border="1" bordercolor = "#000000" bgcolor = "#fff200" align="center">
<tr align="center">
<td height="40" colspan="10"><font color = "black"><strong>고객 조회 결과</strong></font> </td>
</tr>
<tr>
<td align="center" width="100" height="15"> <font color = "black"><strong></font>고객번호</strong></font> </td>
<td align="center" width="100" height="15"> <font color = "black"><strong></font>고객명</strong></font> </td>
<td align="center" width="100" height="15"> <font color = "black"><strong></font>핸드폰번호</strong></font> </td>
<td align="center" width="100" height="15"> <font color = "black"><strong></font>현금/카드</strong></font> </td>
<td align="center" width="100" height="15"> <font color = "black"><strong></font>결제금액</strong></font> </td>
<td align="center" width="100" height="15"> <font color = "black"><strong></font>방문날짜</strong></font> </td>
<td align="center" width="100" height="15"> <font color = "black"><strong></font>메모/특이사항</strong></font> </td>
<td align="center" width="100" height="15"> <font color = "black"><strong></font>쿠폰사용여부</strong></font> </td>
</tr>

<%
try {
String memo = request.getParameter("memo");
String memoo = request.getParameter("memo");
int count = 0; /* 페이지 총 로우수 구하기 */
int pagenum = 0; /* 페이징 네비게이션 페이지 번호 */
double count2 = 0.0; /* 페이지 네비게이션 용도  */
String url = "jdbc:oracle:thin:@localhost:1521:xe";
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con = DriverManager.getConnection(url,"hr","hr");
String sql = "select * from company where c_memo like ? order by c_number";
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setString(1, "%" + memo + "%");
ResultSet rs = pstmt.executeQuery();
%>

<%
String sql2 = "select count(c_name) coupon from company where c_memo like ?";
PreparedStatement pstmt2 = con.prepareStatement(sql2);
pstmt2.setString(1, "%" + memo + "%");
ResultSet rs2 = pstmt2.executeQuery();
String memo2 = null;
String link = null;
rs2.next();
%>

<%
rs.next();
	do {
		String number = rs.getString("c_number");
		String name = rs.getString("c_name");
		String phone = rs.getString("c_phone");
		String payment = rs.getString("c_payment");
		String money = rs.getString("c_money");
		String date = rs.getString("c_date");
	    memo = rs.getString("c_memo");
		int coupon = rs2.getInt("coupon");
		link = "./memberUpdate.jsp?number="+number;
		String link2 = "./couponService.jsp?number="+number;
		String A = null; /* 메모값 복사용 */
		String m = null; /* null 체크용 */
		A=memo;
		if (A==null) {
			m=" ";
		} else {
		m=A;
		}
%>

<tr>
<td align="center" height="7"><strong><a href = "<%=link%>"> <font color = "#9095e9"> <%= number %></font></a></strong></td>
<td align="center"> <strong> <%= name %> </strong></td>
<td align="center"> <strong> <%= phone %></strong></td>
<td align="center"> <strong><%= payment %></strong></td>
<td align="center"> <strong><%= money %></strong></td>
<td align="center"> <strong><%= date %></strong></td>
<td align="center"> <strong><%= m %></strong></td>
<td align="center"> <strong><a href="<%=link2%>"> <font color = "#9095e9">쿠폰사용</a></strong></td>
</tr>
<%memo2=rs.getString(7);%>
<%} while(rs.next());%>
<center>
<strong> "<%=memoo%>" 로 조회한 방문 누적 횟수는 <font color="red"><%=rs2.getInt(1) %></font>번입니다. <br></strong><br>
<strong> 중복된 이름이 있는경우 <font color="red">고객번호</font>를 누르면 상세정보를 확인할수있습니다. </strong><br><br>
<strong> <font color="red">고객번호</font>를 누르면 회원을 수정할수 있고, 해당 고객의 쿠폰사용을 누르면 <font color="red">10</font>회 방문시 쿠폰이 사용가능합니다.<br></strong><br>
<strong> <font color="red">메모</font>로 조회한 고객은 기능이 한정됩니다.<br></strong></center><br>
</table>
</form>
<% pstmt.close(); rs.close(); con.close(); pstmt2.close(); rs2.close(); } catch (Exception e) {
e.printStackTrace();
%>
<script>
alert("조회한 회원정보가 없습니다.");
location.href="memoSelect.jsp";
</script>
<%} %> 
<br><br><br><br>
<%@ include file = "footer.jsp" %>
</body>
</html>