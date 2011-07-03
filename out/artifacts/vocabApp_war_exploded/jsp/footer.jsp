<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="vocabApp.PMF" %>
<%@ page import="vocabApp.Words" %>
<%@ page import="javax.jdo.Query" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<div class="footer" id="footer">
    <%
        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();

        PersistenceManager pm = PMF.get().getPersistenceManager();
        String queryString = "select from " + Words.class.getName() + " where email == '"
                + user.getEmail() + "' order by date desc";
        Query query = pm.newQuery(queryString);
        List<Words> wordsList = (List<Words>) query.execute();

    %>
    <div align="center">You have added <%= wordsList.size()%> new words</div>
</div>
</html>