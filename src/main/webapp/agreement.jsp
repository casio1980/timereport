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

</head>

<body>
<div class="container-narrow">

    <div>
		<jsp:include page="includes/header.jsp" />
    </div>

    <hr />

	<div class="row">
	    <div>
	        <h2>Пользовательское соглашение</h2>
	        <h3>1. Общие положения</h3>
	        <p>1.1. Настоящее Соглашение регламентирует отношения между ООО "Таймрепорт" (далее - Администрация) и физическим или юридическим лицом (далее - Пользователем) по использованию аккаунта, зарегистрированного на сайте <a href="http://timereport.ru/">timereport.ru</a>.</p>
	        <p>1.2. Соглашение вступает в силу с момента выражения Пользователем согласия с его условиями путем регистрации до момента заключения договора на оказание услуг.</p>
	
	        <h3>2. Условия пользования Аккаунтом</h3>
	        <p>2.1. Сервис Таймрепорт (далее - Сервис) является услугой, обеспечивающей учет рабочего времени (трудозатрат) при помоши веб-интерфейса.</p>
	        <p>2.2. При регистрации (создании аккаунта) на сайте <a href="http://timereport.ru/">timereport.ru</a>, Пользователь обязуется предоставить достоверную и полную информацию о себе по вопросам, предлагаемым в Регистрационной форме, и поддерживать ее в актуальном состоянии. Если Пользователь предоставляет неверную информацию, Администрация имеет право заблокировать либо удалить аккаунт Пользователя и отказать ему в предоставлении услуг.</p>
	        <p>2.3. Пользователь единолично несет ответственность за свои действия при пользовании услугами сервиса, включая, помимо прочего, оплату стоимости доступа к интернету в процессе такого использования.</p>
	        <p>2.4. Пользователь обязуется не воспроизводить, не копировать, не продавать, не перепродавать и не использовать для каких-либо коммерческих целей какую-либо часть услуг или контента, пользование услугами, либо доступ к услугам и контенту аккаунта.</p>
	        <p>2.5. Регистрируясь на сайте <a href="http://timereport.ru/">timereport.ru</a>, Пользователь подтверждает свое согласие на обработку своих персональных данных, переданных Администрации. Администрация обязуется не продавать и не предоставлять личные данные Пользователя третьим лицам ни при каких обстоятельствах, за исключением случаев поступления запроса на предоставление подобной информации со стороны суда, правоохранительных органов и в иных предусмотренных законодательством Российской Федерации случаях.</p>
	        <p>2.6. Администрация оставляет за собой право в любой момент изменить, приостановить или прекратить предоставление услуг полностью или частично без предварительного уведомления. Пользователь освобождает Администрацию от ответственности  за любое изменение, ограничение или прекращение предоставления услуг.</p>
	        <p>2.7. Пользователь соглашается с тем, что Администрация по своему собственному усмотрению может удалить его аккаунт, а также любую информацию, относящуюся к предоставляемым услугам, по какой бы то ни было причине в любое время без предварительного уведомления.</p>
	        <p>2.8. Администрация имеет право на одностороннее изменение положений Соглашения. Действующая версия Соглашения всегда находится на странице по адресу <a href="http://timereport.ru/web/agreement.jsp">timereport.ru/web/agreement.jsp</a>.</p>
	        <p>2.9. Несоблюдение условий настоящего Соглашения может повлечь за собой блокирование аккаунта Пользователя.</p>
	
	        <h3>3. Ответственность Пользователя и Администрации</h3>
	        <p>3.1. Пользователь несет полную ответственность за размещенную им на аккаунте информацию, а также  любые материалы или информацию, переданную другим пользователям. Пользователь гарантирует, что размещаемая им информация не нарушают прав и интересов других лиц и требования законодательства.</p>
	        <p>3.2. Пользователь использует Сервис на свой собственный риск. Администрация не принимает на себя никакой ответственности, в том числе и за соответствие своих сервисов цели Пользователя.</p>
	        <p>3.3. Пользователь понимает и соглашается с тем, что Администрация не несет ответственности за любые прямые или непрямые убытки (даже в том случае, если Администрация была предупреждена о возможности ущерба), понесенные в результате использования или невозможности использования аккаунта либо любого другого случая, имеющего отношение к услугам Сервиса.</p>
	
	        <h3>4. Заключительные положения</h3>
	        <p>4.1. Соглашение является юридически обязывающим договором между Пользователем и Администрацией.</p>
	        <p>4.2. Применимым правом по настоящему Соглашению является право Российской Федерации. Все споры по поводу Соглашения разрешаются согласно действующему законодательству Российской Федерации по месту нахождения Администрации.</p>
	        <p>4.3. Ввиду безвозмездности услуг, оказываемых в рамках Соглашения, нормы о защите прав потребителей не могут быть к нему применимы.</p>
	        <p>4.4. Признание судом какого-либо положения Соглашения недействительным не влечет за собой недействительности иных положений Соглашения.</p>
	    </div>
	
	</div>
	
    <hr />

    <div class="footer row-fluid">
		<jsp:include page="includes/footer.jsp" />
    </div>

</div>	

</body>
</html>
