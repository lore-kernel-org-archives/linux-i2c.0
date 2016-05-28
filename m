From: kernel test robot <fengguang.wu@intel.com>
Subject: [i2c: dev] d6760b14d4:  BUG: KASAN: slab-out-of-bounds in
 of_device_uevent at addr ffff8800091b4c49
Date: Sat, 28 May 2016 14:30:08 +0800
Message-ID: <57493af0.akIr4abjopweDkBu%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_57493af0.56m+K9dyVM5EF72hEA2eqx9CD7gMKVb1xGnn5Ww62wZiNuUC"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Erico Nunes <erico.nunes@datacom.ind.br>
Cc: LKP <lkp@01.org>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, wfg@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

This is a multi-part message in MIME format.

--=_57493af0.56m+K9dyVM5EF72hEA2eqx9CD7gMKVb1xGnn5Ww62wZiNuUC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit d6760b14d4a1243f918d983bba1e35c5a5cd5a6d
Author:     Erico Nunes <erico.nunes@datacom.ind.br>
AuthorDate: Tue May 3 15:45:43 2016 -0300
Commit:     Wolfram Sang <wsa@the-dreams.de>
CommitDate: Thu May 26 21:18:57 2016 +0200

    i2c: dev: switch from register_chrdev to cdev API
    
    i2c-dev had never moved away from the older register_chrdev interface to
    implement its char device registration. The register_chrdev API has the
    limitation of enabling only up to 256 i2c-dev busses to exist.
    
    Large platforms with lots of i2c devices (i.e. pluggable transceivers)
    with dedicated busses may have to exceed that limit.
    In particular, there are also platforms making use of the i2c bus
    multiplexing API, which instantiates a virtual bus for each possible
    multiplexed selection.
    
    This patch removes the register_chrdev usage and replaces it with the
    less old cdev API, which takes away the 256 i2c-dev bus limitation.
    It should not have any other impact for i2c bus drivers or user space.
    
    This patch has been tested on qemu x86 and qemu powerpc platforms with
    the aid of a module which adds and removes 5000 virtual i2c busses, as
    well as validated on an existing powerpc hardware platform which makes
    use of the i2c bus multiplexing API.
    i2c-dev busses with device minor numbers larger than 256 have also been
    validated to work with the existing i2c-tools.
    
    Signed-off-by: Erico Nunes <erico.nunes@datacom.ind.br>
    [wsa: kept includes sorted]
    Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

+------------------------------------------------------------------+------------+------------+------------+
|                                                                  | e3879e4f31 | d6760b14d4 | c5311a944e |
+------------------------------------------------------------------+------------+------------+------------+
| boot_successes                                                   | 0          | 0          | 0          |
| boot_failures                                                    | 96         | 27         | 21         |
| BUG:KASAN:slab-out-of-bounds_in_of_device_uevent_at_addr         | 94         | 27         | 21         |
| backtrace:of_unittest                                            | 94         | 27         | 21         |
| backtrace:kernel_init_freeable                                   | 96         | 27         | 21         |
| INFO:suspicious_RCU_usage                                        | 2          |            |            |
| backtrace:rcu_torture_writer                                     | 2          |            |            |
| INFO:rcu_sched_self-detected_stall_on_CPU                        | 1          |            |            |
| INFO:rcu_sched_detected_stalls_on_CPUs/tasks                     | 1          |            |            |
| backtrace:__pci_register_driver                                  | 1          |            |            |
| backtrace:virtio_pci_driver_init                                 | 1          |            |            |
| invoked_oom-killer:gfp_mask=0x                                   | 2          |            |            |
| Mem-Info                                                         | 2          |            |            |
| Kernel_panic-not_syncing:Out_of_memory_and_no_killable_processes | 2          |            |            |
| backtrace:vfs_write                                              | 2          |            |            |
| backtrace:SyS_write                                              | 2          |            |            |
| backtrace:populate_rootfs                                        | 2          |            |            |
| BUG:KASAN:use-after-free_in_cdev_del_at_addr                     | 0          | 26         | 21         |
| BUG:KASAN:use-after-free_in_kobject_put_at_addr                  | 0          | 25         | 21         |
| BUG:KASAN:use-after-free_in_cdev_default_release_at_addr         | 0          | 21         | 20         |
| BUG:KASAN:use-after-free_in_cdev_purge_at_addr                   | 0          | 21         | 20         |
+------------------------------------------------------------------+------------+------------+------------+

[   70.613944] /testcase-data/phandle-tests/consumer-a: arguments longer than property
[   70.622462] irq: no irq domain found for /testcase-data/interrupts/intc0 !
[   70.755208] ==================================================================
[   70.757418] BUG: KASAN: slab-out-of-bounds in of_device_uevent+0x1c9/0x2dc at addr ffff8800091b4c49
[   70.759372] Read of size 1 by task swapper/0/1
[   70.764683] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.6.0-10859-gd6760b1 #1
[   70.772916] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Debian-1.8.2-1 04/01/2014
[   70.774885]  0000000000000000 ffff88000999f350 ffffffff8a49bf09 ffffffff00000009
[   70.777048]  ffff880009800100 ffffed0001236989 ffff8800091b4c40 ffff88000999f3c8
[   70.779212]  ffffffff89e60664 ffffffff8ada9499 0000000000000286 ffff88000999f3a0
[   70.781323] Call Trace:
[   70.791845]  [<ffffffff8a49bf09>] dump_stack+0x148/0x1e2
[   70.793055]  [<ffffffff89e60664>] kasan_report+0x2ea/0x515
[   70.798326]  [<ffffffff8ada9499>] ? of_device_uevent+0x1c9/0x2dc
[   70.800646]  [<ffffffff8ada5247>] ? of_find_property+0x4d/0x58
[   70.801874]  [<ffffffff89e5ff6f>] __asan_load1+0x45/0x47
[   70.813884]  [<ffffffff8ada9499>] of_device_uevent+0x1c9/0x2dc
[   70.815115]  [<ffffffff8ada92d0>] ? of_device_get_modalias+0x26f/0x26f
[   70.820197]  [<ffffffff8a4ae85a>] ? vsnprintf+0x9cd/0x9ff
[   70.821433]  [<ffffffff8a790cf0>] dev_uevent+0x2ad/0x4ee
[   70.829809]  [<ffffffff8a790a43>] ? device_get_devnode+0x19b/0x19b
[   70.834311]  [<ffffffff8a4a1916>] ? add_uevent_var+0x1c1/0x1f0
[   70.835635]  [<ffffffff8a4a1755>] ? kobject_action_type+0xf6/0xf6
[   70.847664]  [<ffffffff8a4a93fc>] ? strncpy+0x33/0x51
[   70.848768]  [<ffffffff8a790a43>] ? device_get_devnode+0x19b/0x19b
[   70.850118]  [<ffffffff8a4a1d06>] kobject_uevent_env+0x3c1/0x895
[   70.860750]  [<ffffffff8a4a21fc>] kobject_uevent+0x22/0x24
[   70.861960]  [<ffffffff8a792ffd>] device_add+0x606/0xaa9
[   70.894054]  [<ffffffff8a7929f7>] ? dev_warn+0xfa/0xfa
[   70.895478]  [<ffffffff8ada999b>] ? of_device_make_bus_id+0x198/0x198
[   70.900209]  [<ffffffff89d44723>] ? trace_hardirqs_on_caller+0x27d/0x2c4
[   70.906060]  [<ffffffff8ada8c55>] of_device_add+0xa3/0xaa
[   70.907678]  [<ffffffff8ada9d2c>] of_platform_device_create_pdata+0xd5/0x10a
[   70.909768]  [<ffffffff8adaa1cd>] of_platform_device_create+0x2b/0x30
[   70.921685]  [<ffffffff8adaa2de>] of_platform_notify+0x10c/0x1df
[   70.923298]  [<ffffffff8adaa1d2>] ? of_platform_device_create+0x30/0x30
[   70.929593]  [<ffffffff89d48f1c>] ? lock_acquire+0xd4/0x11c
[   70.931112]  [<ffffffff89d48f1c>] ? lock_acquire+0xd4/0x11c
[   70.951893]  [<ffffffff89d0472a>] ? __blocking_notifier_call_chain+0x52/0x88
[   70.961551]  [<ffffffff89d042de>] notifier_call_chain+0x75/0xbc
[   70.966243]  [<ffffffff89d04740>] __blocking_notifier_call_chain+0x68/0x88
[   70.968020]  [<ffffffff89d04790>] blocking_notifier_call_chain+0x30/0x32
[   70.969607]  [<ffffffff8adaa990>] of_reconfig_notify+0x24/0x4a
[   70.970835]  [<ffffffff8adaae4a>] __of_changeset_entry_notify+0x14a/0x1f3
[   70.972343]  [<ffffffff8adaad00>] ? of_property_notify+0xe0/0xe0
[   70.975869]  [<ffffffff8af5ca06>] ? __mutex_unlock_slowpath+0x2a4/0x2cc
[   70.982674]  [<ffffffff8af5c762>] ? wait_for_completion_killable_timeout+0x10/0x10
[   70.984549]  [<ffffffff8adabf49>] __of_changeset_apply+0x19c/0x21c
[   70.990166]  [<ffffffff8adabf49>] ? __of_changeset_apply+0x19c/0x21c
[   70.991479]  [<ffffffff8adabdad>] ? of_changeset_destroy+0xce/0xce
[   70.996828]  [<ffffffff89d44777>] ? trace_hardirqs_on+0xd/0xf
[   70.998377]  [<ffffffff8ada59b5>] ? of_get_next_child+0x42/0x4c
[   71.003005]  [<ffffffff8adb4311>] of_overlay_create+0x4ee/0x5fc
[   71.004872]  [<ffffffff8adb4311>] ? of_overlay_create+0x4ee/0x5fc
[   71.006479]  [<ffffffff8adb3e23>] ? of_overlay_apply_one+0x2ff/0x2ff
[   71.016412]  [<ffffffff89d44723>] ? trace_hardirqs_on_caller+0x27d/0x2c4
[   71.017791]  [<ffffffff89d44777>] ? trace_hardirqs_on+0xd/0xf
[   71.022493]  [<ffffffff8ada5de8>] ? of_find_node_opts_by_path+0x2e6/0x2f8
[   71.024266]  [<ffffffff8ae88571>] of_unittest_apply_overlay+0x76/0xf4
[   71.028045]  [<ffffffff8ae88692>] of_unittest_apply_overlay_check+0xa3/0x13b
[   71.029540]  [<ffffffff8ce573c7>] of_unittest+0x2772/0x3480
[   71.030788]  [<ffffffff8ce54c55>] ? of_unittest_check_tree_linkage+0x158/0x158
[   71.032654]  [<ffffffff8a4a0834>] ? kobject_add_internal+0x4e6/0x4e6
[   71.034051]  [<ffffffff8a4a21fc>] ? kobject_uevent+0x22/0x24
[   71.035278]  [<ffffffff8a4a0a78>] ? kset_register+0x4e/0x56
[   71.036509]  [<ffffffff8cdd2bae>] ? set_debug_rodata+0x20/0x20
[   71.037812]  [<ffffffff8ae8818f>] ? add_sysfs_fw_map_entry+0xce/0xd6
[   71.043278]  [<ffffffff8ce54c55>] ? of_unittest_check_tree_linkage+0x158/0x158
[   71.045152]  [<ffffffff8cdd2bae>] ? set_debug_rodata+0x20/0x20
[   71.056264]  [<ffffffff8cdd373a>] do_one_initcall+0x114/0x252
[   71.057549]  [<ffffffff8cdd3626>] ? start_kernel+0x637/0x637
[   71.065513]  [<ffffffff8cdd2c40>] ? repair_env_string+0x92/0x9d
[   71.066841]  [<ffffffff89d01df7>] ? parse_args+0x5a6/0x5b9
[   71.070327]  [<ffffffff8cdd2bae>] ? set_debug_rodata+0x20/0x20
[   71.075364]  [<ffffffff8cdd3a6b>] kernel_init_freeable+0x1f3/0x2ab
[   71.076718]  [<ffffffff8af4e186>] kernel_init+0x11/0x15c
[   71.077922]  [<ffffffff8af6354f>] ret_from_fork+0x1f/0x40
[   71.085098]  [<ffffffff8af4e175>] ? rest_init+0x17c/0x17c
[   71.086576] Object at ffff8800091b4c40, in cache kmalloc-32
[   71.088079] Object allocated with size 9 bytes.
[   71.089348] Allocation:
[   71.090224] PID = 1
[   71.091019]  [<ffffffff89c3bfbf>] save_stack_trace+0x26/0x41
[   71.092508]  [<ffffffff89e5f5b6>] kasan_kmalloc+0x80/0x10c
[   71.093881]  [<ffffffff89e5fbd2>] kasan_kmalloc+0x85/0x91
[   71.095157]  [<ffffffff89e5d787>] __kmalloc_track_caller+0x1b5/0x1c9
[   71.096776]  [<ffffffff89e134da>] kmemdup+0x24/0x4e
[   71.098287]  [<ffffffff8adab9df>] __of_prop_dup+0xe0/0x169
[   71.101716]  [<ffffffff8adb3bf6>] of_overlay_apply_one+0xd2/0x2ff
[   71.109820]  [<ffffffff8adb3dac>] of_overlay_apply_one+0x288/0x2ff
[   71.118779]  [<ffffffff8adb42a9>] of_overlay_create+0x486/0x5fc
[   71.120137]  [<ffffffff8ae88571>] of_unittest_apply_overlay+0x76/0xf4
[   71.122042]  [<ffffffff8ae88692>] of_unittest_apply_overlay_check+0xa3/0x13b
[   71.127825]  [<ffffffff8ce573c7>] of_unittest+0x2772/0x3480
[   71.129106]  [<ffffffff8cdd373a>] do_one_initcall+0x114/0x252
[   71.131270]  [<ffffffff8cdd3a6b>] kernel_init_freeable+0x1f3/0x2ab
[   71.133851]  [<ffffffff8af4e186>] kernel_init+0x11/0x15c
[   71.135085]  [<ffffffff8af6354f>] ret_from_fork+0x1f/0x40
[   71.136492] Memory state around the buggy address:
[   71.146901]  ffff8800091b4b00: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
[   71.156678]  ffff8800091b4b80: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc

