class FriendshipsController < ApplicationController
  def destroy
    @friendships = current_user.friendships.find_by(friend_id: params[:id])
    @friendships.destroy
    respond_to do |format|
      format.html { redirect_to connect_path, notice: 'Successfully unfriended' }
      format.json { head :no_content }
    end
  end
end
