#
# Cookbook:: hello
# Recipe:: agentless-testing-examples
#
# This recipe is used to demonstrate agentless testing examples
# Copyright:: 2024 Progress Software Inc

apt_package 'tree' do
  action :install
end

apt_preference 'curl' do
  pin 'version 7.68*'
  pin_priority 1001
end

apt_repository 'habitat' do
  uri 'https://bldr.habitat.sh/latest/debian/'
  components %w(stable main)
  distribution 'stable'
  key 'https://bldr.habitat.sh/gpg.pub'
  action :add
end

# Ensure APT package cache is updated
apt_update 'update' do
  action :update
end

# Install a package using apt_package resource
apt_package 'nginx' do
  action :install
end

bash 'Reload daemon' do
  code <<-EOH
    systemctl daemon-reload
  EOH
  action :nothing
end

breakpoint 'name' do
  action :break
end

chef_client_config 'default' do
  # URL of your Chef Server
  chef_server_url 'https://your-chef-server/organizations/your-org'

  # Name of the node as recognized by the Chef Server
  node_name 'node-name'

  # Log file location
  log_location '/var/log/chef-client.log'

  # Log level for Chef Client
  log_level :info

  # Directory to store the configuration file
  config_directory '/etc/chef'

  action :nothing
end

chef_sleep 'pause_for_30_seconds' do
  seconds 30
  action :sleep
end

cron 'daily_script' do
  minute '0'
  hour '0'
  command '/tmp/local/bin/daily_script.sh'
  user 'root'
  action :create
end

cron_access 'allow_user' do
  user 'username'     # Replace 'username' with the actual username
  action :allow       # Default action is :allow, can be omitted if using default
end

cron_d 'example_job' do
  minute '0'
  hour '2'
  day '*'
  month '*'
  weekday '*'
  command '/usr/bin/example_command'
  user 'root'
  action :create
end

directory '/tmp/chef-repo' do
  action :create
end

execute 'test_echo' do
  command 'echo "Target Mode Connected Successfully..!!"'
end

file '/etc/crontab' do
  mode '0600'
  owner 'root'
  group 'root'
end

git '/tmp/chef-repo' do
  repository 'https://github.com/chef/chef.git'
  revision 'main'
  action :sync
end

group 'developers' do
  action :remove
end

habitat_install 'install habitat' do
  bldr_url 'http://localhost'
  hab_version '1.5.50'
end

# Configure and start the Habitat Supervisor
habitat_sup 'default' do
  action :run
  # Configuration options
  service 'default'   # Specify the service name, which will be used for supervision
  ring 'default'      # The name of the Habitat ring (cluster) to join
  topology 'leader'   # Topology options: 'leader', 'standalone', or 'federation'
  gossip 'default'    # The name of the gossip service
  # Set the configuration options (adjust as needed)
  config do
    {
      'peer' => 'default', # Example configuration option
      'listen' => '0.0.0.0:9631', # Example configuration option
    }
  end
end

hostname 'my-new-hostname' do
  action :set
end

# Make a GET request to fetch posts
http_request 'fetch_posts' do
  url 'https://jsonplaceholder.typicode.com/posts'
  action :get
  headers({
    'Accept' => 'application/json',
  })
  not_if { ::File.exist?('/tmp/posts_fetched') } # Only run if the file doesn't already exist
end

# Execute a command to create a file after fetching posts
execute 'create_post_fetch_file' do
  command 'touch /tmp/posts_fetched'
  action :run
  only_if 'curl -s https://jsonplaceholder.typicode.com/posts | grep "userId"'
end

# Make a POST request to create a new post
http_request 'create_post' do
  url 'https://jsonplaceholder.typicode.com/posts'
  action :post
  message({
    title: 'foo',
    body: 'bar',
    userId: 1,
  }.to_json)
  headers({
    'Content-Type' => 'application/json',
    'Accept' => 'application/json',
  })
end

execute 'configure_network_interface' do
  command 'ifconfig eth0 192.168.1.100 netmask 255.255.255.0 up'
  action :run
end

kernel_module 'udf' do
  load_dir '/etc/modprobe.d'
  action :disable
end

s_links = ['/usr/sbin/lsmod', '/usr/sbin/rmmod', '/usr/sbin/insmod', '/usr/sbin/modinfo', '/usr/sbin/modprobe', '/usr/sbin/depmod']
s_links.each do |files|
  link files.to_s do
    to '../bin/kmod'
  end
end

log 'Testign Log Resources....!!!'

chef_sleep '10' do
  action :sleep
end

notify_group 'crude_stop_and_start' do
  notifies :sleep, 'chef_sleep[10]', :immediately
end

ohai 'reload' do
  plugin 'etc'
  action :reload
end

ohai_hint 'ec2' do
  action :create
end

file '/etc/crontab' do
  mode '0600'
  owner 'root'
  group 'root'
