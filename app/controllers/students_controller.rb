class StudentsController < ApplicationController
  include Responder

  before_action :set_student, only: %i[show edit update destroy download]

  # GET /students
  # GET /students.json
  def index
    @students = Student.all
  end

  # GET /students/1
  # GET /students/1.json
  def show; end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit; end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)
    respond_on_create(@student)
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_on_update(@student, student_params)
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_on_destroy(students_url)
  end

  def download
    pdf = PdfService.new(@student)
    send_file(pdf.create, filename: "#{@student.display_name}.pdf", type: 'application/pdf', disposition: 'inline')
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:username, :first_name, :last_name)
  end
end
