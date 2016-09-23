var btnApply;
var btnLeave;

document.addEventListener('DOMContentLoaded', function(event){
		btnApply = document.getElementsByClassName('js-btn-apply')[0];
		btnLeave = document.getElementsByClassName('js-btn-leave')[0];

		btnApply.onclick = onclickApply;
});

function onclickApply(event){
	var projectId = btnApply.getAttribute('data-id');
	var category = document.getElementsByClassName('js-category')[0];
	var container = document.getElementsByClassName('js-container-options')[0];
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

function showLeave(response){
	if(response.status === 200){
		container.removeChild(btnApply);
		console.log('hola')
		category.setAttribute('hidden');
		var btn = document.createElement("button");
		var text = document.createTextNode('Leave');
		btn.classList.add('js-btn-leave');

	}; 
};

