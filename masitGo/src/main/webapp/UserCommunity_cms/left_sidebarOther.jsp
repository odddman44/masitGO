<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
<link rel="stylesheet" href="${path}/com/vendors/mdi/css/materialdesignicons.min.css">
</head>
<nav class="sidebar sidebar-offcanvas" id="sidebar">
	<ul class="nav">
		<li class="nav-item"><a class="nav-link"
			href="${path}/mainpage/index.jsp"> <i
				class="ti-home menu-icon"></i> <span class="menu-title">HOME</span>
		</a></li>
		<li class="nav-item"><a class="nav-link"
			href="${path}/login_jsr/myPost.jsp"> <i
				class="mdi mdi-file-document-box menu-icon"></i> <span class="menu-title">게시글 조회</span>
		</a></li>
		<li class="nav-item"><a class="nav-link"
			href="${path}/login_jsr/myComent.jsp"> <i
				class="mdi mdi-comment-processing menu-icon"></i> <span class="menu-title">댓글 목록 조회</span>
		</a></li>
	</ul>
</nav>