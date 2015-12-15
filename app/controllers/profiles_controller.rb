class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:show, :edit, :update]

  def new
    return redirect_to action: :edit if current_user.profile
    @profile = Profile.new
  end

  def create
    @profile = current_user.build_profile(profile_params)

    if @profile.save
      redirect_to action: :show
    else
      redirect_to :back
    end
  end

  def edit
    return redirect_to action: :new unless current_user.profile
  end

  def show
    return redirect_to action: :new unless current_user.profile
    redirect_to action: :edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to action: :show
    else
      redirect_to :back
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:sex, :birthday, :prefecture, :job)
  end

  def set_profile
    @profile = current_user.profile
  end
end
