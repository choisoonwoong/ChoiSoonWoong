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
<br><br><br>
<table width = "1000" height ="180" border="1" bordercolor = "#000000" bgcolor = "#fff200" align="center">
<tr align="center">
<td height="40" colspan="10"><font color = "black"><strong>고객 조회 결과</strong></font> </td>
</tr>
<tr>
<td align="center" width="100" height="15"> <font color = "black"><strong></font>순번</strong></font> </td>
<td align="center" width="100" height="15"> <font color = "black"><strong></font>고객번호</strong></font> </td>
<td align="center" width="100" height="15"> <font color = "black"><strong></font>고객명</strong></font> </td>
<td align="center" width="100" height="15"> <font color = "black"><strong></font>핸드폰번호</strong></font> </td>
<td align="center" width="100" height="15"> <font color = "black"><strong></font>현금/카드</strong></font> </td>
<td align="center" width="100" height="15"> <font color = "black"><strong></font>결제금액</strong></font> </td>
<td align="center" width="100" height="15"> <font color = "black"><strong></font>방문날짜</strong></font> </td>
<td align="center" width="100" height="15"> <font color = "black"><strong></font>메모/특이사항</strong></font> </td>
<td align="center" width="100" height="15"> <font color = "black"><strong></font>쿠폰사용여부</strong></font> </td>
<td align="center" width="100" height="15"> <font color = "black"><strong></font>고객삭제</strong></font> </td>
</tr>

