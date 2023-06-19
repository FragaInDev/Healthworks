<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/styles.css" />'>
<link rel="icon" type="image/svg" href='<c:url value="./resources/icon.svg" />'>
<meta charset="UTF-8">
<title>Adicionar Profissionais</title>
</head>
<body>
	<header>
		<a class="btn-voltar" href = "gestorProfi">
			<img class="icon-voltar" src='<c:url value="./resources/back.svg" />'>
		</a>
		<span>Adicionar Profissionais</span>
		<img src='<c:url value="./resources/logo-branco.svg" />'>
	</header>
	<div class="content">
		<div>
			<h1>Preencha os dados para adicionar o profissional.</h1>
		</div>
		<div>
			<form action="gestorAddProfi" method="post">
				<div class="form">
					<div class="form-fields">
						<label for="cpf">CPF</label>
						<input type="text" id="cpf" name="cpf" placeholder="Digite o cpf">
					</div>
					
					<div class="form-fields">
						<label for="nome">Nome</label>
						<input type="text" id="nome" name="nome" placeholder="Digite o nome">
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
						<select id="cargo" name="cargo" onchange="showHide()">
							<option value= "0">Escolha o cargo</option>
							<option value= "02">Médico</option>
							<option value= "03">Atendente</option>
						</select>
					</div>
					
					<div class="form-fields">
						<input type="text" id="crm" name="crm" style="display: none;" placeholder="Digite o crm">
					</div>
					
					<div class="form-fields">
						<select id="espec" name="espec" style="display: none;">
							<c:forEach items="${especialidade }" var="e">
							<option value="${e.codigo }">${e.nome }</option>
							</c:forEach>
						</select>
					</div>
				</div>
	
				<button class="btn-form" type="submit" id="botao" name="botao" value="Adicionar profissional">Adicionar profissional</button>
			</form>
		</div>
	</div>
	
	<script>
    	function showHide() {
        	var cargo = document.getElementById("cargo").value;
        	var crm = document.getElementById("crm");
        	var espec = document.getElementById("espec");

        	if (cargo === '02') {
           		crm.style.display = "block";
           		espec.style.display = "block";
      		} else {
            	crm.style.display = "none";
            	espec.style.display = "none";
        	}
    	}
    	
    	window.onload = showHide;
	</script>
</body>
</html>