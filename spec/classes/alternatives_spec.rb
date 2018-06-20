require 'spec_helper'

describe 'javalocal::alternatives' do
  let(:pre_condition) { 'include javalocal' }

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) { { 'java_install_path' => 'jdk1.8.0_171' } }

      it { is_expected.to compile }
    end
  end
end
