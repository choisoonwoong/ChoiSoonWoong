<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link href ="common.css" rel="stylesheet" type="text/css">
<html>
<head>
<meta charset="UTF-8">	
<title>회원가입</title>
</head>
<body>
<form method="post" name="member" action="memberProc.jsp">
<script>
/* 회원가입 null값 체크 */
function input_check() {
	if (document.member.id.value =='') {
		alert("아이디를 입력하세요.");
		member.id.focus();
		return;
	}
	else if (document.member.password.value =='') {
		alert("비밀번호를 입력하세요.");
		member.password.focus();
		return;
	}
	else if (document.member.password_check.value =='') {
		alert("비밀번호확인을 입력하세요.");
		member.password_check.focus();
		return;
	}
	else if (document.member.password.value != document.member.password_check.value) {
		alert("비밀번호와 비밀번호 확인이 같지 않습니다.");
		member.password.focus();
		return;
	}
	document.member.submit();
}

</script>
<%@include file = "header.jsp" %>
<%@ include file ="nav_Session_X.jsp" %>
<br><br>
<center>
<table width = "500" height ="180" border="1" bordercolor = "#000000" bgcolor = "#fff200" align="center">
<tr align="center">
<td colspan="2"><font color = "black"><strong>회원가입</strong></font> </td>
</tr>
<tr>
<td align="center"> <font color = "black"><strong>아이디</strong> </font> </td>
<td align="center"> <input type="text" name="id"> </td>
</tr>

<tr>
<td align="center"> <font color = "black"><strong>비밀번호</strong> </font> </td>
<td align="center"> <input type="password" name="password"> </td>
</tr>

<tr>
<td align="center"> <font color = "black"><strong>비밀번호확인</strong> </font> </td>
<td align="center"> <input type="pas 	sword" name="password_check"> </td>
</tr>

<tr class="btn_group">
<td colspan="3">
<button type = "button" name = "login" onclick="input_check()">회원가입</button></a>
<a href = "login.jsp">
<button type = "button" name = "login">로그인</button></a>
</td>
</table>
</center>
</form>
<%@include file = "footer.jsp" %>
</body>
</html>