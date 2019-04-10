SimpleCov.start 'rails' do
  add_group "Presenters", "app/presenters"
  add_group "Queries", "app/queries"
  add_group "Services", "app/services"

  add_filter "app/jobs/application_job.rb"

end
