class UsersController < ApplicationController
    skip_before_action :authorized, only: [:new, :create]
    layout 'base', except: [:new, :edit]
    #Sign Up for a user.
    def new
        redirect_to '/home' if logged_in?
        @user = User.new()
    end

    def create
        @user = User.new(user_params)
        validate(new_user_path)
    end

    
    def show
        @current_user = current_user
        @posts = @current_user.posts
        @top_ten_tags = Tag.tag_colors
    end

    def edit
        @user = current_user 
    end 

    def update 
        @user = current_user 
        @user.update(user_params)
        validate(edit_user_path)
    end 
    
    #Delete an account
    def destroy
        current_user.destroy
        redirect_to '/'
    end

    private

    def user_params 
        params.require(:user).permit(:user_name, :password, :password_confirmation, :image)
    end

    def validate(error_path)
        if @user.valid?
            @user.save()
            session[:user_id] = @user.id
            Conversation.default_convo(@user.id)
            redirect_to '/home'
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to error_path
        end
    end
end
