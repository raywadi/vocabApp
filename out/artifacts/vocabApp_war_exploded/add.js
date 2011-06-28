function add(word,shorthand){
    $.ajax({
                url: '/search',
                dataType:"text",
                type:'POST',
                data:{word:word,shorthand:shorthand},
                success:function(resp) {
                }
            });
}