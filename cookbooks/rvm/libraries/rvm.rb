class Chef::ResourceDefinition::RVM
  def self.ruby_version(name)
    name.strip =~ /^\d/ ? "ruby-#{name}" : name
  end
end
  