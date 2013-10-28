$(function() {
  $("form").on("click", ".add-fields", function(evt) {
    evt.preventDefault()

    var $this = $(this),
        time = +new Date(),
        regexp = new RegExp($this.data("id"), "g");

    $this.before($this.data('fields').replace(regexp, time))

    $("input.start-date, input.end-date").datepicker();
  });
});
