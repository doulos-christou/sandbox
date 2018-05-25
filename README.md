## Vagrant Multiple-VM Creation and Configuration
Automatically provision multiple VMs with Vagrant and VirtualBox. Automatically install, configure, and test
Puppet Master and Puppet Agents on those VMs. 


#### JSON Configuration File
The Vagrantfile retrieves multiple VM configurations from a separate `nodes.json` file. All VM configuration is
contained in the JSON file. You can add additional VMs to the JSON file, following the existing pattern. The
Vagrantfile will loop through all nodes (VMs) in the `nodes.json` file and create the VMs. You can easily swap
configuration files for alternate environments since the Vagrantfile is designed to be generic and portable.

#### Instructions
```
# Step to create multi-vm Puppet environment (master and 2 node systems)
        
        - launch terminal session (i.e git-bash)
        - from terminal session, execute vagrant up command while in directory containing Vagrantfile
        
    example:
        - cd ~/Projects/multi-vagrant-puppet-vms # directory containing Vagrantfile
        => $ vagrant up

    
# Steps to access Puppet master server and establish communication with node systems
    
    - from terminal session, execute vagrant ssh command to connect to Pupper master server
    
    example:
        => $ vagrant ssh puppet.example.com
        - if prompted, click 'yes' to accept new security key
        
    - verify Puppet master server was successfully loaded
    
    example:
        - ubuntu@puppet:~$ #Puppet master terminal prompt
        => $ sudo service puppetmaster status |grep loaded
                
    - stop Puppet master service
    
    example:
        - ubuntu@puppet:~$ #Puppet master terminal prompt
        => $ sudo service puppetmaster stop; sudo service puppetmaster status |grep active
                    
    - generate new ca key for Puppet master server; kill Puppet master server
    
    example:
        - ubuntu@puppet:~$ #Puppet master terminal prompt
        => $ sudo puppet master --verbose --no-daemonize
        => Ctrl+C # kill Puppet master service process
                       
    - start Puppet master service
    
    example:
        - ubuntu@puppet:~$ #Puppet master terminal prompt
        => $ sudo service puppetmaster start; sudo service puppetmaster status |grep active
                
    - check status of master and node certificates
    
    example:
        - ubuntu@puppet:~$ #Puppet master terminal prompt
        => $ sudo puppet cert list --all
        
    - from new terminal session, execute vagrant ssh command to connect to node01 system
    
    example:
        => $ vagrant ssh node01.example.com
        - if prompted, click 'yes' to accept new security key
    
    - verify Puppet agent was successfully loaded
    
    example:
        - ubuntu@node01:~$ #node01 terminal prompt
        => $ sudo service puppet status |grep loaded
                
    - initiate certificate signing request for node01 and node02 to Puppet master server
        - ubuntu@node01:~$ #node01 terminal prompt
        => $ sudo puppet agent --test --waitforcert=60
        - ubuntu@puppet:~$ #Puppet master terminal prompt
        => $ sudo puppet cert list
        => $ sudo puppet cert sign --all
        - ubuntu@node01:~$ #node01 terminal prompt
        result:
            - Info: Caching certificate for node01.example.com
              Info: Caching certificate_revocation_list for ca
              Info: Retrieving pluginfacts
              Info: Retrieving plugin
              Notice: /File[/var/lib/puppet/lib/puppet]/ensure: created
              ...
              Info: Loading facts
              Info: Caching catalog for node01.example.com
              Info: Applying configuration version '1491690352'
              Notice: Debug output on node01 node.
              Notice: /Stage[main]/Main/Node[node01.example.com]/Notify[Debug output on node01 node.]/message: defined 'message' as 'Debug output on node01 node.'
              Notice: Finished catalog run in 0.01 seconds
```
#### Forwarding Ports
Used by Vagrant and VirtualBox. To create additional forwarding ports, add them to the 'ports' array. For example:
 ```
 "ports": [
        {
          ":host": 1234,
          ":guest": 2234,
          ":id": "port-1"
        },
        {
          ":host": 5678,
          ":guest": 6789,
          ":id": "port-2"
        }
      ]
```
#### Useful Multi-VM Commands
The use of the specific <machine> name is optional.
* `vagrant up <machine>`
* `vagrant reload <machine>`
* `vagrant destroy -f <machine> && vagrant up <machine>`
* `vagrant status <machine>`
* `vagrant ssh <machine>`
* `vagrant global-status`
* `facter`
* `sudo tail -50 /var/log/syslog`
* `sudo tail -50 /var/log/puppet/masterhttp.log`
* `tail -50 ~/VirtualBox\ VMs/postblog/<machine>/Logs/VBox.log`# puppet
