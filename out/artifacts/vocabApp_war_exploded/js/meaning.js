function meaning(word) {
    $.ajax({
        url: 'http://www.google.com/dictionary/json',
        dataType:"jsonp",
        data:{q:word,sl:"en",tl:"en"},
        success:function(resp) {
            var itr = resp.primaries[0].entries;
            var out = '';
            var count=1;
            for (var i = 0; i < itr.length; i++) {
                if (itr[i].type === "meaning") {
                    out += count++  +'. '+itr[i].terms[0].text + '<br><hr>';
                }
            }
            $("#meaning").html(out);
            document.getElementById("loading").style.visibility="hidden"
        }
    });
}