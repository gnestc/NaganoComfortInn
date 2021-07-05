require 'date'
module Admin
  class ReportsController < ApplicationController
    def show
      @report = Report.find(params[:id])
      respond_to do |format|
        format.pdf do
          render pdf: 'report-'+@report.id.to_s + "-" +@report.issue_date.to_s,
                 template: "admin/reports/show",
                 disposition: :inline,
                 encoding: 'utf8',
                 title: "report-no"+@report.id.to_s + "-" +@report.issue_date.to_s
        end
      end
    end

    def index
      @reports = Report.not_deleted
    end

    def new
      @today = Date.today.strftime("%F")
    end

    def edit

    end

    def create
      @report = Report.new(params[:report])
      @report.save
      redirect_to admin_report_path(@report, format: :pdf)
    end

    def update

    end

    def destroy
      @report = Report.find(params[:id])
      @report.update_column(:deleted_at, Date.today.to_formatted_s(:db))
      redirect_to admin_reports_path
    end
  end
end