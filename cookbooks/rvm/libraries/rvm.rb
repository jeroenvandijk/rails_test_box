module RVM
  class Ruby
    attr_accessor :name
    
    def initialize(name)
      @name = name
    end
    
    # Based on `rvm notes`, make sure you run it on the environment you are 
    # targetting. This is just targetted at ubuntu. Would be better if we could
    # get this list easily by running a rvm command.
    def packages
      mri_packages = %w(build-essential bison openssl libreadline6 libreadline6-dev curl git-core 
        zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev 
        sqlite3 libxml2-dev libxslt1-dev autoconf libc6-dev)
      
      if ree? || mri?
        mri_packages
      elsif ruby_head?
        mri_packages + %w(subversion)
      elsif jruby_head?
        %w(ant openjdk-6-jdk)
      elsif jruby?
        %w(g++ openjdk-6-jre-headless)
      elsif ironruby?
        %w(mono-2.0-devel)
      else
        []
      end
    end
    
    def recipes
      if jruby?
        %w(java)
      else
        []
      end
    end
    
    def version
      name.strip =~ /^\d/ ? "ruby-#{name}" : name
    end
    
    def mri?
      version =~ /^ruby/
    end
    
    def requires_java?
      version =~ /^jruby/
    end
    
    def ree?
      version =~ /^ree/
    end
    
    def ironruby?
      version =~ /^ironruby/
    end
    
    def ruby_head?
      version =~ /^ruby-head$/
    end
    
    def jruby_head?
      version =~ /^jruby-head$/
    end
    
    def jruby?
      version =~ /^jruby/
    end
    
  end

end
