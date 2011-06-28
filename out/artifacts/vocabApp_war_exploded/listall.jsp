<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="vocabApp.PMF" %>
<%@ page import="vocabApp.Words" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="javax.jdo.Query" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Simple jsp page</title>
    <script type="text/javascript" src="/js/jquery.js"></script>
    <script type="text/javascript" src="/js/hindi.js"></script>
    <script type="text/javascript" src="/js/meaning.js"></script>
    <script type="text/javascript">
        function delete_all() {
            $.ajax({
                url: '/deleteall',
                dataType:"text",
                type:'POST',
                data:{password:'qwedsa'},
                success:function(resp) {
                    alert("done");
                }
            });
        }

        function api_call(word) {
            $("#meaning").html("loading...")
            //            hindi(word);
            meaning(word);
        }

        function hide() {
            document.getElementById("meaningWithList").style.visibility = "hidden";
        }
        function show() {
            document.getElementById("meaningWithList").style.visibility = "visible";
        }
    </script>
</head>
<jsp:include page="template.jsp"></jsp:include>
<body>
<div id="content">
    <br>
    <%
        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();

        PersistenceManager pm = PMF.get().getPersistenceManager();
        String queryString = "select from " + Words.class.getName() + " where email == '"
                + user.getEmail() + "' order by date desc";
        Query query = pm.newQuery(queryString);
        query.setRange(0, 10);
        List<Words> wordsList = (List<Words>) query.execute();
        String shortHand="";
    %>
    <div class="wordList"
         id="wordList">
        <%
            if (wordsList.size() == 0) {
        %>
        There are no words in your word list yet.
        <%
            }
            for (Words word : wordsList) {
                if("".equals(word.getShortHand())){
                    shortHand = "No shortHand given";
                } else {
                    shortHand=word.getShortHand();
                }
            %>
            <div class="word" title="<%=shortHand%>" align="center" onclick="api_call('<%= word.getWord() %>');">
                <%= word.getWord()%>
            </div>
        <%
            }
        %>
    </div>

<%--<div onclick="delete_all()">DELETE</div>--%>
<div id="meaningWithList">
    <div id="hindimeaning" align="center"></div>
    <br>

    <div id="meaning" align="left">
    </div>
</div>
</body>
</html>