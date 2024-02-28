<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  %>
<%@ page import="database.LocPostDao"%>

<jsp:useBean id="dao" class="database.LocPostDao" />
<%
    int postId = Integer.parseInt(request.getParameter("postId"));
    int delCnt = dao.deletePost(postId);
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    out.print("{\"delCnt\":" + delCnt + "}");
%>