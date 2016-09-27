var list = "";
var formEdit;
document.addEventListener('DOMContentLoaded', function(event){
	if(window.location.pathname == "/edit") {
		var btn = document.getElementsByClassName('js-add-skill')[0];
		var input = document.getElementsByClassName('js-skill')[0];
		list = document.getElementsByClassName('added-skills')[0];
		formEdit = document.getElementsByClassName('edit_user')[0];
		var skills = [];

		//btn.onclick = onclickAddSkill;
		//formEdit.onsubmit = submitEdit;
		btn.addEventListener("click", onclickAddSkill);
		formEdit.addEventListener("click", submitEdit);
	};
});

function onclickAddSkill(e){
	e.preventDefault();
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
};

function submitEdit(e){
	e.preventDefault();
	input.value = skills;
	console.log('makna');
	this.submit();
};





