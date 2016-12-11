require 'spec_helper'

describe 'passenger_repo', type: :class do
  ['6.0', '7.0', '8.0', '12.04', '14.04'].each do |operatingsystemrelease|
    if operatingsystemrelease =~ %r{^[678]\.(\d+)}
      lsbdistid       = 'Debian'
      operatingsystem = 'Debian'
    else
      lsbdistid       = 'Ubuntu'
      operatingsystem = 'Ubuntu'
    end

    if operatingsystemrelease == '6.0'
      lsbdistcodename = 'squeeze'
    elsif operatingsystemrelease == '7.0'
      lsbdistcodename = 'wheezy'
    elsif operatingsystemrelease == '8.0'
      lsbdistcodename = 'jessie'
    elsif operatingsystemrelease == '12.04'
      lsbdistcodename = 'precise'
    elsif operatingsystemrelease == '14.04'
      lsbdistcodename = 'trusty'
    end

    context "when run on #{lsbdistid} release #{operatingsystemrelease}" do
      if lsbdistcodename == 'trusty'

        let :facts do
          {
            lsbdistcodename: lsbdistcodename,
            lsbdistid: lsbdistid,
            lsbdistrelease: operatingsystemrelease,
            operatingsystem: operatingsystem,
            operatingsystemrelease: operatingsystemrelease,
            osfamily: 'Debian'
          }
        end

      else

        let :facts do
          {
            lsbdistcodename: lsbdistcodename,
            lsbdistid: lsbdistid,
            operatingsystem: operatingsystem,
            operatingsystemrelease: operatingsystemrelease,
            osfamily: 'Debian'
          }
        end

      end

      it { is_expected.to compile.with_all_deps }

      context 'by default' do
        it 'the Phusion OSS APT repository should be installed' do
          is_expected.to contain_apt__source('phusion_passenger').with(
            'location' => 'https://oss-binaries.phusionpassenger.com/apt/passenger',
            'release' => lsbdistcodename
          )
        end
      end

      context 'with enterprise_license_key and enterprise_token set' do
        let :params do
          {
            enterprise_license_key: 'ABC',
            enterprise_token: 'DEF'
          }
        end

        it 'the file resource /etc/passenger-enterprise-license should be in the catalog' do
          is_expected.to contain_file('/etc/passenger-enterprise-license').with('content' => 'ABC')
        end

        it 'the Phusion Enterprise APT repository should be installed' do
          is_expected.to contain_apt__source('phusion_passenger_enterprise').with(
            'location' => 'https://download:DEF@www.phusionpassenger.com/enterprise_apt',
            'release' => lsbdistcodename
          )
        end
      end
    end
  end
end
