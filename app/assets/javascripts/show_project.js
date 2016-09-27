var btnApply;
var btnLeave;
var category;
var container;

document.addEventListener('DOMContentLoaded', function(event){
		btnApply = document.getElementsByClassName('js-btn-apply')[0];
		btnLeave = document.getElementsByClassName('js-btn-leave')[0];
		category = document.getElementsByClassName('js-category')[0];
		container = document.getElementsByClassName('js-container-options')[0];

		//delegación de eventos
		// container.addEventListener('click', function(event) {
	  //    var clickedEl = event.target;
	  //    if(clickedEl.className[0] === 'js-btn-apply') {
	  //       onclickApply;
	  //    }
		// });

		// container.addEventListener("click", function(e) {
    //   	for (var target=e.target; target && target!=this; target=target.parentNode) {
  	//   		// loop parent nodes from the target to the delegation node
  	//       if (target.className('js-btn-apply')) {
  	//         onclickApply.call(target, e);
  	//         break;
  	//       }
  	//     }
		// }, false);

		$(".js-container-options").on('click', ".js-btn-apply", onclickApply);

		$(".js-container-options").on('click', ".js-btn-leave", onclickLeave);

		// container.addEventListener('click', function(event) {
	  //    var clickedEl = event.target;
	  //    if(clickedEl.className[0] === 'js-btn-leave') {
	  //       onclickLeave;
	  //    }
		// });

});

function onclickApply(event){
	btnApply = document.getElementsByClassName('js-btn-apply')[0];
	var projectId = btnApply.getAttribute('data-id');
	var query = '/api/v1/projects/' + projectId + '/apply';
	var data = {
		category: category.value
	}
	$.ajax({
		type: 'POST',
		url: query,
		data: data,
		success: showLeave
	});
	// proxy('POST', query, 'json', category.value).then(showLeave);
};

function onclickLeave(event){
	btnLeave = document.getElementsByClassName('js-btn-leave')[0];
	var projectId = btnLeave.getAttribute('data-id');
	var query = '/api/v1/projects/' + projectId + '/leave';
	$.ajax({
		type: 'POST',
		url: query,
		success: showApply
	});
	// proxy('POST', query, 'json', category.value).then(showLeave);
};

function showLeave(response){
	//no funciona el if(response.status === 200)
	console.log('hola')
	btnApply.setAttribute('style', 'display: none');
	category.setAttribute('style', 'display: none');
	btnLeave.setAttribute('style', 'display: block'); 
};

function showApply(response){
	console.log('hola')
	btnLeave.setAttribute('style', 'display: none');
	category.setAttribute('style', 'display: inline-block');
	btnApply.setAttribute('style', 'display: block');
};

// function showLeave(response){
// 	//no funciona el if(response.status === 200)
// 	console.log('hola')
// 	var btnApply = document.getElementsByClassName('js-btn-apply')[0];
// 	var idProject = btnApply.getAttribute('data-id');
// 	category.setAttribute('hidden', 'true');
// 	var btn = document.createElement("button");
// 	var text = document.createTextNode('Leave');
// 	btn.appendChild(text);
// 	btn.classList.add('js-btn-leave');
// 	btn.setAttribute('data-id', idProject);
// 	container.appendChild(btn);
// 	container.removeChild(btnApply); 
// };

// function showApply(response){
// 	console.log('hola')
// 	var btnLeave = document.getElementsByClassName('js-btn-leave')[0];
// 	var idProject = btnLeave.getAttribute('data-id');
// 	category.removeAttribute('hidden');
// 	var btn = document.createElement("button");
// 	var text = document.createTextNode('Apply');
// 	btn.appendChild(text);
// 	btn.classList.add('js-btn-apply');
// 	btn.setAttribute('data-id', idProject);
// 	container.appendChild(btn);
// 	container.removeChild(btnLeave); 
// };

