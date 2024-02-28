<jsp:useBean id="dao" class="database.MsDao"/>
 <jsp:useBean id="report" class="vo.Report"/>
 <jsp:setProperty property="*" name="report"/>
 {"insReport":${dao.writeReport(report)}}