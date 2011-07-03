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

        function api_call(word, domObject) {
            
            var parent = $(domObject).parent();
            $("#meaning").html("loading...")
            //            hindi(word);
            meaning(word);
            $(".word").removeClass("wordHighlight");
            $(parent).addClass("wordHighlight");
        }

        function unarchive_word(domObject) {
            var parent = $(domObject).parent();
            var wordObject = parent.children();
            parent.remove();
            var word = wordObject.html();
            $.ajax({
                url: '/jsp/archive',
                dataType:"text",
                type:'POST',
                data:{word:word,archive:'false'},
                success:function(resp) {
                }
            });
        }

        function delete_word(domObject){
            var parent = $(domObject).parent();
            var wordObject = parent.children();
            parent.remove();
            var word = wordObject.html();
            $.ajax({
                url: '/jsp/deleteall',
                dataType:"text",
                type:'POST',
                data:{word:word},
                success:function(resp) {
                }
            });

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
<div id="content" onmouseover="show()" onmouseout="hide()">
    <br>
    <%
        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();

        PersistenceManager pm = PMF.get().getPersistenceManager();
        String queryString = "select from " + Words.class.getName() + " where email == '"
                + user.getEmail() + "' && archived == 'true' order by date desc";
        Query query = pm.newQuery(queryString);
        List<Words> wordsList = (List<Words>) query.execute();
        String shortHand = "";
    %>

    <div class="wordList" id="wordList">
        <%
            if (wordsList.size() == 0) {
        %>
        There are no words in your word list yet.
        <%
            }
            for (Words word : wordsList) {
                if ("".equals(word.getShortHand())) {
                    shortHand = "No shortHand given";
                } else {
                    shortHand = word.getShortHand();
                }
        %>
        <div class="word" title="<%=shortHand%>" align="center">
            <span class="wordText" id="word" onclick="api_call('<%= word.getWord() %>',this);"><%=word.getWord()%></span>
            <span class="image" onclick="delete_word(this)"><img align="right" height="16" width="16" src="/images/delete.png" alt="Delete" title="Delete"/></span>
            <span class="image" onclick="unarchive_word(this)"><img align="left" height="16" width="16" src="/images/unarchive.png" alt="archive" title="Archive"/></span>
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
</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</div>
</html>