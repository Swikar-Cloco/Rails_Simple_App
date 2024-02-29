class SessionsController < ApplicationController
    def new
        if logged_in?
            redirect_to articles_path   
        end
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            #  session instance method can be used to create a session and that session will be stored in cookie or cache in the browser
            session[:user_id] = user.id
            flash[:notice] = "Logged in successfully"
            redirect_to articles_path

        else
            
            # flash notice is persists for a request respond cycle so flash would work when req-resp cucle happens while using redirect or similar methods but if we need to use flash without a complete cycle we have to use flash.now but it's not working 
            flash.now[:notice] = "Login Failed"
            # flash[:notice] = "Fail"
            # redirect_to login_path
            render 'new'
        end


        
    end

    def destroy
        # to logout we just simply need to kill the session, or empty the session
        puts "AsdasdASdASdASdAsdASdASd"
        puts "Destroyed sssssssssssssssssssssssssssssssssssssssssssssssssss"
        puts @user
        puts current_user
        # if (@user == current_user)
        session[:user_id] = nil
        puts session[:user_id]
        puts "AsdasdASdASdASdAsdASdASd"
        flash[:notice] = "Logged out"
        redirect_to root_path
        # end
    end
end