class BackupsController < ApplicationController
  # POST /backups.json
  def create
    @host = Host.find(params[:host_id])
    @backup = @host.backups.new(params[:backup])

    respond_to do |format|
      if @backup.save
        format.json { render json: @backup, status: :created, location: host_backups_path(@host) }
      else
        format.json { render json: @backup.errors, status: :unprocessable_entity }
      end
    end
  end
end
