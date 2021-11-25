class Admin::MainController < ApplicationController
  before_action :require_user, :admin?

  layout "admin"

  def index

  end
end