<%
	try {
	String name = request.getParameter("name");
	String phonee = request.getParameter("phone");
	int rnumstart = Integer.parseInt(request.getParameter("rnumstart"));
	int rnumstop = Integer.parseInt(request.getParameter("rnumstop"));
	String no = request.getParameter("no");
	int cc = 0;
	int i = 0; /* 순번 */
	int count = 0; /* 페이지 총 로우수 구하기 */
	int pagenum = 0; /* 페이징 네비게이션 페이지 번호 */
	double count2 = 0.0; /* 페이지 네비게이션 용도  */
String url = "jdbc:oracle:thin:@localhost:1521:xe";
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con = DriverManager.getConnection(url,"hr","hr");
String sql = "select * from (select c_number, c_name, c_phone, c_payment, to_char(c_money,'999,999,999,999') as c_money, " +
		"c_date, c_memo, rownum as rnum from (select * from company order by c_number) where c_name = ? and c_phone=? order by to_number(c_number)) where rnum between ? and ?";
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setString(1, name);
pstmt.setString(2, phonee);
pstmt.setInt(3, rnumstart);
pstmt.setInt(4, rnumstop);
ResultSet rs = pstmt.executeQuery();
%>

<%
String sql2 = "select sum(coupon) coupon from coupon where name=? and phone=?";
PreparedStatement pstmt2 = con.prepareStatement(sql2);
pstmt2.setString(1, name);
pstmt2.setString(2, phonee);
ResultSet rs2 = pstmt2.executeQuery();
String name2 = null;
String link = null;
rs2.next();
%>

<%
String sql3 = "select c_name, c_coupon, c_date, c_count from coupon2 where c_name=? and phone=?";
PreparedStatement pstmt3 = con.prepareStatement(sql3);
pstmt3.setString(1, name);
pstmt3.setString(2, phonee);
ResultSet rs3 = pstmt3.executeQuery();
rs3.next();
%>

<%
rs.next();
	do {
		String number = rs.getString("c_number");
		String phone = rs.getString("c_phone");
		String payment = rs.getString("c_payment");
		String money = rs.getString("c_money");
		String date = rs.getString("c_date");
		String memo = rs.getString("c_memo");
		int coupon = rs2.getInt("coupon");
		cc = rs3.getInt(2); /* 쿠폰 카운트 값 */
		link = "./memberUpdate.jsp?number="+number+"&phonee="+phone;
		String link2 = "./couponService.jsp?number="+number+"&phone="+phone;
		String link3 = "./memberDelete.jsp?phone="+phone+"&number="+number+"&payment="+payment+"&cc="+cc;
		String link4 = "./memberInsert2.jsp?phone="+phone+"&name="+name;
		String A = null; /* memo값 복사용  */
		String m = null; /* memo값 null 체크용 */
		A=memo;
		if (A==null) {
			m=" ";
		} else {
		m=A;
		}
%>

<%
String sql4 = "select count(*) from company where c_name = ? and c_phone=? ";
PreparedStatement pstmt4 = con.prepareStatement(sql4);
pstmt4.setString(1, name);
pstmt4.setString(2, phonee);
ResultSet rs4 = pstmt4.executeQuery();
rs4.next();
count = rs4.getInt(1);
count2 = count;
rs4.close();
pstmt4.close();
i++; /* 순번 1씩증가 */
%>

<tr>
<td align="center"> <strong> <%= i %> </strong></td>
<td align="center" height="7"><strong><a href = "<%=link%>"> <font color = "#9095e9"> <%= number %></font></a></strong></td>
<td align="center"> <strong> <a href="<%=link4%>"><font color="#9095e9"><%= name %></font></a> </strong></td>
<td align="center"> <strong> <%= phone %></strong></td>
<td align="center"> <strong><%= payment %></strong></td>
<td align="center"> <strong><%= money %></strong></td>
<td align="center"> <strong><%= date %></strong></td>
<td align="center"> <strong><%= m %></strong></td>
<td align="center"> <strong><a href="<%=link2%>" onclick="return confirm('<%=name%> 님 쿠폰을 사용하시겠습니까? 사용하면 되돌릴수 없습니다.')"> <font color = "#9095e9">쿠폰사용</a></strong></td>
<td align="center"> <strong><a href="<%=link3%>" onclick="return confirm('<%=name%> 님을 삭제하시겠습니까? 삭제하면 되돌릴수 없습니다.')"> <font color = "red">삭제</a></strong></td>
</tr>
<%name2=rs.getString(2);%>
<%} while(rs.next());%>
<center>
<strong> "<%=name2%>" 님 방문누적횟수는 <font color="red"><%=rs2.getInt(1) %></font>번입니다. <br></strong><br>
<strong> 중복된 이름이 있는경우 <font color="red">고객번호</font>를 누르면 상세정보를 확인할수있습니다. </strong><br><br>
<strong> <font color="red">고객번호</font>를 누르면 회원을 수정할수 있고, 해당 고객의 쿠폰사용을 누르면 <font color="red">10</font>회 방문시 쿠폰이 사용가능합니다.<br></strong><br><br><hr>
<strong> <font color="red"><%=rs3.getString(1) %></font> 님의 쿠폰을 사용하지않은 방문횟수는 <font color="red"><%=cc %></font> 회이고 <br><br>
마지막으로 쿠폰(+1)을 적립 또는 사용(-10)한 날짜는 <font color="red"><%=rs3.getString(3) %></font>이고, 총 쿠폰을 사용한 횟수는 <font color="red"><%=rs3.getString(4) %>회</font> 입니다. </strong><br>
<br><strong>고객 <font color="red">삭제</font>는 이름으로 검색했을때만 가능합니다.<br><br>
<strong>고객 <font color="red">수정, 쿠폰사용</font>은 가장 상단의 메뉴만 선택가능합니다.<br>
<%pstmt3.close(); rs3.close(); pstmt2.close(); rs2.close(); pstmt.close(); rs.close(); con.close(); %>
</strong></center><br><br>
</table>
</form>
<br><br>
<center>
<a href="dayMemberSelectProc.jsp?rnumstart=1&rnumstop=10&name=<%=name%>&phone=<%=phonee%>"><start><<</start></a> &nbsp;
<%
	int start = 1;
	int stop = 10;
	for (pagenum=1; pagenum<=count2/10+0.9; pagenum++) { %>
	<a href="dayMemberSelectProc.jsp?rnumstart=<%=start%>&rnumstop=<%=stop%>&name=<%=name %>&phone=<%=phonee%>"><page><%=pagenum%></page></a> &nbsp;
<%
start += 10;
stop += 10; 
} %>

<a href="dayMemberSelectProc.jsp?rnumstart=<%=start-10 %>&rnumstop=<%=stop-10 %>&name=<%=name%>&phone=<%=phonee%>"><stop>>></stop></a>
</center>
<%}catch (Exception e) { %>
<%} %>
<br><br><br><br>
<%@ include file = "footer.jsp" %>
</body>
</html>