git bisect start c5311a944e65241db0c1d6777ba8dc678e4b95ce 2dcd0af568b0cf583645c8a317dd12e344b1c72a --
git bisect good 165884dee0c0ca098e86853542e5a66aebea1882  # 12:12     21+     25  Merge 'sound/for-next' into devel-spot-201605281009
git bisect  bad 2eb9daf8a36c42f56363126db4d0951ae268d1f2  # 12:21      0-     21  Merge 'linux-review/William-Wu/support-rockchip-dwc3-driver/20160527-193349' into devel-spot-201605281009
git bisect good 9f550046a4a630521250f8c888c5e0d4338d2fa8  # 12:35     22+     24  Merge 'linux-review/Javier-Martinez-Canillas/mwifiex-Fix-some-error-handling-issues-in-mwifiex_sdio_probe-function/20160527-222338' into devel-spot-201605281009
git bisect  bad 34b019584b93b0815e3fd335d261eac21034c067  # 12:54      0-     22  Merge 'drm-intel/drm-intel-nightly' into devel-spot-201605281009
git bisect good 025de5b31b692cd182c8c1ca85f40f9a1be76cca  # 13:10     22+     22  Merge 'linux-review/Srinivas-Kandagatla/ASoC-msm8916-Add-codec-Device-Tree-bindings/20160527-215246' into devel-spot-201605281009
git bisect  bad 4301b354cf48a772cdd27ae07c7f17240f202dfe  # 13:19      4-     14  Merge 'linux-review/Shardar-Shariff-Md/i2c-tegra-use-readx_poll_timeout-after-config_load-reg-programmed/20160527-215125' into devel-spot-201605281009
git bisect good 67fed0da5ac23ab6187c362b7ade08339872f718  # 13:30     22+     24  i2c: at91: change log when dma configuration fails
git bisect  bad d6760b14d4a1243f918d983bba1e35c5a5cd5a6d  # 13:46      1-      4  i2c: dev: switch from register_chrdev to cdev API
git bisect good e3879e4f3179121b1b59fd0033379d0ee700dead  # 13:54     22+     26  i2c: xlr: rename ARCH_TANGOX to ARCH_TANGO
# first bad commit: [d6760b14d4a1243f918d983bba1e35c5a5cd5a6d] i2c: dev: switch from register_chrdev to cdev API
git bisect good e3879e4f3179121b1b59fd0033379d0ee700dead  # 14:03     70+     96  i2c: xlr: rename ARCH_TANGOX to ARCH_TANGO
# extra tests with CONFIG_DEBUG_INFO_REDUCED
git bisect  bad d6760b14d4a1243f918d983bba1e35c5a5cd5a6d  # 14:09      0-     12  i2c: dev: switch from register_chrdev to cdev API
# extra tests on HEAD of linux-devel/devel-spot-201605281009
git bisect  bad c5311a944e65241db0c1d6777ba8dc678e4b95ce  # 14:10      0-     21  0day head guard for 'devel-spot-201605281009'
# extra tests on tree/branch linus/master
git bisect  bad ed2608faa0f701b1dbc65277a9e5c7ff7118bfd4  # 14:21      0-      3  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
# extra tests on tree/branch linus/master
git bisect  bad ed2608faa0f701b1dbc65277a9e5c7ff7118bfd4  # 14:21      0-     29  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
# extra tests on tree/branch linux-next/master
git bisect  bad b5631e1f2c1c8bac5bc866d4a7f8c6f415cae9e9  # 14:29      0-     22  Add linux-next specific files for 20160527


---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--=_57493af0.56m+K9dyVM5EF72hEA2eqx9CD7gMKVb1xGnn5Ww62wZiNuUC
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-vm-kbuild-yocto-x86_64-34:20160528134626:x86_64-randconfig-s5-05281135:4.6.0-10859-gd6760b1:1.gz"

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
SDrP9x/55D//8S8fzs4vP389+zMp7k+/vr25+n5/dn443s++/fzj99++v/n49d+/PVx2fku/
dciGnN/lc5dD4z6Nb7+/vDwv396binSVdj6keN19u+otXlzs/D7my7zLl1d5V66+/csHBv1f
54uG5pwNFJ31//vtp09fvvuWntG3t7sPjg3q7Xfvf/x89n9/uvjuW/qXb+8uf9hffX2/Z8Dz
Hy++3ry/Ov/p0+WXT/df8jymb/mG310Q0rm//9kHclo+7N7f/86by+//17n55c7Xfq1zsl+8
vLqdJwrPw3n54cfbuw/n7s1Puw/vz371p7//L9/dP/wfD5/ynfm5Zxf095c/fDee/zk9hv37
b8c/z+8+09d5+DCeK3R2Sbb95st3a+/07Nd/+MM/v/vd73/1n3/73f8r7/jD7t/fff3M8vld
IeP6p9/++b//4z+/+xPd1Xffklv39f2Xb/mdfeuVN/ut9ipf9zu4s3/8r3989+ff/ul//PZP
3918/Hi2392+/+nzLR2cP3735ctPf3bfeJ/J5Tk7KNfVm/efvn/3nl/Sd/vb2wNZ6Gz3+eby
u8O/0q/d/tu73fu/7n66e3fQwKuz28uvn6/IyX1D//KOVJEtOOkyP51PX798Ry/47PPuI2HQ
QXn36foLx9dfP787/J0/+/jh5t1fd18uf7j69P134y/PPn36fHf/r2xT35H+XN3c/fhdOPtM
fvfnL49/4UhyPt59er+fv82Tv3Rnf/l+993HT7f0nM9u/3p28/m7t/RHVbi3b69+uPxMQdbF
1Rt6PZ/IMJHn/uW79r+fnZ1zuEC+wbfXd9/eXV36bw//fa6CnZ1/OIvBnZ3fffhMHsz5IQI9
29Mjcd983H+h//6O/od+4fAfw0Z8c3N1/5csQmefbq/Ibny8pN/5dH67H393/vC8zm5KdG5/
d3F2fvvl8uyC4trvOCf2nh8+fR5HeGfXN/QoHu+Zn5vTb/mbD/urm913/Fvf3Fx/95eb2y83
n87OP99cMczZMGd3P3z49sch3/TX1renb3NDj52vfAtXHn5kXXy1owDqIzuL53Q3n9/vfqLD
4iP9F//tl0+3Zx+/knvxv/0/nhYoNgN6BQA=

