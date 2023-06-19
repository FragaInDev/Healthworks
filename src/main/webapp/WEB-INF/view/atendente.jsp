<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/styles.css" />'>
<link rel="icon" type="image/svg" href='<c:url value="./resources/icon.svg" />'>
<meta charset="UTF-8">
<title>Pacientes</title>
</head>
<body>
	<header>
		<img src='<c:url value="./resources/logo-branco.svg" />'>
		<span>Pacientes</span>
		<div class="gheader">
			<a class="btn-consulta" href ="consultas">
				<img class="icon-consulta" src='<c:url value="./resources/calendar.svg" />'>
				Gerenciar consultas
			</a>
			<a class="btn-sair" href = "index" onclick="return confirm('Tem certeza que deseja sair?')">
				<img class="icon-sair" src='<c:url value="./resources/sair.svg" />'>
			</a>
		</div>
	</header>
	<div class="content">
		<div class="paciente">
			<a class="btn-add" href="atendenteAddPaci">
				<img class="icon-btnadd" src='<c:url value="./resources/plus.svg" />'>
				Adicionar paciente
			</a>
			<form action="atendente" method="post">
				<div class="busca">
					<input type="text" class="barra-pesquisa" id="ba" name="ba" placeholder="Pesquise o paciente">
					<button type="submit" class="btn-pesquisa" id="botao" name="botao" value="buscar">
						<img class="icon-search" src='<c:url value="./resources/search.svg" />'>
					</button>
				</div>
			</form>
		</div>
		<div>
			<c:if test="${not empty paciente}">
				<table>
				<thead>
					<tr>
						<th>CPF</th>
						<th>Nome</th>
						<th>Código do SUS</th>
						<th>Data de Nascimento</th>
						<th>Email</th>
						<th>Telefone</th>
						<th>Gênero</th>
						<th>Tipo Sanguíneo</th>
						<th>Peso</th>
						<th>Altura</th>
						<th>Ações</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${paciente }" var="p">
						<tr>
							<td><c:out value="${p.cpf }"></c:out></td>
							<td><c:out value="${p.nome }"></c:out></td>
							<td><c:out value="${p.cartaoSUS }"></c:out></td>
							<td><c:out value="${p.dataNasc }"></c:out></td>
							<td><c:out value="${p.email }"></c:out></td>
							<td><c:out value="${p.telefone }"></c:out></td>
							<td><c:out value="${p.genero }"></c:out></td>
							<td><c:out value="${p.tipoSanguineo }"></c:out></td>
							<td><c:out value="${p.peso }"></c:out></td>
							<td><c:out value="${p.altura }"></c:out></td>
							<td>
								<a class="btn-edit" href="<c:url value='/editPaciente/${p.cpf}'/>"><img class="icon-edit" src='<c:url value="./resources/pen.svg" />'></a>
								<a class="btn-remove" href="<c:url value='/deletePaciente/${p.cpf}/${p.email }'/>" onclick="return confirm('Tem certeza que deseja excluir?')">
									<img class="icon-edit" src='<c:url value="./resources/trash.svg" />'>
								</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
				</table>
			</c:if>
		</div>
	</div>
</body>
</html>