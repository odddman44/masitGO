<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row" >
<style>
	#quick {
  	color: white;
  	text-decoration-line: none;
	}

</style>
	<div
		class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
		<a class="navbar-brand brand-logo mr-5" href="${path}/mainpage/index.jsp"><img
			src="${path}/com/images/masitGO_long.png" class="mr-2" alt="logo" /></a> <a
			class="navbar-brand brand-logo-mini" href="${path}/mainpage/index.jsp"><img
			src="${path}/com/images/masitGo_logo.png" alt="logo" /></a>
	</div>
	<div
		class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
		<button class="navbar-toggler navbar-toggler align-self-center"
			type="button" data-toggle="minimize">
			<span class="icon-menu"></span>
		</button>
		<%
		HttpSession sess = request.getSession();
		Member member = (Member) session.getAttribute("m01");
		if (member !=null){
		%>
		<ul class="navbar-nav navbar-nav-right">
			<li class="nav-item nav-settings d-none d-lg-flex">
				<%
				if (member !=null && "관리자".equals(member.getName())){
				%>
				<li class="nav-item nav-settings d-none d-lg-flex"><i class="ti-user menu-icon"></i>
				<a href="${path}/admin_SSH/admin.jsp" id="quick">&nbsp관리자페이지&nbsp&nbsp&nbsp&nbsp&nbsp</a></li>
					<%
					}
					%>
			</li>
		
			<li class="nav-item nav-profile dropdown"><a
				class="nav-link dropdown-toggle" href="#" data-toggle="dropdown"
				id="profileDropdown"> <img
					src="${path}/com/images/faces/face30.png" alt="profile" />
					<!-- 로그인 이미지 첨부 -->
			</a>
			<div class="dropdown-menu dropdown-menu-right navbar-dropdown"
					aria-labelledby="profileDropdown">
					<a class="dropdown-item" href="${path}/login_jsr/mypage.jsp"> <i class="mdi mdi-account text-primary"></i>
						마이페이지
					</a> <a class="dropdown-item" href="${path}/login_jsr/logoutAction.jsp"> <i class="ti-power-off text-primary"></i>
						로그아웃
					</a>
				</div></li>
				<li class="nav-item nav-settings d-none d-lg-flex" id="quick"><%=member.getName() %>님이 로그인중입니다.
			<%
			} else {
			%>		
			<ul class="navbar-nav navbar-nav-right">
			<li class="nav-item nav-profile dropdown"><a
				class="nav-link dropdown-toggle" href="#" data-toggle="dropdown"
				id="profileDropdown"> <img
					src="${path}/com/images/faces/face30.png" alt="profile" />
			</a>
				<div class="dropdown-menu dropdown-menu-right navbar-dropdown"
					aria-labelledby="profileDropdown">
					<a class="dropdown-item" href="${path}/login_jsr/register.jsp"> <i class="ti-settings text-primary"></i>
						회원가입
					</a> <a class="dropdown-item" href="${path}/login_jsr/login.jsp"> <i class="ti-power-off text-primary"></i>
						로그인
					</a>
				</div></li>
				<%
				}
				%>
			<!--
			<a class="nav-link" href="#"> 
				<i class="icon-ellipsis"></i> 세팅옵션 기능 사용시 주석해제
			</a>
			-->
			</li>
		</ul>
		<button
			class="navbar-toggler navbar-toggler-right d-lg-none align-self-center"
			type="button" data-toggle="offcanvas">
			<span class="icon-menu"></span>
		</button>
	</div>
</nav>