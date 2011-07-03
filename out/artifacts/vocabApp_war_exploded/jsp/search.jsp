<html>
<head>
    <script type="text/javascript" src="/js/jquery.js"></script>
    <script type="text/javascript" src="/js/hindi.js"></script>
    <script type="text/javascript" src="/js/meaning.js"></script>
    <script type="text/javascript" src="/js/add.js"></script>
    <script type="text/javascript">
        document.getElementById("searchWord").focus();
        function api_call() {

            var word = $("#searchWord").val();
            //            hindi(word);
            if(word===''){
                return;
            }
            $("#meaning").html("loading...");
            meaning(word);
            add(word, '');
            var content = "<br><input class=\"input\" type=\"text\" id=\"shorthand\" size=\"30\"/>";
            $("#shand").html(content);
            content = $("#input").html() + "<a href='/jsp/search.jsp' class=\"smallNote\">  Reset</a>";
            $("#input").html(content);
            document.getElementById("go").value = 'Add Shorthand';
            document.getElementById("go").onclick = function() {
                add_shorthand()
            };
        }

        function add_shorthand() {
            var shorthand = $("#shorthand").val();
            var word = $("#searchWord").val();
            add(word, shorthand);
            $("#shand").html("");
            $("#searchWord").val("");
            $("#meaning").html("");
            document.getElementById("go").value = 'Go';
            document.getElementById("go").onclick = "api_call()";

        }

        function validate() {
            var word = $("textarea").val();
            var len = word.length;
            if (len > 1) {
                var lastChar = word[len - 1];
                if (lastchar === ' ') {
                    alert("should only enter alphabet");
                }
            }
        }
    </script>
    <%--//http://translate.google.com/translate_a/t?client=t&text=text&sl=en&tl=hi--%>
    <%--//https://ajax.googleapis.com/ajax/services/language/translate?q=word&v=1.0&langpair=en|hi--%>
    <%--//http://www.google.com/dictionary/json?callback=dict_api.callbacks.id&q=test&sl=en&tl=en--%>
    <title>Simple jsp page</title>
</head>
<jsp:include page="template.jsp"></jsp:include>
<div id="content">
    <br><br><br>

    <div id="searchBox" align="center">
        <form>
            <input class="input" type="text" id="searchWord" size="30"/>

            <div id="shand">
            </div>
            <br/>

            <div id="input">
                <input class="submit" type="submit" id="go" value="Go" onclick="api_call();return false;"/>
            </div>
        </form>
    </div>
    <br>

    <div id="hindimeaning" align="center"></div>
    <br>

    <div class="meaning" id="meaning" align="left">

    </div>

</div>
<jsp:include page="footer.jsp"></jsp:include>
</div>
</body>
</html>