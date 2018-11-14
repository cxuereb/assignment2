require "dm-core"
require "dm-migrations"
#Dir.pwd is class method of Dir
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/student.db")
#https://app16418.herokuapp.com/songs

class Student
  include DataMapper::Resource # mixin
  property :id, Serial
  property :firstname, String
  property :lastname, String
  property :address, Text
  property :birthday, Date
  property :grade, Integer
end

class Comment
  include DataMapper::Resource # mixin
  property :name, String
  property :content, Text
  property :created_at, Date
end

DataMapper.finalize


get '/students' do
 @students = Student.all
 erb :students
end

get '/comment' do
  @comments = Comment.all
  erb :comment
end

get '/video' do
  erb :video
end

get '/login' do
  erb :login
end

post '/login' do
      if params[:username] == settings.username &&
         params[:password] == settings.password
        session[:admin] = true
        redirect to ('/students')
      else
          erb :login
      end
end

get '/logout' do
  session.clear
  "logging out..."
end
