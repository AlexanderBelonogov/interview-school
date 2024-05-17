class SubjectsController < ApplicationController
  include Responder
  before_action :set_subject, only: %i[show edit update destroy]

  # GET /subjects
  # GET /subjects.json
  def index
    @subjects = Subject.all
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show; end

  # GET /subjects/new
  def new
    @subject = Subject.new
  end

  # GET /subjects/1/edit
  def edit; end

  # POST /subjects
  # POST /subjects.json
  def create
    @subject = Subject.new(subject_params.merge(teacher_subjects_params))

    respond_on_create(@subject)
  end

  # PATCH/PUT /subjects/1
  # PATCH/PUT /subjects/1.json
  def update
    respond_on_update(@subject, teacher_subjects_params)
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    @subject.destroy
    respond_on_destroy(subjects_url)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_subject
    @subject = Subject.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def subject_params
    params.require(:subject).permit(:name, :description)
  end

  def teacher_subjects_params
    return {} if params[:subject][:teacher_ids].nil?

    @subject.teacher_subjects.each(&:mark_for_destruction) if @subject.present?
    {
      teacher_subjects_attributes: params[:subject][:teacher_ids].reject(&:empty?).map { |id| {teacher_id: id} }
    }
  end
end
