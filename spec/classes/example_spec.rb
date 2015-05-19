require 'spec_helper'

describe 'prerender' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "prerender class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('prerender::params') }
          it { is_expected.to contain_class('prerender::install').that_comes_before('prerender::config') }
          it { is_expected.to contain_class('prerender::config') }
          it { is_expected.to contain_class('prerender::service').that_subscribes_to('prerender::config') }

          it { is_expected.to contain_service('prerender') }
          it { is_expected.to contain_package('prerender').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'prerender class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { is_expected.to contain_package('prerender') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
