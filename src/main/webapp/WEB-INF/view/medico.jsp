<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/styles.css" />'>
<link rel="icon" type="image/svg" href='<c:url value="./resources/icon.svg" />'>
<meta charset="UTF-8">
<title>Agenda</title>
</head>
<body>
	<header>
		<img src='<c:url value="./resources/logo-branco.svg" />'>
		<span>Agenda de Consultas</span>
		<div class="gheader">
			<a class="btn-sair" href = "index" onclick="return confirm('Tem certeza que deseja sair?')">
				<img class="icon-sair" src='<c:url value="./resources/sair.svg" />'>
			</a>
		</div>
	</header>
	<div class="content">
		<div>
			<h1>Olá, aqui está sua agenda!</h1>
			
			<form action="medico" method="post">
				<div class="busca">
					<input type="hidden" id="email" name="email" value="${param.email}">
					<input type="text" class="barra-pesquisa" id="barra" name="barra" placeholder="Pesquise a consulta por paciente ou data">
					<button type="submit" class="btn-pesquisa" id="botao" name="botao" value="buscar"><img class="icon-search" src='<c:url value="./resources/search.svg" />'></button>
				</div>
			</form>
		</div>
		<div class="consulta">
			<c:if test="${not empty consulta}">
				<table>
				<thead>
					<tr>
						<th style="display: none;">ID</th>
						<th>Data</th>
						<th>Hora</th>
						<th>Paciente</th>
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
							<td>
								<a class="btn-info" href="<c:url value='/info/${c.cod}'/>">
									<img class="icon-info" src='<c:url value="./resources/info.svg" />'>
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