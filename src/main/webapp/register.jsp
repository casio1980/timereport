<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <link rel="icon" href="css/favicon.ico">
  <link href="css/bootstrap2/bootstrap.min.css" rel="stylesheet" />
  <link href="css/welcome.css" rel="stylesheet" />
  <link href="css/forms.css" rel="stylesheet" />
  
  <title>Регистрация в системе Таймрепорт</title>

</head>

<body>
<div class="container-narrow">

    <div>
		<jsp:include page="includes/header.jsp" />
    </div>

    <hr />

	<div class="container" style="text-align:center">
	
		<h3>Регистрация временно закрыта</h2>
	
		<!-- 
	    <form role="form" action="login.do" method="post">
	        <% if(request.getParameter("error") != null) { %>
	    	<div class="alert">
	    		<b>Ошибка:</b> Неверный логин/пароль
	    	</div>
   	        <% } %>
	    
	    	<input name="inputEmail" type="text" class="input-block-level" placeholder="Email"/>
	    	<input name="inputPassword" type="password" class="input-block-level" placeholder="Пароль"/>

	        <input class="btn btn-primary" type="submit" value="Войти" />
	    </form>
	     -->
	</div>
	
    <hr />

    <div class="footer row-fluid">
		<jsp:include page="includes/footer.jsp" />
    </div>

</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script type="text/javascript">
	
	$(function() {
		$("a[href='register.do']").parent().addClass("active");		
	});
	
</script>

</body>
</html>
