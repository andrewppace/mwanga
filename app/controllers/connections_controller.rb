class ConnectionsController < ApplicationController
  def index
    @contacts = @current_user.connections
  end
end
