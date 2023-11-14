class PlayersController < ApplicationController
    before_action :require_login_player, except: [:new, :create, :connexion, :authenticate]
    # Action pour afficher le profil d'un joueur
    def show
      @player = Player.find(params[:id])
  
      # Vérifier si le joueur est connecté
      unless session[:player_id] == @player.id
        redirect_to new_session_path, alert: "Vous devez être connecté pour accéder à cette page."
      end
    end
  
    # Action pour afficher le formulaire d'inscription d'un joueur
    def new
      @player = Player.new
    end
  
    # Action pour traiter la création d'un nouveau joueur
    def create
      # Crée une nouvelle instance de Player avec les paramètres fournis par le formulaire
      @player = Player.new(player_params)
      
      # Si le joueur est sauvegardé avec succès dans la base de données
      if @player.save
        # Connecte automatiquement le joueur nouvellement créé en ajoutant son ID à la session
        session[:player_id] = @player.id
        # Redirige vers la page du profil du joueur
        redirect_to @player
      else
        # Si la sauvegarde échoue, rend à nouveau le formulaire d'inscription
        render :new, status: :unprocessable_entity
      end
    end

    def destroy_session
      session[:player_id] = nil
      redirect_to new_player_path, notice: "Vous avez été déconnecté avec succès."
    end

     # Action pour afficher le formulaire de connexion d'un joueur
    def connexion
      # Affiche le formulaire de connexion
    end

    # Action pour traiter la soumission du formulaire de connexion
    def authenticate
      @player = Player.find_by(name: params[:player]&.fetch(:name))
  
      if @player && @player.authenticate(params[:player]&.fetch(:password))
        session[:player_id] = @player.id
        redirect_to player_path(@player), notice: "Connexion réussie !"
      else
        flash.now[:alert] = "Nom d'utilisateur ou mot de passe incorrect."
        render :connexion, status: :unprocessable_entity
      end
    end
  
    private
      # Méthode privée pour définir les paramètres autorisés lors de la création ou de la mise à jour d'un joueur
      def player_params 
        params.require(:player).permit(:name, :password)
      end
  end
  