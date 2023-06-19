<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/styles.css" />'>
<meta charset="UTF-8">
<title>Healthworks | Gestor</title>
</head>
<body>
	<header>
			<img src='<c:url value="./resources/logo-branco.svg" />'>
			<div class="gheader">
				<span>Olá, seja bem vindo!</span>
				<a class="btn-sair" href = "index" onclick="return confirm('Tem certeza que deseja sair?')">
					<img class="icon-sair" src='<c:url value="./resources/sair.svg" />'>
				</a>
			</div>
	</header>
	<div class="content">
		<h1>O que você precisa fazer hoje?</h1>
		<div class="opgestor">
			<div class="opgestorbtn">
				<a class="btn-opgestor" href = "gestorProfi">
					<img class="icon-users" src='<c:url value="./resources/users.svg" />'>
					Gerenciar Profissionais
				</a>
			</div>
			<div class="opgestorbtn">
				<a class="btn-opgestor" href = "gestorEspec">
					<img class="icon-users" src='<c:url value="./resources/hospital.svg" />'>
					Gerenciar Especialidades
				</a>
			</div>
		</div>
	</div>
</body>
</html>