<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link rel="stylesheet" href="static/css/login.css" type="text/css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css">
    <script src="static/JS/jquery-3.4.1.min.js"></script>
</head>

<body>
    <div class="form-box">
        <h1><a href = "index.jsp">웹프 9팀</a></h1>
        <div class="login-page">
            <form class="register-form" action="joinAction.jsp" method="post">
                <div class="input-box2">
                    <i class="far fa-user"></i>
                    <input name="userID" id = "userID" type="text" placeholder="아이디 입력">
                </div>
                
             <div class="input-box">
                    <i class="far fa-envelope"></i>
                    <input name="userEmail" id="userEmail" type="text" placeholder="이메일 입력">
                </div>
                <div class="input-box">
                    <i class="fas fa-key"></i>
                    <input name = "userPassword" id="userPassword" type="password" placeholder="비밀번호 입력">
                </div>

                
                <p class = "errmsg e2">입력이 누락된 항목이 있습니다.</p>                    
                <p class = "errmsg e3">입력한 비밀번호와 재입력한 비밀번호가 일치하지 않습니다.</p>

                <input class=login-btn type="submit" value="회원가입">
                <p class="message"><a href="login.jsp">로그인 화면</a></p>
            </form>
        </div>
    </div>

    <script src="static/JS/signupform_checkValue.js"></script>
</body>

</html>