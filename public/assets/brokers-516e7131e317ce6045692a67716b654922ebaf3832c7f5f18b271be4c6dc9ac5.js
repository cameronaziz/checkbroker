(function() {
  document.getElementsByClassName("uploadBtn").onchange = function () {
    document.getElementsByClassName("uploadFile").style.display = 'block';
    document.getElementsByClassName("uploadFile").value = this.value;
};
;


}).call(this);
