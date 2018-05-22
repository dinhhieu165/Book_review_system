$(document).ready(function(){
  $('#id_btn_follow').on('click',function(){
    if('Follow' === $('#id_btn_follow').val()){
      $.ajax({
        type: 'post',
        url: '/relationships.json',
        dataType: 'json',
        data: {
          followed_id: $('#followed_id').val(),
        },
        success: function(data){
          $('#id_btn_follow').val('UnFollow');
          $('#followers').text(data.followed);
        },
        error: function (error_message){
          alert('error'+error_message);
        }
      });
    }
    else {
      $.ajax({
        type: 'DELETE',
        url: '/relationships/' + $('#followed_id').val(),
        dataType: 'json',
        success: function(data){
          $('#id_btn_follow').val('Follow');
          $('#followers').text(data.followed);
        },
        error: function (error_message){
          alert('error'+error_message);
        }
      });
    }
  });
});