--=_57493af0.56m+K9dyVM5EF72hEA2eqx9CD7gMKVb1xGnn5Ww62wZiNuUC
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-quantal-intel12-10:20160528135445:x86_64-randconfig-s5-05281135:4.6.0-10858-ge3879e4:1.gz"

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
dORMlCaiX5pYIUXHchSlieiXJlYenu6+s0lo/dJEMoGi/5iT0PqliZXzfrbWEKWJ6JcmVmjB
HtiEojQR/dJEdlDslCSKwiz0C7MqRie2jaIwC/3CrIqp2NM5URRmoV+YRWRyWi5RFGahX5hV
uZjKfcxJzvzCrIo12bk6FIVZ6BdmVWxONBRFYRb6hVmVU6+uaExy5hdmVc5i2SpIlKWgX5ZS
S3amWqMoS0G/LIVsULSLP1CUpaBfllLZFba5KcpS0C9LqWTU2skFFGUp6Jel1Jo8H12UpaBf
llJJoTmGiyhLQb8spdJzOqa7SMqjn5SvtTkDglEk5dFPynOMxImfiaQ8+kn52mK3s9UokvLo
J+Vr43FqLlgywdTXbBgdd0ck5dFPytP7d3avoUhJop+SrFxkZBt7IiWJfkqy9uBMAkeRkkQ/
JVl7dPZUoEhJop+S5GVdztcUKUn0U5K1k962v6ZIyKCfkKm9gV0XhCIhg35CppHDb68XQpGQ
QT8hw9S0p1igSMign5DhNmF74HkR4ejih6NbqM5ktiLC0cUPR7dAT2me6EWEo4sfjm68aNe+
MxGMK34wrsUUbMuxiGBc8YNxLWawq/CLCEXc3YsNBiB8p0d/1cUpePHx/ad3+8/7s18nSH38
2tuvzsJA/3Kzv/3Nw7UpFob95z/86c3ZzfXHtzf7769vP+9v3t5e7D6cXX28OXv/6ePN57fX
l9+8iserMvBcq7OzP+6+v744+/Dl/fn+5s1ZeNMivmmtPfwgz88m+N/94U/fnf39t9/SDVxc
v7v+/PPZT+HrWM4SsfrV//3lw6vEltfZ5f6n64v9Lf3aLx8uHzAgD7oe/vLV55v9/s3Zt18+
vbu+2NETfti9359dfxjPeLG73b+63H3efXV2s+e/uDz7/PHsby7vf/gV/9mv4t88QNOZz8fX
r371q7PLz68YYvz328+7m89nH6/Ovny4/jz+9NXZzx+/nP3l+t27s9v9/mx/c8NvZn97u/t+
f/sARyzhwYqvp3t5/emH3YfLd/sBf/v64uOH2y/v9zevdvyZvry7PPvw8fPZ93v6zfc/eLF/
9+721fvr29vrD9+Pb+Aifrr5+NP15f7m+HlaHksY/t+/D2zs1J1wH1fXHy7P7n7wCFczviBc
D4GPztVwu5vv6b9++Hx79u7jh+/3N2ef6UfP6Kk/7W8+/3yEjY09jBeHrSNGd33z72/okfg/
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
8zTIE0B1nmdtngbZKXtWLgNbUUOJT8nTcHZRjSJ75ifqVR62G5+N9Lda7bwlVoc9qTzwljwN
8sjh53XlYEe9Mmh1ngZ7UabP1nfY1GzS7eFK3tCrbNOV4coSou5UXxuuLCGp8rHVeZoSuEtm
OU9zCEO4eZoScAxk3ZCnIS5mdsgX8jT0V7Xr8WoltiRD9VvyNIWse10sujZPU1JQDFudpxlz
815gIUyhM1cWqK3I09BlTTZMrM/TkHNS+0KWZ2WepiSoS9PZtuVpCqkn5fZuy9OQKivKzTol
T0NWQlXVcM/I05REH3Fh/Uq+1CYD/WppMpTU9Vy2Lbq/5KAMn+2Kr/AKy6WNVGsUXyaBOTVB
TfZZ5te3LU/DsdY8N3iQontOg0fhjmpQiCvGoMl9KUfEMtaL/O2EuHP7aZbbXY6Id1vP/DxN
4RavKB9l5/XTPJFVKbkfJo9MiG7m54mUU4EwyqpeLqtSoIwgw69+9auzy8+vmHHjv+8/jOzH
PQvPXp1F6GSO3N7uL786o4+3u353jJwUJN+e7usfiCtk59BlX+jn7gjA/h0J6ZuzSPriv579
+hHfziOnGF4dg/e73kgcw2+OwDj6Af/XzTUJOCnsz3TW8m9gIb+DJ+V3+erjh3c/n7GN8+Ys
07ETfjwitNGf5d8aOWB3dza+U+v90Z0d/mg3EgnHO6u9cHzkiUdOM3BPF10Ad7gD/k9//273
iTF4uyu/rfCf/n3//ssrss8/79+/+msrbwucvdp/YG306sef3p+9uvj05Yz+C//x3S9+/enH
71+T2f3lr68PF7y62X24PAQfXt3iq8Bh+Zjx9fcXF6/K67t00xVPXYopknRiv7okZy7T+XcZ
9nty7C7p/b7+6T2D/serxWTVK05ykcD8Hz98+fD9W86Tvf20+3B98U082+9u3v08Yus/fvP5
88/fha/IaE/0Bg5Pdfn1u4/fv31H7tO7b/Y3N4ctuWe7T3Tt4b/Sj938+9vdu7/sfr59e3j0
y7Obiy+f6Fvvv6b/8pbeAdtA79695ff28cvnbzjFdPj9r+LZ7cerzxyh+PLp4Z4+vL9++5fd
54sfLj9+/834w7OPHz/d3v1XTme8vdm9v7y+/fGbxDL3/tPnhz8IZ7zy4OO7/fw0j/4wnP30
/e6bDx9vyL45O7v5+PHzN68v9z+9JoRwdvOXM/aJvnn94/mX63eXg2+3r2++fHj171/2X/av
6WM+8d3Gt311yW/szfj3q9tPHz+/IkutjJ8hgXqz9qu+Ob++JT69OmD211/ff+W1AMdfmzGG
9ApfsTf9Lqazc7r9ix++eXS3r427Pfvdn/70L2//8Mff/uPff/P/ivRe3pxffv3+mr7Y2ws6
QD9/0/6Ps7NXfGrfXJ69/nh7/Z5c2Nf//mX3gaTs/j9fXXy82d9x8uuL7//j7NV7UjxE7Nv3
n87S2atDbPdsz2rkqw/7z/S/v6H/oB84/I8z0hY3X11f3v3hOYnJ2ceby/3NNx8u6Gc+vrrZ
jz97dS+oZ9dcDLu/PT97dfP54ux8d7v/hr2Idyz19Pt4Cv7ZFSnlb15f3b6+vdyl1yyw4dX9
Dd99GXr6r97vL6933/Bff3V99c1P1zfkitgQ8fkQ6fkQ+fkQ8HwIfD5EWQ/x6fqSrz8b+uP2
h/ekNUgmXtMfL2CQ6O1vrknn8CVvxCWHv1q86nJHZ9UHdldf0e//REb72Qeynkmg6U8/f7w5
+/Dl3buz//T/BxF2SaRDVQUA

--=_57493af0.56m+K9dyVM5EF72hEA2eqx9CD7gMKVb1xGnn5Ww62wZiNuUC
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config-4.6.0-10859-gd6760b1"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 4.6.0 Kernel Configuration
#
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_X86_64_SMP=y
CONFIG_ARCH_HWEIGHT_CFLAGS="-fcall-saved-rdi -fcall-saved-rsi -fcall-saved-rdx -fcall-saved-rcx -fcall-saved-r8 -fcall-saved-r9 -fcall-saved-r10 -fcall-saved-r11"
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DEBUG_RODATA=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
CONFIG_KERNEL_XZ=y
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_FHANDLE=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_IRQ_DOMAIN_DEBUG=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set

