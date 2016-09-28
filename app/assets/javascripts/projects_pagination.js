var numPages;
var $table;
var currentPage = 1;
var newPage = 0;
var url;
$(document).ready(function(){
  $('.current').next().removeAttr('rel');
  numPages = parseInt($('.next_page').prev().text());
  console.log(numPages);
  var href = $('.next_page').prev().attr('href')
  url = href.split('=')[0] + '=';
  $('.pagination').on('click', 'a', changePage);
  $table = $('.table-projects');
});


function changePage(event) {
  event.preventDefault();
  var $tagA = $(event.currentTarget);
  var url = $tagA.attr('href');
  url = '/api/v1' + url;
  $.ajax({
    type: 'get',
    url: url,
    success: function (response) {
      //debugger
      $table.empty();
      //debugger
      response.forEach(printProject);
      editPagination($tagA);
    }
  });
};

function printProject(project) {
  $table.append('<div class="one-project">' + 
    '<div class="project-img">' +
        '<a href="/projects/' + project.id + '">' +
          '<img src="../project' + (project.id%3 + 1) +'.png">' +
        '</a>' +
      '</div>' +
      '<div class="project-name">' +
        '<h4>' + project.name + '</h4><span id="triangle-bottomleft"></span>' +
      '</div>' +
      '<p>Type:' +  project.project_type + '</p>' +
      '<p>Main purpose:' + project.purpose + '</p>' +
    '</div>');
};

function editPagination($tagA) {
  console.log('hola');
  console.log($tagA);

  if ($tagA.hasClass('previous_page')) {
    console.log('prev');
    newPage = currentPage - 1;
    // debugger
    $('.current').prev().replaceWith($('<em class="aux">' + newPage + '</em>'));
    // debugger
    $('.current').replaceWith($('<a href ="' + url + currentPage + '">' + currentPage + '</a>'));
    $('.aux').addClass('current');
    $('.current').removeClass('aux');

  } else if ($tagA.hasClass('next_page')){
    console.log('next');
    newPage = currentPage + 1;
    $('.current').next().replaceWith($('<em class="aux">' + newPage + '</em>'));
    $('.current').replaceWith($('<a href ="' + url + currentPage + '">' + currentPage + '</a>'));
    $('.aux').addClass('current');
    $('.current').removeClass('aux');
  } else {
    console.log('num');
    newPage = parseInt($tagA.text());
    $('.current').replaceWith($('<a href ="' + url + currentPage + '">' + currentPage + '</a>'));
    $tagA.replaceWith($('<em class="current">' + newPage + '</em>'));
  }

  currentPage = newPage;
  
  if (currentPage === 1) {
    $('.previous_page').replaceWith($('<span class="previous_page disabled">← Previous</span>'));
    $('.next_page').replaceWith($('<a class="next_page" href="' + (url + (currentPage + 1)) + '">Next →</span>'));
  } 
  else if (currentPage === numPages){
    $('.previous_page').replaceWith($('<a class="previous_page" href="' + (url + (currentPage - 1)) + '">← Previous</span>'));
    $('.next_page').replaceWith($('<span class="next_page disabled">Next →</span>'))
  }
  else {
    $('.previous_page').replaceWith($('<a class="previous_page" href="' + (url + (currentPage - 1)) + '">← Previous</span>'));
    $('.next_page').replaceWith($('<a class="next_page" href="' + (url + (currentPage + 1)) + '">Next →</span>'));
  }
};