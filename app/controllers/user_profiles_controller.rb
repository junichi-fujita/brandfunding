class UserProfilesController < ApplicationController

  def edit
    @user = User.find(params[:id])
    @user_profile = @user.user_profile
  end

  def update
    flash[:notice] = '更新'
    @user = User.find(params[:id])
    if @user.user_profile.update(user_profile_params)
      redirect_to user_path(@user.id), notice: "プロフィールを更新しました。"
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :edit
    end
  end

  private

  def user_profile_params
    params.require(:user_profile).permit(
        :family_name,
        :family_name_sub,
        :last_name,
        :last_name_sub,
        :sex,
        :birthday,
        :add_no,
        :prefectures,
        :address,
        :phone_no1,
        :phone_no2
      )
  end

end
