require 'rails_helper'
require 'support/shared_examples/site'

RSpec.describe Site, type: :model do
  it_behaves_like "site"
end
