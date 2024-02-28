<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="vo.Member"%>	
<head>
<link rel="stylesheet" href="${path}/com/vendors/mdi/css/materialdesignicons.min.css">
</head>
<nav class="sidebar sidebar-offcanvas" id="sidebar">
	<ul class="nav">
		<li class="nav-item">
			<button type="button" class="btn btn-secondary" onclick="location.href='${path}/mainpage/writer.jsp'">글쓰기</button>
		</li>
		<li class="nav-item"><a class="nav-link"
			href="${path}/mainpage/index.jsp"> <i
				class="ti-home menu-icon"></i> <span class="menu-title">HOME</span>
		</a></li>
		<li class="nav-item"><a class="nav-link"
			href="${path}/UserCommunity_cms/userIndex.jsp"> <i
				class="ti-menu-alt menu-icon"></i> <span class="menu-title">전체글보기</span>
		</a></li>
		<li class="nav-item"><a class="nav-link"
			href="${path}/UserCommunity_cms/userIndex.jsp?board=공지"> <i
				class="icon-paper menu-icon"></i> <span class="menu-title">공지글보기</span>
		</a></li>
		<li class="nav-item"><a class="nav-link"
			href="${path}/Board_okw/onBoard_Map.jsp"> <i
				class="ti-map-alt menu-icon"></i> <span class="menu-title">맛집정보공유</span>
		</a></li>
		<li class="nav-item"><a class="nav-link" data-toggle="collapse"
			href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
				<i class="icon-layout menu-icon"></i> <span class="menu-title">지역별 커뮤니티</span> <i class="menu-arrow"></i>
		</a>
			<div class="collapse" id="ui-basic">
				<ul class="nav flex-column sub-menu">
					<li class="nav-item"><a class="nav-link"
						href="${path}/UserCommunity_cms/userIndex.jsp?board=지역별 커뮤니티(서울)">서울</a></li>
					<li class="nav-item"><a class="nav-link"
						href="${path}/UserCommunity_cms/userIndex.jsp?board=지역별 커뮤니티(경기/인천)">경기/인천</a></li>
					<li class="nav-item"><a class="nav-link"
						href="${path}/UserCommunity_cms/userIndex.jsp?board=지역별 커뮤니티(충청/강원/제주)">충청/강원/제주</a></li>
					<li class="nav-item"><a class="nav-link"
						href="${path}/UserCommunity_cms/userIndex.jsp?board=지역별 커뮤니티(전라/경상)">전라/경상</a></li>
				</ul>
			</div></li>
		<li class="nav-item"><a class="nav-link"
			href="${path}/UserCommunity_cms/userIndex.jsp?board=잡담"> <i
				class="ti-comment-alt menu-icon"></i> <span class="menu-title">잡담</span>
		</a></li>
		
	
	</ul>
</nav>