#
# CPU/Task time and stats accounting
#
# CONFIG_TICK_CPU_ACCOUNTING is not set
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_FAST_NO_HZ is not set
# CONFIG_TREE_RCU_TRACE is not set
CONFIG_RCU_KTHREAD_PRIO=0
# CONFIG_RCU_NOCB_CPU is not set
# CONFIG_RCU_EXPEDITE_BOOT is not set
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_NMI_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CPUSETS is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
# CONFIG_RD_LZ4 is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
# CONFIG_BPF_SYSCALL is not set
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_USERFAULTFD=y
CONFIG_PCI_QUIRKS=y
CONFIG_MEMBARRIER=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
CONFIG_PROFILING=y
CONFIG_OPROFILE=y
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_JUMP_LABEL=y
CONFIG_STATIC_KEYS_SELFTEST=y
# CONFIG_UPROBES is not set
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_CC_STACKPROTECTOR=y
CONFIG_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR_NONE is not set
CONFIG_CC_STACKPROTECTOR_REGULAR=y
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
# CONFIG_CPU_NO_EFFICIENT_FFS is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_DEV_BSG=y
# CONFIG_BLK_DEV_BSGLIB is not set
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_CMDLINE_PARSER is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_AMIGA_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_BLOCK_COMPAT=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_FREEZER=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_FAST_FEATURE_TESTS=y
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
CONFIG_X86_EXTENDED_PLATFORM=y
CONFIG_X86_VSMP=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_DEBUG=y
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_QUEUED_LOCK_STAT=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=12
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_INTEL is not set
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=y
# CONFIG_VM86 is not set
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
# CONFIG_X86_64_ACPI_NUMA is not set
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_MOVABLE_NODE=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=y
# CONFIG_TRANSPARENT_HUGEPAGE is not set
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_AREAS=7
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
CONFIG_ZSMALLOC=y
CONFIG_PGTABLE_MAPPING=y
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_X86_PMEM_LEGACY is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
# CONFIG_X86_INTEL_MPX is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
# CONFIG_SCHED_HRTICK is not set
# CONFIG_KEXEC is not set
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_LEGACY_VSYSCALL_NATIVE is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_HIBERNATION is not set
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
CONFIG_PM_AUTOSLEEP=y
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
# CONFIG_PM_WAKELOCKS_GC is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_SLEEP_DEBUG=y
CONFIG_DPM_WATCHDOG=y
CONFIG_DPM_WATCHDOG_TIMEOUT=60
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
CONFIG_PM_GENERIC_DOMAINS=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_PM_GENERIC_DOMAINS_SLEEP=y
CONFIG_PM_GENERIC_DOMAINS_OF=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_PROCFS_POWER=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_FAN is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=y
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
# CONFIG_ACPI_THERMAL is not set
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
# CONFIG_ACPI_APEI_GHES is not set
# CONFIG_ACPI_APEI_MEMORY_FAILURE is not set
CONFIG_ACPI_APEI_EINJ=y
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
CONFIG_ACPI_EXTLOG=y
CONFIG_PMIC_OPREGION=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
# CONFIG_INTEL_IDLE is not set

#
# Memory power savings
#
# CONFIG_I7300_IDLE is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_MMCONFIG is not set
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
# CONFIG_PCIEAER is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEBUG=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
CONFIG_PCI_BUS_ADDR_T_64BIT=y
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_HT_IRQ=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
# CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# PCI host controller drivers
#
# CONFIG_PCIE_DW_PLAT is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_PCCARD is not set
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_TSI721=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
# CONFIG_RAPIDIO_DMA_ENGINE is not set
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=y
CONFIG_RAPIDIO_MPORT_CDEV=y

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_TSI57X=y
# CONFIG_RAPIDIO_CPS_XX is not set
# CONFIG_RAPIDIO_TSI568 is not set
# CONFIG_RAPIDIO_CPS_GEN2 is not set
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_HAVE_AOUT is not set
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
# CONFIG_IA32_EMULATION is not set
CONFIG_X86_X32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_KEYS_COMPAT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_PMC_ATOM=y
CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_NET_KEY is not set
# CONFIG_INET is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NET_PTP_CLASSIFY is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
# CONFIG_DNS_RESOLVER is not set
# CONFIG_BATMAN_ADV is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_HSR is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_SOCK_CGROUP_DATA is not set
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set
# CONFIG_LIB80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_RFKILL_REGULATOR is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_NFC is not set
# CONFIG_LWTUNNEL is not set
# CONFIG_DST_CACHE is not set
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y
# CONFIG_FIRMWARE_IN_KERNEL is not set
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
# CONFIG_DMA_SHARED_BUFFER is not set
# CONFIG_DMA_CMA is not set

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
CONFIG_MTD=y
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
# CONFIG_MTD_CMDLINE_PARTS is not set
CONFIG_MTD_OF_PARTS=y
CONFIG_MTD_AR7_PARTS=y

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
CONFIG_INFTL=y
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
CONFIG_MTD_CFI_LE_BYTE_SWAP=y
# CONFIG_MTD_CFI_GEOMETRY is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_OTP is not set
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=y

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_PHYSMAP_OF is not set
CONFIG_MTD_SBC_GXX=y
CONFIG_MTD_AMD76XROM=y
CONFIG_MTD_ICHXROM=y
CONFIG_MTD_ESB2ROM=y
# CONFIG_MTD_CK804XROM is not set
CONFIG_MTD_SCB2_FLASH=y
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
# CONFIG_MTD_PCI is not set
CONFIG_MTD_INTEL_VR_NOR=y
CONFIG_MTD_PLATRAM=y
# CONFIG_MTD_LATCH_ADDR is not set

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=y
# CONFIG_MTD_PMC551_BUGFIX is not set
CONFIG_MTD_PMC551_DEBUG=y
CONFIG_MTD_SLRAM=y
# CONFIG_MTD_PHRAM is not set
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTDRAM_ABS_POS=0
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# CONFIG_MTD_NAND is not set
# CONFIG_MTD_ONENAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
CONFIG_MTD_UBI_GLUEBI=y
# CONFIG_MTD_UBI_BLOCK is not set
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_ADDRESS_PCI=y
CONFIG_OF_IRQ=y
CONFIG_OF_PCI=y
CONFIG_OF_PCI_IRQ=y
CONFIG_OF_MTD=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set

#
# DRBD disabled because PROC_FS or INET not selected
#
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_OSD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_HD is not set
# CONFIG_BLK_DEV_RSXX is not set
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
CONFIG_BLK_DEV_NVME_SCSI=y

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
# CONFIG_AD525X_DPOT_I2C is not set
CONFIG_DUMMY_IRQ=y
CONFIG_IBM_ASM=y
CONFIG_PHANTOM=y
CONFIG_SGI_IOC4=y
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1780=y
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=y
CONFIG_DS1682=y
CONFIG_BMP085=y
CONFIG_BMP085_I2C=y
# CONFIG_USB_SWITCH_FSA9480 is not set
CONFIG_SRAM=y
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
# CONFIG_EEPROM_93CX6 is not set
CONFIG_CB710_CORE=y
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_SENSORS_LIS3_I2C is not set

#
# Altera FPGA firmware download module
#
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
CONFIG_SCIF_BUS=y

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#
# CONFIG_SCIF is not set

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_GENWQE is not set
CONFIG_ECHO=y
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_KERNEL_API is not set
# CONFIG_CXL_EEH is not set
CONFIG_HAVE_IDE=y
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
CONFIG_BLK_DEV_IDE_SATA=y
# CONFIG_IDE_GD is not set
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
CONFIG_BLK_DEV_IDETAPE=y
CONFIG_BLK_DEV_IDEACPI=y
CONFIG_IDE_TASK_IOCTL=y
# CONFIG_IDE_PROC_FS is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_PLATFORM is not set
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEDMA_SFF=y

