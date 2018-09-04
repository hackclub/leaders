// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

// Disable use without FullStory
window.onload = function() {
  var blocked
  setTimeout(function() {
    if (typeof FS === 'undefined') {
      blocked = true
    } else {
      axios.post('https://rs.fullstory.com/rec/page').catch(function() {
        blocked = true
      })
    }
  }, 4000)
  setTimeout(function() {
    if (blocked) {
      var body = document.getElementsByTagName('body')
      body[0].remove()
      alert(
        'Your adblocker is preventing us from reporting bugs. Please disable it in order to use the Hack Club Leaders Dashboard.'
      )
    }
  }, 4500)
}
