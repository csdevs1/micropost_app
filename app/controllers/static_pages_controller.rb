class StaticPagesController < ApplicationController
    before_action :not_logged_in, only: [:home]
    
    def home
    end
    
    def help
    end
    
    def about
    end
    
    def contact
    end
    
    private
        def not_logged_in
            redirect_to(current_user) unless !logged_in?
        end
end