#
# PCI IDE chipsets support
#
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_PCIBUS_ORDER is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_OPTI621=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_AEC62XX=y
# CONFIG_BLK_DEV_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_ATIIXP=y
CONFIG_BLK_DEV_CMD64X=y
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_JMICRON=y
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT8172 is not set
CONFIG_BLK_DEV_IT8213=y
CONFIG_BLK_DEV_IT821X=y
CONFIG_BLK_DEV_NS87415=y
CONFIG_BLK_DEV_PDC202XX_OLD=y
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
CONFIG_BLK_DEV_SVWKS=y
CONFIG_BLK_DEV_SIIMAGE=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=y
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_BLK_DEV_TC86C001=y
CONFIG_BLK_DEV_IDEDMA=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_NETLINK is not set
# CONFIG_SCSI_MQ_DEFAULT is not set
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y
CONFIG_CHR_DEV_SCH=y
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
# CONFIG_SCSI_SAS_LIBSAS is not set
CONFIG_SCSI_SRP_ATTRS=y
# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_DH is not set
CONFIG_SCSI_OSD_INITIATOR=y
CONFIG_SCSI_OSD_ULD=y
CONFIG_SCSI_OSD_DPRINT_SENSE=1
# CONFIG_SCSI_OSD_DEBUG is not set
# CONFIG_ATA is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
# CONFIG_MD_LINEAR is not set
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID10=y
CONFIG_MD_RAID456=y
CONFIG_MD_MULTIPATH=y
# CONFIG_MD_FAULTY is not set
CONFIG_BCACHE=y
# CONFIG_BCACHE_DEBUG is not set
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_MQ_DEFAULT is not set
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=y
# CONFIG_DM_DEBUG_BLOCK_STACK_TRACING is not set
CONFIG_DM_BIO_PRISON=y
CONFIG_DM_PERSISTENT_DATA=y
CONFIG_DM_CRYPT=y
CONFIG_DM_SNAPSHOT=y
CONFIG_DM_THIN_PROVISIONING=y
CONFIG_DM_CACHE=y
CONFIG_DM_CACHE_SMQ=y
# CONFIG_DM_CACHE_CLEANER is not set
CONFIG_DM_ERA=y
CONFIG_DM_MIRROR=y
# CONFIG_DM_LOG_USERSPACE is not set
CONFIG_DM_RAID=y
# CONFIG_DM_ZERO is not set
CONFIG_DM_MULTIPATH=y
# CONFIG_DM_MULTIPATH_QL is not set
CONFIG_DM_MULTIPATH_ST=y
CONFIG_DM_DELAY=y
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=y
CONFIG_DM_VERITY=y
CONFIG_DM_VERITY_FEC=y
CONFIG_DM_SWITCH=y
CONFIG_DM_LOG_WRITES=y
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
CONFIG_TCM_FILEIO=y
CONFIG_TCM_PSCSI=y
CONFIG_LOOPBACK_TARGET=y
# CONFIG_ISCSI_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_MACINTOSH_DRIVERS is not set
# CONFIG_NETDEVICES is not set
# CONFIG_VHOST_NET is not set
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y
CONFIG_NVM=y
# CONFIG_NVM_DEBUG is not set
# CONFIG_NVM_GENNVM is not set
# CONFIG_NVM_RRPC is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5520 is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_STMPE is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TC3589X is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
CONFIG_MOUSE_SERIAL=y
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=y
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=y
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=y
CONFIG_JOYSTICK_GRIP_MP=y
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
CONFIG_JOYSTICK_TMDC=y
CONFIG_JOYSTICK_IFORCE=y
CONFIG_JOYSTICK_IFORCE_232=y
CONFIG_JOYSTICK_WARRIOR=y
CONFIG_JOYSTICK_MAGELLAN=y
# CONFIG_JOYSTICK_SPACEORB is not set
CONFIG_JOYSTICK_SPACEBALL=y
CONFIG_JOYSTICK_STINGER=y
CONFIG_JOYSTICK_TWIDJOY=y
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=y
# CONFIG_JOYSTICK_XPAD is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_88PM80X_ONKEY is not set
CONFIG_INPUT_AD714X=y
CONFIG_INPUT_AD714X_I2C=y
# CONFIG_INPUT_BMA150 is not set
CONFIG_INPUT_E3X0_BUTTON=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_MC13783_PWRBUTTON is not set
CONFIG_INPUT_MMA8450=y
CONFIG_INPUT_MPU3050=y
# CONFIG_INPUT_APANEL is not set
CONFIG_INPUT_ATLAS_BTNS=y
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
# CONFIG_INPUT_REGULATOR_HAPTIC is not set
CONFIG_INPUT_RETU_PWRBUTTON=y
CONFIG_INPUT_TPS65218_PWRBUTTON=y
# CONFIG_INPUT_TWL6040_VIBRA is not set
CONFIG_INPUT_UINPUT=y
CONFIG_INPUT_PALMAS_PWRBUTTON=y
# CONFIG_INPUT_PCF50633_PMU is not set
CONFIG_INPUT_PCF8574=y
CONFIG_INPUT_ADXL34X=y
CONFIG_INPUT_ADXL34X_I2C=y
CONFIG_INPUT_CMA3000=y
CONFIG_INPUT_CMA3000_I2C=y
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
CONFIG_INPUT_DRV2665_HAPTICS=y
CONFIG_INPUT_DRV2667_HAPTICS=y
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=y
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
# CONFIG_LEGACY_PTYS is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_NOZOMI=y
# CONFIG_N_GSM is not set
CONFIG_TRACE_ROUTER=y
CONFIG_TRACE_SINK=y
CONFIG_GOLDFISH_TTY=y
CONFIG_DEVMEM=y
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_FSL is not set
# CONFIG_SERIAL_8250_DW is not set
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_MOXA=y
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=y
CONFIG_SERIAL_SCCNXP=y
# CONFIG_SERIAL_SCCNXP_CONSOLE is not set
# CONFIG_SERIAL_SC16IS7XX is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_ALTERA_UART_CONSOLE=y
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
CONFIG_SERIAL_RP2=y
CONFIG_SERIAL_RP2_NR_UARTS=32
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=y
# CONFIG_IPMI_SI_PROBE_DEFAULTS is not set
CONFIG_IPMI_SSIF=y
CONFIG_IPMI_WATCHDOG=y
CONFIG_IPMI_POWEROFF=y
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_VIA=y
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_HW_RANDOM_TPM=y
CONFIG_NVRAM=y
CONFIG_R3964=y
# CONFIG_APPLICOM is not set
CONFIG_MWAVE=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
CONFIG_HPET=y
# CONFIG_HPET_MMAP is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
# CONFIG_TCG_TIS is not set
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=y
CONFIG_TCG_NSC=y
CONFIG_TCG_ATMEL=y
# CONFIG_TCG_INFINEON is not set
CONFIG_TCG_CRB=y
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=y
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=y
CONFIG_I2C_AMD756_S4882=y
CONFIG_I2C_AMD8111=y
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=y
# CONFIG_I2C_ISMT is not set
CONFIG_I2C_PIIX4=y
# CONFIG_I2C_NFORCE2 is not set
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=y
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_DESIGNWARE_CORE=y
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
CONFIG_I2C_DESIGNWARE_PCI=y
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_KEMPLD=y
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PXA_PCI is not set
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT_LIGHT=y
CONFIG_I2C_TAOS_EVM=y

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_CROS_EC_TUNNEL is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set

#
# PPS support
#
# CONFIG_PPS is not set

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
# CONFIG_GPIOLIB is not set
CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_DS1WM=y

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
# CONFIG_W1_SLAVE_SMEM is not set
# CONFIG_W1_SLAVE_DS2408 is not set
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
# CONFIG_W1_SLAVE_DS2431 is not set
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2760=y
CONFIG_W1_SLAVE_DS2780=y
# CONFIG_W1_SLAVE_DS2781 is not set
# CONFIG_W1_SLAVE_DS28E04 is not set
# CONFIG_W1_SLAVE_BQ27000 is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=y
# CONFIG_GENERIC_ADC_BATTERY is not set
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_ACT8945A=y
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_SBS=y
CONFIG_BATTERY_BQ27XXX=y
# CONFIG_BATTERY_BQ27XXX_I2C is not set
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=y
CONFIG_CHARGER_PCF50633=y
CONFIG_CHARGER_MAX8903=y
# CONFIG_CHARGER_LP8727 is not set
CONFIG_CHARGER_LP8788=y
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65090=y
CONFIG_CHARGER_TPS65217=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
# CONFIG_BATTERY_RT5033 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_AS3722 is not set
# CONFIG_POWER_RESET_RESTART is not set
# CONFIG_POWER_RESET_SYSCON is not set
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
CONFIG_POWER_AVS=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
CONFIG_SENSORS_ABITUGURU3=y
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=y
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_ASC7621=y
# CONFIG_SENSORS_K8TEMP is not set
CONFIG_SENSORS_K10TEMP=y
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=y
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_I5K_AMB=y
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
# CONFIG_SENSORS_MC13783_ADC is not set
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_GL518SM=y
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=y
# CONFIG_SENSORS_IBMPEX is not set
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=y
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6642=y
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=y
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NCT7904=y
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHTC1=y
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=y
# CONFIG_SENSORS_SCH56XX_COMMON is not set
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS1015=y
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83781D=y
# CONFIG_SENSORS_W83791D is not set
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=y
# CONFIG_SENSORS_W83627HF is not set
CONFIG_SENSORS_W83627EHF=y
# CONFIG_SENSORS_WM8350 is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_EMULATION is not set
CONFIG_INTEL_POWERCLAMP=y
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
CONFIG_INTEL_SOC_DTS_THERMAL=y

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=y
# CONFIG_GENERIC_ADC_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
CONFIG_SSB=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
# CONFIG_SSB_DEBUG is not set
CONFIG_BCMA_POSSIBLE=y

#
# Broadcom specific AMBA
#
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
CONFIG_BCMA_HOST_SOC=y
# CONFIG_BCMA_DRIVER_PCI is not set
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_ACT8945A=y
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=y
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_ATMEL_FLEXCOM=y
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_CROS_EC=y
# CONFIG_MFD_CROS_EC_I2C is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_HI6421_PMIC=y
CONFIG_HTC_PASIC3=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_MFD_JANZ_CMODIO=y
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77686=y
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
# CONFIG_PCF50633_GPIO is not set
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RTSX_PCI=y
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_RK808=y
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
CONFIG_AB3100_OTP=y
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
CONFIG_STMPE_I2C=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
# CONFIG_MFD_LP3943 is not set
CONFIG_MFD_LP8788=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS65217=y
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
CONFIG_MFD_TC3589X=y
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PM800=y
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_ACT8945A is not set
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ANATOP=y
# CONFIG_REGULATOR_AB3100 is not set
CONFIG_REGULATOR_AS3722=y
# CONFIG_REGULATOR_BCM590XX is not set
# CONFIG_REGULATOR_DA9210 is not set
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
# CONFIG_REGULATOR_HI6421 is not set
# CONFIG_REGULATOR_ISL9305 is not set
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP8755=y
# CONFIG_REGULATOR_LP8788 is not set
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_MAX1586=y
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=y
# CONFIG_REGULATOR_MAX8907 is not set
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8973=y
# CONFIG_REGULATOR_MAX8997 is not set
CONFIG_REGULATOR_MAX77686=y
CONFIG_REGULATOR_MAX77802=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6397=y
# CONFIG_REGULATOR_PALMAS is not set
# CONFIG_REGULATOR_PCF50633 is not set
CONFIG_REGULATOR_PFUZE100=y
# CONFIG_REGULATOR_PV88060 is not set
# CONFIG_REGULATOR_PV88080 is not set
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_RK808 is not set
CONFIG_REGULATOR_RN5T618=y
CONFIG_REGULATOR_RT5033=y
CONFIG_REGULATOR_S2MPA01=y
# CONFIG_REGULATOR_S2MPS11 is not set
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_TPS51632=y
# CONFIG_REGULATOR_TPS6105X is not set
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=y
# CONFIG_REGULATOR_TPS65090 is not set
CONFIG_REGULATOR_TPS65217=y
CONFIG_REGULATOR_TPS65218=y
# CONFIG_REGULATOR_TPS6586X is not set
CONFIG_REGULATOR_TPS65912=y
# CONFIG_REGULATOR_WM8350 is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
# CONFIG_MEDIA_RADIO_SUPPORT is not set
CONFIG_MEDIA_SDR_SUPPORT=y
# CONFIG_MEDIA_RC_SUPPORT is not set
CONFIG_MEDIA_CONTROLLER=y
# CONFIG_MEDIA_CONTROLLER_DVB is not set
CONFIG_VIDEO_DEV=y
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_DVB_CORE=y
# CONFIG_TTPCI_EEPROM is not set
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
# CONFIG_SMS_SDIO_DRV is not set

#
# Media ancillary drivers (tuners, sensors, i2c, frontends)
#
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=y
CONFIG_VIDEO_TDA7432=y
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
CONFIG_VIDEO_TEA6420=y
CONFIG_VIDEO_MSP3400=y
CONFIG_VIDEO_CS3308=y
CONFIG_VIDEO_CS5345=y
CONFIG_VIDEO_CS53L32A=y
CONFIG_VIDEO_TLV320AIC23B=y
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_WM8775 is not set
CONFIG_VIDEO_WM8739=y
CONFIG_VIDEO_VP27SMPX=y
CONFIG_VIDEO_SONY_BTF_MPX=y

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=y

