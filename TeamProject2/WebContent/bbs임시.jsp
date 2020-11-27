<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<!-- 스타일시트 참조  -->

<link rel="stylesheet" href="css/bootstrap.css">
<title>jsp 게시판 웹사이트</title>

</head>
<body>
	<%
		//로긴한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		
		 int boardID = 1;
			if (request.getParameter("boardID") != null){
				boardID = Integer.parseInt(request.getParameter("boardID"));
			}
		
		
	%>
	<!-- 네비게이션  -->
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="bs-example-navbar-collapse-1"
				aria-expaned="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="index.html">JSP 게시판</a>
		</div>
		<div class="collapse navbar-collapse"
			id="#bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="index.html">메인</a></li>
				
				<% if (boardID == 1){ %>
					<li class="active"><a href="bbs.jsp?boardID=1&pageNumber=1">운동 게시판</a></li>
					<li><a href="bbs.jsp?boardID=2&pageNumber=1">자유 게시판</a></li>
				<%} else if(boardID == 2){ %>
					<li><a href="bbs.jsp?boardID=1&pageNumber=1">운동 게시판</a></li>
					<li class="active"><a href="bbs.jsp?boardID=2&pageNumber=1">자유 게시판</a></li>
				<% } %>
				
				<!-- <li class="active"><a href="bbs.jsp">게시판</a></li> -->
			</ul>

			<%
				//라긴안된경우
				if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="signup.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>

			<%
				}
			%>
		</div>
	</nav>
	<!-- 게시판 -->
	
		<%
		if(boardID == 1){
	%>
			<center><h1>운동게시판<br></h1></center>
			<center><p>운동에 관한 글을 쓰는 곳입니다.</center><br></p>
	<% }
		else if(boardID == 2){
	%>
			<center><h1>자유게시판<br></h1></center>
			<center><p>자유롭게 글을 쓰는 곳입니다.</center><br></p>
	<% }%>
	
	
	
	
	<div class="container">
		<div class = "row">
			<table class="table table-striped" style="text-align:center; border:1px solid #dddddd"> 
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">구분</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						BbsDAO bbsDAO = new BbsDAO();
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber, boardID);
	
						for(int i=0;i<list.size();i++){
					%>
				
					<tr>
							<td>
									<%
									if(boardID == 1){
								%>
										운동게시판
								<% }
									else if(boardID == 2){
								%>
										자유게시판
								<% }%>
							 </td>
							<td><a href="view.jsp?boardID=<%=boardID%>&bbsID=<%= list.get(i).getBbsID() %>">
							<%= list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %>
							</a></td>							
							<td><%= list.get(i).getUserID() %></td>
							<td><%= list.get(i).getBbsDate().substring(0,11) + list.get(i).getBbsDate().substring(11,13) + "시" 
							+ list.get(i).getBbsDate().substring(14,16) + "분" %></td>					
					</tr>
					
					<%
					
						}
					%>
				</tbody>
			</table>
				<%

					//if (pageNumber != 1) {
				%>

<!-- 
				<a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>"
					class="btn btn-success btn-arrow-left">이전</a>
				<%
					//}
					//if (bbsDAO.nextPage(pageNumber + 1)) {
				%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>"
					class="btn btn-success btn-arrow-middle">다음</a>
				<%
					//}
				%>	 -->		
			<a href="write.jsp?boardID=<%=boardID%>"class="btn btn-primary pull-right">글쓰기</a>
			
			<div class=container style="text-align:center">
			<%
				BbsDAO bbsDAO1 = new BbsDAO();
				int pages = (int) Math.ceil(bbsDAO1.getCount(boardID)/10)+1;
				for(int i=1; i<=pages; i++){ %>
					<button type="button" onclick="location.href='bbs.jsp?boardID=<%=boardID %>&pageNumber=<%=i %>'"><%=i %></button>
				<%} %>
		</div>
			
			
			
		</div>
		
		
		
		
	</div>

	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 부트스트랩 JS  -->
	<script src="js/bootstrap.js"></script>
</body>
</html>