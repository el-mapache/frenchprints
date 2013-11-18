$(function() {
  $("form").on("click", ".add-fields", function(evt) {
    evt.preventDefault()

    var $this = $(this),
        time = +new Date(),
        regexp = new RegExp($this.data("id"), "g");

    $this.before($this.data('fields').replace(regexp, time))

    $("input.start-date, input.end-date").datepicker();

    var chosen = $("[data-type='chosen-select']")
    if (chosen.length) {
      chosen.chosen({disable_search_threshold: 10}); 
    }
  });
});
