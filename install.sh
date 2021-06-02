sudo cp -f /lib/modules/$(uname -r)/build/kernel/sched/sched.h .
sudo cp -f /lib/modules/$(uname -r)/build/kernel/sched/cpupri.h .
sudo cp -f /lib/modules/$(uname -r)/build/kernel/sched/cpudeadline.h .
sudo cp -f /lib/modules/$(uname -r)/build/kernel/sched/features.h .
sudo cp -f /lib/modules/$(uname -r)/build/kernel/sched/autogroup.h .
sudo cp -f /lib/modules/$(uname -r)/build/kernel/sched/stats.h .
sudo cp -f /lib/modules/$(uname -r)/build/net/bridge/br_private.h .
sudo make
sudo insmod vif.ko
