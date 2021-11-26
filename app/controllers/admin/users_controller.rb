class Admin::UsersController < ApplicationController
  before_action :require_user, :nivel_admin?, except: [:login, :do_login, :logout]
  before_action :set_user, only: %i[ show edit update destroy ]

  layout 'admin'

  # ======================================================================
  # Login methods ========================================================
  # ======================================================================
  # admin/users/login.erb
  def login
  end

  # admin/users/logout.erb
  def logout
    # current_user = User.find_by_email_and_id(session[:email], session[:uid])
    session[:email] = nil
    session[:uid] = nil
    reset_session

    redirect_to login_admin_users_url, notice: "Usuario deslogado"
  end

  # Identifica o usuario, caso valido e as credenciais baterem, armazena os dados de login
  # caso erro redirecona para o login com o erro
  def do_login
    if params[:email].blank?
      redirect_to login_admin_users_path, alert: "Você precisa digitar um email"
    else
      if params[:senha].blank?
        redirect_to login_admin_users_path, alert: "Precisa digitar sua senha."
      else
        user = User.find_by_email params[:email]
        if user.nil?
          redirect_to login_admin_users_path, alert: "Usuario nçao consta no banco de dados."
        else
          #verifica se senhas batem
          if user.senha == params[:senha]
            # armazena as variaveis na sessao
            session[:uid] = user.id
            session[:email] = user.email
            cookies.signed[:user_id] = user.id
            redirect_to admin_users_path, notice: "Bem vindo de volta, #{current_user.email}"
          else
            redirect_to login_admin_users_path, alert: "senha errada"
          end
        end
      end
    end
  end

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
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
        format.html { redirect_to @user, notice: "User was successfully created." }
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
        format.html { redirect_to @user, notice: "User was successfully updated." }
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
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
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
