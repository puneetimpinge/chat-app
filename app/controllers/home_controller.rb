require 'optparse'
require 'xmpp4r'
include Jabber

class HomeController < ApplicationController
  def index
  	if session.has_key?('user1') || session.has_key?('user2') || session.has_key?('password')
  		session.delete('user1')
  		session.delete('user2')
  		session.delete('password')
  	end	
  end

  def  chat
  	session[:user1] = params[:data][:user1]
  	session[:user2] = params[:data][:user2]
  	session[:password] = params[:data][:password]
  end

  def send_message
  	begin
	  	myJID = JID.new("#{params[:user_1]}@li345-119/li345-119")
		myPassword = "#{params[:password]}"

		to = "#{params[:user_2]}@li345-119/li345-119"
		subject = 'sub'

		cl = Client.new(myJID)
		cl.connect('178.79.176.119','5222')
		cl.auth(myPassword)
		body = "#{params[:message]}"
		#body = STDIN.readlines.join
		m = Message.new(to, body).set_type(:normal).set_id('1').set_subject(subject)
		puts m.to_s
		cl.send(m)
		cl.close

		render :json => {:status => true}
	rescue
		render :json => {:status => false}
	end	
  end
end
