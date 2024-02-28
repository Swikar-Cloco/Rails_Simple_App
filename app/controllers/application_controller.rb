class ApplicationController < ActionController::Base
    # By the use of helper method we are defining them as helpers not only for controllers but also for views
    helper_method :current_user, :logged_in?
    def testMethod
        render html: 'Helloo CLOCO'
    end

    # Brought the helper methods stored in application_helper.rb which were only accesible to views now we will make these available for all the controllers and views.
    # to make these accessible to views also we need to define them as helper method which is done by using helper_method and passing names of the methods which are to be helpers 
    def current_user
        # Memorization concept, it simply gives @current_user if it's there if it's not there then it assigns value after querying User.find(session[:user_id]) if session[:user_id]
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    
    def logged_in?
        # !! bang bang is used to turn current user to boolean. It calls current_user and if yes true if no false
        !!current_user

    end
    def require_user
        if !logged_in?
            flash[:notice] = "Login required to perform that action"
            redirect_to login_path
        end
    end

    def require_same_user
        if (current_user.admin==true)
            puts current_user.admin.to_s + " - Admin is true" 
        elsif @article
            if((current_user.id != @article.user_id))
                puts current_user.id
                puts @article.user_id
                flash[:notice] = "You are not authorized for this action"
                redirect_to articles_path
            end
            # if ((current_user.id != @article.user_id) || (current_user.admin!=true))
            #     flash[:notice] = "You are not authorized for this action"
            #     redirect_to articles_path 
            # end
        elsif @user
            if((current_user.id != @user.id))
                puts current_user.id
                puts @user.id
                flash[:notice] = "You are not authorized for this action"
                redirect_to articles_path
            end
            # if ((current_user.id != @user.id) || (current_user.admin!=true))
            #     flash[:notice] = "You are not authorized for this action"
            #     redirect_to articles_path 
            # end
        end
    end
end