#
# Video decoders
#
# CONFIG_VIDEO_ADV7183 is not set
CONFIG_VIDEO_BT819=y
CONFIG_VIDEO_BT856=y
# CONFIG_VIDEO_BT866 is not set
CONFIG_VIDEO_KS0127=y
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
CONFIG_VIDEO_TVP514X=y
CONFIG_VIDEO_TVP5150=y
CONFIG_VIDEO_TVP7002=y
CONFIG_VIDEO_TW2804=y
CONFIG_VIDEO_TW9903=y
CONFIG_VIDEO_TW9906=y
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=y
CONFIG_VIDEO_CX25840=y

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=y
CONFIG_VIDEO_SAA7185=y
CONFIG_VIDEO_ADV7170=y
CONFIG_VIDEO_ADV7175=y
CONFIG_VIDEO_ADV7343=y
# CONFIG_VIDEO_ADV7393 is not set
CONFIG_VIDEO_AK881X=y
CONFIG_VIDEO_THS8200=y

#
# Camera sensor devices
#

#
# Flash devices
#

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=y
CONFIG_VIDEO_UPD64083=y

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
CONFIG_VIDEO_M52790=y

#
# Sensors used on soc_camera driver
#
CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
# CONFIG_MEDIA_TUNER_TEA5761 is not set
CONFIG_MEDIA_TUNER_TEA5767=y
# CONFIG_MEDIA_TUNER_MT20XX is not set
CONFIG_MEDIA_TUNER_MT2060=y
CONFIG_MEDIA_TUNER_MT2063=y
# CONFIG_MEDIA_TUNER_MT2266 is not set
CONFIG_MEDIA_TUNER_MT2131=y
CONFIG_MEDIA_TUNER_QT1010=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
# CONFIG_MEDIA_TUNER_MXL5005S is not set
CONFIG_MEDIA_TUNER_MXL5007T=y
# CONFIG_MEDIA_TUNER_MC44S803 is not set
# CONFIG_MEDIA_TUNER_MAX2165 is not set
# CONFIG_MEDIA_TUNER_TDA18218 is not set
# CONFIG_MEDIA_TUNER_FC0011 is not set
CONFIG_MEDIA_TUNER_FC0012=y
CONFIG_MEDIA_TUNER_FC0013=y
CONFIG_MEDIA_TUNER_TDA18212=y
# CONFIG_MEDIA_TUNER_E4000 is not set
CONFIG_MEDIA_TUNER_FC2580=y
# CONFIG_MEDIA_TUNER_M88RS6000T is not set
CONFIG_MEDIA_TUNER_TUA9001=y
# CONFIG_MEDIA_TUNER_SI2157 is not set
# CONFIG_MEDIA_TUNER_IT913X is not set
# CONFIG_MEDIA_TUNER_R820T is not set
# CONFIG_MEDIA_TUNER_MXL301RF is not set
CONFIG_MEDIA_TUNER_QM1D1C0042=y

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=y
# CONFIG_DVB_STB6100 is not set
CONFIG_DVB_STV090x=y
CONFIG_DVB_STV6110x=y
CONFIG_DVB_M88DS3103=y

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=y
# CONFIG_DVB_TDA18271C2DD is not set
CONFIG_DVB_SI2165=y
CONFIG_DVB_MN88473=y

#
# DVB-S (satellite) frontends
#
# CONFIG_DVB_CX24110 is not set
# CONFIG_DVB_CX24123 is not set
CONFIG_DVB_MT312=y
CONFIG_DVB_ZL10036=y
CONFIG_DVB_ZL10039=y
CONFIG_DVB_S5H1420=y
CONFIG_DVB_STV0288=y
CONFIG_DVB_STB6000=y
CONFIG_DVB_STV0299=y
CONFIG_DVB_STV6110=y
CONFIG_DVB_STV0900=y
CONFIG_DVB_TDA8083=y
# CONFIG_DVB_TDA10086 is not set
CONFIG_DVB_TDA8261=y
CONFIG_DVB_VES1X93=y
CONFIG_DVB_TUNER_ITD1000=y
CONFIG_DVB_TUNER_CX24113=y
CONFIG_DVB_TDA826X=y
CONFIG_DVB_TUA6100=y
CONFIG_DVB_CX24116=y
CONFIG_DVB_CX24117=y
# CONFIG_DVB_CX24120 is not set
CONFIG_DVB_SI21XX=y
CONFIG_DVB_TS2020=y
# CONFIG_DVB_DS3000 is not set
CONFIG_DVB_MB86A16=y
CONFIG_DVB_TDA10071=y

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=y
CONFIG_DVB_SP887X=y
# CONFIG_DVB_CX22700 is not set
# CONFIG_DVB_CX22702 is not set
# CONFIG_DVB_S5H1432 is not set
# CONFIG_DVB_DRXD is not set
CONFIG_DVB_L64781=y
CONFIG_DVB_TDA1004X=y
CONFIG_DVB_NXT6000=y
CONFIG_DVB_MT352=y
# CONFIG_DVB_ZL10353 is not set
CONFIG_DVB_DIB3000MB=y
CONFIG_DVB_DIB3000MC=y
CONFIG_DVB_DIB7000M=y
CONFIG_DVB_DIB7000P=y
# CONFIG_DVB_DIB9000 is not set
CONFIG_DVB_TDA10048=y
# CONFIG_DVB_AF9013 is not set
CONFIG_DVB_EC100=y
# CONFIG_DVB_HD29L2 is not set
# CONFIG_DVB_STV0367 is not set
CONFIG_DVB_CXD2820R=y
CONFIG_DVB_CXD2841ER=y
CONFIG_DVB_RTL2830=y
CONFIG_DVB_RTL2832=y
CONFIG_DVB_SI2168=y
# CONFIG_DVB_AS102_FE is not set

#
# DVB-C (cable) frontends
#
# CONFIG_DVB_VES1820 is not set
CONFIG_DVB_TDA10021=y
# CONFIG_DVB_TDA10023 is not set
CONFIG_DVB_STV0297=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
# CONFIG_DVB_NXT200X is not set
CONFIG_DVB_OR51211=y
# CONFIG_DVB_OR51132 is not set
CONFIG_DVB_BCM3510=y
CONFIG_DVB_LGDT330X=y
# CONFIG_DVB_LGDT3305 is not set
CONFIG_DVB_LGDT3306A=y
# CONFIG_DVB_LG2160 is not set
CONFIG_DVB_S5H1409=y
CONFIG_DVB_AU8522=y
CONFIG_DVB_AU8522_DTV=y
CONFIG_DVB_AU8522_V4L=y
# CONFIG_DVB_S5H1411 is not set

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=y
CONFIG_DVB_DIB8000=y
CONFIG_DVB_MB86A20S=y

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
# CONFIG_DVB_TC90522 is not set

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y
CONFIG_DVB_TUNER_DIB0070=y
CONFIG_DVB_TUNER_DIB0090=y

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=y
CONFIG_DVB_LNBH25=y
# CONFIG_DVB_LNBP21 is not set
CONFIG_DVB_LNBP22=y
# CONFIG_DVB_ISL6405 is not set
CONFIG_DVB_ISL6421=y
CONFIG_DVB_ISL6423=y
# CONFIG_DVB_A8293 is not set
CONFIG_DVB_SP2=y
CONFIG_DVB_LGS8GL5=y
CONFIG_DVB_LGS8GXX=y
CONFIG_DVB_ATBM8830=y
CONFIG_DVB_TDA665x=y
CONFIG_DVB_IX2505V=y
CONFIG_DVB_M88RS2000=y
CONFIG_DVB_AF9033=y
CONFIG_DVB_HORUS3A=y
CONFIG_DVB_ASCOT2E=y

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=y

#
# Graphics support
#
CONFIG_AGP=y
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set

#
# ACP (Audio CoProcessor) Configuration
#
CONFIG_DRM_AMD_ACP=y

