$(function() {
  $(".flash").delay(5000).slideUp(function(){$(this).remove()})


  CodeMirror.fromTextArea($("textarea")[0], {
    tabSize: 2,
    matchBrackets: true,
    workDelay: "500"
  });


})
