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
let currentId;
const toggleComments = ((e) => {
  e.preventDefault();
  const id = e.target.dataset.message
  currentId = id
  const allCommentsContainer = document.querySelector(".all-comments-container")
  const top = document.querySelector('.l-container').scrollTop = '0';
  allCommentsContainer.style.visibility = 'visible';
  document.querySelector(`#comment_post_${id}`).style.visibility = 'visible';
})

const closeComments = (el => {
  document.querySelector(`#comment_post_${currentId}`).style.visibility = 'hidden';
  document.querySelector(".all-comments-container").style.visibility = 'hidden'
})