#
# Frame buffer Devices
#
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_DDC=y
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_SVGALIB=y
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
CONFIG_FB_PM2=y
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
CONFIG_FB_CYBER2000=y
CONFIG_FB_CYBER2000_DDC=y
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
CONFIG_FB_IMSTT=y
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_N411 is not set
CONFIG_FB_HGA=y
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
CONFIG_FB_NVIDIA=y
# CONFIG_FB_NVIDIA_I2C is not set
# CONFIG_FB_NVIDIA_DEBUG is not set
# CONFIG_FB_NVIDIA_BACKLIGHT is not set
CONFIG_FB_RIVA=y
CONFIG_FB_RIVA_I2C=y
# CONFIG_FB_RIVA_DEBUG is not set
# CONFIG_FB_RIVA_BACKLIGHT is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
CONFIG_FB_MATROX=y
# CONFIG_FB_MATROX_MILLENIUM is not set
# CONFIG_FB_MATROX_MYSTIQUE is not set
# CONFIG_FB_MATROX_G is not set
CONFIG_FB_MATROX_I2C=y
CONFIG_FB_RADEON=y
# CONFIG_FB_RADEON_I2C is not set
# CONFIG_FB_RADEON_BACKLIGHT is not set
CONFIG_FB_RADEON_DEBUG=y
CONFIG_FB_ATY128=y
# CONFIG_FB_ATY128_BACKLIGHT is not set
CONFIG_FB_ATY=y
# CONFIG_FB_ATY_CT is not set
CONFIG_FB_ATY_GX=y
# CONFIG_FB_ATY_BACKLIGHT is not set
# CONFIG_FB_S3 is not set
CONFIG_FB_SAVAGE=y
CONFIG_FB_SAVAGE_I2C=y
CONFIG_FB_SAVAGE_ACCEL=y
CONFIG_FB_SIS=y
# CONFIG_FB_SIS_300 is not set
CONFIG_FB_SIS_315=y
CONFIG_FB_NEOMAGIC=y
CONFIG_FB_KYRO=y
CONFIG_FB_3DFX=y
# CONFIG_FB_3DFX_ACCEL is not set
# CONFIG_FB_3DFX_I2C is not set
CONFIG_FB_VOODOO1=y
CONFIG_FB_VT8623=y
CONFIG_FB_TRIDENT=y
CONFIG_FB_ARK=y
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=y
# CONFIG_FB_CARMINE_DRAM_EVAL is not set
CONFIG_CARMINE_DRAM_CUSTOM=y
# CONFIG_FB_SM501 is not set
CONFIG_FB_IBM_GXT4500=y
CONFIG_FB_GOLDFISH=y
CONFIG_FB_VIRTUAL=y
# CONFIG_FB_METRONOME is not set
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
# CONFIG_FB_BROADSHEET is not set
# CONFIG_FB_AUO_K190X is not set
CONFIG_FB_SIMPLE=y
CONFIG_FB_SM712=y
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_PLATFORM is not set
# CONFIG_BACKLIGHT_CLASS_DEVICE is not set
CONFIG_VGASTATE=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_LOGO is not set
CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
# CONFIG_SND is not set
CONFIG_SOUND_PRIME=y
CONFIG_SOUND_OSS=y
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_DMAP=y
CONFIG_SOUND_VMIDI=y
# CONFIG_SOUND_TRIX is not set
CONFIG_SOUND_MSS=y
# CONFIG_SOUND_MPU401 is not set
CONFIG_SOUND_PAS=y
# CONFIG_PAS_JOYSTICK is not set
CONFIG_SOUND_PSS=y
CONFIG_PSS_MIXER=y
# CONFIG_PSS_HAVE_BOOT is not set
CONFIG_SOUND_SB=y
CONFIG_SOUND_YM3812=y
CONFIG_SOUND_UART6850=y
# CONFIG_SOUND_AEDSP16 is not set
# CONFIG_SOUND_KAHLUA is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=y
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
# CONFIG_HID_CHERRY is not set
CONFIG_HID_CHICONY=y
# CONFIG_HID_CMEDIA is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
CONFIG_DRAGONRISE_FF=y
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=y
CONFIG_HID_WALTOP=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LENOVO=y
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=y
CONFIG_HID_LOGITECH_HIDPP=y
# CONFIG_LOGITECH_FF is not set
CONFIG_LOGIRUMBLEPAD2_FF=y
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=y
CONFIG_HID_SAITEK=y
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
CONFIG_GREENASIA_FF=y
CONFIG_HID_SMARTJOYPLUS=y
CONFIG_SMARTJOYPLUS_FF=y
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
CONFIG_HID_THRUSTMASTER=y
CONFIG_THRUSTMASTER_FF=y
CONFIG_HID_WACOM=y
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y

#
# I2C HID support
#
CONFIG_I2C_HID=y
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_USB_PHY is not set
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_TAHVO_USB is not set
# CONFIG_USB_GADGET is not set
# CONFIG_UWB is not set
CONFIG_MMC=y
CONFIG_MMC_DEBUG=y
CONFIG_PWRSEQ_EMMC=y
CONFIG_PWRSEQ_SIMPLE=y

#
# MMC/SD/SDIO Card Drivers
#
# CONFIG_MMC_BLOCK is not set
CONFIG_SDIO_UART=y
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_SDHCI=y
# CONFIG_MMC_SDHCI_PCI is not set
CONFIG_MMC_SDHCI_ACPI=y
# CONFIG_MMC_SDHCI_PLTFM is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=y
# CONFIG_MMC_GOLDFISH is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_USDHI6ROL0=y
CONFIG_MMC_REALTEK_PCI=y
CONFIG_MMC_TOSHIBA_PCI=y
CONFIG_MMC_MTK=y
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
# CONFIG_MSPRO_BLOCK is not set
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
CONFIG_MEMSTICK_JMICRON_38X=y
CONFIG_MEMSTICK_R592=y
CONFIG_MEMSTICK_REALTEK_PCI=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set

#
# LED drivers
#
CONFIG_LEDS_BCM6328=y
# CONFIG_LEDS_BCM6358 is not set
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_PCA9532=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=y
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8788=y
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_CLEVO_MAIL=y
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_WM8350=y
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=y
CONFIG_LEDS_ADP5520=y
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_MAX8997=y
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_MENF21BMC=y
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
CONFIG_LEDS_SYSCON=y

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set
CONFIG_ACCESSIBILITY=y
CONFIG_A11Y_BRAILLE_CONSOLE=y
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
CONFIG_AUXDISPLAY=y
# CONFIG_UIO is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VIRTIO=y

#
# Virtio drivers
#
CONFIG_VIRTIO_PCI=y
# CONFIG_VIRTIO_PCI_LEGACY is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=y
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACERHDF=y
CONFIG_DELL_SMBIOS=y
# CONFIG_DELL_SMO8800 is not set
# CONFIG_FUJITSU_TABLET is not set
CONFIG_HP_ACCEL=y
# CONFIG_HP_WIRELESS is not set
CONFIG_SENSORS_HDAPS=y
CONFIG_ASUS_WIRELESS=y
# CONFIG_ACPI_WMI is not set
CONFIG_TOPSTAR_LAPTOP=y
CONFIG_TOSHIBA_BT_RFKILL=y
CONFIG_TOSHIBA_HAPS=y
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_HID_EVENT is not set
CONFIG_INTEL_IPS=y
CONFIG_IBM_RTL=y
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_INTEL_RST is not set
CONFIG_INTEL_SMARTCONNECT=y
CONFIG_PVPANIC=y
CONFIG_INTEL_PMC_IPC=y
CONFIG_SURFACE_PRO3_BUTTON=y
CONFIG_INTEL_PUNIT_IPC=y
CONFIG_INTEL_TELEMETRY=y
# CONFIG_GOLDFISH_BUS is not set
CONFIG_GOLDFISH_PIPE=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=y
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CROS_EC_CHARDEV is not set
CONFIG_CROS_EC_LPC=y
CONFIG_CROS_EC_PROTO=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_MAX_GEN=y
# CONFIG_COMMON_CLK_MAX77686 is not set
CONFIG_COMMON_CLK_MAX77802=y
# CONFIG_COMMON_CLK_RK808 is not set
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_SI514=y
CONFIG_COMMON_CLK_SI570=y
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_CDCE925=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
CONFIG_COMMON_CLK_S2MPS11=y
CONFIG_CLK_TWL6040=y
# CONFIG_COMMON_CLK_NXP is not set
CONFIG_COMMON_CLK_PALMAS=y
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set
# CONFIG_COMMON_CLK_OXNAS is not set

#
# Hardware Spinlock drivers
#

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
# CONFIG_MAILBOX is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_AMD_IOMMU is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
CONFIG_STE_MODEM_RPROC=y

#
# Rpmsg drivers
#

#
# SOC (System On Chip) specific Drivers
#
# CONFIG_SUNXI_SRAM is not set
CONFIG_SOC_TI=y
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
# CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND is not set
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
CONFIG_EXTCON_MAX8997=y
CONFIG_EXTCON_PALMAS=y
# CONFIG_EXTCON_RT8973A is not set
CONFIG_EXTCON_SM5502=y
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_TRIGGER=y

#
# Accelerometers
#
# CONFIG_BMA180 is not set
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
# CONFIG_HID_SENSOR_ACCEL_3D is not set
CONFIG_IIO_ST_ACCEL_3AXIS=y
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=y
CONFIG_KXCJK1013=y
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
CONFIG_MMA8452=y
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
CONFIG_MXC6255=y
CONFIG_STK8312=y
# CONFIG_STK8BA50 is not set

#
# Analog to digital converters
#
# CONFIG_AD7291 is not set
CONFIG_AD799X=y
# CONFIG_CC10001_ADC is not set
CONFIG_LP8788_ADC=y
CONFIG_MAX1363=y
CONFIG_MCP3422=y
CONFIG_MEN_Z188_ADC=y
CONFIG_NAU7802=y
CONFIG_PALMAS_GPADC=y
CONFIG_TI_ADC081C=y
CONFIG_TI_AM335X_ADC=y
# CONFIG_VF610_ADC is not set

#
# Amplifiers
#

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
# CONFIG_IAQCORE is not set
# CONFIG_VZ89X is not set

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=y
CONFIG_HID_SENSOR_IIO_TRIGGER=y
CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
CONFIG_AD5380=y
# CONFIG_AD5446 is not set
# CONFIG_AD5593R is not set
CONFIG_M62332=y
CONFIG_MAX517=y
CONFIG_MAX5821=y
CONFIG_MCP4725=y
CONFIG_VF610_DAC=y

#
# IIO dummy driver
#
# CONFIG_IIO_SIMPLE_DUMMY is not set

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#

#
# Phase-Locked Loop (PLL) frequency synthesizers
#

#
# Digital gyroscope sensors
#
# CONFIG_BMG160 is not set
CONFIG_HID_SENSOR_GYRO_3D=y
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=y
CONFIG_MAX30100=y

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_HDC100X is not set
CONFIG_HTU21=y
# CONFIG_SI7005 is not set
CONFIG_SI7020=y

#
# Inertial measurement units
#
# CONFIG_BMI160_I2C is not set
# CONFIG_KMX61 is not set
# CONFIG_INV_MPU6050_I2C is not set

#
# Light sensors
#
CONFIG_ACPI_ALS=y
CONFIG_ADJD_S311=y
# CONFIG_AL3320A is not set
CONFIG_APDS9300=y
CONFIG_APDS9960=y
# CONFIG_BH1750 is not set
CONFIG_CM32181=y
CONFIG_CM3232=y
CONFIG_CM3323=y
CONFIG_CM36651=y
CONFIG_GP2AP020A00F=y
CONFIG_ISL29125=y
CONFIG_HID_SENSOR_ALS=y
CONFIG_HID_SENSOR_PROX=y
CONFIG_JSA1212=y
CONFIG_RPR0521=y
CONFIG_SENSORS_LM3533=y
CONFIG_LTR501=y
# CONFIG_MAX44000 is not set
CONFIG_OPT3001=y
CONFIG_PA12203001=y
CONFIG_STK3310=y
CONFIG_TCS3414=y
# CONFIG_TCS3472 is not set
CONFIG_SENSORS_TSL2563=y
CONFIG_TSL4531=y
CONFIG_US5182D=y
# CONFIG_VCNL4000 is not set
# CONFIG_VEML6070 is not set

