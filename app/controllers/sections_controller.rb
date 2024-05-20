class SectionsController < ApplicationController
  include Responder

  before_action :set_section, only: %i[show destroy]

  # GET /sections
  # GET /sections.json
  def index
    @sections = Section.includes(
      { teacher_subject: [:teacher, :subject] },
      :classroom,
      :student_sections
    ).all
  end

  # GET /sections/1
  # GET /sections/1.json
  def show; end

  # GET /sections/new
  def new
    @section = Section.new
  end

  # POST /sections
  # POST /sections.json
  def create
    @section = Section.new(section_params)
    respond_on_create(@section)
  end

  # DELETE /sections/1
  # DELETE /sections/1.json
  def destroy
    @section.destroy
    respond_on_destroy(sections_url)
  end

  private

  def section_params
    params.require(:section).permit(:teacher_subject_id, :classroom_id, :start_at, :week_days, :duration)
  end

  def set_section
    @section = Section.includes(:student_sections).find(params[:id])
  end
end
