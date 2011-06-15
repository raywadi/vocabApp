<html>
<head>
    <script type="text/javascript" src="/js/jquery.js"></script>
    <script type="text/javascript" src="/js/hindi.js"></script>
    <script type="text/javascript" src="/js/meaning.js"></script>
    <script type="text/javascript" src="/add.js"></script>
    <script type="text/javascript">
        document.getElementById("searchWord").focus();
        function api_call() {
            $("#meaning").html("loading...");
            var word = $("textarea").val();
//            hindi(word);
            meaning(word);
            add(word);

        }
    </script>
            <%--//http://translate.google.com/translate_a/t?client=t&text=text&sl=en&tl=hi--%>
            <%--//https://ajax.googleapis.com/ajax/services/language/translate?q=word&v=1.0&langpair=en|hi--%>
            <%--//http://www.google.com/dictionary/json?callback=dict_api.callbacks.id&q=test&sl=en&tl=en--%>
    <title>Simple jsp page</title>
</head>
<jsp:include page="template.jsp"></jsp:include>
<body>
<div id="content">
    <br><br><br>

    <div id="searchBox" align="center">
        <label>
            <textarea style="border-color:#666699; outline-color:#666699; font:18px " name="searchWord" id="searchWord" cols="30" rows="1"></textarea>
        </label>
        <br><br>
        <button style="background-color:#666699; color:white;" id="go" name="go" onclick="api_call()">Search</button>
    </div>
    <br>
    <div id="hindimeaning" align="center"></div>
    <br>

    <div class="meaning" id="meaning" align="left">

    </div>

</div>

<div id="bottom">
</div>
</div>
</body>
</html>