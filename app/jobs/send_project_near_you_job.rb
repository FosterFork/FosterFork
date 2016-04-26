class SendProjectNearYouJob
  include SuckerPunch::Job

  def perform(project)
    User.where.not(project_proximity: nil, latitude: nil, longitude: nil).each do |user|
      next if Geocoder::Calculations.distance_between(user, project, units: :km) > user.project_proximity.to_f
      next unless user.should_get_new_mail_about?(project)

      ProjectMailer.new_project_near_you_mail(project, user).deliver_now
      Rails.logger.info "Geolocation-based mail about #{project.slug} delivered to #{user.name} <#{user.email}>"
    end
  end
end
