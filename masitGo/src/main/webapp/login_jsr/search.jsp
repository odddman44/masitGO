<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<jsp:useBean id="dao" class="database.UserDao"/>
{"searchPwd":'${dao.searchPwd(param.id,param.name)}'}