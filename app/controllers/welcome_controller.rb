class WelcomeController < ApplicationController
  def index
    flash[:notice] ="早上好啊……^_^"

  end

end
