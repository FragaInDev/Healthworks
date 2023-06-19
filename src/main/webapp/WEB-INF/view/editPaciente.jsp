<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href='<c:url value="../resources/styles.css" />'>
<link rel="icon" type="image/svg" href='<c:url value="../resources/icon.svg" />'>
<meta charset="UTF-8">
<title>Editar Paciente</title>
</head>
<body>
	<header>
		<a class="btn-voltar" href = "../atendente">
			<img class="icon-voltar" src='<c:url value="../resources/back.svg" />'>
		</a>
		<span>Editar Paciente</span>
		<img src='<c:url value="../resources/logo-branco.svg" />'>
	</header>
	<div class="content">
		<div>
			<form action="<c:url value='/editPaciente'/>" method="post">
				<input type="hidden" id="cpf" name="cpf" value="${p.cpf }">
				
				<div class="form-fields">
					<label for="nome">Nome</label>
					<input type="text" id="nome" name="nome" value="${p.nome }">
				</div>
				
				<div class="form-fields">
					<label for="dataNasc">Data de Nascimento</label>
					<input type="date" id="dataNasc" name="dataNasc" value="${p.dataNasc }">
				</div>
				
				<div class="form-fields">
					<label for="sus">Número do SUS</label>
					<input type="text" id="sus" name="sus" value="${p.cartaoSUS }">
				</div>
				
				<div class="form-fields">
					<label for="email">Email</label>
					<input type="text" id="email" name="email" value="${p.email }">
				</div>
				
				<div class="form-fields">
					<label for="senha">Senha</label>
					<input type="text" id="senha" name="senha" value="${p.senha }">
				</div>
				
				<div class="form-fields">
					<label for="telefone">Telefone</label>
					<input type="text" id="telefone" name="telefone" value="${p.telefone }">
				</div>
				
				<div class="form-fields">
					<label for="genero">Gênero</label>
					<input type="text" id="genero" name="genero" value="${p.genero }">
				</div>
				
				<div class="form-fields">
					<label for="tipoSangue">Tipo sanguíneo</label>
					<select id="tipoSangue" name="tipoSangue">
						<option value= "A+">A+</option>
						<option value= "A-">A-</option>
						<option value= "B+">B+</option>
						<option value= "B-">B-</option>
						<option value= "AB+">AB+</option>
						<option value= "AB-">AB-</option>
						<option value= "O+">O+</option>
						<option value= "O-">O-</option>
					</select>
				</div>
				
				<div class="form-fields">
					<label for="peso">Peso</label>
					<input type="text" id="peso" name="peso" value="${p.peso }">
				</div>
				
				<div class="form-fields">
					<label for="altura">Altura</label>
					<input type="text" id="altura" name="altura" value="${p.altura }">
				</div>
	
				<div class="btns">
					<button class="btn-salvar" type="submit" id="botao" name="botao" value="Salvar">Salvar</button>
					<a class="btn-cancelar" href="atendente">Cancelar</a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>