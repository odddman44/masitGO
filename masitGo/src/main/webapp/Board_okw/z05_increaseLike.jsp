<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="database.LocPostDao"%>

<%
    int postId = Integer.parseInt(request.getParameter("postId"));
    LocPostDao dao = new LocPostDao();
    boolean success = dao.increaseLikeCount(postId);

    // JSON 형식으로 결과 반환
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    out.print("{ \"success\": " + success + " }");
%>