class RequestsController < ApplicationController
  before_action :logged_in_user
  before_action :load_request, only: :destroy

  def index
    @requests = current_user.requests.order_created_at
      .paginate page: params[:page], per_page: Settings.request.per_page
    respond_to do |format|
      format.html
      format.xls 
      format.csv {send_data @requests.to_csv}
    end
  end

  def create
    @request = current_user.requests.build request_params
    if @request.save
      flash[:success] = t "controllers.requests.create_success"
    else
      flash[:danger] = @request.errors.full_messages
    end
    redirect_to requests_url
  end

  def destroy
    if @request.destroy
      flash[:success] = t "controllers.requests.destroy_success"
    else
      flash[:danger] =  t "controllers.requests.destroy_error"
    end
    redirect_to requests_url
  end

  private
  def request_params
    params.require(:request).permit :book_name, :author, :description
  end

  def load_request
    @request = Request.find_by id: params[:id]
    unless @request
      flash[:danger] = t "controllers.requests.destroy_error"
      redirect_to requests_url
    end
  end
end
