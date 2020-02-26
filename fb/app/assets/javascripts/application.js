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
let myStorage = window.localStorage;

const showComments = (id => {
  const htmlCont = document.querySelector('html')
  const allCommentsContainer = document.querySelector(".all-comments-container")
  myStorage.setItem('currentScrollTop', htmlCont.scrollTop)
  htmlCont.scrollTop = '0';
  htmlCont.style.overflow = 'hidden'
  allCommentsContainer.style.visibility = 'visible';
  document.querySelector(`#comment_post_${id}`).style.visibility = 'visible';
  const nodeList = document.querySelectorAll('.card-body')
  nodeList.forEach((node) => {
    node.classList.remove('zoom');
  })
})

const rememberState = (ev => {
  let id = localStorage.getItem('id')
  let currentScrollTop = myStorage.getItem('currentScrollTop');
  if(!isNaN(currentScrollTop)) {
    document.querySelector('html').scrollTop = currentScrollTop
    myStorage.setItem('currentScrollTop', null);
  }

  if (!isNaN(id)) {
    showComments(id);
  }
});

const toggleComments = ((e) => {
  e.preventDefault();
  const id = e.target.dataset.message;
  currentId = id
  myStorage.setItem('currentScrollTop', document.querySelector('html').scrollTop)
  showComments(id);
  myStorage.setItem('id', id);
})

const closeComments = (el => {
  const htmlCont = document.querySelector('html')
  currentId = myStorage.getItem('id');
  currentScrollTop = myStorage.getItem('currentScrollTop')
  document.querySelector(`#comment_post_${currentId}`).style.visibility = 'hidden';
  document.querySelector(".all-comments-container").style.visibility = 'hidden';
  const nodeList = document.querySelectorAll('.card-body')
  nodeList.forEach((node) => {
    node.classList.add('zoom');
  })
  htmlCont.style.overflow = 'scroll';
  console.log(currentScrollTop);
  if(!isNaN(currentScrollTop)) {
    htmlCont.scrollTop = currentScrollTop
    myStorage.setItem('currentScrollTop', null);
  }
  myStorage.setItem('id', null);
});

const toggleNotification1 = (ev => {
  const notificationContainer = document.querySelector('.note-container')
  const note = document.querySelector('[note]');
  const note1 = document.querySelector('[note1]');
  const note2 = document.querySelector('[note2]');
  if(notificationContainer != undefined){
    if(notificationContainer.style.display === 'none'){
      notificationContainer.style.display = 'block';
      document.querySelector('.note-container').style.display = 'block';
      document.querySelector("#down1").style.display = 'none'
      document.querySelector("#up1").style.display = 'inline-block'
      note1.style.display = 'none';
      note.style.display = 'none';
      note2.style.display = 'none';
    }
    else{
      notificationContainer.style.display = 'none';
      document.querySelector("#down1").style.display = 'inline-block'
      document.querySelector("#up1").style.display = 'none'
      document.querySelector('.note-container').style.display = 'none';
    }
  }
});

const toggleNotification = (ev => {
  const notificationContainer = document.querySelector('.notification-container')
  const note = document.querySelector('[note]');
  const note1 = document.querySelector('[note1]');
  if(notificationContainer != undefined){
    if(notificationContainer.style.display === 'none'){
      notificationContainer.style.display = 'block';
      document.querySelector('.note-container').style.display = 'block';
      document.querySelector("#down").style.display = 'none'
      document.querySelector("#up").style.display = 'inline-block'
      note1.style.display = 'none';
      note.style.display = 'none';
    }
    else{
      notificationContainer.style.display = 'none';
      document.querySelector("#down").style.display = 'inline-block'
      document.querySelector("#up").style.display = 'none';
    }
  }
});

const toggleNewPost = () => {
  document.querySelector('.form-overlay').style.display = 'block';
}

const closePostForm = () => {
  document.querySelector('.form-overlay').style.display = 'none';
}

const openForm = (name => {
  window.event.preventDefault();
  if (name === 'log-in') {
    document.querySelector(`.${name}`).style.display = 'block';
    document.querySelector('.toggle-log-in').style.display = 'block';
  } else {
    document.querySelector('.log-in').style.display = 'none';
    document.querySelector(`.${name}`).style.display = 'block';
    document.querySelector('.toggle-log-in').style.display = 'none';
    document.querySelector('.toggle-sign-up').style.display = 'block';
  }
})
