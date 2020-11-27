<%@ page language="java" contentType="text/html; charset=UTF-8"

	pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="static/css/bbs.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<script src="static/JS/jquery-3.4.1.min.js"></script>
<script src="static/js/jquery-3.4.1.min.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Sunflower:wght@300&display=swap" rel="stylesheet">
<title>jsp 게시판 웹사이트</title>
</head>
<body>
	<%
		//로긴한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		
		 int boardID = 1;
			if (request.getParameter("boardID") != null){
				boardID = Integer.parseInt(request.getParameter("boardID"));
			}
		
	%>

	<!-- 네비게이션  -->
		<div class="header">
         <div><a class="menu-item" href="index.jsp">인공지능 홈PT</a></div>
	    <div class="menu">
            <a href="#" class='menu-item'>나의 다이어리</a>
            <a href="bbs.jsp?boardID=1&pageNumber=1" class='menu-item'>운동 게시판</a>
            <a href="bbs.jsp?boardID=1&pageNumber=1" class='menu-item'>자유 게시판</a>
            <%if(userID == null) {%>
            <a href="login.jsp" class='menu-item'>로그인</a>
            <a href="signup.jsp" class='menu-item'>회원 가입</a>            
            <%} else if(userID != null){ %>
            <a href="logoutAction.jsp" class='menu-item'>로그아웃</a>
            <% } %>
        </div>
    </div>
	<!-- 게시판 -->
	<br><br>

	<div class="container">
		<div class = "row">
			<form method="post" encType = "multipart/form-data" action="writeAction.jsp?boardID=<%=boardID%>&keyValue=multipart">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th style="background-color: #eeeee; text-align: center;">게시판 글쓰기 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
						</tr>	
		
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height:350px;"></textarea></td>
						</tr>
						<tr>
							<td><input type="file" name="fileName"></td>
						</tr>
					</tbody>
					</table>
						<input type="submit" class="btn-primary pull-right" value="글쓰기">
			</form>

		</div>
	</div>
	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 부트스트랩 JS  -->
	<script src="js/bootstrap.js"></script>
</body>
</html>