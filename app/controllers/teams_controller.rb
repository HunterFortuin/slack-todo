class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  def index
    @teams = Team.all
  end

  def show
  end

  def new
    @team = Team.new
  end

  def edit
  end

  def create
    @team = Team.new(team_params)
    if @team.save
        current_user.teams << @team
        redirect_to team_path(@team)
    else
        render 'new'
    end
  end

  def update
    if @team.update_attributes(team_params)
        redirect_to team_path(@team)
    else
        render 'edit'
    end
  end

  def destroy
    @team.destroy
    redirect_to root_path, notice: "Team destroyed"
  end

  private
  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :slack_token)
  end
end
