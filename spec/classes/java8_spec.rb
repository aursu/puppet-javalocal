require 'spec_helper'

describe 'javalocal::java8' do
  let(:pre_condition) { 'include javalocal' }

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      os_facts[:os]['architecture'] = os_facts[:architecture]
      let(:facts) { os_facts }

      it { is_expected.to compile }
    end
  end
end
