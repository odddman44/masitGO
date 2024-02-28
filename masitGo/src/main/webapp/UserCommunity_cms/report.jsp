<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*" import="vo.*"
	import="database.MsDao"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html lang="en">

<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>����GO</title>
<!-- plugins:css -->
<link rel="stylesheet" href="${path}/com/vendors/feather/feather.css">
<link rel="stylesheet"
	href="${path}/com/vendors/ti-icons/css/themify-icons.css">
<link rel="stylesheet"
	href="${path}/com/vendors/css/vendor.bundle.base.css">
<!-- endinject -->
<!-- Plugin css for this page -->
<link rel="stylesheet"
	href="${path}/com/vendors/datatables.net-bs4/dataTables.bootstrap4.css">
<link rel="stylesheet"
	href="${path}/com/vendors/ti-icons/css/themify-icons.css">
<link rel="stylesheet" type="text/css"
	href="path/com/js/select.dataTables.min.css">
<!-- End plugin css for this page -->
<!-- inject:css -->
<link rel="stylesheet"
	href="${path}/com/css/vertical-layout-light/style.css">
<link rel="stylesheet"
	href="${path}/com/css/vertical-layout-light/custom_style.css">
<!-- endinject -->
<link rel="shortcut icon" href="path/com/images/favicon.png" />
</head>
<style>
fieldset{
	border: 2px solid blue;
	width:500px;
	height:700px;
}
#repBtn{
	width:100%;
}
legend{
	text-align:center;
	color:red;
	font-weight:border;
}
#reportInfo{
	margin-bottom:50px;
	margin-left:10px;
}
#resons{
	margin-left:10px;
}
</style>
<%
	// member session 가져오기
	Member m01 = (Member)session.getAttribute("m01");
	// 로그인한 member session이 존재하면
	 String id = (m01 != null) ? m01.getId() : null; // 로그인한 객체가 없으면 id는 member
	 System.out.println(id);
	 String jsVariable = (id != null) ? "'" + id + "'" : "null";
	 String post_idStr = request.getParameter("post_id"); // post_id 가져오기
	 int post_id = -1; // 존재하지 않는 post_id로 초기화
	 String title = "";
	 String writer = "";
	 if(post_idStr!=null) post_id = Integer.parseInt(post_idStr);
	 if(post_id!=-1){
		 MsDao dao = new MsDao();
		 PostDTO post = null;
		 if(dao.getPostByPost_id(post_id)!=null) post = dao.getPostByPost_id(post_id); // dao의 객체가 있으면 post객체에 할당
		 writer = post.getId(); // 작성자 id가져오기
		 title = post.getTitle(); // 작성글 제목 가져오기
	 }
%>
<script src="jquery-3.6.0.js"></script>
	<script type="text/javascript">
	// url에서 특정 요소 찾아오는 함수
	function getParameterByName(name) {
	    var url = new URL(window.location.href);
	    return url.searchParams.get(name);
	}
	var id=<%=jsVariable%>
	console.log(id)
	// url에서 post_id 찾아오기
	var post_id = getParameterByName("post_id")
	console.log(post_id)
	// 신고 사유 가져오기

	
		$(document).ready(function(){
			$("#repBtn").click(function(){
				var reason = $("input[name=reason]:checked").val();
				$("input[name=post_id]").val(post_id); // 포스트 아이디값 넣기
				$("input[name=id]").val(id); // 신고자 아이디값 넣기
				console.log("신고사유"+reason)
				if(reason === undefined){
					alert("신고 사유를 선택해주세요")
				}else{
					// alert($("form").serialize())
					// 신고 사유를 선택했을 때
					$.ajax({
						// 신고 기능 수행
						url: "z04_report.jsp",
						data: $("form").serialize(),
						dataType: "json",
						success: function(data){
							var insReport = data.insReport;
							if(insReport > 0){
								alert("신고완료!");
								// 현재 창 닫기
								window.close()
								
							}
						},
						error: function(err){
							console.log(err);
						}
					});
					
				}
			})
		})
	
	</script>
<body>
	<div class="container">
	
		<form class="forms-sample">
		<input type="hidden" name="post_id"/>
		<input type="hidden" name="id"/>
			<fieldset>
				
				<hr>
				<div id="reportInfo" class="row">
				
					<legend>신고 사유 선택</legend>
					<label>제목:<%=title %></label>
					<br>
					<label>작성자:<%=writer%></label>
				</div>
				<div id="resons">
				<input type="radio" name="reason" value="주제와 상관없는 게시글" id="reason1">
					<label for="rate1">주제와 상관없는 게시글</label><br> 
				<input type="radio"name="reason" value="스팸홍보/도배글" id="reason2">
					<label for="rate2">스팸홍보/도배글</label><br> 
				<input type="radio" name="reason" value="불법 정보 포함" id="reason3">
					<label for="rate3">불법 정보 포함</label><br> 
				<input type="radio" name="reason" value="욕설/혐오표현 포함" id="reason4">
					<label for="rate4">욕설/혐오표현 포함</label><br> 
				<input type="radio" name="reason" value="개인정보 노출" id="reason5">
					<label for="rate5">개인정보 노출</label><br>
					<br>
					<br>
				</div>
 				<div class="d-grid gap-2 col-12 mx-auto">
  					<button id="repBtn" class="btn btn-primary" type="button">신고하기</button>
  				</div>
			</fieldset>
			
			
		</form>
		
	
	</div>

	<!-- plugins:js -->
	<script src="${path}/com/vendors/js/vendor.bundle.base.js"></script>
	<!-- endinject -->
	<!-- Plugin js for this page -->
	<script src="${path}/com/vendors/chart.js/Chart.min.js"></script>
	<script src="${path}/com/vendors/datatables.net/jquery.dataTables.js"></script>
	<script
		src="${path}/com/vendors/datatables.net-bs4/dataTables.bootstrap4.js"></script>
	<script src="${path}/com/js/dataTables.select.min.js"></script>

	<!-- End plugin js for this page -->
	<!-- inject:js -->
	<script src="${path}/com/js/off-canvas.js"></script>
	<script src="${path}/com/js/hoverable-collapse.js"></script>
	<script src="${path}/com/js/template.js"></script>
	<script src="${path}/com/js/settings.js"></script>
	<script src="${path}/com/js/todolist.js"></script>
	<!-- endinject -->
	<!-- Custom js for this page-->
	<script src="${path}/com/js/dashboard.js"></script>
	<script src="${path}/com/js/Chart.roundedBarCharts.js"></script>
	<!-- End custom js for this page-->
	
</body>


</html>