#
# Magnetometer sensors
#
# CONFIG_BMC150_MAGN_I2C is not set
CONFIG_MAG3110=y
# CONFIG_HID_SENSOR_MAGNETOMETER_3D is not set
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=y
CONFIG_HID_SENSOR_DEVICE_ROTATION=y

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=y
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_SYSFS_TRIGGER=y

#
# Digital potentiometers
#
# CONFIG_DS1803 is not set
CONFIG_MCP4531=y
# CONFIG_TPL0102 is not set

#
# Pressure sensors
#
# CONFIG_HID_SENSOR_PRESS is not set
# CONFIG_HP03 is not set
# CONFIG_MPL115_I2C is not set
CONFIG_MPL3115=y
CONFIG_MS5611=y
CONFIG_MS5611_I2C=y
CONFIG_MS5637=y
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set

#
# Lightning sensors
#

#
# Proximity sensors
#
CONFIG_LIDAR_LITE_V2=y
# CONFIG_SX9500 is not set

#
# Temperature sensors
#
# CONFIG_MLX90614 is not set
CONFIG_TMP006=y
CONFIG_TSYS01=y
# CONFIG_TSYS02D is not set
CONFIG_NTB=y
CONFIG_NTB_AMD=y
CONFIG_NTB_INTEL=y
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
CONFIG_NTB_TRANSPORT=y
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
CONFIG_VME_CA91CX42=y
# CONFIG_VME_TSI148 is not set

#
# VME Board Drivers
#
CONFIG_VMIVME_7805=y

#
# VME Device Drivers
#
# CONFIG_PWM is not set
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_FMC=y
CONFIG_FMC_FAKEDEV=y
CONFIG_FMC_TRIVIAL=y
CONFIG_FMC_WRITE_EEPROM=y
CONFIG_FMC_CHARDEV=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_PHY_PXA_28NM_HSIC is not set
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_BCM_KONA_USB2_PHY=y
CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=y
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set

#
# Performance monitor support
#
CONFIG_RAS=y
CONFIG_THUNDERBOLT=y

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# CONFIG_LIBNVDIMM is not set
CONFIG_NVMEM=y
CONFIG_STM=y
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
CONFIG_INTEL_TH_GTH=y
# CONFIG_INTEL_TH_STH is not set
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=y
CONFIG_INTEL_TH_DEBUG=y

#
# FPGA Configuration Support
#
# CONFIG_FPGA is not set

#
# Firmware Drivers
#
CONFIG_EDD=y
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DELL_RBU is not set
CONFIG_DCDBAS=y
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_GOOGLE_FIRMWARE=y

#
# Google Firmware Drivers
#
CONFIG_GOOGLE_MEMCONSOLE=y
CONFIG_UEFI_CPER=y

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
# CONFIG_EXT4_USE_FOR_EXT2 is not set
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_FS_ENCRYPTION=y
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
CONFIG_JFS_FS=y
# CONFIG_JFS_POSIX_ACL is not set
# CONFIG_JFS_SECURITY is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
CONFIG_XFS_WARN=y
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
CONFIG_BTRFS_DEBUG=y
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=y
# CONFIG_F2FS_STAT_FS is not set
# CONFIG_F2FS_FS_XATTR is not set
CONFIG_F2FS_CHECK_FS=y
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QFMT_V1=y
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_OVERLAY_FS=y

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_FSCACHE_OBJECT_LIST=y
CONFIG_CACHEFILES=y
# CONFIG_CACHEFILES_DEBUG is not set
CONFIG_CACHEFILES_HISTOGRAM=y

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_PROC_VMCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_CONFIGFS_FS=y
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
CONFIG_ADFS_FS=y
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=y
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_HFS_FS=y
# CONFIG_HFSPLUS_FS is not set
CONFIG_BEFS_FS=y
CONFIG_BEFS_DEBUG=y
CONFIG_BFS_FS=y
CONFIG_EFS_FS=y
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
CONFIG_JFFS2_SUMMARY=y
# CONFIG_JFFS2_FS_XATTR is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
# CONFIG_JFFS2_LZO is not set
CONFIG_JFFS2_RTIME=y
# CONFIG_JFFS2_RUBIN is not set
CONFIG_UBIFS_FS=y
CONFIG_UBIFS_FS_ADVANCED_COMPR=y
# CONFIG_UBIFS_FS_LZO is not set
CONFIG_UBIFS_FS_ZLIB=y
CONFIG_UBIFS_ATIME_SUPPORT=y
# CONFIG_LOGFS is not set
CONFIG_CRAMFS=y
# CONFIG_SQUASHFS is not set
CONFIG_VXFS_FS=y
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
CONFIG_HPFS_FS=y
# CONFIG_QNX4FS_FS is not set
CONFIG_QNX6FS_FS=y
CONFIG_QNX6FS_DEBUG=y
CONFIG_ROMFS_FS=y
CONFIG_ROMFS_BACKED_BY_BLOCK=y
# CONFIG_ROMFS_BACKED_BY_MTD is not set
# CONFIG_ROMFS_BACKED_BY_BOTH is not set
CONFIG_ROMFS_ON_BLOCK=y
CONFIG_PSTORE=y
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
CONFIG_PSTORE_RAM=y
CONFIG_SYSV_FS=y
# CONFIG_UFS_FS is not set
CONFIG_EXOFS_FS=y
# CONFIG_EXOFS_DEBUG is not set
CONFIG_ORE=y
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=y
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=y
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y

#
# Compile-time checks and compiler options
#
# CONFIG_DEBUG_INFO is not set
# CONFIG_ENABLE_WARN_DEPRECATED is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_ARCH_WANT_FRAME_POINTERS=y
CONFIG_FRAME_POINTER=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
CONFIG_DEBUG_OBJECTS_FREE=y
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
CONFIG_DEBUG_OBJECTS_WORK=y
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_DEBUG_SLAB is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_MEMORY_NOTIFIER_ERROR_INJECT is not set
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KMEMCHECK=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_KASAN=y
CONFIG_KASAN_OUTLINE=y
# CONFIG_KASAN_INLINE is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_KCOV=y
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
# CONFIG_LOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=1
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_TIMEKEEPING=y
CONFIG_TIMER_STATS=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_LIST is not set
CONFIG_DEBUG_PI_LIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_REPEATEDLY is not set
CONFIG_SPARSE_RCU_POINTER=y
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
# CONFIG_RCU_TORTURE_TEST_RUNNABLE is not set
CONFIG_RCU_TORTURE_TEST_SLOW_PREINIT=y
CONFIG_RCU_TORTURE_TEST_SLOW_PREINIT_DELAY=3
# CONFIG_RCU_TORTURE_TEST_SLOW_INIT is not set
CONFIG_RCU_TORTURE_TEST_SLOW_CLEANUP=y
CONFIG_RCU_TORTURE_TEST_SLOW_CLEANUP_DELAY=3
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_CPU_NOTIFIER_ERROR_INJECT=y
# CONFIG_PM_NOTIFIER_ERROR_INJECT is not set
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAIL_MAKE_REQUEST is not set
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
CONFIG_LATENCYTOP=y
CONFIG_ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS=y
# CONFIG_DEBUG_STRICT_USER_COPY_CHECKS is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_FP_TEST=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set

#
# Runtime Testing
#
CONFIG_LKDTM=y
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
CONFIG_ASYNC_RAID6_TEST=y
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_KSTRTOX=y
CONFIG_TEST_PRINTF=y
CONFIG_TEST_BITMAP=y
CONFIG_TEST_RHASHTABLE=y
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_BUILD_DOCSRC=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_UDELAY=y
CONFIG_MEMTEST=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=y
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_DEBUG_WX=y
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_IOMMU_DEBUG=y
# CONFIG_IOMMU_STRESS is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
CONFIG_DEFAULT_IO_DELAY_TYPE=3
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
CONFIG_DEBUG_ENTRY=y
CONFIG_DEBUG_NMI_SELFTEST=y
# CONFIG_X86_DEBUG_FPU is not set
CONFIG_PUNIT_ATOM_DEBUG=y

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=y
CONFIG_ASYNC_MEMCPY=y
CONFIG_ASYNC_XOR=y
CONFIG_ASYNC_PQ=y
CONFIG_ASYNC_RAID6_RECOV=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=y
# CONFIG_CRYPTO_AUTHENC is not set
CONFIG_CRYPTO_ABLK_HELPER=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_RMD128=y
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
CONFIG_CRYPTO_SHA512_SSSE3=y
CONFIG_CRYPTO_SHA1_MB=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_WP512=y
# CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_X86_64=y
# CONFIG_CRYPTO_AES_NI_INTEL is not set
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_BLOWFISH_X86_64=y
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_DES3_EDE_X86_64=y
CONFIG_CRYPTO_FCRYPT=y
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_SALSA20=y
# CONFIG_CRYPTO_SALSA20_X86_64 is not set
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_BITREVERSE=y
# CONFIG_HAVE_ARCH_BITREVERSE is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_IO=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
# CONFIG_CRC8 is not set
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
CONFIG_RANDOM32_SELFTEST=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_NLATTR=y
CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=y
# CONFIG_DDR is not set
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONTS=y
# CONFIG_FONT_8x8 is not set
CONFIG_FONT_8x16=y
CONFIG_FONT_6x11=y
CONFIG_FONT_7x14=y
CONFIG_FONT_PEARL_8x8=y
CONFIG_FONT_ACORN_8x8=y
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_6x10 is not set
CONFIG_FONT_SUN8x16=y
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_10x18 is not set
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_MMIO_FLUSH=y
CONFIG_STACKDEPOT=y

--=_57493af0.56m+K9dyVM5EF72hEA2eqx9CD7gMKVb1xGnn5Ww62wZiNuUC--
