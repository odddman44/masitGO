<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="database.LocPostDao"%>
<%
    int postId = Integer.parseInt(request.getParameter("post_id"));
    String title = request.getParameter("title");
    String content = request.getParameter("content");

    LocPostDao dao = new LocPostDao();
    //boolean success = dao.updatePost(postId, title, content);

    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
   // out.print("{\"success\":" + success + "}");
%>