document.addEventListener('DOMContentLoaded', function(event){
	var btn = document.getElementsByClassName('js-add-skill')[0];
	var input = document.getElementsByClassName('js-skill')[0];
	var list = document.getElementsByClassName('added-skills')[0];
	var formEdit = document.getElementsByClassName('edit_user')[0];
	//var userSkills = {}
	

	var skills = [];
	btn.onclick = function(e){
		e.preventDefault()
		var skill = input.value;
		skills.push(skill);
		input.value = "";
		printSkills(skill);
	};

	function printSkills(skill){
		var list_li = document.createElement("li");
		var skill_node = document.createTextNode(skill);
		list_li.appendChild(skill_node);
		list.appendChild(list_li);
	}

	formEdit.onsubmit=function(e){
		e.preventDefault();
		input.value = skills;
		console.log('makna');
		 this.submit();

	}
});






