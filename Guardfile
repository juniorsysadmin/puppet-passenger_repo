notification :on

guard 'rake', :task => 'test' do
  watch(%r{^manifests\/(.+)\.pp$})
  watch(%r{^spec\/(.+)\.rb$})
end
