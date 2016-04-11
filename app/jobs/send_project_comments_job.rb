class SendProjectCommentsJob
  include SuckerPunch::Job

  def perform(project, comment)
    project.participations.each do |participation|
      next if comment.user == participation.user
      ProjectMailer.comment_mail(comment, participation).deliver_now
      user = participation.user
      Rails.logger.info "Message ##{comment.id} ('#{comment.message.title}') delivered to #{user.name} <#{user.email}>"
    end
  end
end
