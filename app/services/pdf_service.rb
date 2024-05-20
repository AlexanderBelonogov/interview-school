class PdfService
  attr_reader :student, :tmp_file

  HEADER = ['Number', 'Subject', 'Teacher', 'Classroom', 'Time']

  def initialize(student)
    @student = student
    @tmp_file = File.join(Dir.tmpdir, SecureRandom.uuid)
  end

  def create
    with_pdf_service do |pdf|
      pdf.text("Schedule #{student.display_name}", align: :center, size: 16)
      pdf.move_down(5)
      pdf.font_size(12)
      render_schedule_table(pdf)
    end
    tmp_file
  end

  def close_file
    tmp_file.close!
  end

  private

  def render_schedule_table(pdf)
    pdf.table(build_details, cell_style: { size: 8 }, position: :center ) do |table|
      table.row(0).font_style = :bold
      table.cells.borders = []
      table.row(-1).borders = [:top]
      table.column(5).align = :right
    end
  end

  def build_details
    result = [HEADER]
    student.sections.each.with_index(1) do |section, i|
      result << build_row(section, i)
    end
    result
  end

  def build_row(section, number)
    teacher_subject = section.teacher_subject
    [
      number,
      teacher_subject.subject_name,
      teacher_subject.first_and_last_name,
      section.classroom_number,
      "#{section.start_at_to_am_pm} - #{section.end_at_to_am_pm}",
    ]
  end

  def with_pdf_service
    Prawn::Document.generate(tmp_file) do |pdf|
      yield pdf
    end
  end
end