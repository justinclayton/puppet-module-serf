require 'spec_helper'

describe 'serf', :type => :class do
  let(:params) {{
    :version    => '0.2.0',
    :bin_dir    => '/usr/local/bin',
  }}

  context 'on linux' do
    let(:facts) {{
      :kernel       => 'Linux',
      :architecture => 'i386',
    }}
    context '32-bit' do
      let(:facts) {{
        :kernel       => 'Linux',
        :architecture => 'i386',
      }}
      it 'should download serf' do
        should contain_staging__file('serf.zip').with_source('https://dl.bintray.com/mitchellh/serf/0.2.0_linux_386.zip')
      end
      it 'should extract serf' do
        should contain_staging__extract('serf.zip').with({
          :target  => '/usr/local/bin',
          :creates => '/usr/local/bin/serf',
        })
      end
    end
    context '64-bit' do
      let(:facts) {{
        :kernel       => 'Linux',
        :architecture => 'x86_64',
      }}
      it 'should download serf' do
        should contain_staging__file('serf.zip').with_source('https://dl.bintray.com/mitchellh/serf/0.2.0_linux_amd64.zip')
      end
      it 'should extract serf' do
        should contain_staging__extract('serf.zip').with({
          :target  => '/usr/local/bin',
          :creates => '/usr/local/bin/serf',
        })
      end
    end
    context 'unsupported architecture' do
      let(:facts) {{
        :kernel       => 'Linux',
        :architecture => 'fuuuu',
      }}
      it 'should fail with an error' do
        expect { subject }.to raise_error(Puppet::Error,/Unsupported kernel architecture \"fuuuu\"/)
      end
    end
    it 'should manage a config file' do
      pending 'use json erb'
    end
    it 'should manage serf agent as a service' do
      should contain_file('serf.upstart.init').with({
        :path => '/etc/init/serf.conf',
        :mode => '0755',
      })
      should contain_service('serf').with({
        :enable   => true,
        :ensure   => 'running',
        :provider => 'upstart',
      })
    end
  end
  context 'on unsupported os' do
    let(:facts) {{ :kernel => 'fuuuu' }}
    it 'should fail with an error' do
      expect { subject }.to raise_error(Puppet::Error,/Unsupported kernel \"fuuuu\"/)
    end
  end
end
