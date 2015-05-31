class SlackInterpretersController < ApplicationController
    skip_before_action :authenticate_user!

    def tasks
        if params[:text].include?("showalltasks")
            redirect_to all_tasks_slack_interpreters_url(params)
        else
            new_task
        end
    end

    def new_task
        team = Team.find_by_slack_token(params[:token])
        user = team.present? ? team.users.find_by_slack_username(params[:user_name]) : nil
        user_id = user.present? ? user.id : nil
        description = params[:text]

        task = Task.new(description: description, user_id: user_id)

        if task.save
            render status: 200, json: "#{task.description} has been added to your to do list."
        else
            render status: :unprocessable_entity, json: "#{task.errors.full_messages.to_sentence} - Make sure everything is configured correctly."
        end
    end

    def all_tasks
        team = Team.find_by_slack_token(params[:token])
        user = team.present? ? team.users.find_by_slack_username(params[:user_name]) : nil

        if user.present?
            render status: 200, json: "#{user.tasks.where(complete: false).map { |t| "* #{t.description}" }}"
        else
            render status: 200, json: "Your configuration is messed up. Make sure your token and slack username are correct."
        end
    end
end
