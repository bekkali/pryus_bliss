class AdministrateursController < ApplicationController
  def index
    @administrateurs = Administrateur.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @administrateurs }
    end
  end
  def show
    @administrateur = Administrateur.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @administrateur }
    end
  end
  
  def new
    @administrateur = Administrateur.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @administrateur }
    end
  end
  def create
    @administrateur = Administrateur.new(params[:administrateur])

    respond_to do |format|
      if @administrateur.save
        format.html { redirect_to @administrateur, notice: 'Administrateur was successfully created.' }
        format.json { render json: @administrateur, status: :created, location: @administrateur }
      else
        format.html { render action: "new" }
        format.json { render json: @administrateur.errors, status: :unprocessable_entity }
      end
    end
  end
  
def edit
    @administrateur = Administrateur.find(params[:id])
  end
 
  def update
    @administrateur = Administrateur.find(params[:id])

    respond_to do |format|
      if @administrateur.update_attributes(params[:administrateur])
        format.html { redirect_to @administrateur, notice: 'Enregistrement réussi' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @administrateur.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @administrateur = Administrateur.find(params[:id])
    @administrateur.destroy

    respond_to do |format|
      format.html { redirect_to administrateurs_url }
      format.json { head :ok }
    end
  end
  def login
    return unless request.post?
    administrateur = Administrateur.authenticate(params[:login], params[:password])

    if administrateur
      session[:administrateur_id] = administrateur.id
      flash[:notice] = "Bienvenue #{administrateur.login}!"
#      redirect_to 'index'
      target = session[:original_uri] || ''
      session[:original_uri] = nil
      redirect_to target
    else
      session[:administrateur_id] = nil
      flash[:error] = 'Login ou mot de passe incorrect'
	  params[:login] = ''
	  params[:password] = nil
    end
  end
  
  def logout
    session[:administrateur_id] = nil
    flash[:notice] = 'A bientot!'
    redirect_to ''
  end
end
