class Admin::RequestsController < ApplicationController
  
  def index
    @requests = Request.processing.order_created_at.paginate page:
      params[:requests_page], per_page: Settings.request.per_page

    @accepted = Request.accepted.order_updated_at.paginate page:
      params[:accepted_page], per_page: Settings.accepted.per_page

    @rejected = Request.rejected.order_updated_at.paginate page:
      params[:rejected_page], per_page: Settings.rejected.per_page

    respond_to do |format|
      format.html
      format.xls
      format.csv {send_data @accepted.to_csv}
    end
  end

  def update
    @request = Request.find_by id: params[:id]
    render file: Settings.page_404_url unless @request
    if @request.save
      @request.update_attributes status: params[:value]
      flash[:success] = t "admin.controller.update_success" 
      RequestMailer.send_email_accepted_request(@request).deliver_now
    else
      flash[:danger] = t "admin.controller.update_fail"
    end
    redirect_to admin_requests_path
  end
end
