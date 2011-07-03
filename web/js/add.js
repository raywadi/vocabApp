function add(word,shorthand){
    $.ajax({
                url: '/jsp/search',
                dataType:"text",
                type:'POST',
                data:{word:word,shorthand:shorthand},
                success:function(resp) {
                }
            });
}