class ConnectionsController < ApplicationController
  before_filter :add_breadcrumbs
  def index
    @contacts = @current_user.connections
  end
private
  def add_breadcrumbs
    @breadcrumbs.add "my account", account_path
    @breadcrumbs.add "connections", connections_path
  end
end
