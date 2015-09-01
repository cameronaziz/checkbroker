(function() {
  document.getElementsByClassName("trigger").onClick = function () {
    document.getElementsByClassName("uploadFile")[0].style.display = 'block';
    document.getElementsByClassName("uploadFile")[0].value = this.value;
};
;


}).call(this);
