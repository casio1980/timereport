<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <link rel="icon" href="../css/favicon.ico">
  
  <title>Таймрепорт</title>
    
  <!-- Bootstrap core CSS -->
  <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="../css/style.css" rel="stylesheet">
</head>

  <body>

    <div>
		<jsp:include page="../includes/securedHeader.jsp" />
    </div>

    <div id="view" class="container">
    
    </div><!-- /.container -->


    <!-- Core JavaScript
    ================================================== -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.7.0/underscore-min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/backbone.js/1.1.2/backbone-min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/backbone.modelbinder/1.0.5/Backbone.ModelBinder.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/backbone.validation/0.11.3/backbone-validation-min.js"></script>        
    <script src="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <script src="../js/bootstrap-typeahead.min.js"></script>

    <script src="../js/plugins.js"></script>
    <script src="../js/items-list.js"></script>
    
    <script id="addViewTemplate" type="text/template">
            <div class="row">
            <div class="col-md-12">
            <h3>Новая задача</h3>
            </div>
            </div>
            <div class="row">
            <form class="form-horizontal">
                <div class="form-group">
                <label for="name" class="col-sm-2 control-label">Название</label>
                <div class="col-sm-10">
                <input type="text" class="form-control" id="name" name="name" placeholder="Название">
                <span class="help-block hidden"></span>
                </div>
                </div>
                <div class="form-group">
                <label for="description" class="col-sm-2 control-label">Описание</label>
                <div class="col-sm-10">
                <textarea class="form-control" rows="7" id="description" name="description" placeholder="Описание" />
                <span class="help-block hidden"></span>
                </div>
                </div>
                <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                <button type="submit" class="btn btn-success">Добавить</button>
                </div>
                </div>
            </form>
            </div>
	</script>    
    
    <script type="text/javascript">
        ItemsList.init({
            url: "${url}",
            validation: { name: { required: true} },            
            addButtonTitle: "Добавить задачу",
            addViewTemplate: $("#addViewTemplate").text()
        });
    </script>

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <!-- <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script> -->
  </body>
</html>
