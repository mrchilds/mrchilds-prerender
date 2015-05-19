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

          it { is_expected.to contain_notify('Wide open space') }
        end
      end
    end
  end
end
