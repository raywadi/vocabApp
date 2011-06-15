<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Simple jsp page</title>
    <script type="text/javascript" src="/js/jquery.js"></script>
    <script type="text/javascript" src="/add.js"></script>
    <script type="text/javascript">
        function sleep(time) {
            var startTime = new Date();
            while (new Date().getTime() < startTime + time);
                    }
        function api_call() {
            var words = $("textarea").val().split("\n");
            for (var i = 0; i < words.length; i++) {
                add(words[i]);
            }
            document.getElementById("searchWord").value='';
            document.getElementById("successMessage").style.visibility="visible";
            sleep(5000);
            alert("4)")
            document.getElementById("successMessage").style.visibility="hidden";
        }
    </script>
</head>
<jsp:include page="template.jsp"></jsp:include>
<body onload="">
<div id="content" align="center" >
    <div style="padding:25px">
        <textarea style="border-color:#666699; outline-color:#666699; font:18px" name="searchWord" id="searchWord" cols="50" rows="10"></textarea>
        <br>
        <button id="go" style="background-color:#666699; color:white;" name="go" onclick="api_call()">Add</button>

    </div>
    <div id="successMessage" align="center">Added to the wordlist successfully</div>

</div>

</body>
</html>