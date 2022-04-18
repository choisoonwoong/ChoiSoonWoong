<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<link href="common.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<html>
<meta charset="UTF-8">
<title>고객 입력 page</title>
<body>
<form method="post" name="insert" action="memberInsertProc.jsp">
<script>
/* 고객 입력 null값 및 유효성 체크 */
function insert_check () {
	if (document.insert.name.value == ''){
		alert("고객명을 입력하세요.");
		insert.name.focus();
		return;
	}
    if (document.insert.name.value.indexOf(" ") >= 0) {
        alert("고객명에 공백을 사용할 수 없습니다.")
        insert.name.focus()
        return false;
    }
	if (document.insert.phone1.value == ''){
		alert("핸드폰번호를 입력하세요.");
		insert.phone1.focus();
		return;
	}
	var phone1 = /^[0-9]{1,}$/;
    if (!phone1.test(document.insert.phone1.value)) {
        alert("핸드폰 번호는 숫자로 입력하세요.");
        insert.phone1.focus();
        return;
    }
	if (document.insert.phone2.value == ''){
		alert("핸드폰번호를입력하세요.");
		insert.phone2.focus();
		return;
	}
	var phone2 = /^[0-9]{1,}$/;
    if (!phone2.test(document.insert.phone2.value)) {
        alert("핸드폰 번호는 숫자로 입력하세요.");
        insert.phone2.focus();
        return;
    }
	if (document.insert.phone3.value == ''){
		alert("핸드폰번호를 입력하세요.");
		insert.phone3.focus();
		return;
	}
	var phone3 = /^[0-9]{1,}$/;
    if (!phone3.test(document.insert.phone3.value)) {
        alert("핸드폰 번호는 숫자로 입력하세요.");
        insert.phone3.focus();
        return;
    }
	if (document.insert.payment.value == '0'){
		alert("결제수단을 선택하세요.");
		insert.payment.focus();
		return;
	}
	if (document.insert.money.value == ''){
		alert("금액을 입력하세요.");
		insert.money.focus();
		return;
	}
	var pwtype = /^[0-9]{1,}$/;
    if (!pwtype.test(document.insert.money.value)) {
        alert("금액은 숫자로 입력하세요.");
        insert.money.focus();
        return;
    }
	document.insert.submit();
}

/* 핸드폰 번호 입력되면 한칸씩 자동 이동 */
function phone_pass() {
	if (document.insert.phone1.value.length==3) {
	document.insert.phone2.focus();
	}
	if (document.insert.phone2.value.length==4) {
		document.insert.phone3.focus();
	}
	if (document.insert.phone3.value.length==4) {
		document.insert.money.focus();
	}
}

</script>

<%@ include file ="header.jsp" %>
<% request.setCharacterEncoding("UTF-8"); %>
</head>
<%@ include file ="nav.jsp" %>
<br><br><br>
<table width = "500" height ="180" border="1" bordercolor = "#000000" bgcolor = "#fff200" align="center">
<tr align="center">
<td colspan="2" height="30"><font color = "black"><strong>고객입력</strong></font> </td>
</tr>
<tr>
<td align="center" width="200" height="50"> <font color = "black"><strong><font color="red">*</font>고객명</strong></font> </td>
<td align="center"> <input type="text" name="name" id="zero">

<select id = "changeMember" onchange="member(this.value);">
<option value="회원">회원</option>
<option value="비회원">비회원</option>
</select> </td> </tr>

<tr>
<td align="center" width="200" height="50"> <font color = "black"><strong><font color="red">*</font>핸드폰번호</strong> </font> </td>
<td align="center" width="200" height="50">
<input type="text" size = "3" name="phone1" maxlength="3" onkeyup="phone_pass()" id="zero2"> - 
<input type="text" size = "4" name="phone2" maxlength="4" onkeyup="phone_pass()" id="zero3"> -
<input type="text" size = "4" name="phone3" maxlength="4" onkeyup="phone_pass()" id="zero4"></td>
</tr>


<script>
/* 비회원 선택시 자동으로 value값 입력 */
var member = function(value){
	$("#zero").val(value);
	$("#zero2").val("0");
	$("#zero3").val("0");
	$("#zero4").val("0");
	$("#zero5").val("카드");
	$("#money").val("10000");
}
</script>

<tr>
<td align="center" width="200" height="50"> <strong><font color="red">*</font>현금/카드</strong> </td>
<td align="center" width="200" height="50">


<select name="payment" id="zero5">
<option value="0">--선택--</option>
<option value="현금">현금</option>
<option value="카드">카드</option>
</select> </td> </tr>

<tr>
<td align="center" width="200" height="50"> <strong>스타일 선택</strong> </td>
<td align="center" width="200" height="50">
<select id = "changeTest" onchange="choice(this.value);">
<option value="0">--선택하세요--</option>
<%
String url = "jdbc:oracle:thin:@localhost:1521:xe";
String sql = "select * from choice";
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con = DriverManager.getConnection(url,"hr","hr");
PreparedStatement pstmt = con.prepareStatement(sql);
ResultSet rs = pstmt.executeQuery();
while (rs.next()) {
	String option1 = rs.getString("option1");
	String money = rs.getString("money");
%>
<option value="<%=money %>"><%=option1 %></option>
<%} rs.close(); pstmt.close(); con.close(); %>
</select>
<tr>
<td align="center" width="200" height="50"> <strong><font color="red">*</font>결제금액<br>(직접입력가능)</strong> </td>
<td align="center" width="200" height="50"> <input type="text" name="money" id="money"> </td>
</tr>

<input type="hidden" name="style" id="style">

<script>
/* 추가한 스타일 이름 선택시 등록한 금액 value값 자동 입력 */
var choice = function(value){
	$("#money").val(value); 
	}
	
</script>


<tr>
<td align="center" width="200" height="50"> <strong>메모(비고)</strong> </td>
<td align="center" width="400" height="100"> <textarea cols="45" rows="10" name="memo"></textarea></td>
</tr>
<tr><td colspan="2"><font color="red"><strong> * </font>항목은 필수 입력항목입니다.</strong><br><font color="red"><strong>  주의 : 중복되는 핸드폰번호를 입력하지마세요!</font></strong></td></tr>
</table>
<br>
<table align="center">
<tr class="btn_group">
<td colspan="2">
<button type = "button" name = "insert" onclick="insert_check()" ><strong>고객 등록</strong></button>
<a href = "memberInsert.jsp">
<button type = "button" name = "login"><strong>다시쓰기</strong></button></a>
</td>
</table>
</form>
<%@ include file ="footer.jsp" %>
</body>
</html>