<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"    
    %>
<jsp:useBean id="dao" class="database.LocPostDao"/>
<jsp:useBean id="post" class="vo.MpostDTO"/>
<jsp:setProperty property="*" name="post"/>
{"insMpost":${dao.insertPostAndLocation(post)}}