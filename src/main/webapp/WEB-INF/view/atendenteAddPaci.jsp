<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/styles.css" />'>
<link rel="icon" type="image/svg" href='<c:url value="./resources/icon.svg" />'>
<meta charset="UTF-8">
<title>Novo Paciente</title>
</head>
<body>
	<header>
		<a class="btn-voltar" href = "atendente">
			<img class="icon-voltar" src='<c:url value="./resources/back.svg" />'>
		</a>
		<span>Adicionar Paciente</span>
		<img src='<c:url value="./resources/logo-branco.svg" />'>
	</header>
	<div class="content">
		<div>
			<h1>Preencha os dados para adicionar um paciente.</h1>
		</div>
		<div>
			<form action="atendenteAddPaci" method="post">
				<div class="form-fields">
					<label for="cpf">CPF</label>
					<input type="text" id="cpf" name="cpf" placeholder="Digite o cpf">
				</div>
				
				<div class="form-fields">
					<label for="nome">Nome</label>
					<input type="text" id="nome" name="nome" placeholder="Digite o nome">
				</div>
				
				<div class="form-fields">
					<label for="dataNasc">Data de Nascimento</label>
					<input type="date" id="dataNasc" name="dataNasc" placeholder="Selecione a data">
				</div>
				
				<div class="form-fields">
					<label for="sus">Número do SUS</label>
					<input type="text" id="sus" name="sus" placeholder="Digite os 15 números">
				</div>
				
				<div class="form-fields">
					<label for="email">Email</label>
					<input type="text" id="email" name="email" placeholder="Digite o email">
				</div>
				
				<div class="form-fields">
					<label for="senha">Senha</label>
					<input type="password" id="senha" name="senha" placeholder="Digite a senha">
				</div>
				
				<div class="form-fields">
					<label for="telefone">Telefone</label>
					<input type="text" id="telefone" name="telefone" placeholder="Digite o telefone">
				</div>
				
				<div class="form-fields">
					<label for="genero">Gênero</label>
					<input type="text" id="genero" name="genero" placeholder="Digite o genero">
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
					<input type="text" id="peso" name="peso" placeholder="Digite o peso">
				</div>
				
				<div class="form-fields">
					<label for="altura">Altura</label>
					<input type="text" id="altura" name="altura" placeholder="Digite a altura">
				</div>			
			
				<button class="btn-form" type="submit" id="botao" name="botao" value="Adicionar paciente">Adicionar paciente</button>
			</form>
		</div>
	</div>
</body>
</html>