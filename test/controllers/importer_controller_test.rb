require 'test_helper'

class ImporterControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get importer_index_url
    assert_response :success
  end

end
