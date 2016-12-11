require 'beaker-rspec'

# Install Puppet
unless ENV['RS_PROVISION'] == 'no'
  # This will install the latest available package on el and deb based
  # systems fail on windows and osx, and install via gem on other *nixes
  foss_opts = { default_action: 'gem_install' }

  default.is_pe? ? install_pe : install_puppet(foss_opts)

  hosts.each do |host|
    on host, "mkdir -p #{host['distmoduledir']}"
  end
end

UNSUPPORTED_PLATFORMS = %w(AIX RedHat Solaris).freeze

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    hosts.each do |host|
      copy_module_to(host, source: proj_root, module_name: 'passenger_repo')
      shell("/bin/touch #{default['puppetpath']}/hiera.yaml")
      on host, puppet('module install puppetlabs-apt --version 2.0.1'), acceptable_exit_codes: [0, 1]
    end
  end
end
