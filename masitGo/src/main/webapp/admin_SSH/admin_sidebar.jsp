<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
<link rel="stylesheet" href="${path}/com/vendors/mdi/css/materialdesignicons.min.css">
</head>

<style>
 .goodButton{
 	background-color: #003ea8;
 	color: white;
 	margin: 10%;
 	border-radius:20px;
 	font-size: 20px;
 	border:none;
 	padding: 5%;
 }
</style>

<nav class="sidebar sidebar-offcanvas" id="sidebar">
	<ul class="nav">
		<li class="nav-item">
			<button type="button" class="goodButton" 
			onclick="location.href='${path}/admin_SSH/admin_members.jsp'">회원정보 조회</button>
		</li>
		<li class="nav-item">
			<button type="button" class="goodButton" 
			onclick="location.href='${path}/admin_SSH/admin_report.jsp'">신고글 관리</button>
		</li>
	</ul>
</nav>