<%@ page import="database.MsDao" %>
<%@ page contentType="application/json;charset=UTF-8" %>
<%@ page language="java" %>
<%
	String idStr = request.getParameter("post_id");
	int post_id = 0;
	int isUpt = 0;
	if(idStr!=null){ 
		post_id = Integer.parseInt(idStr);
		MsDao dao = new MsDao();
		isUpt = dao.increaseViews(post_id);
		 System.out.println("Post ID: " + post_id + ", isUpt: " + isUpt);
	}
	
%>
<jsp:useBean id="dao" class="database.MsDao"/>
 <%-- 조회수 올리기 --%>
 {"isUpt":<%=isUpt%>}
 