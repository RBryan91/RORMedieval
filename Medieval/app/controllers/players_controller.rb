class PlayersController < ApplicationController
    before_action :require_login_player, except: [:connect, :authenticate, :new, :create]

    def connect
      render 'login'
    end
    # Action pour afficher le profil d'un joueur
    def show
      session[:character_id] = nil
      @player = Player.find(params[:id])
      @characters = @player.characters
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

    def logout
      reset_session
      redirect_to root_path
    end

    # Action pour traiter la soumission du formulaire de connexion
    def authenticate
      @player = Player.find_by(name: params[:player]&.fetch(:name))
  
      if @player && @player.authenticate(params[:player]&.fetch(:password))
        session[:player_id] = @player.id
        redirect_to player_path(@player)
      else
        flash.now[:alert] = "Nom d'utilisateur ou mot de passe incorrect."
        redirect_to login_players_path
      end
    end
  
    private
      # Méthode privée pour définir les paramètres autorisés lors de la création ou de la mise à jour d'un joueur
      def player_params 
        params.require(:player).permit(:name, :password)
      end
  end
  