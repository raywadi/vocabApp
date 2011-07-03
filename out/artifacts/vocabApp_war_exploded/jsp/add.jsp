<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Simple jsp page</title>
    <script type="text/javascript" src="/js/jquery.js"></script>
    <script type="text/javascript" src="/js/add.js"></script>
    <script type="text/javascript">
        function hide() {
            document.getElementById("successMessage").style.visibility = "hidden";
        }
        function api_call() {
            var words = $("textarea").val().split("\n");
            for (var i = 0; i < words.length; i++) {
                var currentWord = words[i].split(":");
                var word = currentWord[0];
                var shortHand = '';
                if (currentWord.length == 2) {
                    shortHand = currentWord[1];
                }
                add(word, shortHand);
            }
            document.getElementById("searchWord").value = '';
            document.getElementById("successMessage").style.visibility = "visible";
            //            sleep(5000);
            //            document.getElementById("successMessage").style.visibility = "hidden";
        }
    </script>
</head>
<jsp:include page="template.jsp"></jsp:include>
<div id="content" align="center" style="padding-bottom:5px">
    <div style="padding:25px">
        <textarea onclick="hide();" class="input" name="searchWord" id="searchWord"
                  cols="50" rows="10"></textarea>
        <br>
        <button id="go" class="submit" name="go" onclick="api_call()">Add</button>

    </div>
    <div id="successMessage" align="center">Added to the wordlist successfully</div>

</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</div>
</html>