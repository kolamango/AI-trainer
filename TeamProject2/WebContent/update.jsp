<%@ page language="java" contentType="text/html; charset=UTF-8"

	pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>

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
		if (userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		
		 int boardID = 1;
			if (request.getParameter("boardID") != null){
				boardID = Integer.parseInt(request.getParameter("boardID"));
			}
		
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if(!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다..')");
			script.println("history.back()");
			script.println("</script>");
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
			<form method="post" encType = "multipart/form-data"  action="updateAction.jsp?bbsID=<%= bbsID %>&boardID=<%=boardID%>">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2"
								style="background-color: #eeeeee; text-align: center;">글수정 </th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%= bbs.getBbsTitle() %>" ></td>
						</tr>
				
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px;" ><%= bbs.getBbsContent() %></textarea></td>
						</tr>
						<tr>
							<td><input type="file" name="fileName"></td>
						</tr>
					</tbody>
				</table>	
				<button type="submit" class="btn btn-primary pull-right" >글수정</button>
			</form>

		</div>
	</div>
	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 부트스트랩 JS  -->
	<script src="js/bootstrap.js"></script>
</body>
</html>