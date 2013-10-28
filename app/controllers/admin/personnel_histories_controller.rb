class Admin::PersonnelHistoriesController < ApplicationController
  before_filter :get_record, only: [:show,:edit,:update,:destroy]

  def index
    @records = PersonnelHistory.where(trackable_id: params[:id])
  end

  def new
    @record = PersonnelHistory.new
    @journal = Journal.find(params[:journal_id])
  end

  def show
  end

  def create
    @journal = Journal.find(params[:journal_id])
    @record = @journal.personnel_histories.build(params[:personnel_history])

    respond_to do |f|
      if @journal.save
        f.html {redirect_to admin_journal_personnel_histories_path, notice: "Record successfully saved." }
      else
        f.html { render "new", errors: @record.errors.full_messages }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def get_record
    @record = PersonnelHistory.find(params[:id])
    @journal = Journal.find(params[:journal_id])
  end
end
