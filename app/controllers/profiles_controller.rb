class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[ show edit update destroy ]
  before_action :same_profile?, only: %i[edit update destroy]
  skip_before_action :user_has_profile?, only:  %i[ new create ]

  def index
    @profiles = Profile.all
  end

  def show
  end

  def new
    @profile = Profile.new
  end

  def edit
  end

  def create
    @profile = current_user.build_profile(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: "Profile was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: "Profile was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @profile.destroy!

    respond_to do |format|
      format.html { redirect_to profiles_path, status: :see_other, notice: "Profile was successfully destroyed." }
    end
  end

  private
    def set_profile
      @profile = Profile.find(params[:id])
    end

    def profile_params
      params.require(:profile).permit(:name, :city, :country, :birth, :gender, :role)
    end

    def same_profile?
      redirect_to users_path if current_user != @profile.user && !current_user.profile.superadmin?
    end
end
