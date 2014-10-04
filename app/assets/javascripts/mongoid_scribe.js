$(function(){
  $("select.polymorphic").on("change", function(event){
    var type         = $(this).find(":selected").data("type");
    var $hiddenField = $(this).siblings("input[type='hidden']");
    $hiddenField.val(type);
  })
})
