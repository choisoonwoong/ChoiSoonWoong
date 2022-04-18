<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*" %>
    <%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, java.text.*" %>
<!DOCTYPE html>
<link href ="common.css" rel="stylesheet" type="text/css">
<script src="day.js"></script>
<html>
<head>
<style>
graph {letter-spacing:-5px;}

</style>
<meta charset="UTF-8">
<title>매출조회 page</title>
</head>
<body>
<%@ include file = "header.jsp" %>
<%@ include file = "nav.jsp" %>
<br><br><br>
<h2 align="center">매출조회</h2>
<br><br>
<table width="1200" border="1">
<tr>
<td align="center"> 날짜  </td>
<td align="center"> 카드건수 </td>
<td align="center"> 카드금액 </td>
<td align="center"> 현금건수 </td>
<td align="center"> 현금금액 </td>
<td align="center"> 총 건수 </td>
<td align="center"> 총액 </td>
</tr>
<c:set var="i" value="0"/>
<%
	int year = Integer.parseInt(request.getParameter("yyear"));
	String yyear = request.getParameter("yyear");
	String sum = null;
	String y = null;
	String graph = null;
	int total=0;
	int total2=0;
	int day_sum = 0;
	int m = 0;
String url = "jdbc:oracle:thin:@localhost:1521:xe";
String sql =  "select distinct year, mon, max(sum) over(partition by mon), sum(sum2), nvl(max(hyun_sum) over(partition by mon),0), " +
"nvl(max(hyun_cnt) over(partition by mon),0), nvl(max(card_cnt) over(partition by mon),0), nvl(max(card_sum) over(partition by mon),0), max(summ) " +
"from (select distinct substr(d.day1,'1','2') year, substr(d.day1,'4','2') mon, " +
"nvl(to_char(sum(c.c_money) over (partition by substr(d.day1,'4','2')),'999,999,999,999'),0) sum, " +
"nvl(sum(c.c_money) over (partition by substr(d.day1,'4','2')),0) summ, " +
"count(c.c_number) over (partition by substr(d.day1,'4','2')) sum2, d.day1, to_char(e.hyun_sum,'999,999,999,999') hyun_sum, " + 
"to_char(f.card_sum,'999,999,999,999') card_sum, e.hyun_cnt, f.card_cnt from company c right outer join company_day d " +
"on to_date(c.c_date,'YY-MM-DD') = to_date(d.day1,'YY-MM-DD') and substr(day1,'1','2') = ? left outer join "+
"(select day1, count(c_number) over (partition by substr(d.day1,'4','2')) as hyun_cnt, sum(c_money) over (partition by substr(d.day1,'4','2')) as hyun_sum from "+
"company c join company_day d on to_date(c.c_date,'YY-MM-DD')=to_date(d.day1,'YY-MM-DD') and c_payment='현금' and substr(day1,'1','2') = ?) e " +
"on to_date(d.day1,'YY-MM-DD')=to_date(e.day1,'YY-MM-DD') and substr(d.day1,'1','2') = ? " +
"left outer join (select day1, count(c_number) over (partition by substr(d.day1,'4','2')) as card_cnt, " +
"sum(c_money) over (partition by substr(d.day1,'4','2')) as card_sum from company c join company_day d " +
"on to_date(c.c_date,'YY-MM-DD')=to_date(d.day1,'YY-MM-DD') and c_payment='카드' and substr(d.day1,'1','2') = ?) f " +
"on to_date(d.day1,'YY-MM-DD')=to_date(f.day1,'YY-MM-DD') and substr(d.day1,'1','2') = ? where substr(d.day1,'1','2') = ? " +
"group by d.day1, d.day2, c.c_money, c.c_number, e.hyun_sum, f.card_sum, e.hyun_cnt,f.card_cnt " +
"order by d.day1) ms right outer join monthh m on ms.mon = m.month and substr(day1,'1','2') = ? " +
"where substr(day1,'1','2') = ? " +
"group by day1, year, mon, sum, sum2, hyun_sum, hyun_cnt, card_cnt, card_sum order by mon"; 

Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con = DriverManager.getConnection(url,"hr","hr");
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setInt(1, year);
pstmt.setInt(2, year);
pstmt.setInt(3, year);
pstmt.setInt(4, year);
pstmt.setInt(5, year);
pstmt.setInt(6, year);
pstmt.setInt(7, year);
pstmt.setInt(8, year);
ResultSet rs = pstmt.executeQuery();	
while(rs.next()) {
	
	sum = rs.getString(3);
	y = rs.getString(1);
	total += rs.getInt(9);
	total2 += rs.getInt(9);
	day_sum = rs.getInt(9);
	m = day_sum/200000;
	
	if (m==0) {
		graph = "";
	}
	else if (m==1) {
		graph = "■";
	}
	else if (m==2) {
		graph = "■■";
	}
	else if (m==3) {
		graph = "■■■";
	}
	else if (m==4) {
		graph = "■■■■";
	}
	else if (m==5) {
		graph = "■■■■■";
	}
	else if (m==6) {
		graph = "■■■■■■";
	}
	else if (m==7) {
		graph = "■■■■■■■";
	}
	else if (m==8) {
		graph = "■■■■■■■";
	}
	else if (m==9) {
		graph = "■■■■■■■■";
	}
	else if (m==10) {
		graph = "■■■■■■■■■";
	}
	else if (m==11) {
		graph = "■■■■■■■■■■";
	}
	else if (m==12) {
		graph = "■■■■■■■■■■■";
	}
	else if (m==13) {
		graph = "■■■■■■■■■■■■";
	}
	else if (m==14) {
		graph = "■■■■■■■■■■■■■";
	}
	else if (m==15) {
		graph = "■■■■■■■■■■■■■■";
	}
	else if (m==16) {
		graph = "■■■■■■■■■■■■■■■";
	}
	else if (m==17) {
		graph = "■■■■■■■■■■■■■■■■";
	}
	else if (m==18) {
		graph = "■■■■■■■■■■■■■■■■■";
	}
	else if (m==19) {
		graph = "■■■■■■■■■■■■■■■■■■";
	}
	else if (m==20) {
		graph = "■■■■■■■■■■■■■■■■■■■";
	}
	else if (m==21) {
		graph = "■■■■■■■■■■■■■■■■■■■■";
	}
	else if (m==22) {
		graph = "■■■■■■■■■■■■■■■■■■■■■";
	}
	else if (m==23) {
		graph = "■■■■■■■■■■■■■■■■■■■■■■";
	}
	else if (m==24) {
		graph = "■■■■■■■■■■■■■■■■■■■■■■■";
	}
	else if (m==25) {
		graph = "■■■■■■■■■■■■■■■■■■■■■■■■";
	}
	else if (m==26) {
		graph = "■■■■■■■■■■■■■■■■■■■■■■■■■";
	}
	else if (m==27) {
		graph = "■■■■■■■■■■■■■■■■■■■■■■■■■■";
	}
	else if (m==28) {
		graph = "■■■■■■■■■■■■■■■■■■■■■■■■■■■";
	}
	else if (m==29) {
		graph = "■■■■■■■■■■■■■■■■■■■■■■■■■■■■";
	}
	else if (m==30) {
		graph = "■■■■■■■■■■■■■■■■■■■■■■■■■■■■■";
	}
	else if (m==31) {
		graph = "■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■";
	}
	else if (m==32) {
		graph = "■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■";
	}
	else if (m==33) {
		graph = "■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■";
	}
	else if (m==34) {
		graph = "■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■";
	}
	else if (m==35) {
		graph = "■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■";
	}
	else if (m==36) {
		graph = "■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■";
	}
	else if (m==37) {
		graph = "■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■";
	}
	else if (m==38) {
		graph = "■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■";
	}
	else if (m==39) {
		graph = "■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■";
	}
	else if (m==40) {
		graph = "■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■";
	}
	else if (m>40) {
		graph = "■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■";
	}
	
%>
<tr>
<td align="center"> 20<%=rs.getString(1) %>년 <%=rs.getString(2) %>월  </td>
<td align="center"> <strong><%if (sum.length()>=2) { %>총<font color="#3f48cc"> <%=rs.getString(7) %></font>건</strong><%} else { %> <%=rs.getString(7) %> <%}%> </td>
<td align="center"><strong><%if (sum.length()>=2) { %><font color="#3f48cc"> <%=rs.getString(8) %></font>원</strong><%} else { %> <%=rs.getString(8) %> <%}%></td>
<td align="center"> <strong><%if (sum.length()>=2) { %>총<font color="#3f48cc"> <%=rs.getString(6) %></font>건</strong><%} else { %> <%=rs.getString(6) %> <%}%> </td>
<td align="center"><strong><%if (sum.length()>=2) { %><font color="#3f48cc"> <%=rs.getString(5) %></font>원</strong><%} else { %> <%=rs.getString(5) %> <%}%>
<td align="center"> <strong><%if (sum.length()>=2) { %>총<font color="red"> <%=rs.getString(4) %></font>건</strong><%} else { %> <%=rs.getString(4) %> <%}%>  </td>
<td align="left"> <graph><strong><font color="#f76996"> <%=graph %> </font></strong></graph>&nbsp;&nbsp;
<strong><%if (sum.length()>=2) { %>총<font color="red"> <%=rs.getString(3) %></font>원</strong><%} else { %> <%=rs.getString(3) %> <%}%> </td>
</tr>
<%}rs.close(); pstmt.close(); con.close(); %>
</table>
<br><br><br><br>
<table width="900" border="1">
<tr>
<td> <strong>20<%=y%>년도 매출 총 금액은 <font color="red"> <% String str = String.format("%,d",total); %><%=str %> </font>원 입니다.</strong> </td>
</tr>
<tr>
<td> <strong>20<%=y%>년도 한달평균 매출 총 금액은 <font color="red"> <% String str2 = String.format("%,d",total/12); %><%=str2 %> </font>원 입니다.</strong> </td>
</tr>
</table>
<%@ include file = "footer.jsp" %>
</body>
</html>