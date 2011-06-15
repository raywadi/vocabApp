<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>VocabApp</title></head>
<jsp:include page="template.jsp"></jsp:include>
<body>
<div id="content" style="padding-left:15px;padding-bottom:15px">
    <h4>A simple app to help you remember new words.</h4>
    This app will maintain list of new words you encounter.
    Whenever you encounter a new word, just add that word to the wordlist and app will make sure you see that word again
    and again so that it sticks with you forever.
    This will de done by sending words to you via mail at regular intervals.

    <h5>What do you have to do??</h5>
    Just sign in using your gmail account and thats all!!!
    <br><br>
    Now you can either <a href="/search">search</a> meaning of a word and that word will automatically be added to
    your wordlist or just add word/words to your wordlist using <a href="/add">bulk add</a>.

</div>
</body>
</html>