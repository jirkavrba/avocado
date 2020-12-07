class SubjectsController < ApplicationController
  before_action :authenticate!, except: [:index, :show]
  before_action :authorize, except: [:index, :show]
  before_action :set_subject, except: :index

  rescue_from CanCan::AccessDenied, with: :not_found_or_forbidden

  def index
    @subjects = Subject.all
  end

  def show
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.create subject_params
    redirect_to subjects_path
  end

  def edit
  end

  def update
    @subject.update subject_params
    redirect_to subjects_path
  end

  def destroy
    @subject.delete
    redirect_to subjects_path
  end

  private

  def authorize
    authorize! :modify, :subject
  end

  def set_subject
    @subject = Subject.find_by id: params[:id]
  end

  def subject_params
    params.require(:subject).permit(:title, :code)
  end

  def not_found_or_forbidden
    can?(:modify, :subject) ? not_found : forbidden
  end
end
