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
let currentScrollTop;
const toggleComments = ((e) => {
  e.preventDefault();
  const id = e.target.dataset.message
  const lContainer = document.querySelector('.l-container')
  currentId = id
  const allCommentsContainer = document.querySelector(".all-comments-container")
  currentScrollTop = lContainer.scrollTop;
  const top = lContainer.scrollTop = '0';
  lContainer.style.overflow = 'hidden'
  allCommentsContainer.style.visibility = 'visible';
  document.querySelector(`#comment_post_${id}`).style.visibility = 'visible';
  const nodeList = document.querySelectorAll('.card-body')
  nodeList.forEach((node) => {
    node.classList.remove('zoom');
  })
  document.querySelector('.card-body').classList.remove('zoom');
})

const closeComments = (el => {
  const lContainer = document.querySelector('.l-container')
  document.querySelector(`#comment_post_${currentId}`).style.visibility = 'hidden';
  document.querySelector(".all-comments-container").style.visibility = 'hidden';
  const nodeList = document.querySelectorAll('.card-body')
  nodeList.forEach((node) => {
    node.classList.add('zoom');
  })
  lContainer.style.overflow = 'scroll';
  lContainer.scrollTop = currentScrollTop;
});
