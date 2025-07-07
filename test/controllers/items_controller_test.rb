require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    Item.delete_all
    @user=User.create!(email_address: "six@example.com", password: "password", password_confirmation: "password")
    log_in_as(@user)
  end

  test "should get index and show total" do
    Item.create!(cliente: "Mario", descripcion: "Banco", precio: 880, piezas: 1, direccion: "Merida, Yuc", vendedor: "Montse")
    Item.create!(cliente: "Jorge", descripcion: "Mesa", precio: 1099, piezas: 2, direccion: "Tizimin, Yuc", vendedor: "Joel")

    get items_url
    assert_response :success
    assert_match "Visualizador de Items", response.body
    assert_match "$3,078.00", response.body
  end

  test "should import items from tsv file" do
    file =fixture_file_upload("test/fixtures/files/testvalues.tsv", "text/tab-separated-values")
    assert_difference "Item.count", 15 do
      post import_items_url, params: { file: file }
    end

    assert_redirected_to items_url
    follow_redirect!
    assert_match "Items agregados correctamente", response.body
  end

  test "should not import items without a file" do
    post import_items_url
    assert_redirected_to items_url
    follow_redirect!
    assert_match "Por favor, selecciona un documento valido.", response.body
  end

  test "should delete all items" do
    Item.create!(cliente: "Mario", descripcion: "Banco", precio: 880, piezas: 1, direccion: "Merida, Yuc", vendedor: "Montse")
    assert_difference "Item.count", -1 do
      delete destroy_all_items_url
    end
    assert_redirected_to items_url
    follow_redirect!
    assert_match "Todos los items se han eliminado", response.body
  end
end
