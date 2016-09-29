var numPages;
var currentPage = 1;
var newPage = 0;
var url;
$(document).ready(function(){
  var href = $('.next_page').prev().attr('href')
  url = href.split('=')[0] + '=';
  numPages = parseInt($('.next_page').prev().text());
  
  $('.pagination').on('click', 'a', changePage);
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
      printProjects(response);
      editPagination($tagA);
    }
  });
};
function printProjects(response) {
  var $table = $('.table-projects');
  $table.empty();
  response.forEach(function(project){
    $table.append('<div class="one-project">' + 
    '<div class="project-img">' +
        '<a href="/projects/' + project.id + '">' +
          '<img src="../project' + (project.id%3 + 1) +'.png">' +
        '</a>' +
      '</div>' +
      '<div class="project-name">' +
        '<h4>' + project.name + '</h4><span id="triangle-bottomleft"></span>' +
      '</div>' +
    '</div>');
  })
};
function replaceAtag(){
  $('.current').replaceWith($('<a href ="' + url + currentPage + '">' + currentPage + '</a>'));
  $('.aux').addClass('current');
  $('.current').removeClass('aux');
}
function replaceEmTag(className){
  return $('<em class="'+className+'">' + newPage + '</em>');
}
function editPagination($tagA) {
  var emTag = $('<em class="aux">' + newPage + '</em>');
  if ($tagA.hasClass('previous_page')) {
    newPage = currentPage - 1;
    $('.current').prev().replaceWith(replaceEmTag('aux'));
    replaceAtag();
  } else if ($tagA.hasClass('next_page')){
    newPage = currentPage + 1;
    $('.current').next().replaceWith(replaceEmTag('aux'));
    replaceAtag();
  } else {
    newPage = parseInt($tagA.text());
    $('.current').replaceWith($('<a href ="' + url + currentPage + '">' + currentPage + '</a>'));
    $tagA.replaceWith(replaceEmTag('current'));
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