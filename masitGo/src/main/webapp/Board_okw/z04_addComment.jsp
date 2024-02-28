<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="database.LocPostDao"%>
<%@ page import="java.io.PrintWriter"%>
<%
    // 파라미터에서 게시글 ID, 사용자 ID, 댓글 내용을 가져옵니다.
    int postId = Integer.parseInt(request.getParameter("postId"));
    String userId = request.getParameter("userId");
    String content = request.getParameter("content");

    // DAO 객체 생성
    LocPostDao dao = new LocPostDao();

    // 댓글 추가
    boolean isAdded = dao.addComment(postId, userId, content);

    // 결과 반환
    response.setContentType("application/json");
    if (isAdded) {
        response.getWriter().print("{\"success\": true}");
    } else {
        response.getWriter().print("{\"success\": false}");
    }
%>