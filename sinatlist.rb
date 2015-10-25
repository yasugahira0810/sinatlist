require 'sinatra'
require 'active_record'
require 'yaml'

ActiveRecord::Base.configurations = YAML.load_file('./model/database.yml')
ActiveRecord::Base.establish_connection(:development)

class Student < ActiveRecord::Base
end

#students = Student.all
#students.each do |stu|
#  puts stu.id + "\t" + stu.name + "\t" + stu.email
#end

get '/' do
  @students = Student.all
  erb :index
end

post '/new' do
  student = Student.new
  student.id = params[:id]
  student.name = params[:name]
  student.email = params[:email]
  student.save
  redirect '/'
end

delete '/del' do
  student = Student.find(params[:id])
  student.destroy
  redirect '/'
end
