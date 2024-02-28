class ArticlesController < ApplicationController
    before_action :find_article, only: [:edit, :update, :destroy ]
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy] 
    def show
        # the parameter passed in the URI transfers here in params in hash data structure (dictonary)
        # created instance variable so that it would be globally accessible
        @id = params[:id]
        @ids_in_Article = Article.ids

        # yes_exists = @exists.select {|ex_id| ex_id == @id} 

        @ids_in_Article.each do |id_from_table|
          if @id.to_s == id_from_table.to_s
            @yes_exists = true
            break
          else
            @yes_exists = false
          end
        end 
        # {|ex_id| ex_id == @id} 

        if @yes_exists==true 
            @article = Article.find(params[:id])
        else
            html_content = "<h2>No record found for "  + params[:id] + "</h2>"

            render html: html_content.html_safe
        end

    end
    
    def index
        # @articles = Article.all
        # instead of getting all the articles we are using pagination technique and we are getting limited items per page 
        @articles  = Article.paginate(page: params[:page], per_page: 5)
    end

    def new
      # When new is loaded for any old records/previously created records, below variable is false and when it is loaded after creating a new article 
      # this is not needed. Initially I was trying to make the form common for new creation and edition of old. 
      # But rails is smart enough to detect if new form needs to be generated of a form should be pre-filled if it is for edit depending upon the redirection we use
      # But I am leaving this as it is as I am learning and I want to remember this if I come back after a couple of month or maybe years
      @newArticleCreated = 0

      # if !logged_in?
      #   redirect_to login_path,  notice: "Please log in to create your own article."

      # end

    end

    # Edit generally should be after new and before create, if not put in order it might not work
    def edit
      # if current_user.id == @article.user_id
      #   puts "Can edit"
      # else
      #   puts "Can't edit"
      #   flash[:notice] = "You dont have permission for this action"
      #   redirect_to articles_path 
      # end
      # @article = Article.find(params[:id])
    end

    # def create
    #   puts params[:article]
    #   @parameter = params[:article]
    #   # render plain: params[:article]

    # end



    def create
      @article = Article.new(article_params)
      # Hard coding the value of user_id while creating article as authentication system has not been implemented
      # @article.user = User.find(2)
      @article.user = current_user


      # This block allows your controller to respond to different formats such as HTML, JSON, XML, etc. The block takes a format object that represents the format of the request.
      # But this is not necessary
      respond_to do |format|

        if @article.save
          # Flash helper for notice or alert to display flash messages. But it can be passed directly in another way 
          # flash[:notice] = "My desired notice"

          # This will do a simple redirect to article_path. The article is prefix of the GET route for the articles/:id URI or articles#show controller#action/method
          # redirect_to article_path(@article)
          # or it can be done
          # redirect_to @article
          # aswell.
          
          # The below code can also be used to redirect with notice and it iterates to different format
          format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
          format.json { render :show, status: :created, location: @article }

        else

          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    end

    # update generally should be after the create
    def update
      # for new creation we will create an object by .new mthod but for update we will find and update
      # @article = Article.new(article_params)

      # @article = Article.find(params[:id])
      puts @article
      
      if  @article.update(article_params)
        flash[:notice]="Successfully updated"
        redirect_to @article
      else
        
        # puts "This is flash notice for now"
        # puts    flash[:notice] 
        raw_errors = @article.errors.full_messages
        errors=[]
        raw_errors.each do |error|
          errors<<error
        end
        puts "final error"
        puts errors
        flash[:notice] = "Could not update. Error/s " + errors.to_s
        # @article.errors.full_messages
        # redirect_to edit_article_url(@article)
        render 'edit'
      end
      # if @article.save
      # respond_to do |format|
    end

    def destroy
      # @article = Article.find(params[:id])    
      @article.destroy
      flash[:notice] = "The user alongwith all related articles destroyed"
      redirect_to articles_path
    end

  
    private
  # the article_params method whitelists the two parameters title and descripton so that it can be passed to Article model. It's rails security feature from rails 4
    def article_params
      params.require(:article).permit(:title, :description)
    end

    # This methods is creted for refactoring the code
    # as the find method for Article is used multiple times, we created a method/action for this and we will setup and use before_action helper to execute this method before other methods where article find is done.
    def find_article
      @article = Article.find(params[:id])
    end



end