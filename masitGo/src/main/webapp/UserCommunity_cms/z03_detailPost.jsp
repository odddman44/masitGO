<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<jsp:useBean id="dao" class="database.MsDao"/>
<jsp:useBean id="post" class="vo.PostDTO"/>
<jsp:useBean id="gson2" class="com.google.gson.Gson"/>
${gson2.toJson(dao.getPostByPost_id(param.post_id))}
