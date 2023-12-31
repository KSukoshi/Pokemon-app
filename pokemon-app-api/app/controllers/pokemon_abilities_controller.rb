class PokemonAbilitiesController < ApplicationController
  before_action :set_pokemon_ability, only: %i[ show edit update destroy ]

  def index
    @pokemon_abilities = PokemonAbility.all
    render json: @pokemon_abilities, except: [:created_at, :updated_at, :pokemon_id]
  end

  def show
    if @pokemon_ability == "Not found"
      render json: {
        error: "Pokemon not found"
      }, status: 400
    else
      render json: @pokemon_ability, except: [:created_at, :updated_at, :pokemon_id]
    end
  end

  def new
    @pokemon_ability = PokemonAbility.new
  end

  def edit
  end

  def create
  end

  def update
    respond_to do |format|
      if @pokemon_ability.update(pokemon_ability_params)
        format.json { render :show, status: :ok, location: @pokemon_ability }
      else
        format.json { render json: @pokemon_ability.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pokemon_ability.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

    def find_abilities
      Pokemon.find_by(name: params[:id]).pokemon_abilities
    end

    def fetch_abilities_and_create
      abilities = Services::PokeApi::Api.get_abilities(params[:id])

      if abilities.empty?
        @pokemon_ability = "Not found"
        @pokemon.destroy
      else
        @pokemon.save

        abilities.each do |ability|
          PokemonAbility.create(name: ability[0], url: ability[1], pokemon_id: @pokemon.id)
        end
      end
    end

    def set_pokemon_ability
      @pokemon = Pokemon.find_or_initialize_by(name: params[:id].downcase)
    
      @pokemon.id.nil? ? fetch_abilities_and_create : @pokemon_ability = find_abilities
    end

    def pokemon_ability_params
      params.fetch(:pokemon_ability, {})
    end
end
