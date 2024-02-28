<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*" import="vo.*"
	import="database.MsDao"
	%>
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
fieldset {
	border: 2px solid blue;
	margin-top: 50px;
	width: 600px;
	height: 700px;
}
#postInfo{
	margin-top:10px;
	margin-bottom:100px;
}

legend {
	text-align: center;
	font-weight:bold;
	color:skyblue;
}

#buttonDiv {
	margin-right: 10px;
}

.center-div {
	display: flex;
	justify-content: center;
	align-items: center;
	font-size:30px;
}

#rateForm input[type=radio] {
    display: none; /* 라디오 박스 감춤 */
}

#rateForm .star {
    font-size: 2em; /* 이모지 크기 */
    color: transparent; /* 기존 이모지 컬러 제거 */
    text-shadow: 0 0 0 #f0f0f0; /* 새 이모지 색상 부여 */
}

#rateForm .star:hover {
    text-shadow: 0 0 0 #f0f0f0; /* 마우스 호버 뒤에오는 이모지들 */
}

#rateForm input[type=radio]:hover ~ label,
#rateForm input[type=radio]:checked ~ label {
    color: yellow; /* 마우스를 올렸을 때와 선택되었을 때의 색상을 노란색으로 설정 */
    text-shadow: 0 0 0 #f0f0f0; /* 그림자 효과 유지 */
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
var id = <%=jsVariable%> // session id값
function getParameterByName(name) {
    var url = new URL(window.location.href);
    return url.searchParams.get(name);
}
var post_id = getParameterByName("post_id") // 포스트 아이디 받아오기
$(document).ready(function(){
	$("#regBtn").click(function(){
		$("#rateForm [name=id]").val(id); // 아이디값
		$("#rateForm [name=post_id]").val(post_id); // 포스트 아이디값
		$.ajax({
			// 글쓰기 기능 수행
			url: "z07_writeRating.jsp",
			data: $("#rateForm").serialize(),
			dataType: "json",
			success: function(data){
				console.log(data.insRating)
				if(data.insRating > 0){
					alert("별점 등록 완료!");
					// 별점 창 닫기
					window.close();
				}
			},
			error: function(err){
				console.log(err);
			}
		});
	})
	
});
</script>

<body>
    <div class="container">
        <form id="rateForm" class="forms-sample">
        <input type="hidden" name="post_id"/>
        <input type="hidden" name="id"/>
            <fieldset>
                <div id="postInfo">
                    <legend>별점 주기</legend>
                    <label>제목:<%=title%></label> <br> 
                    <label>작성자:<%=writer%></label>
                </div>
                <div class="center-div">
                    <div class="row">
                        <br> <br> <br> <br> <br> <br> <br>
                        <br>
                        <div class="col-1"></div>
                        <div class="col-2">
                            <input type="radio" name="score" value="1" id="rate1">
                            <label for="rate1" class="star">⭐</label>
                        </div>
                        <div class="col-2">
                            <input type="radio" name="score" value="2" id="rate2">
                            <label for="rate2" class="star">⭐</label>
                        </div>
                        <div class="col-2">
                            <input type="radio" name="score" value="3" id="rate3">
                            <label for="rate3" class="star">⭐</label>
                        </div>
                        <div class="col-2">
                            <input type="radio" name="score" value="4" id="rate4">
                            <label for="rate4" class="star">⭐</label>
                        </div>
                        <div class="col-2">
                            <input type="radio" name="score" value="5" id="rate5">
                            <label for="rate5" class="star">⭐</label>
                        </div>
                        <div class="col-1"></div>
                    </div>
                </div>
                <br> <br> <br>
                <div class="row" id="buttonDiv">
                    <div class="col-12 text-right">
                        <button type="button" id="regBtn" class="btn btn-primary">별점 등록</button>
                        <button class="btn btn-info" type="button" id="clsBtn">취소</button>
                    </div>
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