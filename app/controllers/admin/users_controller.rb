class Admin::UsersController < ApplicationController
  before_action :require_user, :admin?, except: [:login, :do_login, :create]
  before_action :set_user, only: %i[ show edit update destroy ]

  layout "admin"

  #==========================================================
  # LOGIN ===================================================
  #==========================================================

  def login
    @user_exists = true

    unless User.exists?
      @user_exists = false
      @user = User.new
    end

    render layout: "login"
  end

  #==========================================================
  # verificação de usuario e login
  def do_login
    unless params[:email].blank?
      user = User.find_by_email params[:email]
      if user.blank?
        #retornar erro
         redirect_to login_admin_users_url, alert: "E-mail invalido."
      else
        #verificar senha
        if user.senha == params[:senha]
          session[:email] = user.email
          session[:uid]   = user.id
          cookies.signed[:user_id] = user.id

          redirect_to admin_main_index_url
        else
          #senha errada
          redirect_to login_admin_users_url, alert: "Senha errada."
        end
      end
    else
      redirect_to login_admin_users_url, alert: "Por favor digite um email valido."
    end
  end

  #==========================================================
  # desloga usuário
  def logout
    unless @current_user.blank?
      session[:email] = nil
      session[:uid]   = nil
      reset_session
    end
    redirect_to login_admin_users_url
  end
  #==========================================================
  # FUNCTIONS ===============================================
  #==========================================================

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to edit_admin_user_path(@user), notice: "Usuário cadastrado com sucesso." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to edit_admin_user_path(@user), notice: "Usuário editado com sucesso." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: "Usuário deletado com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :nome, :senha, :tipo)
    end
end
