<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %> <!-- userdao의 클래스 가져옴 -->
<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 -->
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<% request.setCharacterEncoding("UTF-8"); %>

<!-- 한명의 회원정보를 담는 user클래스를 자바 빈즈로 사용 / scope:페이지 현재의 페이지에서만 사용-->
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>jsp 게시판 웹사이트</title>
</head>
<body>
	<%
	
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		
		 int boardID = 1;
			if (request.getParameter("boardID") != null){
				boardID = Integer.parseInt(request.getParameter("boardID"));
			}
		

			String realFolder="";
			String saveFolder = "bbsUpload";
			String encType = "utf-8";
			String map="";
			int maxSize=5*1024*1024;
			
			ServletContext context = this.getServletContext();
			realFolder = context.getRealPath(saveFolder);
			
			MultipartRequest multi = null;
			
			multi = new MultipartRequest(request,realFolder,maxSize,encType,new DefaultFileRenamePolicy());		
			String fileName = multi.getFilesystemName("fileName");
			String bbsTitle = multi.getParameter("bbsTitle");
			String bbsContent = multi.getParameter("bbsContent");
			bbs.setBbsTitle(bbsTitle);
			bbs.setBbsContent(bbsContent);
			
			
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
			
		}
	
		
		
		else{
			if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null
					|| bbs.getBbsTitle().equals("") || bbs.getBbsContent().equals("") ){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} 
			else{
					BbsDAO bbsDAO = new BbsDAO(); //인스턴스생성
				
					int result = bbsDAO.write(bbs.getBbsTitle(),userID, bbs.getBbsContent(), boardID);				
					if(result == -1){ // 아이디가 기본키기. 중복되면 오류.
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글쓰기에 실패했습니다.')");
						script.println("history.back()");
						script.println("</script>");
					}
					//가입성공	
					else {
						
				 		PrintWriter script = response.getWriter();
						if(fileName != null){
							File oldFile = new File(realFolder+"\\"+fileName);
							File newFile = new File(realFolder+"\\"+(result - 1)+"사진.jpg");
							oldFile.renameTo(newFile);
						}						

						script.println("<script>");
						script.println("location.href= \'bbs.jsp?boardID="+boardID+"\'");
						script.println("</script>");
					}
				}
			
		}
	
	

			%>

</body>
</body>
</html>