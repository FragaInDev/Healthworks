<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href='<c:url value="../../resources/styles.css" />'>
<link rel="icon" type="image/svg" href='<c:url value="../../resources/icon.svg" />'>
<meta charset="UTF-8">
<title>Editar Especialidade</title>
</head>
<body>
	<header>
		<a class="btn-voltar" href = "../../gestorEspec">
			<img class="icon-voltar" src='<c:url value="../../resources/back.svg" />'>
		</a>
		<span>Editar Especialidade</span>
		<img src='<c:url value="../../resources/logo-branco.svg" />'>
	</header>
	<div class="content">
		<div>
			<form action="<c:url value='/editEspec'/>" method = "post">
				<div class="form-fields">
					<label for="espec-nome">Nome da especialidade</label>
					<input type="hidden" id="cod" name="cod" value="${e.codigo }">
					<input type="text" id="espec-nome" name="espec-nome" value="${e.nome }">
				</div>
				<div class="btns">
						<button class="btn-salvar" type="submit" id="botao" name="botao" value="Salvar">Salvar</button>
						<a class="btn-cancelar" href="gestorEspec">Cancelar</a>
				</div>
			</form>
		</div>
	</div>
	
</body>
</html>