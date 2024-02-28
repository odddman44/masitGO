<jsp:useBean id="dao" class="database.MsDao"/>
 <jsp:useBean id="post" class="vo.Post"/>
 <jsp:setProperty property="*" name="post"/>
 {"insPost":${dao.writePost(post)}}