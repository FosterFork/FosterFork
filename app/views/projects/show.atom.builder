atom_feed do |feed|
  feed.title @project.title
  feed.description "#{Settings.platform_name} - #{@project.abstract}"
  feed.updated @project.last_update
  feed.icon "/favicon.ico"
  #feed.logo ...

  feed.entry(@project) do |entry|
    entry.title @project.title
    entry.summary @project.abstract
    entry.content layout_render_markdown(@project.description), type: :html
    entry.author @project.owner.name
    entry.updated @project.updated_at
  end

  @project.messages.each do |message|
    feed.entry(@project, url: project_url(@project, anchor: "message-#{message.id}")) do |entry|
      entry.id "project-#{@project.id}--message-#{message.id}"
      entry.title "#{message.title}"
      #entry.summary ...
      entry.content message.content, type: :text
      entry.author message.user.name
      entry.updated message.updated_at
    end
  end
end
