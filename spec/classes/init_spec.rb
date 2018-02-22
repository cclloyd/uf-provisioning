require 'spec_helper'
describe 'provisioning' do

  context 'with defaults for all parameters' do
    it { should contain_class('provisioning') }
  end
end
