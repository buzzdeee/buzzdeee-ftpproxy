require 'spec_helper'
describe 'ftpproxy' do

  context 'with defaults for all parameters' do
    it { should contain_class('ftpproxy') }
  end
end
