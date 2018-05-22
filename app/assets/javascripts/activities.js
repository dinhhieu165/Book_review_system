(function() {
  $(function() {
    return $('.interaction_area a.btn_like').off('click').on('click', function(e) {
      var self;
      self = $(this);
      $.ajax({
        url: self.attr('href'),
        type: 'POST',
        dataType: 'json',
        data: {
          like: {
            user_id: self.data('user-id'),
            activity_id: self.data('activity-id')
          }
        },
        error: function(jqXHR, textStatus, errorThrown) {
          return alert('AJAX Error: #{textStatus}');
        },
      });
      return e.preventDefault();
    });
  });

  e.stopPropagation();

}).call(this);