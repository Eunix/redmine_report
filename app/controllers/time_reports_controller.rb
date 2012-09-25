class TimeReportsController < ApplicationController
  unloadable

  before_filter :require_login

  def index
  end

  def create
    @reports = Report.get(params[:group], params[:week])

    render :layout => 'report'
  end



end
