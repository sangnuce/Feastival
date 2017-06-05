class ReportsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def create
    @report = current_user.owned_reports.build report_params
    if @report.save
      flash[:success] = t ".created"
    else
      flash[:error] = t ".not_created"
    end
    redirect_to current_user
  end

  private
  def report_params
    params.require(:report).permit :content, :reported_id, :reported_type
  end
end
