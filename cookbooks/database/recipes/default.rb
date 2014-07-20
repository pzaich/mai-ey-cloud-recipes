#
# Cookbook Name: database
# Recipe: default
#
# Description:
# configure a custom database.yml file for engineyard.
# All parameters except the adapter are pulled from the EY node JSON element. See
# http://docs.engineyard.com/use-deploy-hooks-with-engine-yard-cloud.html for an
# example of the node JSON object. This object is also used for by deploy hooks
# at Engine Yard.
#
# borrowed from https://gist.github.com/jeremy2/1989695
#


if ['solo', 'app_master', 'app', 'util'].include?(node[:instance_role])
  # for each application
  node[:engineyard][:environment][:apps].each do |app|

    # create new database.yml
    template "/data/#{app[:name]}/shared/config/database.yml" do
      source 'database.yml.erb'
      owner node[:users][0][:username]
      group node[:users][0][:username]
      mode 0644
      variables({
        :environment => node[:environment][:framework_env],
        :adapter => 'postgresql',
        :database => app[:database_name],
        :username => node[:users][0][:username],
        :password => node[:users][0][:password],
        :host => node[:db_host]
      })
    end
  end
end