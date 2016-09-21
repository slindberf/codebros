document.addEventListener('DOMContentLoaded', function(event){
	btn = document.getElementsByClassName('js-add-skill')[0];
	input = document.getElementsByClassName('js-skill')[0];
	list = document.getElementsByClassName('added-skills')[0];
	
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
});




