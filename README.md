# autothrottle
SC2021 AD/AE
1. Hardware specifications of a target machine
We utilize two hardware configurations for Micro- and Macro-benchmark evaluation

	1) Micro-benchmark evaluation
		- CPU: Intel Xeon E5-2650 v2@2.6 GHz hyperthreading off
		- Memory: 64 GB
		- NIC: 40 GbE (connected to a remote machine equipped with two Intel Xeon E5-2630 v2@2.6 GHz Hexa-core processors and 64 B memory)
	2) Macro-benchmark evaluation
		- CPU: Intel Xeon E5-2650v3@2.3 GHz hyperthreading off
		- Memory: 256 GB
		- NIC: 10 GbE
		
[Caveats of our work]
- Our evaluation requires multiple host servers, at least two for micro-benchmark and five for macro-benchmark evaluation. Also, the host servers should connect to either 40 GbE (micro-) or 10 GbE (macro-benchmark).
- If the above hardware configuration is not available, there can be performance degradation.

2. Module compile and installation

	1) Kernel compile and reboot
	```console
	cd ~
	wget https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/linux-5.4.58.tar.gz
	tar xzvf linux-5.4.58.tar.gz
	git clone
    cd autothrottle
    cp -rf ./kernel/* ~/linux-5.4.58/net/bridge/
    cd ~/linux-5.4.58
    cp /boot/config-$(uname -r) ./.config
    make olddefconfig
    N=`getconf _NPROCESSORS_ONLN`
    make -j$N
    make modules_install install
    reboot
	```	
	
	2) Module installation
	```console
	cd ~/autothrottle
	./install.sh
	```

3. System configuration
	1) Activate RFS (receive flow steering) and disable irqbalance to eliminate bottlenecks in network interfaces and interrupt processing ($INTERFACE indicates the network interfaces used for this experiment.)
	```console
	cd ~/autothrottle/script
	N=`getconf _NPROCESSORS_ONLN`
	sh rfs_set.sh $N $INTERFACE
	service irqbalance stop
	```
	
	2) Setting up a container environment
	- Autothrottle supports containers to achieve predictable network performance. So, this evaluation requires a container environment based on Docker. To install Docker, please refer to https://docs.docker.com/get-docker/

4. Micro-benchmark evaluation
	1) Create containers for evaluation
	
	- Run containers on the target machine. The number of containers should be double the number of CPU cores. Each container is based on the latest Ubuntu image and we install Netperf benchmark inside the containers.
	```console
	cd ~/autothrottle/script
	N=`getconf _NPROCESSORS_ONLN`
	sh run_container.sh $N
	```

	[Autothrottle]
	
	- Assign the same bandwidth requirements ($GOAL) to all containers.
	```console
	cd ~/autothrottle/script
	N=`getconf _NPROCESSORS_ONLN`
	./fair_perf_set.sh $N $GOAL
	```
	
	- Execute Netserver in the remote server with $IP when $CN indicates the number of containers running on the target machine
	```console
	./netserver $CN $IP
	```
	
	- Run Netperf benchmark in all containers. $M indicates the message size
	```console
	sh run_netperf.sh $N $M $IP
	```
	
	[Linux traffic control (tc)]
	
	- Before starting Linux tc evaluation, the containers used for Autothrottle evaluation should be stopped and the module (vif.ko) needs to be unloaded.
	```console
	cd ~/autothrottle/script
	N=`getconf _NPROCESSORS_ONLN`
	./restart_container.sh $N stop
	rmmod vif.ko
	./restart_container.sh $N start
	```
	
	- Install tcconfig (https://github.com/thombashi/tcconfig#tcconfig) to utilize Linux tc for containers
	```console
	sudo pip install tcconfig
	```
	
	- Configure the same network bandwidth ($GOAL) to the containers using tcset
	```console
	cd ~/autothrottle/script
	N=`getconf _NPROCESSORS_ONLN`
	./tcset.sh $N $GOAL
	```
	- Execute Netserver in the remote server with $IP when $CN indicates the number of containers running on the target machine
	```console
	./netserver $CN $IP
	```
	- Run Netperf benchmark in all containers same as the Autothrottle evaluation
	```console
	./run_netperf.sh $N $M
	```
