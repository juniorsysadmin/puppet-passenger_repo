require 'spec_helper_acceptance'

describe 'passenger_repo class:', unless: UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  # rubocop:disable RSpec/MultipleExpectations
  it 'runs successfully' do
    pp = <<-EOS
    class { 'passenger_repo': }
    EOS

    # Apply twice to ensure no errors the second time.
    apply_manifest(pp, catch_failures: true) do |r|
      expect(r.stderr).not_to match(%r{error}i)
    end
    apply_manifest(pp, catch_changes: true) do |r|
      expect(r.stderr).not_to eq(%r{error}i)

      expect(r.exit_code).to be_zero
    end
  end
  # rubocop:enable RSpec/MultipleExpectations
end