end

package 'curl' do
  action :install
end

perl 'hello world' do
  code <<-EOH
    print 'Hello world! From Chef and Perl.';
  EOH
end

reboot 'now' do
  action :reboot_now
  reason 'Cannot continue Chef run without a reboot.'
end

remote_file '/etc/index.html' do
  mode '0755'
  action :create
  source 'https://www.google.com/'
end

ruby_block 'print_message' do
  block do
    puts 'This is a Ruby block in Chef!' # Custom Ruby code
  end
  action :run # Default action
end

service 'cron' do
  action %i(enable start)
end

sudo 'webadmin_apache' do
  user 'root'
  commands ['/bin/systemctl restart httpd']
  nopasswd true
  action :create
end

template '/tmp/ssh_knownn' do
  source 'ssh_known_hosts.erb' # 'index.html'
  mode '0644'
  local true
  action :create
end

timezone 'UTC' do
  action :set
end

user_ulimit 'tomcat' do
  filehandle_limit 8192
  filename 'tomcat_filehandle_limits.conf'
end

yum_repository 'rhel-repo' do
  reposdir '/tmp/'
  action :create
  make_cache false
end

user 'cbtest' do
  comment 'system guy'
  system true
  shell '/bin/false'
end

selinux_install 'selinux' do
  action :install
  packages %w(make policycoreutils selinux-policy selinux-policy-targeted libselinux-utils setools-console)
end

selinux_user 'ctest' do
  level 's0'
  range 's0'
  roles %w(sysadm_r staff_r)
end

selinux_login 'ctest' do
  user 'user_u'
  range 's0'
  action :manage
end

selinux_fcontext '/tmp/foo.txt' do
  secontext 'samba_share_t'
  file_type 'a'
  action :add
end

selinux_permissive 'httpd_t' do
  action :add
end

selinux_module 'my_policy_module' do
  base_dir '/etc/selinux/local/'
  content <<-EOF
    module custom_module 1.0;
    echo 'Hello Test';
  EOF
  action :remove
end

selinux_port '5678' do
  protocol 'tcp'
  secontext 'http_port_t'
end

selinux_state 'enforcing' do
  action :enforcing
end

selinux_boolean 'ssh_keysign' do
  value true
  persistent false # The change will not persist after a reboot
  action :set
end

ssh_known_hosts_entry 'gitlab.com' do
  file_location '/etc/ssh/ssh_known_hosts'
  action :create
end

if plateform_family?('rhel')
  rhsm_register 'register_with_rhsm' do
    username 'username' # Replace with your Red Hat username
    password 'Password' # Replace with your Red Hat password
    auto_attach true
    action :register
  end

  rhsm_subscription 'attach_subscription' do
    pool_id 'pool_id' # Replace with your subscription pool ID
    action :attach
  end

  rhsm_repo 'rhel-9-server-rpms' do
    repo_name 'rhel-atomic-7-cdk-3.11-rpms'
    action :enable
  end

  rhsm_errata 'apply_rhsa' do
    errata_id 'RHSA-2014:1293'
    action :install
  end

  rhsm_errata_level 'RHSA-2014' do
    errata_level 'moderate'
    action :install
  end
end

swap_file '/swapfile' do
  size 524 # Size in MB
  persist false
  action :create
end

sysctl 'net.ipv4.ip_forward' do
  value '1'
  action :apply
end

chef_container 'my_container' do
  action :create
end

systemd_unit 'my_custom_service.service' do
  content(
    {
      'Unit' => {
        'Description' => 'My Custom Service',
        'After' => 'network.target',
      },
      'Service' => {
        'ExecStart' => '/usr/bin/my_custom_script.sh',
        'Restart' => 'on-failure',
      },
      'Install' => {
        'WantedBy' => 'multi-user.target',
      },
    }
  )
  action [:create, :enable, :start]
end

locale 'set system locale' do
  lang 'en_US.UTF-8'
end

chef_acl '*/*' do
  rights :all, users: 'root'
  recursive true
  action :create
end

script 'run_custom_script' do
  interpreter 'bash' # Specify a custom interpreter
  code "echo 'This is a custom script in Chef!'" # Custom script code
  action :run # Default action
end

subversion 'checkout_project_code' do
  repository 'https://github.com/torvalds/linux.git'
  destination '/tmp/project'
  revision 'HEAD' # Check out revision 1234
  svn_info_args 'false'
  svn_arguments 'false'
  action :sync
end

yum_package 'httpd' do
  action :install
end

yum_repository 'rhel-repo' do
  reposdir '/tmp/'
  action :create
  make_cache false
end

snap_package 'node' do
  version '16/stable'
  options 'classic'
  action :install
end

rpm_package 'Install crond' do
  package_name 'nginx'
  source '/tmp/nginx-1.20.2-1.el9.ngx.x86_64.rpm' # Path to the RPM file on the local machine
  action :install
