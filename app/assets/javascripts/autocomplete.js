var form = $('.my_form')
var button = $('.my_button')
button.click(function(){
   console.log(form.val()); 
});

$(document).ready(function(){

    $(".my_form").keyup(function(){
        var search = $(this).val();

        if(search != ""){
            var datObject;
            $.ajax({
                url: 'autocomplete',
                method: 'GET',
                dataType: 'json',
                data: {'term': search},
                success:function(data){
                var len = data["data"].length;
                 console.log('Success!', data);
                  for( var i = 0; i<len; i++){
                        var id = data["data"][i]['id']
                        var name = data["data"][i]['name'];
                        document.getElementById("searchResult").innerHTML+="<li value='"+id+"'>"+name+"</li>";

                    }
                                   
                }
                });
                $("#searchResult").innerHTML="bonjour"

                     }
    });

});
