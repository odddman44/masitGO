<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="database.LocPostDao"%>
<%@ page import="vo.Comment"%>
<%@ page import="com.google.gson.Gson"%>

<%
    // 게시글 ID를 파라미터에서 가져옵니다.
    int postId = Integer.parseInt(request.getParameter("postId"));

    // DAO 객체 생성
    LocPostDao dao = new LocPostDao();

    // 댓글 목록 가져오기
    List<Comment> comments = dao.getComments(postId);

    // Gson 객체를 사용하여 JSON으로 변환합니다.
    Gson gson = new Gson();
    String jsonComments = gson.toJson(comments);

    // JSON 문자열을 출력합니다.
    out.print(jsonComments);
%>