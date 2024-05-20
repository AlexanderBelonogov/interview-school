class StudentSectionsController < ApplicationController
  before_action :_set_student_section, only: %i[destroy]
  before_action :_set_section, only: %i[new create]

  def new
    @student_section = StudentSection.new(section: @section)
  end

  def create
    @student_section = StudentSection.new(_student_section_params)
    @student_section.section = @section
    if @student_section.save
      flash[:notice] = 'Student was successfully added'
    else
      render :new
    end
  end

  def destroy
    @student_section.destroy!
    flash[:notice] = 'Student was successfully removed'
  end

  private

  def _set_student_section
    @student_section = StudentSection.find(params[:id])
  end

  def _set_section
    @section = Section.find params[:section_id]
  end

  def _student_section_params
    params.require(:student_section).permit(:student_id)
  end
end
