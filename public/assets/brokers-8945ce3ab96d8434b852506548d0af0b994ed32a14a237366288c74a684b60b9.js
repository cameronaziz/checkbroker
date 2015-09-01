(function() {
  document.getElementsByClassName("uploadBtn").onchange = function () {
    document.getElementsByClassName("uploadFile").value = this.value;
};
;


}).call(this);
