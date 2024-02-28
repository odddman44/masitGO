<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  %>
<jsp:useBean id="dao" class="database.UserDao"/>
<jsp:useBean id="m01" class="vo.Member"/>
<jsp:setProperty property="*" name="m01"/>
{"insMember": ${dao.insertMember(m01)}}