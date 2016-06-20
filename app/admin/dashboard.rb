include ApplicationHelper

ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel "General information" do
          attributes_table_for :user do
            row("Deployed code revision") do
              code_revision
            end

            row("# of user accounts") do
              User.count
            end
            row("# of newsletter subscribers") do
              User.where(newsletter: true).count
            end

            row("# of publicy visible projects") do
              Project.publicly_visible.count
            end
            row("# of public projects") do
              Project.where(public: true).count
            end
            row("# of private projects") do
              Project.where(public: false).count
            end
            row("# of approved projects") do
              Project.where(approved: true).count
            end
            row("# of unapproved projects") do
              Project.where(approved: false).count
            end

            row("# of unresolved abuse_reports") do
              AbuseReport.where(resolver: nil).count
            end
          end
        end
      end

      column do
        panel "Latest Users" do
          table_for User.order('id DESC').limit(10) do
            column :name do |user|
              link_to user.name, [:admin, user]
            end

            column :email
            column :zip
            column :project_proximity
            column :confirmed do |user|
              status_tag(user.confirmed?)
            end
          end
        end
      end

    end

    columns do
      column do
        panel "Latest Approved Projects" do
          table_for Project.where(approved: true).order('id DESC').limit(10) do
            column :title do |project|
              link_to project.title, [:admin, project]
            end

            column :owner
            column :date
            column :public
          end
        end
      end

      column do
        panel "Latest Unapproved Projects" do
          table_for Project.where(approved: false).order('id DESC').limit(10) do
            column :title do |project|
              link_to project.title, [:admin, project]
            end

            column :owner
            column :date
            column :public
          end
        end
      end
    end

    columns do
      column do
        panel "Latest messages" do
          table_for Message.limit(10) do
            column :id do |message|
              link_to message.id, [:admin, message]
            end

            column :project

            column :user do |message|
              link_to message.user.name, [:admin, message.user]
            end

            column :title
            column :created_at
          end
        end
      end

      column do
        panel "Latest comments" do
          table_for Comment.limit(10) do
            column :id do |comment|
              link_to comment.id, [:admin, comment]
            end

            column :message

            column :user do |message|
              link_to message.user.name, [:admin, message.user]
            end

            column :content do |comment|
              comment.content.truncate(30)
            end

            column :created_at
          end
        end
      end
    end

    columns do
      column do
        panel "Unresolved Abuse Reports" do
          table_for AbuseReport.where(resolver: nil).order('id DESC').limit(10) do
            column :id do |abuse_report|
              link_to abuse_report.id, [:admin, abuse_report]
            end

            column :project do |abuse_report|
              link_to abuse_report.project.title, [:admin, abuse_report.project]
            end

            column :reporter do |abuse_report|
              link_to abuse_report.reporter.name, [:admin, abuse_report.reporter] unless abuse_report.reporter.nil?
            end

            column :reason do |abuse_report|
              abuse_report.reason.truncate(100) rescue ""
            end
          end
        end
      end

      column do
        panel "Latest Inqueries" do
          table_for Inquiry.limit(10) do
            column :id do |inquiry|
              link_to inquiry.id, [:admin, inquiry]
            end

            column :project

            column :user do |inquiry|
              link_to inquiry.user.name, [:admin, inquiry.user]
            end

            column :content do |inquiry|
              inquiry.content.truncate(200)
            end

            column :created_at
          end
        end
      end

    end

  end
end
