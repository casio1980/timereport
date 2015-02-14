<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="home.do"><!-- <img alt="home" src="../img/logo-grey.png"> &nbsp;--></a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li <% if (request.getRequestURL().toString().contains("home.do")) out.println("class=\"active\""); %>>
            	<a href="home.do"><b>Мой отчет</b></a>
            </li>
            <li <% if (request.getRequestURL().toString().contains("users.do")) out.println("class=\"active\""); %>>
            	<a href="users.do"><b>Сотрудники</b></a>
            </li>
            <li <% if (request.getRequestURL().toString().contains("projects.do")) out.println("class=\"active\""); %>>
            	<a href="projects.do"><b>Проекты</b></a>
            </li>
            <li <% if (request.getRequestURL().toString().contains("activities.do")) out.println("class=\"active\""); %>>
            	<a href="activities.do"><b>Задачи</b></a>
            </li>
          </ul>
	      <ul class="nav navbar-nav navbar-right">
			<li class="navbar-text">${sessionScope.username}, ${sessionScope.companyname}</li>
			<li><a href="logout.do">Выход</a></li>
		  </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
    
