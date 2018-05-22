function userRequest(user_id, book_id, message_success, message_failed){
  $.ajax({
    type: 'post',
    url: '/users/' + user_id + '/requests',
    dataType: 'json',
    data: {
      request: {
        user_id: user_id,
        book_id: book_id,
      }
    },
    success: function(response){
      if(response.is_success === true){
        $('.book-show-btn-request').attr('disabled', true);
        $('.book-show-btn-request').after('<span>' + message_success + '</span>')
      }
      else {
        $('.book-show-btn-request').after('<span>' + message_failed + '</span>')
      }
    },
    error: function(error_message){
      alert('error' + error_message);
    }
  });
}