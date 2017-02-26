class MembershipsController < ApplicationController
  def create
    @member = Membership.find_by(name: params[:name])
    if @member
      @memberships = @member
    else
    @membership = Membership.new(name: params[:name])
    @membership.save
    user_membership = UserMembership.new(user_id: current_user.id, membership_id: @membership.id)
    if user_membership.save
      flash[:success] = "You have added you gym!"
    end
    redirect_to "/users/#{current_user.id}/edit"
    end
  end
end
