class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def edit
  end

  def show
  end

  def update
    if @profile.update(profile_params)
      redirect_to action: :edit
    else
      redirect_to :back
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:sex, :birthday, :age, :prefecture, :job)
  end

  def set_profile
    @profile = current_user.profile || current_user.build_profile
  end
end
