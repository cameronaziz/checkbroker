(function() {
  jQuery(function() {
    return $('.uploadBtn').change(function() {
      var a;
      a = $(this).val().split('\\');
      return $('.trigger').html(a[a.length - 1]);
    });
  });

}).call(this);
