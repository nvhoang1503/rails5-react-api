class Admin::HomeController < Admin::BaseController
  before_action :authenticate_admin!
  def index
  end
end
