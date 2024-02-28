<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="database.LocPostDao"%>

<%
    int postId = Integer.parseInt(request.getParameter("post_id"));
    LocPostDao dao = new LocPostDao();
    double avgRating = dao.getPostRatings(postId);

    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    out.print("{ \"averageRating\": " + avgRating + " }");
%>