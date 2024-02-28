<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="dao" class="database.MsDao"/>
<jsp:useBean id="post" class="vo.PostDTO"/>
<jsp:useBean id="gson" class="com.google.gson.Gson"/>
<jsp:setProperty property="*" name="post"/>
${gson.toJson(dao.getPost(param.board, param.sort))}

