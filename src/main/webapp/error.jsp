<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <link rel="shortcut icon" href="css/favicon.ico" type="image/x-icon" />

  <title>Error : CarsTrends.ru</title>

  <!-- Bootstrap core CSS -->
  <link href="css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="css/signin.css" rel="stylesheet">

  <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
</head>

<body>

  <div class="container">
  
	<div class="row-fluid">
        <div class="span3 centering text-center">
		    <a href="login.jsp"><img src="img/ferrari.png" /></a>
        </div>
    </div>
    
	<div class="row-fluid">
	    <div class="span3 centering text-center">
		    <div class="alert alert-danger" role="alert">Unhandled exception in <b><c:out value="${servletName}"/></b>: <c:out value="${message}"/>.</div>
		    
        </div>
    </div>

  </div> <!-- /container -->

</body>
</html>
