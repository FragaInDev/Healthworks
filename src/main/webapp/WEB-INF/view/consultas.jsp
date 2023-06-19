<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/styles.css" />'>
<link rel="icon" type="image/svg" href='<c:url value="./resources/icon.svg" />'>
<meta charset="UTF-8">
<title>Consultas</title>
</head>
<body>
	<header>
		<img src='<c:url value="./resources/logo-branco.svg" />'>
		<span>Agenda de Consultas</span>
		<div class="gheader">
			<a class="btn-paciente" href = "atendente">
				<img class="icon-paciente" src='<c:url value="./resources/heartbeat.svg" />'>
				Gerenciar pacientes
			</a>
			<a class="btn-sair" href = "index" onclick="return confirm('Tem certeza que deseja sair?')">
				<img class="icon-sair" src='<c:url value="./resources/sair.svg" />'>
			</a>
		</div>
	</header>
	<div class="content">
		<div class="menu-consulta">
			<a class="btn-add" href="consultaAdd">
				<img class="icon-btnadd" src='<c:url value="./resources/plus.svg" />'>
				Adicionar consulta
			</a>
			
			<form action="consultas" method="post">
				<div class="busca">
					<input type="text" class="barra-pesquisa" id="barra" name="barra" placeholder="Pesquise o paciente, a data ou o médico">
					<button type="submit" class="btn-pesquisa" id="botao" name="botao" value="buscar"><img class="icon-search" src='<c:url value="./resources/search.svg" />'></button>
				</div>
			</form>
		</div>
		<c:if test="${not empty consulta}">
			<table>
				<thead>
					<tr>
						<th style="display: none;">ID</th>
						<th>Data</th>
						<th>Horário</th>
						<th>Paciente</th>
						<th>Médico</th>
						<th>Especialidade</th>
						<th>Ações</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${consulta }" var="c">
						<tr>
							<td style="display: none;"><c:out value="${c.cod }"></c:out></td>
							<td><c:out value="${c.data }"></c:out></td>
							<td><c:out value="${c.hora }"></c:out></td>
							<td><c:out value="${c.paciente }"></c:out></td>
							<td><c:out value="${c.medico }"></c:out></td>
							<td><c:out value="${c.especialidade }"></c:out></td>
							<td>
								<a class="btn-edit" href="<c:url value='/editConsulta/${c.cod}'/>"><img class="icon-edit" src='<c:url value="./resources/pen.svg" />'></a>
								<a class="btn-remove" href="<c:url value='/deleteConsulta/${c.cod}'/>" onclick="return confirm('Tem certeza que deseja excluir?')">
									<img class="icon-edit" src='<c:url value="./resources/trash.svg" />'>
								</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
</body>
</html>