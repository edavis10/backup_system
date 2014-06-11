class BackupsController < ApplicationController
  # POST /backups.json
  def create
    @host = Host.find(params[:host_id])
    @backup = @host.backups.new(backup_params)

    respond_to do |format|
      if @backup.save
        format.json { render json: @backup, status: :created, location: host_backups_path(@host) }
      else
        format.json { render json: @backup.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def backup_params
    params.require(:backup).permit(:log)
  end
end
