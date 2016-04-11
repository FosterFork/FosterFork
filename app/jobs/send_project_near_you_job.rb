class SendProjectNearYouJob
  include SuckerPunch::Job

  def perform(project)
    return if Settings.user_proximity.nil?

    User.near(project, Settings.user_proximity.to_i).each do |user|
      if user.should_get_new_mail_about?(project)
        ProjectMailer.new_project_near_you_mail(project, user).deliver_now
        Rails.logger.info "Geolocation-based mail about #{project.slug} delivered to #{user.name} <#{user.email}>"
      end
    end
  end
end
