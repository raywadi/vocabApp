function delete_all() {
            $.ajax({
                url: '/jsp/deleteall',
                dataType:"text",
                type:'POST',
                data:{password:'qwedsa'},
                success:function(resp) {
                    alert("done");
                }
            });
        }