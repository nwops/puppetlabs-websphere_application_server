Puppet::Type.newtype(:websphere_cluster_member) do
  @doc = <<-DOC
    @summary Manages members of a WebSphere server cluster.
    @todo
      - Parameter validation
      - Sane defaults for parameters
      - Other things?
      - Better documentation for params?
      - Maybe make this take a hash instead of a million parameters?
    DOC

  autorequire(:websphere_cluster) do
    self[:name]
  end

  autorequire(:user) do
    self[:runas_user]
  end

  autorequire(:group) do
    self[:runas_group]
  end

  ensurable

  newparam(:cell) do
    desc 'The name of the cell the cluster member belongs to'
    validate do |value|
      unless value =~ %r{^[-0-9A-Za-z._]+$}
        raise("Invalid cell #{value}")
      end
    end
  end

  newproperty(:client_inactivity_timeout) do
    desc 'Manages the clientInactivityTimeout for the TransactionService'
  end

  newparam(:cluster) do
    desc 'The name of the cluster'
    validate do |value|
      unless value =~ %r{^[-0-9A-Za-z._]+$}
        raise("Invalid cluster #{value}")
      end
    end
  end

  newparam(:dmgr_profile) do
    desc 'The name of the DMGR profile to manage. E.g. PROFILE_DMGR_01'
    validate do |value|
      unless value =~ %r{^[-0-9A-Za-z._]+$}
        raise("Invalid dmgr_profile #{value}")
      end
    end
  end

  newparam(:profile) do
    desc <<-EOT
      Optional. The profile of the server to use for executing wsadmin
      commands. Will default to dmgr_profile if not set.
    EOT
  end

  newparam(:gen_unique_ports) do
    defaultto true
    munge do |value|
      value.to_s
    end
    desc 'Specifies whether the genUniquePorts when adding a cluster member'
  end

  newproperty(:jvm_maximum_heap_size) do
    defaultto '1024'
    desc "Manages the maximumHeapSize setting for the cluster member's JVM"
  end

  newproperty(:jvm_verbose_mode_class) do
    defaultto false
    munge do |value|
      value.to_s
    end
    desc "Manages the verboseModeClass setting for the cluster member's JVM"
  end

  newproperty(:jvm_verbose_garbage_collection) do
    defaultto false
    munge do |value|
      value.to_s
    end
    desc "Manages the verboseModeGarbageCollection setting for the cluster member's JVM"
  end

  newproperty(:jvm_verbose_mode_jni) do
    defaultto false
    munge do |value|
      value.to_s
    end
    desc "Manages the verboseModeJNI setting for the cluster member's JVM"
  end

  newproperty(:jvm_initial_heap_size) do
    defaultto '1024'
    desc "Manages the initialHeapSize setting for the cluster member's JVM"
  end

  newproperty(:jvm_run_hprof) do
    defaultto false
    munge do |value|
      value.to_s
    end
    desc "Manages the runHProf setting for the cluster member's JVM"
  end

  newproperty(:jvm_hprof_arguments) do
    desc "Manages the hprofArguments setting for the cluster member's JVM"
  end

  newproperty(:jvm_debug_mode) do
    munge do |value|
      value.to_s
    end
    desc "Manages the debugMode setting for the cluster member's JVM"
  end

  newproperty(:jvm_debug_args) do
    desc "Manages the debugArgs setting for the cluster member's JVM"
  end

  newproperty(:jvm_executable_jar_filename) do
    desc "Manages the executableJarFileName setting for the cluster member's JVM"
  end

  newproperty(:jvm_generic_jvm_arguments) do
    desc "Manages the genericJvmArguments setting for the cluster member's JVM"
  end

  newproperty(:jvm_disable_jit) do
    desc "Manages the disableJIT setting for the cluster member's JVM"
    munge do |value|
      value.to_s
    end
  end

  newparam(:server) do
    desc 'The server to add to the cluster'
    isnamevar
    validate do |value|
      unless value =~ %r{^[-0-9A-Za-z._]+$}
        raise("Invalid server #{value}")
      end
    end
  end

  newparam(:node_name) do
    desc 'Required. The name of the _node_ to add as a cluster member.'
    validate do |value|
      unless value =~ %r{^[-0-9A-Za-z._]+$}
        raise("Invalid node_name #{value}")
      end
    end
  end

  newparam(:profile_base) do
    desc 'The absolute path to the profile base directory. E.g. /opt/IBM/WebSphere/AppServer/profiles'
    validate do |value|
      raise("Invalid profile_base #{value}") unless Pathname.new(value).absolute?
    end
  end

  newparam(:replicator_entry) do
    desc 'This parameter is inactive.'
    ## Not sure if this is even used yet
  end

  newproperty(:runas_group) do
    desc 'Manages the runAsGroup for a cluster member'
  end

  newproperty(:runas_user) do
    desc 'Manages the runAsUser for a cluster member'
  end

  newproperty(:total_transaction_timeout) do
    desc 'Manages the totalTranLifetimeTimeout for the ApplicationServer'
  end

  newproperty(:threadpool_webcontainer_min_size) do
    desc 'Manages the minimumSize setting for the WebContainer ThreadPool'
  end

  newproperty(:threadpool_webcontainer_max_size) do
    desc 'Manages the maximumSize setting for the WebContainer ThreadPool'
  end

  newproperty(:umask) do
    defaultto '022'
    desc 'Manages the ProcessExecution umask for a cluster member'
  end

  newparam(:user) do
    desc "The user to run 'wsadmin' with"
    defaultto 'root'
    validate do |value|
      unless value =~ %r{^[-0-9A-Za-z._]+$}
        raise("Invalid user #{value}")
      end
    end
  end

  newparam(:dmgr_host) do
    desc <<-EOT
      The DMGR host to add this cluster member to.

      This is required if you're exporting the cluster member for a DMGR to
      collect.  Otherwise, it's optional.
    EOT
  end

  newparam(:wsadmin_user) do
    desc "Specifies the username for using 'wsadmin'"
  end

  newparam(:wsadmin_pass) do
    desc "Specifies the password for using 'wsadmin'"
  end

  newparam(:weight) do
    defaultto '2'
    desc 'Manages the cluster member weight (memberWeight) when adding a cluster member'
  end
end
