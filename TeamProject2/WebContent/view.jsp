<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="comment.Comment" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.util.ArrayList"%>
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
		
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		
		 int boardID = 1;
			if (request.getParameter("boardID") != null){
				boardID = Integer.parseInt(request.getParameter("boardID"));
			}
		
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href= \'bbs.jsp?boardID="+boardID+"\'");
			script.println("</script>");
		}
		

		
		
		Bbs bbs = new BbsDAO().getBbs(bbsID); %>

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
	

	<!-- 게시판 -->

	<div class="container">
		<div class = "row">
				<table class="table table-striped" style="text-align:center; border:1px solid #dddddd"> 
					<thead>
						<tr>
							<th colspan="3" style="background-color: #eeeeee; text-align: center; width:1000px"">게시판 글 보기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width:20%">글 제목</td>
							<td colspan="2"><%= bbs.getBbsTitle() %></td> 
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="2"><%= bbs.getUserID() %></td> 
						</tr>						
							<td>작성일</td>	
							<td colspan="2"><%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시"
							+ bbs.getBbsDate().substring(14, 16) + "분"%></td>
						</tr>
							<td>내용</td>	
							<td colspan="2" style="min-height: 200px; text-align: left;"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br/>") %>
							</tr>
				
										<tr>
						
								<% 	 // 
									String real = "C:\\Users\\Hwanoon\\eclipse-workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp3\\wtpwebapps\\TeamProject2\\bbsUpload";
									File viewFile = new File(real+"\\"+bbsID+"사진.jpg");
								
									if(viewFile.exists()){
								%>
								<tr>
									<td colspan="6"><br><br><img src = "bbsUpload/<%=bbsID %>사진.jpg" border="300px" width="300px" height="300px"><br><br>
									<% }
									else {%><td colspan="6"><br><br><%} %>	
								
							<tr>			
							
							
							</td>
						</tr>												
					</tbody>		
			</table>	
					<%
						if(userID != null && userID.equals(bbs.getUserID())){
					%>
					
						<a href="update.jsp?bbsID=<%= bbsID %>&boardID=<%= boardID %>" class="btn btn-primary">수정</a>
						<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>&boardID=<%= boardID %>" class="btn btn-primary">삭제</a>
					<% 
						}
					%>										
		</div>
		
				<!-- 댓글 -->
		<div class="container">
			<div class="row">
				
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<tbody>
					<tr>
						<td align="left" bgcolor="beige">댓글</td>
					</tr>
					<br>
					<tr>
						<%
							CommentDAO commentDAO = new CommentDAO();
							ArrayList<Comment> list = commentDAO.getList(boardID, bbsID);
							for(int i=0; i<list.size(); i++){
						%>
							<div class="container">
								<div class="row">
								
									<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
										<tbody>
										<tr>
										<td align="left">작성자 : <%= list.get(i).getUserID() %> </td>
										<td align="right">
										
										<% for(int x=0;x<75;x++){ %>
										
										&nbsp;
										
										<% } %>
										
										<%= list.get(i).getCommentDate().substring(0,11) + list.get(i).getCommentDate().substring(11,13) + "시" + list.get(i).getCommentDate().substring(14,16) + "분" %></td>
										<td colspan="2"></td>
										 
										<td align="right"><%
													if(list.get(i).getUserID() != null && list.get(i).getUserID().equals(userID)){
												%>
													<!-- 	<form name = "p_search">
															<a type="button" onclick="nwindow(<%=boardID%>,<%=bbsID %>,<%=list.get(i).getCommentID()%>)" class="btn-primary">수정</a>
														</form>  -->
														
														<a onclick="return confirm('정말로 삭제하시겠습니까?')" href = "commentDeleteAction.jsp?bbsID=<%=bbsID %>&commentID=<%= list.get(i).getCommentID() %>">삭제</a>
																	
												<%
													}
												%>	
										</td>
										</tr>
										<tr>
											<tdcolspan="5" align="left"><%= list.get(i).getCommentText() %></td>									
											<% } %>	
										</tr>
									</tbody>
								</table>			
							</div>
						</div>
		
		
		
		
		
		<hr>
		
		<div class="container">
			<div class="form-group">
			<form method="post" action="commentAction.jsp?bbsID=<%= bbsID %>&boardID=<%=boardID%>">
					<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
						<tr>
							<td style="border-bottom:none;" valign="middle"><br><br><%=userID %></td>
							<td><input type="text" style="height:100px;" class="form-control" placeholder="상대방을 존중하는 댓글을 남깁시다." name = "commentText"></td>
							<td><br><br><input type="submit" class="btn-primary pull" value="댓글 작성"></td>
						</tr>
					</table>
			</form>
			</div>
		</div>
		
	</div>
	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 부트스트랩 JS  -->
	<script src="js/bootstrap.js"></script>
</body>
</html>