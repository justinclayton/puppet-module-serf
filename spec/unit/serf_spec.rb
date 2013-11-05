require 'spec_helper'

describe 'serf', :type => :class do
  let(:params) do
    {
      :version    => '0.1.1',
      :target_dir => '/usr/local/bin'
    }
  end

  it 'should download serf'
  it 'should manage serf agent as a service'
end
