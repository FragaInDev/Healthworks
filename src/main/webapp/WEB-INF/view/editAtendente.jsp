<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href='<c:url value="../resources/styles.css" />'>
<link rel="icon" type="image/svg" href='<c:url value="../resources/icon.svg" />'>
<meta charset="ISO-8859-1">
<title>Editar Atendente</title>
</head>
<body>
	<header>
		<a class="btn-voltar" href = "../gestorProfi">
			<img class="icon-voltar" src='<c:url value="../resources/back.svg" />'>
		</a>
		<span>Editar Atendente</span>
		<img src='<c:url value="../resources/logo-branco.svg" />'>
	</header>
	<div class="content">
		<div>
			<h1>Preencha os dados para editar o profissional.</h1>
		</div>
		<div>
			<form action="<c:url value='/editAtendente'/>" method="post">
				<input type="hidden" id="cpf" name="cpf" value="${a.cpf }">
						
				<div class="form-fields">
					<label for="nome">Nome</label>		
					<input type="text" id="nome" name="nome" value="${a.nome }">
				</div>
				
				<div class="form-fields">
					<label for="email">Email</label>
					<input type="text" id="email" name="email" value="${a.email }">
				</div>
				
				<div class="form-fields">
					<label for="senha">Senha</label>
					<input type="password" id="senha" name="senha" value="${a.senha }">
				</div>
				
				<div class="form-fields">
					<label for="telefone">Telefone</label>
					<input type="text" id="telefone" name="telefone" value="${a.telefone }">
				</div>
				
				<div class="form-fields">
					<select id="cargo" name="cargo">
						<option value= "03">Atendente</option>
						<option value= "02">Médico</option>
					</select>
				</div>
		
				<button class="btn-form" type="submit" id="botao" name="botao" value="Atualizar profissional">Atualizar profissional</button>
			</form>
		</div>
	</div>
</body>
</html>