require_relative 'lib/kitchen_helper.rb'
require 'optparse'

task :diagnose, [:name] do |_t, args|
  p run_kitchen(:name, args.name).diagnose
end

task :build, [:name, :pkg] do |_t, args|
  i = run_kitchen(:name, args.name)
  hostname = i.send('state_file').read[:hostname]
  if i.transport.send('config')[:username] == 'centos'
    system "rsync -e 'ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o IdentitiesOnly=yes' -qrazc ./habitat centos@#{hostname}:/#{data_path i}"
    i.remote_exec <<-EOH
      cd #{plans_path i}
      sudo HAB_NOCOLORING=true hab studio build -R #{args.pkg}
    EOH
  elsif i.transport.send('config')[:username] == 'Administrator'
    system "rsync -qrazc ./habitat/ rsync://#{hostname}/#{plans_path i}"
    i.remote_exec <<-EOH
      export TEMP='C:/cygwin/tmp'
      cd #{plans_path i}
      hab studio build -R #{args.pkg}
    EOH
  end
end

task :install, [:name, :pkg] do |_t, args|
  i = run_kitchen(:name, args.name)
  i.remote_exec <<-EOH
    pushd #{plans_path i}/#{args.pkg} > /dev/null
    pkg_artifact=$(cat #{last_build_env i} | grep pkg_artifact | awk -F '=' '{print $2}' | sed $'s/[\r:\"]//g') 
    #{sudo? i} hab pkg install "results/$pkg_artifact"
  EOH
end

task :upload, [:name, :pkg] do |_t, args|
  i = run_kitchen(:name, args.name)
  i.remote_exec <<-EOH
    pushd #{plans_path i}/#{args.pkg} > /dev/null
    pkg_artifact=$(cat #{last_build_env i} | grep pkg_artifact | awk -F '=' '{print $2}' | sed $'s/[\r:\"]//g') 
    #{sudo? i} hab pkg upload results/$pkg_artifact
  EOH
end

task :promote, [:name, :pkg] do |_t, args|
  i = run_kitchen(:name, args.name)
  i.remote_exec <<-EOH
     pushd #{plans_path i}/#{args.pkg} > /dev/null
     pkg_ident=$(cat #{last_build_env i} | grep pkg_ident | awk -F '=' '{print $2}' | sed $'s/[\r:\"]//g') 
     #{sudo? i} hab pkg promote $pkg_ident stable
  EOH
end
