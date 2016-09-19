# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = User.create([
	{name: 'Rocio', email: 'rocio@gmail.com', password: '123456', city: 'Madrid'},
	{name: 'Rosa', email: 'rosa@gmail.com', password: '123456', city: 'Getafe'},
	{name: 'Sara', email: 'sara@gmail.com', password: '123456', city: 'Lisboa'},
	{name: 'Saro', email: 'saro@gmail.com', password: '123456', city: 'Madrid'},
	{name: 'Sarna', email: 'sarna@gmail.com', password: '123456', city: 'Amsterdam'}
	])	

projects = Project.create([
	{project_type: 'web', name: 'code', purpose: '123456', description: 'Madrid'},
	{project_type: 'mobile', name: 'code1', purpose: '123456', description: 'Getafe'},
	{project_type: 'web', name: 'code2', purpose: '123456', description: 'Lisboa'},
	{project_type: 'mobile', name: 'code3', purpose: '123456', description: 'Madrid'},
	{project_type: 'web', name: 'code4', purpose: '123456', description: 'Amsterdam'}
	])	








