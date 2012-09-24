class TimeReportsController < ApplicationController
  unloadable

  def index
  end

  def create
    @reports = Report.get(params[:group], params[:week])
  end
end
