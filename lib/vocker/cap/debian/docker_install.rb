module VagrantPlugins
  module Vocker
    module Cap
      module Debian
        module DockerInstall
          def self.docker_install(machine)
            machine.communicate.tap do |comm|
              # TODO: Perform check on the host machine if aufs is installed and using LXC
              if machine.provider_name != :lxc
                comm.sudo("lsmod | grep aufs || modprobe aufs || apt-get install -y linux-image-extra-`uname -r`")
              end
              comm.sudo("curl http://get.docker.io/gpg | apt-key add -")
              comm.sudo("echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list")
              comm.sudo("apt-get update")
              comm.sudo("apt-get install -y -q xz-utils lxc-docker -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold'")
            end
          end
        end
      end
    end
  end
end
