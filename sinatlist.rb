require 'sinatra'
require 'active_record'
require 'yaml'

# Connect DB
ActiveRecord::Base.configurations = YAML.load_file('./model/database.yml')
ActiveRecord::Base.establish_connection(:development)

# Connect table
connection = ActiveRecord::Base.connection

unless connection.table_exists?(:students)
  connection.create_table :students do |stu|
#    stu.column :name, :string, null: false
#    stu.column :email, :string, null: false
    stu.column :name, :string
    stu.column :email, :string
#    stu.timestamps
  end
end

class Student < ActiveRecord::Base
end

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

#get '/:id/edit' do
#  @student = Student.find(params[:id])
#  erb :edit
#end

get '/:id/edit' do
  @student = Student.find(params[:id])
  erb :edit
end

put '/:id' do
  student = Student.find(params[:id])
  student.update_attributes!(
    id:		params[:id],
    name:	params[:name],
    email:	params[:email]
  )
  redirect '/'
end
