<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="vo.Mpost" %>
<jsp:useBean id="gson" class="com.google.gson.Gson"/>
<jsp:useBean id="dao" class="database.LocPostDao"/>

<%
    // post_id 매개변수 받기
    String postIdParam = request.getParameter("post_id");
    int postId = 0;
    if (postIdParam != null && !postIdParam.isEmpty()) {
        postId = Integer.parseInt(postIdParam);
    }

    // 게시글 상세 정보 가져오기
    Mpost postDetail = dao.getPostDetail(postId);

    // JSON 형식으로 변환 및 출력
    out.print(gson.toJson(postDetail));
%>