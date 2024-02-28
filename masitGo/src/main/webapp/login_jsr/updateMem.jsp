<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  %>
<jsp:useBean id="dao" class="database.UserDao"/>
<jsp:useBean id="m01" class="vo.Member"/>
<jsp:setProperty property="*" name="m01"/>
{"updMember": ${dao.updateMember(m01)}}
<%
Member updatedMember = dao.getMemberById(request.getParameter("id"));
session.setAttribute("m01", updatedMember);
%>
