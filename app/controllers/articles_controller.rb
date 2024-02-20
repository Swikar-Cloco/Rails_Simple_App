class ArticlesController < ApplicationController
    def show
        # the parameter passed in the URI transfers here in params in hash data structure (dictonary)
        # created instance variable so that it would be globally accessible
        @id = params[:id]
        @ids_in_Article = Article.ids

        # yes_exists = @exists.select {|ex_id| ex_id == @id} 

        @ids_in_Article.each do |ex_id|
          if @id.to_s == ex_id.to_s
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
            html_content = "<h1>No record found for "  + params[:id] + "</h1>"

            render html: html_content.html_safe
        end

    end
    
    def index
        @articles = Article.all
    end
end