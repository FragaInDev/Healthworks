<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href='<c:url value="../resources/styles.css" />'>
<link rel="icon" type="image/svg" href='<c:url value="../resources/icon.svg" />'>
<meta charset="UTF-8">
<title>Informações</title>
</head>
<body>
	<header>
		<a class="btn-voltar" onclick="voltar()">
			<img class="icon-voltar" src='<c:url value="../resources/back.svg" />'>
		</a>
		<span>Informações do Paciente</span>
		<img src='<c:url value="../resources/logo-branco.svg" />'>
	</header>
	<div class="content">
		<div class="form-fields">
			<label for="nome">Nome</label>
			<input type="text" id="nome" name="nome" value="${p.nome }" readonly>
		</div>
		
		<div class="form-fields">
			<label for="dataNasc">Data de Nascimento</label>
			<input type="date" id="dataNasc" name="dataNasc" value="${p.dataNasc }" readonly>
		</div>
		
		<div class="form-fields">
			<label for="genero">Gênero</label>
			<input type="text" id="genero" name="genero" value="${p.genero }" readonly>
		</div>
		
		<div class="form-fields">
			<label for="altura">Altura</label>
			<input type="text" id="altura" name="altura" value="${p.altura }" readonly>
		</div>
		
		<div class="form-fields">
			<label for="peso">Peso</label>
			<input type="text" id="peso" name="peso" value="${p.peso }" readonly>
		</div>
		
		<div class="form-fields">
			<label for="tipoSangue">Tipo sanguíneo</label>
			<input type="text" id="tipoSangue" name="tipoSangue" value="${p.peso }" readonly>
		</div>
	</div>
	
	<script>
	    function voltar() {
	      history.back();
	    }
  	</script>
</body>
</html>