<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>로그인</title>
    <link rel="stylesheet" href="static/css/login.css" />
    <link
      rel="stylesheet"
      href="https://use.fontawesome.com/releases/v5.1.0/css/all.css"
    />
    <script src="static/js/jquery-3.4.1.min.js"></script>
  </head>

  <body>
    <div class="form-box">
      <h1><a href="index.jsp">웹프 9팀</a></h1>
      <div class="login-page">
        <form class="login-form" method="post" action="loginAction.jsp">
          <div class="input-box">
            <i class="far fa-user"></i>
            <input
              id="inputId"
              name="userID"
              type="text"
              placeholder="아이디"
              autocomplete="off"
            />
          </div>
          <div class="input-box">
            <i class="fas fa-key"></i>
            <input id="inputPw" name="userPassword" type="password" placeholder="비밀번호" />
            <span class="eye" onclick="viewPassword()">
              <i id="hide1" class="far fa-eye"></i>
              <i id="hide2" class="far fa-eye-slash"></i>
            </span>
          </div>

          <input type="submit" value="로그인" class="login-btn">
          <p class="errmsg">아이디를 입력해 주세요.</p>
          <p class="errmsg">비밀번호를 입력해 주세요.</p>
          <p class="message"><a href="signup.jsp">회원가입</a></p>
        </form>
      </div>
    </div>

    <script src="static/JS/loginform_checkValue.js"></script>
    <script src="static/JS/loginform_viewPassword.js"></script>
  </body>
</html>
