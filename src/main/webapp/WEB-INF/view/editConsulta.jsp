<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href='<c:url value="../resources/styles.css" />'>
<link rel="icon" type="image/svg" href='<c:url value="../resources/icon.svg" />'>
<meta charset="UTF-8">
<title>Editar Consulta</title>
</head>
<body>
	<header>
		<a class="btn-voltar" href = "consultas">
			<img class="icon-voltar" src='<c:url value="../resources/back.svg" />'>
		</a>
		<span>Editar Consulta</span>
		<img src='<c:url value="../resources/logo-branco.svg" />'>
	</header>
	<div class="content">
		<div>
			<form action="<c:url value='/editConsulta'/>" method="post">
				<div class="form">
				
					<input type="hidden" id="cod" name="cod" value="${c.cod }">
					
					<div class="form-fields">
						<label for="cpf">CPF</label>
						<input type="text" id="cpf" name="cpf" value="${c.paciente }">
					</div>
					
					<div class="form-fields">
						<label for="data">Data da consulta</label>
						<input type="date" id="data" name="data" value="${c.data }">
					</div>
					
					<div class="form-fields">
						<label for="hora">Horário da consulta</label>
						<input type="time" id="hora" name="hora" value="${c.hora }">
					</div>
					
					<div class="form-fields">
						<label for="medico">Selecione o profissional</label>
						<select id="medico" name="medico">
							<c:forEach items="${medico }" var="m">
							<option value="${m.crm }">${m.nome }</option>
							</c:forEach>
						</select>
					</div>
					
					<div class="form-fields">
						<label for="espec">Selecione a especialidade</label>
						<select id="espec" name="espec">
							<c:forEach items="${especialidade }" var="e">
							<option value="${e.codigo }">${e.nome }</option>
							</c:forEach>
						</select>
					</div>
				</div>
	
				<div class="btns">
						<button class="btn-salvar" type="submit" id="botao" name="botao" value="Salvar">Salvar</button>
						<a class="btn-cancelar" href="../consultas">Cancelar</a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>