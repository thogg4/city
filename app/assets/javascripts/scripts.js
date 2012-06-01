$(function() {
  $(".flash").delay(5000).fadeOut()


  CodeMirror.fromTextArea($("textarea")[0], {
    tabSize: 2,
    matchBrackets: true,
    workDelay: "500"
  });


})
