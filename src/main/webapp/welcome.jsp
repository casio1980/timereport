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
  
  <title>Таймрепорт - учет рабочего времени, табель учета рабочего времени, трудоемкость</title>
  
  <!-- Google Analytics -->
  <script>
	  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	
	  ga('create', 'UA-59767009-1', 'auto');
	  ga('send', 'pageview');	
  </script>

</head>

<body>
<div class="container-narrow">

    <div>
		<jsp:include page="includes/header.jsp" />
    </div>

    <hr />

	<div class="jumbotron row">
	    <div class="span9">
	        <h1>Трудоемкость в реальном времени</h1>
	        <div class="brief row">
	            <div class="span3">
	                <b>Таймрепорт</b> - это система учета времени и расчета трудозатрат для организаций и рабочих групп.
	            </div>
	            <div class="span3">
	                Система не требует установки, работает через Интернет и доступна из любой точки мира.
	            </div>
	            <div class="span3" style="border-right: none">
	                Начать пользоваться системой можно за 1 минуту. Именно столько займет регистрация.
	            </div>
	        </div>
	        <div class="subbrief row">
	            <div class="span4 offset1">
	                <a href="demo.do" class="lead">Посмотреть демо-версию</a><br />
	                Без регистрации
	            </div>
	            <div class="span3">
	                <a class="btn btn-large btn-success" href="register.do">Регистрация</a>
	            </div>
	        </div>
	        Есть вопрос? Пишите: <a href="mailto:info@timereport.ru">info@timereport.ru</a>
	    </div>
	    <div class="span3">
	        <img src="img/buddy.png" alt="" />
	    </div>
	</div>
	
	<div class="row marketing">
	    <div class="span9">
	        <h4>Система учета рабочего времени «Таймрепорт»</h4>
	        <p>Учет рабочего времени в системе «Таймрепорт» построен на основе ежедневных отчетов о затраченном времени.
	        Сотрудники и подрядчики вашей организации вносят данные о времени, которое они затратили на различные проекты или работы.
	        После этого система автоматически расчитывает трудоемкость за неделю, месяц и так далее. При этом можно видеть не только суммарную трудоемкость,
	        но и любую ее детализацию. Например, можно посмотреть, сколько времени было затрачено сотрудниками на определенный вид работ в рамках конкретного проекта.</p>
	        <p>К основным возможностям системы относятся:</p>
	        <ul>
	            <li>Поддержка любого количества сотрудников, проектов и видов работ в рамках организации;</li>
	            <li>Предоставление каждому сотруднику персональной страницы с возможностью ежедневно вести учет трудозатрат;</li>
	            <li>Автоматический расчет трудозатрат;</li>
				<!-- 
	            <li>Табель учета рабочего времени Т-13;</li>
	            <li>Экспорт данных в Excel.</li> -->
	        </ul>
	        <p>Чтобы понять, как работает система, воспользуйтесь <a href="demo.do">демо-входом</a>.</p>
	            
	        <h4>Учет рабочего времени и его преимущества</h4>
	        <p>Основной смысл внедрения системы учета рабочего времени состоит в том, что такая система помогает отслеживать фактическую трудоемкость проектов и работ.
	        Назначение такой системы заключается не в том, чтобы фиксировать время прихода сотрудников на работу (хотя это тоже может быть важно), а в том, чтобы помочь определить,
	        какие проекты работают эффективно, а какие нет. Учет трудозатрат позволяет руководителю понять, на что уходит рабочее время его сотрудников.</p>
	        <p>Система учета рабочего времени поможет вам в тех случаях, когда вы:</p>
	        <ul>
	            <li>Часто спрашиваете у своих сотрудников, чем они занимались;</li>
	            <li>Не можете понять, почему так долго выполняется проект;</li>
	            <li>Не знаете как оценить трудоемкость вашего проекта.</li>
	        </ul>
	        <p>Учет трудозатрат даст вам возможность контролировать использование проектных бюджетов. Он позволит обеспечить более качественное планирование сроков выполнения
	        проектов, а также количества необходимых ресурсов. Он также повысит внутреннюю дисциплину сотрудников.</p>
	    </div>
	
	    <div class="span3">
	        <h4>Новости</h4>
	        <p>02.02.2015 - состоялся перезапуск сервиса.</p>
	    </div>
	</div>
	
    <hr />

    <div class="footer row-fluid">
		<jsp:include page="includes/footer.jsp" />
    </div>

</div>	

</body>
</html>
