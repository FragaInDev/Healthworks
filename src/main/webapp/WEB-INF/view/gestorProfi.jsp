<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/styles.css" />'>
<link rel="icon" type="image/svg" href='<c:url value="./resources/icon.svg" />'>
<meta charset="UTF-8">
<title>Gerenciar Profissionais</title>
</head>
<body>
	<header>
		<img src='<c:url value="./resources/logo-branco.svg" />'>
		<span>Profissionais</span>
		<div class="gheader">
			<a class="btn-menu" href = "gestor">
				<img class="icon-menu" src='<c:url value="./resources/bars.svg" />'>
				Menu
			</a>
			<a class="btn-sair" href = "index" onclick="return confirm('Tem certeza que deseja sair?')">
				<img class="icon-sair" src='<c:url value="./resources/sair.svg" />'>
			</a>
		</div>
	</header>
	<div class="content">
		<div>
			<h1>Painel de Profissionais</h1>
			<a class="btn-add" href="gestorAddProfi">
				<img class="icon-btnadd" src='<c:url value="./resources/plus.svg" />'>
				Adicionar profissional
			</a>
		</div>
		<div class="tables">
			<div>
				<div class="atendente">
					<h2>Atendentes</h2>
					<form action="gestorProfi" method="post">
						<div class="busca">
							<input type="text" class="barra-pesquisa" id="ba" name="ba" placeholder="Pesquise o atendente">
							<button type="submit" class="btn-pesquisa" id="botao" name="botao" value="buscar atendente"><img class="icon-search" src='<c:url value="./resources/search.svg" />'></button>
						</div>
					</form>
				</div>
				
				<c:if test="${not empty atendente}">
					<table>
					<thead>
						<tr>
							<th>CPF</th>
							<th>Nome</th>
							<th>Email</th>
							<th>Telefone</th>
							<th>Ações</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${atendente }" var="a">
							<tr>
								<td><c:out value="${a.cpf }"></c:out></td>
								<td><c:out value="${a.nome }"></c:out></td>
								<td><c:out value="${a.email }"></c:out></td>
								<td><c:out value="${a.telefone }"></c:out></td>
								<td>
									<a class="btn-edit" href="<c:url value='/editAtendente/${a.cpf}'/>"><img class="icon-edit" src='<c:url value="./resources/pen.svg" />'></a>
									<a class="btn-remove" href="<c:url value='/deleteAtendente/${a.cpf}/${a.email }'/>" onclick="return confirm('Tem certeza que deseja excluir?')">
										<img class="icon-edit" src='<c:url value="./resources/trash.svg" />'>
									</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
					</table>
				</c:if>
			</div>
			<div>
				<div class="medico">
					<h2>Médicos</h2>
					<form action="gestorProfi" method="post">
						<div class="busca">
							<input type="text" class="barra-pesquisa" id="bm" name="bm" placeholder="Pesquise o médico">
							<button type="submit" class="btn-pesquisa" id="botao" name="botao" value="buscar medico"><img class="icon-search" src='<c:url value="./resources/search.svg" />'></button>
						</div>
					</form>
				</div>
				<c:if test="${not empty medico}">
					<table>
					<thead>
						<tr>
							<th>CRM</th>
							<th>Nome</th>
							<th>Email</th>
							<th>Telefone</th>
							<th>Especialidade</th>
							<th>Ações</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${medico }" var="m">
							<tr>
								<td><c:out value="${m.crm }"></c:out></td>
								<td><c:out value="${m.nome }"></c:out></td>
								<td><c:out value="${m.email }"></c:out></td>
								<td><c:out value="${m.telefone }"></c:out></td>
								<td><c:out value="${m.especialidade }"></c:out></td>
								<td>
									<a class="btn-edit" href="<c:url value='/editMedico/${m.crm}'/>"><img class="icon-edit" src='<c:url value="./resources/pen.svg" />'></a>
									<a class="btn-remove" href="<c:url value='/deleteMedico/${m.crm}/${m.email }'/>" onclick="return confirm('Tem certeza que deseja excluir?')">
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
		
	</div>
	
</body>
</html>