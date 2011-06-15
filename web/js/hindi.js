function hindi(word){
            $.ajax({
                url: 'https://ajax.googleapis.com/ajax/services/language/translate',
                dataType:"jsonp",
                data:{q:word,v:"1.0",langpair:"en|hi"},
                success:function(resp) {
                    $("#hindimeaning").html(resp.responseData.translatedText);
                }
            });
}