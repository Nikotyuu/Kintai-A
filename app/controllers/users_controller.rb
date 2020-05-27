class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:index,:destroy, :edit_basic_info, :update_basic_info]
  before_action :admin_or_correct_user, only: [:show]
  before_action :set_one_month, only: :show
  before_action :not_admin_user, only: :stow
  

  def index
   @users = User.all
    respond_to do |format|
      format.html do
          #html用の処理を書く
      end 
      format.csv do
          #csv用の処理を書く
          send_data render_to_string, filename: "(ファイル名).csv", type: :csv
      end
    end
   if params[:search]
      @users = User.where('LOWER(name) LIKE ?', "%#{params[:search][:name].downcase}%").paginate(page: params[:page])
   else
      @users = User.paginate(page: params[:page])
   end
  end
  
  def import
    if params[:file].blank?
      flash[:danger] = "インポートするCSVファイルを選択してください。"
      redirect_to users_url
    else
      User.import(params[:file])
      flash[:success] = "CSVファイルをインポートしました。"
      redirect_to users_url
    end
  end


  def show
    @users = User.all
    respond_to do |format|
      format.html do
          #html用の処理を書く
      end 
      format.csv do
          #csv用の処理を書く
      end
    end
      @attendances_list = Attendance.where(name: current_user.name).where.not(user_id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
  @users = User.paginate(page: params[:page], per_page: 20)
  @user = User.find(params[:id])
  if @user.update_attributes(user_params)
    flash[:success] = "アカウント情報を更新しました。"
    redirect_to users_url
  else
    render :index
  end
  end

  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end

  def edit_basic_info
  end
  
  def edit4_basic_info
    @attendance = Attendance.find_by(worked_on: params[:data])
  end
  
  def edit3_basic_info
  end
  

  def update_basic_info
    if @user.update_attributes(basic_info_params)
      flash[:success] = "#{@user.name}の基本情報を更新しました。"
    else
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
    end
    redirect_to users_url
  end

   def will_paginate
   end
   
   
   def not_admin_user
     redirect_to root_url if current_user.admin?
   end
     
   def admin_user
     if current_user.admin?
        flash[:danger] = "管理者には勤怠画面を閲覧できません"
        redirect_to root_url
     end
   end
   
   def admin_or_correct_user
   end
   
   def syukkin
     Attendance.where.not(started_at: nil).each do |attendance|
      if (Date.current == attendance.worked_on) && attendance.finished_at.nil?
        @users = User.all.includes(:attendances)
      end
    end
   end
   
   


  private

    def user_params
      params.require(:user).permit(:name, :email, :affiliation, :employee_number, :uid, :basic_work_time, :designated_work_end_time, :designated_work_start_time, :department, :password, :password_confirmation)
    end

    def basic_info_params
      params.require(:user).permit(:basic_work_time)
    end
    
end