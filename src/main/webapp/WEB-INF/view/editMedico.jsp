<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href='<c:url value="../resources/styles.css" />'>
<link rel="icon" type="image/svg" href='<c:url value="../resources/icon.svg" />'>
<meta charset="ISO-8859-1">
<title>Editar Medico</title>
</head>
<body>
	<header>
		<a class="btn-voltar" href = "../gestorProfi">
			<img class="icon-voltar" src='<c:url value="../resources/back.svg" />'>
		</a>
		<span>Editar Médico</span>
		<img src='<c:url value="../resources/logo-branco.svg" />'>
	</header>
	<div class="content">
		<div>
			<h1>Preencha os dados para editar o profissional.</h1>
		</div>
		<div>
			<form action="<c:url value='/editMedico'/>" method="post">
				<input type="hidden" id="crm" name="crm" value="${m.crm }">
				
				<div class="form-fields">
					<label for="cpf">CPF</label>
					<input type="text" id="cpf" name="cpf" value="${m.cpf }">
				</div>
				
				<div class="form-fields">
					<label for="nome">Nome</label>		
					<input type="text" id="nome" name="nome" value="${m.nome }">
				</div>
				
				<div class="form-fields">
					<label for="email">Email</label>
					<input type="text" id="email" name="email" value="${m.email }">
				</div>

				<div class="form-fields">
					<label for="senha">Senha</label>
					<input type="password" id="senha" name="senha" value="${m.senha }">
				</div>
				
				<div class="form-fields">
					<label for="telefone">Telefone</label>
					<input type="text" id="telefone" name="telefone" value="${m.telefone }">
				</div>
				
				<div class="form-fields">
					<select id="espec" name="espec">
						<c:forEach items="${especialidade }" var="e">
							<option value="${e.codigo }">${e.nome }</option>
						</c:forEach>
					</select>
				</div>
				
				<div class="form-fields">
					<select id="cargo" name="cargo">
						<option value= "02">Médico</option>
						<option value= "03">Atendente</option>
					</select>
				</div>
				
				<button class="btn-form" type="submit" id="botao" name="botao" value="Atualizar profissional">Atualizar profissional</button>
		</form>
		</div>
	</div>
</body>
</html>