function add(word){
    $.ajax({
                url: '/search',
                dataType:"text",
                type:'POST',
                data:{word:word},
                success:function(resp) {
                    //                    alert("done");
                }
            });
}