class SendProjectCommentsJob
  include SuckerPunch::Job

  def perform(project, comment)
    if comment.user != project.owner
      ProjectMailer.comment_mail(comment, project, project.owner, nil).deliver_now
      Rails.logger.info "Message ##{comment.id} ('#{comment.message.title}') delivered to #{project.owner.name} <#{project.owner.email}>"
    end

    project.participations.each do |participation|
      user = participation.user
      next if comment.user == user
      ProjectMailer.comment_mail(comment, project, user, participation).deliver_now
      Rails.logger.info "Message ##{comment.id} ('#{comment.message.title}') delivered to #{user.name} <#{user.email}>"
    end
  end
end
