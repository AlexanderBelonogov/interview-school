json.extract! section, :id, :teacher_subject_id, :classroom_id, :start_at, :end_at, :week_days, :duration
json.classroom_name section.teacher_subject.subject_name
json.section_name section.teacher_subject.subject_name
json.teacher_name section.teacher_subject.first_and_last_name %></td>
json.url section_url(section, format: :json)