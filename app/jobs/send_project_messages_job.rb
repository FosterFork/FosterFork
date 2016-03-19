class SendProjectMessagesJob
  include SuckerPunch::Job

  def perform(project, message)
    project.participations.each do |participation|
      ProjectMailer.message_mail(message, participation).deliver_now
      user = participation.user
      Rails.logger.info "Message ##{message.id} ('#{message.title}') delivered to #{user.name} <#{user.email}>"
    end
  end
end
