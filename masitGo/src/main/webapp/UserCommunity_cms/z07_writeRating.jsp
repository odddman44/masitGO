<jsp:useBean id="dao" class="database.MsDao"/>
 <jsp:useBean id="rating" class="vo.Rating"/>
 <jsp:setProperty property="*" name="rating"/>
 {"insRating":${dao.writeRating(rating)}}