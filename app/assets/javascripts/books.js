(function() {
  var update_book_ajax;

  update_book_ajax = function(inputData, funcSucess, self) {
    inputData.mark.user_id = self.data('user-id');
    inputData.mark.book_id = self.data('book-id');
    inputData._method = 'PATCH';
    $.ajax({
      url: self.attr('href') + '/' + self.data('book-id'),
      type: 'POST',
      dataType: 'json',
      data: inputData,
      error: function(jqXHR, textStatus, errorThrown) {
        return alert('AJAX Error: #{textStatus}');
      },
      success: function(data, textStatus, jqXHR) {
        return funcSucess(data);
      }
    });
  };

  $(function() {
    $('.btn_favorite').off('click').on('click', function(e) {
      var funcSucess, inputData, self;
      self = $(this);
      inputData = {
        mark: {
          favorite: !self.data('is-favorite')
        }
      };
      funcSucess = function(data) {
        if (data.success) {
          if (data.is_favorite) {
            self.parent().addClass('favorited');
            self.data('is-favorite', true);
          } else {
            self.parent().removeClass('favorited');
            self.data('is-favorite', false);
          }
        }
      };
      update_book_ajax(inputData, funcSucess, self);
      e.preventDefault();
      return e.stopPropagation();
    });
    $('.btn_reading').off('click').on('click', function(e) {
      var funcSucess, inputData, self;
      self = $(this);
      inputData = {
        mark: {
          read_status: self.data('next-status')
        }
      };
      funcSucess = function(data) {
        if (data.success) {
          if (self.parent().hasClass('reading')) {
            self.parent().removeClass();
            self.data('next-status', 1);
          } else {
            self.parent().addClass('reading');
            self.data('next-status', 0);
            self.parent().parent().find('li').last().removeClass();
          }
        }
      };
      update_book_ajax(inputData, funcSucess, self);
      e.preventDefault();
      return e.stopPropagation();
    });
    return $('.btn_read').off('click').on('click', function(e) {
      var funcSucess, inputData, self;
      self = $(this);
      inputData = {
        mark: {
          read_status: self.data('next-status')
        }
      };
      funcSucess = function(data) {
        if (data.success) {
          if (self.parent().hasClass('read')) {
            self.parent().removeClass();
            self.data('next-status', 2);
          } else {
            self.parent().addClass('reading');
            self.data('next-status', 0);
            self.parent().parent().find('li').eq(1).removeClass();
          }
        }
      };
      update_book_ajax(inputData, funcSucess, self);
      return e.preventDefault();
    });
  });

  e.stopPropagation();

}).call(this);