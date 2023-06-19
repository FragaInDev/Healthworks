<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/styles.css" />'>
<link rel="icon" type="image/svg" href='<c:url value="./resources/icon.svg" />'>
<meta charset="UTF-8">
<title>Gerenciar Especialidades</title>
</head>
<body>
	<header>
		<img src='<c:url value="./resources/logo-branco.svg" />'>
		<span>Especialidades</span>
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
			<h1>Controle de especialidades</h1>
			
			<form action="gestorEspec" method = "post">
				<div class="form-fields">
					<label for="espec-nome">Nova especialidade</label>
					<div class="busca">
						<input type="text" id="espec-nome" name="espec-nome" placeholder="Digite a especialidade">
						<button type="submit" class="btn-pesquisa" id="botao" name="botao" value="adicionar"><img class="icon-plus" src='<c:url value="./resources/plus.svg" />'></button>
					</div>
				</div>	
			</form>
		</div>
		<div class="table-espec">
			<c:if test="${not empty especialidade}">
				<table>
				<thead>
					<tr>
						<th>Codigo</th>
						<th>Especialidade</th>
						<th>Ações</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${especialidade }" var="e">
						<tr>
							<td><c:out value="${e.codigo }"></c:out></td>
							<td><c:out value="${e.nome }"></c:out></td>
							<td>
								<a class="btn-edit" href="<c:url value='/editEspec/${e.codigo}/${e.nome }'/>"><img class="icon-edit" src='<c:url value="./resources/pen.svg" />'></a>
								<a class="btn-remove" href="<c:url value='/deleteEspec/${e.codigo}'/>" onclick="return confirm('Tem certeza que deseja excluir?')">
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