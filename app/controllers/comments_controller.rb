class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_message

  def create
    unless @message.can_be_comment_on_by? current_user
      return redirect_to @message.project
    end

    comment = Comment.new(permitted_params)
    comment.message = @message
    comment.user = current_user
    comment.save!

    redirect_to @message.project, flash: { success: t('comment.created') }
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy if comment and comment.can_be_deleted_by? current_user
    redirect_to @message.project, flash: { success: t('comment.deleted') }
  end

  private

  def find_message
    begin
      @message = Message.find(params[:message_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to projects_path, flash: { error: t('project.not_found') }
    end
  end

  def permitted_params
    params[:comment].permit([ :content ])
  end

end