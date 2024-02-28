<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, vo.*, database.*, com.google.gson.Gson" %>
<%
    LocPostDao dao = new LocPostDao();
    List<Mpost> mpostList = dao.getMapInfo();
    Gson gson = new Gson();
    String jsonData = gson.toJson(mpostList);
    response.getWriter().write(jsonData);
%>