end

route '10.0.1.10/32' do
  gateway node['network']['default_gateway']
  device node['network']['default_interface']
end

zypper_package 'vim' do
  action :install
end

mount '/mnt/local' do
  device_type :device
  device '/dev/xvda1'
  fstype 'ext4'
end

chef_data_bag 'data_bag' do
  action :create
end

chef_data_bag_item 'data_bag/id' do
  raw_data({
    'feature' => true,
  })
end

chef_environment 'dev' do
  description 'Dev Environment'
  default_attributes({ 'dev' => 1 })
end

cookbook_file '/tmp/chef-repo/config.conf' do
  source 'config.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

habitat_package 'core/httpd' do
  channel 'stable'       # Channel from which to install
  version '2.4.51'       # Optional: Specify version, or omit to install the latest version
  action  :install       # Action to install the package
end

habitat_service 'core/httpd' do
  action :unload # Stops and unloads the service
end

alternatives 'python' do
  link '/usr/bin/python'
  action :remove
end

inspec_waiver 'web_server_security' do
  control 'security-123'
  expiration '2024-06-30'
  justification 'Waiver granted due to ongoing security patch deployment.'
  run_test true
  action :add
end

inspec_waiver_file_entry 'web_server_security_waiver' do
  control 'security-123'
  expiration '2024-06-30'
  file_path '/etc/chef/inspec_waivers.yml'
  justification 'Waiver granted due to ongoing security patch deployment.'
  run_test true
  action :add
end

chef_role 'webserver' do
  description 'Role for web servers'
  default_attributes(
    'apache' => {
      'port' => 80,
    }
  )
  env_run_lists(
    'default' => [
      'role[base]',
      'recipe[apache]',
    ]
  )
  ignore_failure true
  action :create
end

chef_client 'example-client' do
  admin true # Optional: Make this client an API client
  complete true # Optional: Define the client completely
  ignore_failure false # Optional: Do not ignore failure by default
  source_key_path '/home/ubuntu/mohan.pub' # Path to the public key
  action :create # Default action, creates a client
end

# Step 1: Install Habitat
habitat_install 'install habitat' do
  bldr_url 'http://localhost'
  hab_version '1.5.50'
end

# Start the Habitat Supervisor if it's not running
execute 'start_habitat_supervisor' do
  command 'hab sup run'
  user 'root' # Make sure to run as root or as an appropriate user with permissions to start services
  environment({
    'PATH' => '/usr/local/bin:/usr/bin:/bin', # Set the PATH environment variable, if needed
  })
  action :run
  not_if 'pgrep -f hab-sup' # Prevent running the command if a Habitat Supervisor is already running
end

# Now apply the habitat config
habitat_config 'core.httpd' do
  config({
    worker_count: 4,
    http: {
      keepalive_timeout: 120,
    },
  })
  remote_sup '127.0.0.1:9632' # Ensure the supervisor address is correct
  action :apply
end

# Setting node attributes for a Chef run
node.override['example_attribute'] = 'example_value'

# You can use a `chef_node` resource after modifying the node attributes if needed.
chef_node 'example-node' do
  action :create
end

# Create the YAML file with content
file '/home/ubuntu/my_input_source.yaml' do
  content <<-EOH
key1: value1
key2: value2
  EOH
  mode '0644'
  owner 'root'
  group 'root'
  action :create
  notifies :add, 'inspec_input[example_input]', :immediately
end

# Add the input to InSpec
inspec_input 'example_input' do
  input 'key1=value1,key2=value2'
  source '/home/ubuntu/my_input_source.yaml' # Path to the YAML file
  action :nothing # It will be triggered by the file resource
end

# Install ksh (KornShell)
package 'ksh' do
  action :install
end

# Now you can use the ksh resource
ksh 'hello world' do
  code <<-EOH
    echo "Hello, world!"
    echo "Current directory: " $PWD
  EOH
end

# Install csh package
package 'csh' do
  action :install
end

# Execute a C shell script
csh 'hello world' do
  code <<-EOH
    echo "Hello from C shell!"
    echo "Current directory: `pwd`
  EOH
end

# Ensure Python 3 is installed
package 'python3' do
  action :install
end

# Run a Python script using python3
python 'hello_world' do
  code <<-EOH
    print("Hello, world! From Chef and Python.")
  EOH
  action :run
  interpreter 'python3' # Specify python3 interpreter
end

freebsd_package 'curl' do
  action :install
end

# Create a group named 'developers' on the Ubuntu machine
chef_group 'developers' do
  action :create
end

chef_organization 'organization_name' do
  full_name 'Organization Ltd.'
  action :create
end

chef_user 'john_doe' do
  display_name 'John Doe'
  admin true
  email 'john@example.com'
  password 'hashed_password_here'
  action :create
end
