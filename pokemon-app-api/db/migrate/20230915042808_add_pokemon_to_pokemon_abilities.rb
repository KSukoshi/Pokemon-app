class AddPokemonToPokemonAbilities < ActiveRecord::Migration[7.0]
  def change
    add_reference :pokemon_abilities, :pokemon, null: false, foreign_key: true
  end
end
