require "test_helper"

class PokemonAbilitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pokemon_ability = pokemon_abilities(:one)
  end

  test "should get index" do
    get pokemon_abilities_url
    assert_response :success
  end

  test "should get new" do
    get new_pokemon_ability_url
    assert_response :success
  end

  test "should create pokemon_ability" do
    assert_difference("PokemonAbility.count") do
      post pokemon_abilities_url, params: { pokemon_ability: {  } }
    end

    assert_redirected_to pokemon_ability_url(PokemonAbility.last)
  end

  test "should show pokemon_ability" do
    get pokemon_ability_url(@pokemon_ability)
    assert_response :success
  end

  test "should get edit" do
    get edit_pokemon_ability_url(@pokemon_ability)
    assert_response :success
  end

  test "should update pokemon_ability" do
    patch pokemon_ability_url(@pokemon_ability), params: { pokemon_ability: {  } }
    assert_redirected_to pokemon_ability_url(@pokemon_ability)
  end

  test "should destroy pokemon_ability" do
    assert_difference("PokemonAbility.count", -1) do
      delete pokemon_ability_url(@pokemon_ability)
    end

    assert_redirected_to pokemon_abilities_url
  end
end
