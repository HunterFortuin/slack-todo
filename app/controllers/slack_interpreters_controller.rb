class SlackInterpretersController < ApplicationController
    def new_task
        team = Team.find_by_slack_token(params[:token])
        user = team.present? ? team.users.find_by_slack_username(params[:user_name]) : nil
        user_id = user.present? ? user.id : nil
        description = params[:text]

        task = Task.new(description: description, user_id: user_id)

        if task.save
            render status: 200, json: task
        else
            render status: :unprocessable_entity, json: task.errors
        end
    end
end
