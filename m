From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [LKP] [usb] bea5b158ff WARNING: CPU: 0 PID: 25 at
 drivers/usb/core/urb.c:338 usb_submit_urb
Date: Tue, 28 Feb 2017 12:47:09 +0800
Message-ID: <20170228044709.GA19456@b29397-desktop>
References: <20170226101959.hhtbjj4ee6ujxdr4@wfg-t540p.sh.intel.com>
 <20170227095442.GA26576@b29397-desktop>
 <20170228014739.GB12307@yexl-desktop>
 <20170228043255.GD9855@yexl-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170228043255.GD9855@yexl-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Ye Xiaolong <xiaolong.ye@intel.com>
Cc: Rob Herring <robh@kernel.org>, Felipe Balbi <felipe.balbi@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Fengguang Wu <fengguang.wu@intel.com>, LKP <lkp@01.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 28, 2017 at 12:32:55PM +0800, Ye Xiaolong wrote:
> On 02/28, Ye Xiaolong wrote:
> >On 02/27, Peter Chen wrote:
> >>On Sun, Feb 26, 2017 at 06:19:59PM +0800, Fengguang Wu wrote:
> >>> [Sorry, resend to correct Felipe's email address]
> >>> 
> >>> Greetings,
> >>> 
> >>> This debug patch possibly discloses some USB/I2C bugs. Since the USB
> >>> warning shows up earlier in dmesg, it might also be the root cause of
> >>> the I2C bug. The attached reproduce-* script may help debug them.
> >>> 
> >>> [    9.260542] hub 1-0:1.0: 1 port detected
> >>> [    9.261049] hub 1-0:1.0: USB hub found
> >>> [    9.261458] hub 1-0:1.0: 1 port detected
> >>> [    9.262388] kobject (cf9188bc): tried to init an initialized object, something is seriously wrong.
> >>> [    9.263589] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.8.0-rc4-00003-gbea5b15 #2
> >>> [    9.264595] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-20161025_171302-gandalf 04/01/2014
> >>> [    9.265922]  00000000 00000000 c0047db4 c11aec39 cf9188bc c1c1ba9c c0047dcc c11b0616
> >>> [    9.267073]  c1ab0c68 cf9188bc cf9188b4 cf918868 c0047dd8 c13090ec cf9188b4 c0047de4
> >>> [    9.268230]  c130a49e ce6a8000 c0047e04 c1402216 ce69300c 00200246 cf9188b4 cf918000
> >>> [    9.269388] Call Trace:
> >>> [    9.269720]  [<c11aec39>] dump_stack+0x58/0x72
> >>> [    9.270312]  [<c11b0616>] kobject_init+0x27/0x71
> >>> [    9.270929]  [<c13090ec>] device_initialize+0x1b/0xbd
> >>> [    9.271599]  [<c130a49e>] device_register+0xb/0x15
> >>> [    9.272236]  [<c1402216>] usb_add_gadget_udc_release+0x85/0x215
> >>> [    9.273036]  [<c1402403>] usb_add_gadget_udc+0xa/0xc
> >>> [    9.273700]  [<c1403f37>] dummy_udc_probe+0x130/0x168
> >>> [    9.274377]  [<c130cf05>] platform_drv_probe+0x44/0x80
> >>> [    9.275047]  [<c130bef3>] driver_probe_device+0xfe/0x297
> >>> [    9.275748]  [<c130c17a>] __device_attach_driver+0x65/0x71
> >>> [    9.276481]  [<c130add0>] bus_for_each_drv+0x3a/0x67
> >>> [    9.277130]  [<c130bd02>] __device_attach+0x86/0xdb
> >>> [    9.277778]  [<c130c115>] ? driver_allows_async_probing+0xc/0xc
> >>> [    9.278561]  [<c130c28a>] device_initial_probe+0xd/0xf
> >>> [    9.279235]  [<c130af4f>] bus_probe_device+0x25/0x67
> >>> [    9.279895]  [<c130a33d>] device_add+0x341/0x497
> >>> [    9.280517]  [<c130930f>] ? dev_set_name+0x14/0x16
> >>> [    9.281154]  [<c130d4c5>] platform_device_add+0x117/0x161
> >>> [    9.281879]  [<c1d18945>] init+0x20d/0x2f4
> >>> [    9.282431]  [<c1d18738>] ? usb_udc_init+0x3f/0x3f
> >>> [    9.283075]  [<c1cdeba3>] do_one_initcall+0x7e/0xfc
> >>> [    9.283725]  [<c1056209>] ? parse_args+0x19b/0x26f
> >>> [    9.284362]  [<c1cded68>] ? kernel_init_freeable+0x147/0x1eb
> >>> [    9.285100]  [<c1cded84>] kernel_init_freeable+0x163/0x1eb
> >>> [    9.285826]  [<c170d049>] kernel_init+0x8/0xd0
> >>> [    9.286417]  [<c17122e2>] ret_from_kernel_thread+0xe/0x24
> >>> [    9.287118]  [<c170d041>] ? rest_init+0xa5/0xa5
> >>> [    9.288532] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
> >>> [    9.290663] serio: i8042 KBD port at 0x60,0x64 irq 1
> >>> [    9.291372] serio: i8042 AUX port at 0x60,0x64 irq 12
> >>> [    9.293351] serio: i8042 KBD port at 0x60,0x64 irq 1
> >>> [    9.294031] serio: i8042 AUX port at 0x60,0x64 irq 12
> >>
> >>Fengguang, thanks for reporting it, I can also reproduce it using
> >>unbind/bind interface for dummy_udc. The reason for it is that
> >>the memory region of struct usb_gadget at dummy_udc is from the
> >>platform data of platform device dummy_udc, so this memory region
> >>will not be released after the resources for device dummy_udc are
> >>released. The below diff can fix my problem, would you mind testing
> >>it:
> >
> >I've queued jobs to verify your fix, I'll post the result once I get it.
> 
> The dummy_udc WARN is gone with this patch for 100+ times of boot tests.
> 
> Tested-by: Xiaolong Ye <xiaolong.ye@intel.com>
> 
> Thanks,
> Xiaolong
> 

Thanks, Xiaolong. I will submit a patch for it.

Peter
> >
> >Thanks,
> >Xiaolong
> >>
> >>diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
> >>index c60abe3..a358cb9 100644
> >>--- a/drivers/usb/gadget/udc/dummy_hcd.c
> >>+++ b/drivers/usb/gadget/udc/dummy_hcd.c
> >>@@ -1031,6 +1031,7 @@ static int dummy_udc_probe(struct platform_device *pdev)
> >> 	int		rc;
> >> 
> >> 	dum = *((void **)dev_get_platdata(&pdev->dev));
> >>+	memzero_explicit(&dum->gadget, sizeof (struct usb_gadget));
> >> 	dum->gadget.name = gadget_name;
> >> 	dum->gadget.ops = &dummy_ops;
> >> 	dum->gadget.max_speed = USB_SPEED_SUPER;
> >>
> >>
> >>Peter
> >>> 
> >>> The attached dmesg has more follow up errors.
> >>> 
> >>> git bisect start v4.9 v4.8 --
> >>> git bisect  bad 9fe68cad6e74967b88d0c6aeca7d9cd6b6e91942  # 00:43     18-     30  Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
> >>> git bisect  bad d8ea757b25ec82687c497fc90aa83f9bcea24b5b  # 01:11      4-      6  Merge tag 'xtensa-20161005' of git://github.com/jcmvbkbc/linux-xtensa
> >>> git bisect  bad e6445f52d9c8b0e6557a45fa7d0e8e088d430a8c  # 01:17      6-     11  Merge tag 'usb-4.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
> >>> git bisect good 1a4a2bc460721bc8f91e4c1294d39b38e5af132f  # 01:32     52+      0  Merge branch 'x86-asm-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> >>> git bisect good 3ef0a61a467639cf7def299309cd9ea524c3e1c1  # 01:50     52+      0  Merge branch 'x86-boot-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> >>> git bisect  bad e6dce825fba05f447bd22c865e27233182ab3d79  # 02:02     17-     27  Merge tag 'tty-4.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
> >>> git bisect good 597f03f9d133e9837d00965016170271d4f87dcf  # 02:34     55+      0  Merge branch 'smp-hotplug-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> >>> git bisect good 7a53eea1f7b527fd3b6d7ca992914840981afe99  # 02:55     51+      0  Merge tag 'char-misc-4.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
> >>> git bisect  bad 9929780e86854833e649b39b290b5fe921eb1701  # 03:03      1-      3  Merge tag 'driver-core-4.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
> >>> git bisect  bad 2c507e464f791327c94d17a0137f00b4717744fc  # 03:15      2-      4  device core: Remove deprecated create_singlethread_workqueue
> >>> git bisect  bad 03aca7b260ea2aadf92596d2f57160e4aee8ffb0  # 03:26      0-      7  attribute_container: Fix typo
> >>> git bisect  bad bea5b158ff0da9c7246ff391f754f5f38e34577a  # 03:41      0-      1  driver core: add test of driver remove calls during probe
> >>> git bisect good 24ef5f360f22e4408cb49d75755d27d5a21820f7  # 03:57     51+      0  debugfs: remove extra debugfs_create_file_unsafe() declaration
> >>> git bisect good cebf8fd16900fdfd58c0028617944f808f97fe50  # 08:29     55+      0  driver core: fix race between creating/querying glue dir and its cleanup
> >>> # first bad commit: [bea5b158ff0da9c7246ff391f754f5f38e34577a] driver core: add test of driver remove calls during probe
> >>> git bisect good cebf8fd16900fdfd58c0028617944f808f97fe50  # 11:46    160+      0  driver core: fix race between creating/querying glue dir and its cleanup
> >>> # extra tests with CONFIG_DEBUG_INFO_REDUCED
> >>> # extra tests on HEAD of linux-devel/devel-spot-201702252217
> >>> git bisect  bad b2c7455f59b51a4477df19cd36f18ef4734a860e  # 11:51      0-     13  0day head guard for 'devel-spot-201702252217'
> >>> # extra tests on tree/branch linus/master
> >>> git bisect  bad c4f3f22eddc982d247ffe2a6690c3e4a5c46dd09  # 12:01      2-      1  Merge tag 'linux-kselftest-4.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
> >>> # extra tests on tree/branch linux-next/master
> >>> 
> >>> ---
> >>> 0-DAY kernel test infrastructure                Open Source Technology Center
> >>> https://lists.01.org/pipermail/lkp                          Intel Corporation
> >>
> >>
> >>> #!/bin/bash
> >>> 
> >>> kernel=$1
> >>> 		initrd=quantal-core-i386.cgz
> >>> 
> >>> 		wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/initrd/$initrd
> >>> 
> >>> kvm=(
> >>> 	qemu-system-x86_64
> >>> 	-enable-kvm
> >>> 	-cpu kvm64
> >>> 	-kernel $kernel
> >>> 	-initrd $initrd
> >>> 	-m 369
> >>> 	-smp 2
> >>> 	-device e1000,netdev=net0
> >>> 	-netdev user,id=net0
> >>> 	-boot order=nc
> >>> 	-no-reboot
> >>> 	-watchdog i6300esb
> >>> 	-watchdog-action debug
> >>> 	-rtc base=localtime
> >>> 	-serial stdio
> >>> 	-display none
> >>> 	-monitor null
> >>> )
> >>> 
> >>> append=(
> >>> 	root=/dev/ram0
> >>> 	hung_task_panic=1
> >>> 	debug
> >>> 	apic=debug
> >>> 	sysrq_always_enabled
> >>> 	rcupdate.rcu_cpu_stall_timeout=100
> >>> 	net.ifnames=0
> >>> 	printk.devkmsg=on
> >>> 	panic=-1
> >>> 	softlockup_panic=1
> >>> 	nmi_watchdog=panic
> >>> 	oops=panic
> >>> 	load_ramdisk=2
> >>> 	prompt_ramdisk=0
> >>> 	drbd.minor_count=8
> >>> 	systemd.log_level=err
> >>> 	ignore_loglevel
> >>> 	earlyprintk=ttyS0,115200
> >>> 	console=ttyS0,115200
> >>> 	console=tty0
> >>> 	vga=normal
> >>> 	rw
> >>> 	drbd.minor_count=8
> >>> )
> >>> 
> >>> "${kvm[@]}" -append "${append[*]}"
> >>
> >>> #
> >>> # Automatically generated file; DO NOT EDIT.
> >>> # Linux/i386 4.8.0-rc4 Kernel Configuration
> >>> #
> >>> # CONFIG_64BIT is not set
> >>> CONFIG_X86_32=y
> >>> CONFIG_X86=y
> >>> CONFIG_INSTRUCTION_DECODER=y
> >>> CONFIG_OUTPUT_FORMAT="elf32-i386"
> >>> CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
> >>> CONFIG_LOCKDEP_SUPPORT=y
> >>> CONFIG_STACKTRACE_SUPPORT=y
> >>> CONFIG_MMU=y
> >>> CONFIG_ARCH_MMAP_RND_BITS_MIN=8
> >>> CONFIG_ARCH_MMAP_RND_BITS_MAX=16
> >>> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> >>> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> >>> CONFIG_NEED_SG_DMA_LENGTH=y
> >>> CONFIG_GENERIC_ISA_DMA=y
> >>> CONFIG_GENERIC_BUG=y
> >>> CONFIG_GENERIC_HWEIGHT=y
> >>> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> >>> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> >>> CONFIG_GENERIC_CALIBRATE_DELAY=y
> >>> CONFIG_ARCH_HAS_CPU_RELAX=y
> >>> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> >>> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> >>> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> >>> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> >>> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> >>> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> >>> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> >>> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> >>> CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
> >>> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> >>> CONFIG_X86_32_SMP=y
> >>> CONFIG_X86_32_LAZY_GS=y
> >>> CONFIG_ARCH_SUPPORTS_UPROBES=y
> >>> CONFIG_FIX_EARLYCON_MEM=y
> >>> CONFIG_DEBUG_RODATA=y
> >>> CONFIG_PGTABLE_LEVELS=2
> >>> CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
> >>> CONFIG_IRQ_WORK=y
> >>> CONFIG_BUILDTIME_EXTABLE_SORT=y
> >>> 
> >>> #
> >>> # General setup
> >>> #
> >>> CONFIG_INIT_ENV_ARG_LIMIT=32
> >>> CONFIG_CROSS_COMPILE=""
> >>> # CONFIG_COMPILE_TEST is not set
> >>> CONFIG_LOCALVERSION=""
> >>> CONFIG_LOCALVERSION_AUTO=y
> >>> CONFIG_HAVE_KERNEL_GZIP=y
> >>> CONFIG_HAVE_KERNEL_BZIP2=y
> >>> CONFIG_HAVE_KERNEL_LZMA=y
> >>> CONFIG_HAVE_KERNEL_XZ=y
> >>> CONFIG_HAVE_KERNEL_LZO=y
> >>> CONFIG_HAVE_KERNEL_LZ4=y
> >>> CONFIG_KERNEL_GZIP=y
> >>> # CONFIG_KERNEL_BZIP2 is not set
> >>> # CONFIG_KERNEL_LZMA is not set
> >>> # CONFIG_KERNEL_XZ is not set
> >>> # CONFIG_KERNEL_LZO is not set
> >>> # CONFIG_KERNEL_LZ4 is not set
> >>> CONFIG_DEFAULT_HOSTNAME="(none)"
> >>> # CONFIG_SYSVIPC is not set
> >>> # CONFIG_POSIX_MQUEUE is not set
> >>> # CONFIG_CROSS_MEMORY_ATTACH is not set
> >>> CONFIG_FHANDLE=y
> >>> # CONFIG_USELIB is not set
> >>> # CONFIG_AUDIT is not set
> >>> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> >>> 
> >>> #
> >>> # IRQ subsystem
> >>> #
> >>> CONFIG_GENERIC_IRQ_PROBE=y
> >>> CONFIG_GENERIC_IRQ_SHOW=y
> >>> CONFIG_GENERIC_PENDING_IRQ=y
> >>> CONFIG_GENERIC_IRQ_CHIP=y
> >>> CONFIG_IRQ_DOMAIN=y
> >>> CONFIG_IRQ_DOMAIN_HIERARCHY=y
> >>> # CONFIG_IRQ_DOMAIN_DEBUG is not set
> >>> CONFIG_IRQ_FORCED_THREADING=y
> >>> CONFIG_SPARSE_IRQ=y
> >>> CONFIG_CLOCKSOURCE_WATCHDOG=y
> >>> CONFIG_ARCH_CLOCKSOURCE_DATA=y
> >>> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
> >>> CONFIG_GENERIC_TIME_VSYSCALL=y
> >>> CONFIG_GENERIC_CLOCKEVENTS=y
> >>> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
> >>> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> >>> CONFIG_GENERIC_CMOS_UPDATE=y
> >>> 
> >>> #
> >>> # Timers subsystem
> >>> #
> >>> CONFIG_TICK_ONESHOT=y
> >>> CONFIG_NO_HZ_COMMON=y
> >>> # CONFIG_HZ_PERIODIC is not set
> >>> CONFIG_NO_HZ_IDLE=y
> >>> CONFIG_NO_HZ=y
> >>> CONFIG_HIGH_RES_TIMERS=y
> >>> 
> >>> #
> >>> # CPU/Task time and stats accounting
> >>> #
> >>> CONFIG_TICK_CPU_ACCOUNTING=y
> >>> CONFIG_IRQ_TIME_ACCOUNTING=y
> >>> CONFIG_BSD_PROCESS_ACCT=y
> >>> CONFIG_BSD_PROCESS_ACCT_V3=y
> >>> # CONFIG_TASKSTATS is not set
> >>> 
> >>> #
> >>> # RCU Subsystem
> >>> #
> >>> CONFIG_TREE_RCU=y
> >>> # CONFIG_RCU_EXPERT is not set
> >>> CONFIG_SRCU=y
> >>> CONFIG_TASKS_RCU=y
> >>> CONFIG_RCU_STALL_COMMON=y
> >>> CONFIG_TREE_RCU_TRACE=y
> >>> # CONFIG_RCU_EXPEDITE_BOOT is not set
> >>> CONFIG_BUILD_BIN2C=y
> >>> CONFIG_IKCONFIG=y
> >>> CONFIG_IKCONFIG_PROC=y
> >>> CONFIG_LOG_BUF_SHIFT=17
> >>> CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
> >>> CONFIG_NMI_LOG_BUF_SHIFT=13
> >>> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> >>> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> >>> CONFIG_CGROUPS=y
> >>> CONFIG_PAGE_COUNTER=y
> >>> # CONFIG_MEMCG is not set
> >>> CONFIG_CGROUP_SCHED=y
> >>> CONFIG_FAIR_GROUP_SCHED=y
> >>> CONFIG_CFS_BANDWIDTH=y
> >>> CONFIG_RT_GROUP_SCHED=y
> >>> CONFIG_CGROUP_PIDS=y
> >>> # CONFIG_CGROUP_FREEZER is not set
> >>> CONFIG_CGROUP_HUGETLB=y
> >>> CONFIG_CPUSETS=y
> >>> # CONFIG_PROC_PID_CPUSET is not set
> >>> CONFIG_CGROUP_DEVICE=y
> >>> # CONFIG_CGROUP_CPUACCT is not set
> >>> CONFIG_CGROUP_PERF=y
> >>> CONFIG_CGROUP_DEBUG=y
> >>> # CONFIG_CHECKPOINT_RESTORE is not set
> >>> CONFIG_NAMESPACES=y
> >>> # CONFIG_UTS_NS is not set
> >>> CONFIG_USER_NS=y
> >>> CONFIG_PID_NS=y
> >>> CONFIG_NET_NS=y
> >>> CONFIG_SCHED_AUTOGROUP=y
> >>> # CONFIG_SYSFS_DEPRECATED is not set
> >>> # CONFIG_RELAY is not set
> >>> CONFIG_BLK_DEV_INITRD=y
> >>> CONFIG_INITRAMFS_SOURCE=""
> >>> CONFIG_RD_GZIP=y
> >>> CONFIG_RD_BZIP2=y
> >>> CONFIG_RD_LZMA=y
> >>> # CONFIG_RD_XZ is not set
> >>> CONFIG_RD_LZO=y
> >>> # CONFIG_RD_LZ4 is not set
> >>> # CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
> >>> CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> >>> CONFIG_SYSCTL=y
> >>> CONFIG_ANON_INODES=y
> >>> CONFIG_HAVE_UID16=y
> >>> CONFIG_SYSCTL_EXCEPTION_TRACE=y
> >>> CONFIG_HAVE_PCSPKR_PLATFORM=y
> >>> CONFIG_BPF=y
> >>> CONFIG_EXPERT=y
> >>> CONFIG_UID16=y
> >>> CONFIG_MULTIUSER=y
> >>> CONFIG_SGETMASK_SYSCALL=y
> >>> # CONFIG_SYSFS_SYSCALL is not set
> >>> # CONFIG_SYSCTL_SYSCALL is not set
> >>> CONFIG_KALLSYMS=y
> >>> CONFIG_KALLSYMS_ALL=y
> >>> # CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
> >>> CONFIG_KALLSYMS_BASE_RELATIVE=y
> >>> CONFIG_PRINTK=y
> >>> CONFIG_PRINTK_NMI=y
> >>> CONFIG_BUG=y
> >>> # CONFIG_ELF_CORE is not set
> >>> CONFIG_PCSPKR_PLATFORM=y
> >>> CONFIG_BASE_FULL=y
> >>> CONFIG_FUTEX=y
> >>> CONFIG_EPOLL=y
> >>> CONFIG_SIGNALFD=y
> >>> CONFIG_TIMERFD=y
> >>> CONFIG_EVENTFD=y
> >>> # CONFIG_BPF_SYSCALL is not set
> >>> CONFIG_SHMEM=y
> >>> # CONFIG_AIO is not set
> >>> # CONFIG_ADVISE_SYSCALLS is not set
> >>> # CONFIG_USERFAULTFD is not set
> >>> CONFIG_PCI_QUIRKS=y
> >>> # CONFIG_MEMBARRIER is not set
> >>> CONFIG_EMBEDDED=y
> >>> CONFIG_HAVE_PERF_EVENTS=y
> >>> 
> >>> #
> >>> # Kernel Performance Events And Counters
> >>> #
> >>> CONFIG_PERF_EVENTS=y
> >>> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> >>> CONFIG_VM_EVENT_COUNTERS=y
> >>> # CONFIG_COMPAT_BRK is not set
> >>> CONFIG_SLAB=y
> >>> # CONFIG_SLUB is not set
> >>> # CONFIG_SLOB is not set
> >>> # CONFIG_SLAB_FREELIST_RANDOM is not set
> >>> # CONFIG_SYSTEM_DATA_VERIFICATION is not set
> >>> # CONFIG_PROFILING is not set
> >>> CONFIG_KEXEC_CORE=y
> >>> CONFIG_HAVE_OPROFILE=y
> >>> CONFIG_OPROFILE_NMI_TIMER=y
> >>> # CONFIG_JUMP_LABEL is not set
> >>> # CONFIG_UPROBES is not set
> >>> # CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
> >>> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> >>> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> >>> CONFIG_HAVE_IOREMAP_PROT=y
> >>> CONFIG_HAVE_KPROBES=y
> >>> CONFIG_HAVE_KRETPROBES=y
> >>> CONFIG_HAVE_OPTPROBES=y
> >>> CONFIG_HAVE_KPROBES_ON_FTRACE=y
> >>> CONFIG_HAVE_NMI=y
> >>> CONFIG_HAVE_ARCH_TRACEHOOK=y
> >>> CONFIG_HAVE_DMA_CONTIGUOUS=y
> >>> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> >>> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> >>> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> >>> CONFIG_HAVE_CLK=y
> >>> CONFIG_HAVE_DMA_API_DEBUG=y
> >>> CONFIG_HAVE_HW_BREAKPOINT=y
> >>> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> >>> CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> >>> CONFIG_HAVE_PERF_EVENTS_NMI=y
> >>> CONFIG_HAVE_PERF_REGS=y
> >>> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> >>> CONFIG_HAVE_ARCH_JUMP_LABEL=y
> >>> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> >>> CONFIG_HAVE_CMPXCHG_LOCAL=y
> >>> CONFIG_HAVE_CMPXCHG_DOUBLE=y
> >>> CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
> >>> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> >>> CONFIG_SECCOMP_FILTER=y
> >>> CONFIG_HAVE_GCC_PLUGINS=y
> >>> CONFIG_GCC_PLUGINS=y
> >>> # CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
> >>> CONFIG_HAVE_CC_STACKPROTECTOR=y
> >>> # CONFIG_CC_STACKPROTECTOR is not set
> >>> CONFIG_CC_STACKPROTECTOR_NONE=y
> >>> # CONFIG_CC_STACKPROTECTOR_REGULAR is not set
> >>> # CONFIG_CC_STACKPROTECTOR_STRONG is not set
> >>> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> >>> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> >>> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> >>> CONFIG_MODULES_USE_ELF_REL=y
> >>> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> >>> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> >>> CONFIG_HAVE_EXIT_THREAD=y
> >>> CONFIG_ARCH_MMAP_RND_BITS=8
> >>> CONFIG_HAVE_COPY_THREAD_TLS=y
> >>> # CONFIG_HAVE_ARCH_HASH is not set
> >>> CONFIG_ISA_BUS_API=y
> >>> CONFIG_CLONE_BACKWARDS=y
> >>> CONFIG_OLD_SIGSUSPEND3=y
> >>> CONFIG_OLD_SIGACTION=y
> >>> # CONFIG_CPU_NO_EFFICIENT_FFS is not set
> >>> 
> >>> #
> >>> # GCOV-based kernel profiling
> >>> #
> >>> # CONFIG_GCOV_KERNEL is not set
> >>> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> >>> CONFIG_HAVE_GENERIC_DMA_COHERENT=y
> >>> CONFIG_SLABINFO=y
> >>> CONFIG_RT_MUTEXES=y
> >>> CONFIG_BASE_SMALL=0
> >>> # CONFIG_MODULES is not set
> >>> CONFIG_MODULES_TREE_LOOKUP=y
> >>> # CONFIG_BLOCK is not set
> >>> CONFIG_PADATA=y
> >>> CONFIG_UNINLINE_SPIN_UNLOCK=y
> >>> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> >>> CONFIG_RWSEM_SPIN_ON_OWNER=y
> >>> CONFIG_LOCK_SPIN_ON_OWNER=y
> >>> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> >>> CONFIG_QUEUED_SPINLOCKS=y
> >>> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> >>> CONFIG_QUEUED_RWLOCKS=y
> >>> CONFIG_FREEZER=y
> >>> 
> >>> #
> >>> # Processor type and features
> >>> #
> >>> # CONFIG_ZONE_DMA is not set
> >>> CONFIG_SMP=y
> >>> CONFIG_X86_FEATURE_NAMES=y
> >>> # CONFIG_X86_FAST_FEATURE_TESTS is not set
> >>> CONFIG_X86_MPPARSE=y
> >>> # CONFIG_X86_BIGSMP is not set
> >>> CONFIG_GOLDFISH=y
> >>> # CONFIG_X86_EXTENDED_PLATFORM is not set
> >>> CONFIG_X86_INTEL_LPSS=y
> >>> CONFIG_X86_AMD_PLATFORM_DEVICE=y
> >>> CONFIG_IOSF_MBI=y
> >>> # CONFIG_IOSF_MBI_DEBUG is not set
> >>> CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
> >>> # CONFIG_X86_32_IRIS is not set
> >>> # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
> >>> CONFIG_HYPERVISOR_GUEST=y
> >>> CONFIG_PARAVIRT=y
> >>> # CONFIG_PARAVIRT_DEBUG is not set
> >>> # CONFIG_PARAVIRT_SPINLOCKS is not set
> >>> CONFIG_KVM_GUEST=y
> >>> # CONFIG_KVM_DEBUG_FS is not set
> >>> # CONFIG_LGUEST_GUEST is not set
> >>> # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> >>> CONFIG_PARAVIRT_CLOCK=y
> >>> CONFIG_NO_BOOTMEM=y
> >>> # CONFIG_M486 is not set
> >>> # CONFIG_M586 is not set
> >>> # CONFIG_M586TSC is not set
> >>> # CONFIG_M586MMX is not set
> >>> # CONFIG_M686 is not set
> >>> # CONFIG_MPENTIUMII is not set
> >>> # CONFIG_MPENTIUMIII is not set
> >>> # CONFIG_MPENTIUMM is not set
> >>> # CONFIG_MPENTIUM4 is not set
> >>> # CONFIG_MK6 is not set
> >>> # CONFIG_MK7 is not set
> >>> # CONFIG_MK8 is not set
> >>> # CONFIG_MCRUSOE is not set
> >>> CONFIG_MEFFICEON=y
> >>> # CONFIG_MWINCHIPC6 is not set
> >>> # CONFIG_MWINCHIP3D is not set
> >>> # CONFIG_MELAN is not set
> >>> # CONFIG_MGEODEGX1 is not set
> >>> # CONFIG_MGEODE_LX is not set
> >>> # CONFIG_MCYRIXIII is not set
> >>> # CONFIG_MVIAC3_2 is not set
> >>> # CONFIG_MVIAC7 is not set
> >>> # CONFIG_MCORE2 is not set
> >>> # CONFIG_MATOM is not set
> >>> CONFIG_X86_GENERIC=y
> >>> CONFIG_X86_INTERNODE_CACHE_SHIFT=6
> >>> CONFIG_X86_L1_CACHE_SHIFT=6
> >>> CONFIG_X86_INTEL_USERCOPY=y
> >>> CONFIG_X86_USE_PPRO_CHECKSUM=y
> >>> CONFIG_X86_TSC=y
> >>> CONFIG_X86_CMOV=y
> >>> CONFIG_X86_MINIMUM_CPU_FAMILY=4
> >>> CONFIG_X86_DEBUGCTLMSR=y
> >>> # CONFIG_PROCESSOR_SELECT is not set
> >>> CONFIG_CPU_SUP_INTEL=y
> >>> CONFIG_CPU_SUP_CYRIX_32=y
> >>> CONFIG_CPU_SUP_AMD=y
> >>> CONFIG_CPU_SUP_CENTAUR=y
> >>> CONFIG_CPU_SUP_TRANSMETA_32=y
> >>> CONFIG_CPU_SUP_UMC_32=y
> >>> CONFIG_HPET_TIMER=y
> >>> CONFIG_HPET_EMULATE_RTC=y
> >>> CONFIG_DMI=y
> >>> CONFIG_NR_CPUS=8
> >>> # CONFIG_SCHED_SMT is not set
> >>> # CONFIG_SCHED_MC is not set
> >>> CONFIG_PREEMPT_NONE=y
> >>> # CONFIG_PREEMPT_VOLUNTARY is not set
> >>> # CONFIG_PREEMPT is not set
> >>> CONFIG_PREEMPT_COUNT=y
> >>> CONFIG_X86_LOCAL_APIC=y
> >>> CONFIG_X86_IO_APIC=y
> >>> CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
> >>> CONFIG_X86_MCE=y
> >>> # CONFIG_X86_MCE_INTEL is not set
> >>> CONFIG_X86_MCE_AMD=y
> >>> CONFIG_X86_ANCIENT_MCE=y
> >>> CONFIG_X86_MCE_THRESHOLD=y
> >>> CONFIG_X86_MCE_INJECT=y
> >>> 
> >>> #
> >>> # Performance monitoring
> >>> #
> >>> CONFIG_PERF_EVENTS_INTEL_UNCORE=y
> >>> # CONFIG_PERF_EVENTS_INTEL_RAPL is not set
> >>> # CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
> >>> # CONFIG_PERF_EVENTS_AMD_POWER is not set
> >>> # CONFIG_X86_LEGACY_VM86 is not set
> >>> # CONFIG_VM86 is not set
> >>> # CONFIG_TOSHIBA is not set
> >>> CONFIG_I8K=y
> >>> CONFIG_X86_REBOOTFIXUPS=y
> >>> CONFIG_MICROCODE=y
> >>> # CONFIG_MICROCODE_INTEL is not set
> >>> CONFIG_MICROCODE_AMD=y
> >>> CONFIG_MICROCODE_OLD_INTERFACE=y
> >>> CONFIG_X86_MSR=y
> >>> # CONFIG_X86_CPUID is not set
> >>> CONFIG_NOHIGHMEM=y
> >>> # CONFIG_HIGHMEM4G is not set
> >>> # CONFIG_HIGHMEM64G is not set
> >>> CONFIG_VMSPLIT_3G=y
> >>> # CONFIG_VMSPLIT_3G_OPT is not set
> >>> # CONFIG_VMSPLIT_2G is not set
> >>> # CONFIG_VMSPLIT_2G_OPT is not set
> >>> # CONFIG_VMSPLIT_1G is not set
> >>> CONFIG_PAGE_OFFSET=0xC0000000
> >>> # CONFIG_X86_PAE is not set
> >>> CONFIG_ARCH_FLATMEM_ENABLE=y
> >>> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> >>> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> >>> CONFIG_ILLEGAL_POINTER_VALUE=0
> >>> CONFIG_SELECT_MEMORY_MODEL=y
> >>> CONFIG_FLATMEM_MANUAL=y
> >>> # CONFIG_SPARSEMEM_MANUAL is not set
> >>> CONFIG_FLATMEM=y
> >>> CONFIG_FLAT_NODE_MEM_MAP=y
> >>> CONFIG_SPARSEMEM_STATIC=y
> >>> CONFIG_HAVE_MEMBLOCK=y
> >>> CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
> >>> CONFIG_ARCH_DISCARD_MEMBLOCK=y
> >>> CONFIG_MEMORY_ISOLATION=y
> >>> # CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
> >>> CONFIG_SPLIT_PTLOCK_CPUS=4
> >>> CONFIG_COMPACTION=y
> >>> CONFIG_MIGRATION=y
> >>> # CONFIG_PHYS_ADDR_T_64BIT is not set
> >>> CONFIG_VIRT_TO_BUS=y
> >>> # CONFIG_KSM is not set
> >>> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> >>> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
> >>> CONFIG_MEMORY_FAILURE=y
> >>> # CONFIG_HWPOISON_INJECT is not set
> >>> CONFIG_TRANSPARENT_HUGEPAGE=y
> >>> # CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
> >>> CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
> >>> CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
> >>> CONFIG_CLEANCACHE=y
> >>> # CONFIG_CMA is not set
> >>> CONFIG_ZPOOL=y
> >>> # CONFIG_ZBUD is not set
> >>> CONFIG_Z3FOLD=y
> >>> # CONFIG_ZSMALLOC is not set
> >>> CONFIG_GENERIC_EARLY_IOREMAP=y
> >>> CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=y
> >>> # CONFIG_IDLE_PAGE_TRACKING is not set
> >>> CONFIG_FRAME_VECTOR=y
> >>> CONFIG_X86_CHECK_BIOS_CORRUPTION=y
> >>> CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
> >>> CONFIG_X86_RESERVE_LOW=64
> >>> # CONFIG_MTRR is not set
> >>> # CONFIG_ARCH_RANDOM is not set
> >>> # CONFIG_X86_SMAP is not set
> >>> # CONFIG_X86_INTEL_MPX is not set
> >>> # CONFIG_EFI is not set
> >>> CONFIG_SECCOMP=y
> >>> # CONFIG_HZ_100 is not set
> >>> # CONFIG_HZ_250 is not set
> >>> CONFIG_HZ_300=y
> >>> # CONFIG_HZ_1000 is not set
> >>> CONFIG_HZ=300
> >>> CONFIG_SCHED_HRTICK=y
> >>> CONFIG_KEXEC=y
> >>> CONFIG_PHYSICAL_START=0x1000000
> >>> # CONFIG_RELOCATABLE is not set
> >>> CONFIG_PHYSICAL_ALIGN=0x200000
> >>> CONFIG_HOTPLUG_CPU=y
> >>> CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
> >>> # CONFIG_DEBUG_HOTPLUG_CPU0 is not set
> >>> CONFIG_COMPAT_VDSO=y
> >>> # CONFIG_CMDLINE_BOOL is not set
> >>> # CONFIG_MODIFY_LDT_SYSCALL is not set
> >>> 
> >>> #
> >>> # Power management and ACPI options
> >>> #
> >>> CONFIG_SUSPEND=y
> >>> CONFIG_SUSPEND_FREEZER=y
> >>> CONFIG_SUSPEND_SKIP_SYNC=y
> >>> CONFIG_PM_SLEEP=y
> >>> CONFIG_PM_SLEEP_SMP=y
> >>> CONFIG_PM_AUTOSLEEP=y
> >>> # CONFIG_PM_WAKELOCKS is not set
> >>> CONFIG_PM=y
> >>> # CONFIG_PM_DEBUG is not set
> >>> CONFIG_PM_OPP=y
> >>> CONFIG_PM_CLK=y
> >>> CONFIG_PM_GENERIC_DOMAINS=y
> >>> CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
> >>> CONFIG_PM_GENERIC_DOMAINS_SLEEP=y
> >>> CONFIG_PM_GENERIC_DOMAINS_OF=y
> >>> CONFIG_ACPI=y
> >>> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> >>> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> >>> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> >>> CONFIG_ACPI_DEBUGGER=y
> >>> CONFIG_ACPI_DEBUGGER_USER=y
> >>> CONFIG_ACPI_SLEEP=y
> >>> # CONFIG_ACPI_PROCFS_POWER is not set
> >>> CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
> >>> # CONFIG_ACPI_EC_DEBUGFS is not set
> >>> # CONFIG_ACPI_AC is not set
> >>> CONFIG_ACPI_BATTERY=y
> >>> CONFIG_ACPI_BUTTON=y
> >>> CONFIG_ACPI_VIDEO=y
> >>> # CONFIG_ACPI_FAN is not set
> >>> # CONFIG_ACPI_DOCK is not set
> >>> CONFIG_ACPI_CPU_FREQ_PSS=y
> >>> CONFIG_ACPI_PROCESSOR_CSTATE=y
> >>> CONFIG_ACPI_PROCESSOR_IDLE=y
> >>> CONFIG_ACPI_PROCESSOR=y
> >>> # CONFIG_ACPI_IPMI is not set
> >>> CONFIG_ACPI_HOTPLUG_CPU=y
> >>> CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
> >>> CONFIG_ACPI_THERMAL=y
> >>> # CONFIG_ACPI_CUSTOM_DSDT is not set
> >>> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> >>> # CONFIG_ACPI_TABLE_UPGRADE is not set
> >>> CONFIG_ACPI_DEBUG=y
> >>> # CONFIG_ACPI_PCI_SLOT is not set
> >>> CONFIG_X86_PM_TIMER=y
> >>> CONFIG_ACPI_CONTAINER=y
> >>> CONFIG_ACPI_HOTPLUG_IOAPIC=y
> >>> # CONFIG_ACPI_SBS is not set
> >>> # CONFIG_ACPI_HED is not set
> >>> CONFIG_ACPI_CUSTOM_METHOD=y
> >>> # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
> >>> CONFIG_HAVE_ACPI_APEI=y
> >>> CONFIG_HAVE_ACPI_APEI_NMI=y
> >>> CONFIG_ACPI_APEI=y
> >>> # CONFIG_ACPI_APEI_GHES is not set
> >>> # CONFIG_ACPI_APEI_MEMORY_FAILURE is not set
> >>> CONFIG_ACPI_APEI_EINJ=y
> >>> CONFIG_ACPI_APEI_ERST_DEBUG=y
> >>> CONFIG_DPTF_POWER=y
> >>> CONFIG_ACPI_EXTLOG=y
> >>> # CONFIG_PMIC_OPREGION is not set
> >>> CONFIG_ACPI_CONFIGFS=y
> >>> CONFIG_SFI=y
> >>> CONFIG_X86_APM_BOOT=y
> >>> CONFIG_APM=y
> >>> # CONFIG_APM_IGNORE_USER_SUSPEND is not set
> >>> CONFIG_APM_DO_ENABLE=y
> >>> # CONFIG_APM_CPU_IDLE is not set
> >>> CONFIG_APM_DISPLAY_BLANK=y
> >>> # CONFIG_APM_ALLOW_INTS is not set
> >>> 
> >>> #
> >>> # CPU Frequency scaling
> >>> #
> >>> CONFIG_CPU_FREQ=y
> >>> CONFIG_CPU_FREQ_GOV_ATTR_SET=y
> >>> CONFIG_CPU_FREQ_GOV_COMMON=y
> >>> CONFIG_CPU_FREQ_STAT=y
> >>> # CONFIG_CPU_FREQ_STAT_DETAILS is not set
> >>> # CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
> >>> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> >>> CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
> >>> # CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
> >>> # CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
> >>> # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> >>> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> >>> # CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
> >>> CONFIG_CPU_FREQ_GOV_USERSPACE=y
> >>> CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> >>> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> >>> # CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set
> >>> 
> >>> #
> >>> # CPU frequency scaling drivers
> >>> #
> >>> CONFIG_CPUFREQ_DT=y
> >>> CONFIG_CPUFREQ_DT_PLATDEV=y
> >>> # CONFIG_X86_INTEL_PSTATE is not set
> >>> CONFIG_X86_PCC_CPUFREQ=y
> >>> CONFIG_X86_ACPI_CPUFREQ=y
> >>> # CONFIG_X86_ACPI_CPUFREQ_CPB is not set
> >>> CONFIG_X86_POWERNOW_K6=y
> >>> CONFIG_X86_POWERNOW_K7=y
> >>> CONFIG_X86_POWERNOW_K7_ACPI=y
> >>> CONFIG_X86_POWERNOW_K8=y
> >>> # CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
> >>> CONFIG_X86_GX_SUSPMOD=y
> >>> CONFIG_X86_SPEEDSTEP_CENTRINO=y
> >>> CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
> >>> CONFIG_X86_SPEEDSTEP_ICH=y
> >>> CONFIG_X86_SPEEDSTEP_SMI=y
> >>> CONFIG_X86_P4_CLOCKMOD=y
> >>> CONFIG_X86_CPUFREQ_NFORCE2=y
> >>> CONFIG_X86_LONGRUN=y
> >>> CONFIG_X86_LONGHAUL=y
> >>> CONFIG_X86_E_POWERSAVER=y
> >>> 
> >>> #
> >>> # shared options
> >>> #
> >>> CONFIG_X86_SPEEDSTEP_LIB=y
> >>> # CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK is not set
> >>> 
> >>> #
> >>> # CPU Idle
> >>> #
> >>> CONFIG_CPU_IDLE=y
> >>> CONFIG_CPU_IDLE_GOV_LADDER=y
> >>> CONFIG_CPU_IDLE_GOV_MENU=y
> >>> # CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
> >>> CONFIG_INTEL_IDLE=y
> >>> 
> >>> #
> >>> # Bus options (PCI etc.)
> >>> #
> >>> CONFIG_PCI=y
> >>> # CONFIG_PCI_GOBIOS is not set
> >>> # CONFIG_PCI_GOMMCONFIG is not set
> >>> # CONFIG_PCI_GODIRECT is not set
> >>> # CONFIG_PCI_GOOLPC is not set
> >>> CONFIG_PCI_GOANY=y
> >>> CONFIG_PCI_BIOS=y
> >>> CONFIG_PCI_DIRECT=y
> >>> CONFIG_PCI_MMCONFIG=y
> >>> CONFIG_PCI_OLPC=y
> >>> CONFIG_PCI_DOMAINS=y
> >>> CONFIG_PCI_CNB20LE_QUIRK=y
> >>> CONFIG_PCIEPORTBUS=y
> >>> # CONFIG_HOTPLUG_PCI_PCIE is not set
> >>> # CONFIG_PCIEAER is not set
> >>> # CONFIG_PCIEASPM is not set
> >>> CONFIG_PCIE_PME=y
> >>> # CONFIG_PCIE_DPC is not set
> >>> # CONFIG_PCI_MSI is not set
> >>> # CONFIG_PCI_DEBUG is not set
> >>> CONFIG_PCI_REALLOC_ENABLE_AUTO=y
> >>> # CONFIG_PCI_STUB is not set
> >>> # CONFIG_HT_IRQ is not set
> >>> # CONFIG_PCI_IOV is not set
> >>> # CONFIG_PCI_PRI is not set
> >>> # CONFIG_PCI_PASID is not set
> >>> CONFIG_PCI_LABEL=y
> >>> CONFIG_HOTPLUG_PCI=y
> >>> CONFIG_HOTPLUG_PCI_COMPAQ=y
> >>> # CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
> >>> CONFIG_HOTPLUG_PCI_IBM=y
> >>> # CONFIG_HOTPLUG_PCI_ACPI is not set
> >>> CONFIG_HOTPLUG_PCI_CPCI=y
> >>> # CONFIG_HOTPLUG_PCI_CPCI_ZT5550 is not set
> >>> CONFIG_HOTPLUG_PCI_CPCI_GENERIC=y
> >>> CONFIG_HOTPLUG_PCI_SHPC=y
> >>> 
> >>> #
> >>> # PCI host controller drivers
> >>> #
> >>> CONFIG_ISA_BUS=y
> >>> CONFIG_ISA_DMA_API=y
> >>> CONFIG_ISA=y
> >>> # CONFIG_EISA is not set
> >>> CONFIG_SCx200=y
> >>> CONFIG_SCx200HR_TIMER=y
> >>> CONFIG_OLPC=y
> >>> # CONFIG_OLPC_XO1_PM is not set
> >>> CONFIG_OLPC_XO15_SCI=y
> >>> CONFIG_ALIX=y
> >>> # CONFIG_NET5501 is not set
> >>> # CONFIG_GEOS is not set
> >>> CONFIG_AMD_NB=y
> >>> # CONFIG_PCCARD is not set
> >>> # CONFIG_RAPIDIO is not set
> >>> # CONFIG_X86_SYSFB is not set
> >>> 
> >>> #
> >>> # Executable file formats / Emulations
> >>> #
> >>> CONFIG_BINFMT_ELF=y
> >>> CONFIG_ELFCORE=y
> >>> CONFIG_BINFMT_SCRIPT=y
> >>> CONFIG_HAVE_AOUT=y
> >>> # CONFIG_BINFMT_AOUT is not set
> >>> CONFIG_BINFMT_MISC=y
> >>> CONFIG_COREDUMP=y
> >>> CONFIG_HAVE_ATOMIC_IOMAP=y
> >>> CONFIG_PMC_ATOM=y
> >>> CONFIG_NET=y
> >>> 
> >>> #
> >>> # Networking options
> >>> #
> >>> # CONFIG_PACKET is not set
> >>> CONFIG_UNIX=y
> >>> # CONFIG_UNIX_DIAG is not set
> >>> # CONFIG_NET_KEY is not set
> >>> # CONFIG_INET is not set
> >>> # CONFIG_NETWORK_SECMARK is not set
> >>> # CONFIG_NET_PTP_CLASSIFY is not set
> >>> # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
> >>> # CONFIG_NETFILTER is not set
> >>> # CONFIG_ATM is not set
> >>> # CONFIG_BRIDGE is not set
> >>> # CONFIG_VLAN_8021Q is not set
> >>> # CONFIG_DECNET is not set
> >>> # CONFIG_LLC2 is not set
> >>> # CONFIG_IPX is not set
> >>> # CONFIG_ATALK is not set
> >>> # CONFIG_X25 is not set
> >>> # CONFIG_LAPB is not set
> >>> # CONFIG_PHONET is not set
> >>> # CONFIG_IEEE802154 is not set
> >>> # CONFIG_NET_SCHED is not set
> >>> # CONFIG_DCB is not set
> >>> # CONFIG_BATMAN_ADV is not set
> >>> # CONFIG_VSOCKETS is not set
> >>> # CONFIG_NETLINK_DIAG is not set
> >>> # CONFIG_MPLS is not set
> >>> # CONFIG_HSR is not set
> >>> CONFIG_RPS=y
> >>> CONFIG_RFS_ACCEL=y
> >>> CONFIG_XPS=y
> >>> # CONFIG_SOCK_CGROUP_DATA is not set
> >>> # CONFIG_CGROUP_NET_PRIO is not set
> >>> # CONFIG_CGROUP_NET_CLASSID is not set
> >>> CONFIG_NET_RX_BUSY_POLL=y
> >>> CONFIG_BQL=y
> >>> CONFIG_NET_FLOW_LIMIT=y
> >>> 
> >>> #
> >>> # Network testing
> >>> #
> >>> # CONFIG_HAMRADIO is not set
> >>> # CONFIG_CAN is not set
> >>> # CONFIG_IRDA is not set
> >>> # CONFIG_BT is not set
> >>> CONFIG_WIRELESS=y
> >>> # CONFIG_CFG80211 is not set
> >>> # CONFIG_LIB80211 is not set
> >>> 
> >>> #
> >>> # CFG80211 needs to be enabled for MAC80211
> >>> #
> >>> CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
> >>> # CONFIG_WIMAX is not set
> >>> # CONFIG_RFKILL is not set
> >>> # CONFIG_RFKILL_REGULATOR is not set
> >>> # CONFIG_NET_9P is not set
> >>> # CONFIG_CAIF is not set
> >>> # CONFIG_NFC is not set
> >>> # CONFIG_LWTUNNEL is not set
> >>> # CONFIG_DST_CACHE is not set
> >>> # CONFIG_NET_DEVLINK is not set
> >>> CONFIG_MAY_USE_DEVLINK=y
> >>> 
> >>> #
> >>> # Device Drivers
> >>> #
> >>> 
> >>> #
> >>> # Generic Driver Options
> >>> #
> >>> CONFIG_UEVENT_HELPER=y
> >>> CONFIG_UEVENT_HELPER_PATH=""
> >>> CONFIG_DEVTMPFS=y
> >>> CONFIG_DEVTMPFS_MOUNT=y
> >>> CONFIG_STANDALONE=y
> >>> # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> >>> CONFIG_FW_LOADER=y
> >>> # CONFIG_FIRMWARE_IN_KERNEL is not set
> >>> CONFIG_EXTRA_FIRMWARE=""
> >>> CONFIG_FW_LOADER_USER_HELPER=y
> >>> CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
> >>> CONFIG_ALLOW_DEV_COREDUMP=y
> >>> # CONFIG_DEBUG_DRIVER is not set
> >>> CONFIG_DEBUG_DEVRES=y
> >>> CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
> >>> # CONFIG_SYS_HYPERVISOR is not set
> >>> # CONFIG_GENERIC_CPU_DEVICES is not set
> >>> CONFIG_GENERIC_CPU_AUTOPROBE=y
> >>> CONFIG_REGMAP=y
> >>> CONFIG_REGMAP_I2C=y
> >>> CONFIG_REGMAP_SPMI=y
> >>> CONFIG_REGMAP_MMIO=y
> >>> CONFIG_REGMAP_IRQ=y
> >>> CONFIG_DMA_SHARED_BUFFER=y
> >>> # CONFIG_FENCE_TRACE is not set
> >>> 
> >>> #
> >>> # Bus devices
> >>> #
> >>> # CONFIG_CONNECTOR is not set
> >>> CONFIG_MTD=y
> >>> CONFIG_MTD_REDBOOT_PARTS=y
> >>> CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
> >>> CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
> >>> # CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
> >>> CONFIG_MTD_CMDLINE_PARTS=y
> >>> CONFIG_MTD_OF_PARTS=y
> >>> CONFIG_MTD_AR7_PARTS=y
> >>> 
> >>> #
> >>> # User Modules And Translation Layers
> >>> #
> >>> CONFIG_MTD_OOPS=y
> >>> CONFIG_MTD_PARTITIONED_MASTER=y
> >>> 
> >>> #
> >>> # RAM/ROM/Flash chip drivers
> >>> #
> >>> CONFIG_MTD_CFI=y
> >>> CONFIG_MTD_JEDECPROBE=y
> >>> CONFIG_MTD_GEN_PROBE=y
> >>> # CONFIG_MTD_CFI_ADV_OPTIONS is not set
> >>> CONFIG_MTD_MAP_BANK_WIDTH_1=y
> >>> CONFIG_MTD_MAP_BANK_WIDTH_2=y
> >>> CONFIG_MTD_MAP_BANK_WIDTH_4=y
> >>> # CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
> >>> # CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
> >>> # CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
> >>> CONFIG_MTD_CFI_I1=y
> >>> CONFIG_MTD_CFI_I2=y
> >>> # CONFIG_MTD_CFI_I4 is not set
> >>> # CONFIG_MTD_CFI_I8 is not set
> >>> # CONFIG_MTD_CFI_INTELEXT is not set
> >>> CONFIG_MTD_CFI_AMDSTD=y
> >>> # CONFIG_MTD_CFI_STAA is not set
> >>> CONFIG_MTD_CFI_UTIL=y
> >>> CONFIG_MTD_RAM=y
> >>> # CONFIG_MTD_ROM is not set
> >>> CONFIG_MTD_ABSENT=y
> >>> 
> >>> #
> >>> # Mapping drivers for chip access
> >>> #
> >>> CONFIG_MTD_COMPLEX_MAPPINGS=y
> >>> # CONFIG_MTD_PHYSMAP is not set
> >>> # CONFIG_MTD_PHYSMAP_OF is not set
> >>> CONFIG_MTD_SCx200_DOCFLASH=y
> >>> # CONFIG_MTD_AMD76XROM is not set
> >>> # CONFIG_MTD_ICHXROM is not set
> >>> CONFIG_MTD_ESB2ROM=y
> >>> # CONFIG_MTD_CK804XROM is not set
> >>> # CONFIG_MTD_SCB2_FLASH is not set
> >>> # CONFIG_MTD_NETtel is not set
> >>> CONFIG_MTD_L440GX=y
> >>> # CONFIG_MTD_PCI is not set
> >>> CONFIG_MTD_GPIO_ADDR=y
> >>> CONFIG_MTD_INTEL_VR_NOR=y
> >>> CONFIG_MTD_PLATRAM=y
> >>> CONFIG_MTD_LATCH_ADDR=y
> >>> 
> >>> #
> >>> # Self-contained MTD device drivers
> >>> #
> >>> CONFIG_MTD_PMC551=y
> >>> CONFIG_MTD_PMC551_BUGFIX=y
> >>> # CONFIG_MTD_PMC551_DEBUG is not set
> >>> CONFIG_MTD_SLRAM=y
> >>> CONFIG_MTD_PHRAM=y
> >>> CONFIG_MTD_MTDRAM=y
> >>> CONFIG_MTDRAM_TOTAL_SIZE=4096
> >>> CONFIG_MTDRAM_ERASE_SIZE=128
> >>> 
> >>> #
> >>> # Disk-On-Chip Device Drivers
> >>> #
> >>> CONFIG_MTD_DOCG3=y
> >>> CONFIG_BCH_CONST_M=14
> >>> CONFIG_BCH_CONST_T=4
> >>> CONFIG_MTD_NAND_ECC=y
> >>> # CONFIG_MTD_NAND_ECC_SMC is not set
> >>> CONFIG_MTD_NAND=y
> >>> # CONFIG_MTD_NAND_ECC_BCH is not set
> >>> CONFIG_MTD_SM_COMMON=y
> >>> CONFIG_MTD_NAND_DENALI=y
> >>> CONFIG_MTD_NAND_DENALI_PCI=y
> >>> CONFIG_MTD_NAND_DENALI_DT=y
> >>> CONFIG_MTD_NAND_DENALI_SCRATCH_REG_ADDR=0xFF108018
> >>> # CONFIG_MTD_NAND_GPIO is not set
> >>> # CONFIG_MTD_NAND_OMAP_BCH_BUILD is not set
> >>> CONFIG_MTD_NAND_IDS=y
> >>> CONFIG_MTD_NAND_RICOH=y
> >>> CONFIG_MTD_NAND_DISKONCHIP=y
> >>> # CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
> >>> CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
> >>> # CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set
> >>> CONFIG_MTD_NAND_DOCG4=y
> >>> CONFIG_MTD_NAND_CAFE=y
> >>> # CONFIG_MTD_NAND_CS553X is not set
> >>> CONFIG_MTD_NAND_NANDSIM=y
> >>> CONFIG_MTD_NAND_PLATFORM=y
> >>> CONFIG_MTD_NAND_HISI504=y
> >>> # CONFIG_MTD_NAND_MTK is not set
> >>> CONFIG_MTD_ONENAND=y
> >>> CONFIG_MTD_ONENAND_VERIFY_WRITE=y
> >>> CONFIG_MTD_ONENAND_GENERIC=y
> >>> # CONFIG_MTD_ONENAND_OTP is not set
> >>> # CONFIG_MTD_ONENAND_2X_PROGRAM is not set
> >>> 
> >>> #
> >>> # LPDDR & LPDDR2 PCM memory drivers
> >>> #
> >>> CONFIG_MTD_LPDDR=y
> >>> CONFIG_MTD_QINFO_PROBE=y
> >>> CONFIG_MTD_SPI_NOR=y
> >>> CONFIG_MTD_MT81xx_NOR=y
> >>> CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
> >>> CONFIG_MTD_UBI=y
> >>> CONFIG_MTD_UBI_WL_THRESHOLD=4096
> >>> CONFIG_MTD_UBI_BEB_LIMIT=20
> >>> CONFIG_MTD_UBI_FASTMAP=y
> >>> CONFIG_MTD_UBI_GLUEBI=y
> >>> CONFIG_DTC=y
> >>> CONFIG_OF=y
> >>> CONFIG_OF_UNITTEST=y
> >>> CONFIG_OF_FLATTREE=y
> >>> CONFIG_OF_EARLY_FLATTREE=y
> >>> CONFIG_OF_PROMTREE=y
> >>> CONFIG_OF_DYNAMIC=y
> >>> CONFIG_OF_ADDRESS=y
> >>> CONFIG_OF_ADDRESS_PCI=y
> >>> CONFIG_OF_IRQ=y
> >>> CONFIG_OF_PCI=y
> >>> CONFIG_OF_PCI_IRQ=y
> >>> CONFIG_OF_MTD=y
> >>> CONFIG_OF_RESOLVE=y
> >>> CONFIG_OF_OVERLAY=y
> >>> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> >>> # CONFIG_PARPORT is not set
> >>> CONFIG_PNP=y
> >>> CONFIG_PNP_DEBUG_MESSAGES=y
> >>> 
> >>> #
> >>> # Protocols
> >>> #
> >>> CONFIG_ISAPNP=y
> >>> # CONFIG_PNPBIOS is not set
> >>> CONFIG_PNPACPI=y
> >>> 
> >>> #
> >>> # Misc devices
> >>> #
> >>> CONFIG_SENSORS_LIS3LV02D=y
> >>> CONFIG_AD525X_DPOT=y
> >>> CONFIG_AD525X_DPOT_I2C=y
> >>> # CONFIG_DUMMY_IRQ is not set
> >>> # CONFIG_IBM_ASM is not set
> >>> CONFIG_PHANTOM=y
> >>> # CONFIG_SGI_IOC4 is not set
> >>> CONFIG_TIFM_CORE=y
> >>> CONFIG_TIFM_7XX1=y
> >>> CONFIG_ICS932S401=y
> >>> CONFIG_ENCLOSURE_SERVICES=y
> >>> CONFIG_CS5535_MFGPT=y
> >>> CONFIG_CS5535_MFGPT_DEFAULT_IRQ=7
> >>> CONFIG_CS5535_CLOCK_EVENT_SRC=y
> >>> CONFIG_HP_ILO=y
> >>> CONFIG_APDS9802ALS=y
> >>> CONFIG_ISL29003=y
> >>> CONFIG_ISL29020=y
> >>> # CONFIG_SENSORS_TSL2550 is not set
> >>> # CONFIG_SENSORS_BH1780 is not set
> >>> # CONFIG_SENSORS_BH1770 is not set
> >>> # CONFIG_SENSORS_APDS990X is not set
> >>> CONFIG_HMC6352=y
> >>> CONFIG_DS1682=y
> >>> CONFIG_VMWARE_BALLOON=y
> >>> # CONFIG_BMP085_I2C is not set
> >>> # CONFIG_PCH_PHUB is not set
> >>> CONFIG_USB_SWITCH_FSA9480=y
> >>> CONFIG_SRAM=y
> >>> # CONFIG_C2PORT is not set
> >>> 
> >>> #
> >>> # EEPROM support
> >>> #
> >>> # CONFIG_EEPROM_AT24 is not set
> >>> CONFIG_EEPROM_LEGACY=y
> >>> # CONFIG_EEPROM_MAX6875 is not set
> >>> CONFIG_EEPROM_93CX6=y
> >>> CONFIG_CB710_CORE=y
> >>> CONFIG_CB710_DEBUG=y
> >>> CONFIG_CB710_DEBUG_ASSUMPTIONS=y
> >>> 
> >>> #
> >>> # Texas Instruments shared transport line discipline
> >>> #
> >>> # CONFIG_TI_ST is not set
> >>> CONFIG_SENSORS_LIS3_I2C=y
> >>> 
> >>> #
> >>> # Altera FPGA firmware download module
> >>> #
> >>> CONFIG_ALTERA_STAPL=y
> >>> CONFIG_INTEL_MEI=y
> >>> CONFIG_INTEL_MEI_ME=y
> >>> CONFIG_INTEL_MEI_TXE=y
> >>> CONFIG_VMWARE_VMCI=y
> >>> 
> >>> #
> >>> # Intel MIC Bus Driver
> >>> #
> >>> 
> >>> #
> >>> # SCIF Bus Driver
> >>> #
> >>> 
> >>> #
> >>> # VOP Bus Driver
> >>> #
> >>> 
> >>> #
> >>> # Intel MIC Host Driver
> >>> #
> >>> 
> >>> #
> >>> # Intel MIC Card Driver
> >>> #
> >>> 
> >>> #
> >>> # SCIF Driver
> >>> #
> >>> 
> >>> #
> >>> # Intel MIC Coprocessor State Management (COSM) Drivers
> >>> #
> >>> 
> >>> #
> >>> # VOP Driver
> >>> #
> >>> # CONFIG_ECHO is not set
> >>> # CONFIG_CXL_BASE is not set
> >>> # CONFIG_CXL_AFU_DRIVER_OPS is not set
> >>> CONFIG_HAVE_IDE=y
> >>> 
> >>> #
> >>> # SCSI device support
> >>> #
> >>> CONFIG_SCSI_MOD=y
> >>> # CONFIG_SCSI_DMA is not set
> >>> # CONFIG_SCSI_NETLINK is not set
> >>> CONFIG_FUSION=y
> >>> CONFIG_FUSION_MAX_SGE=128
> >>> # CONFIG_FUSION_LOGGING is not set
> >>> 
> >>> #
> >>> # IEEE 1394 (FireWire) support
> >>> #
> >>> CONFIG_FIREWIRE=y
> >>> CONFIG_FIREWIRE_OHCI=y
> >>> CONFIG_FIREWIRE_NOSY=y
> >>> # CONFIG_MACINTOSH_DRIVERS is not set
> >>> # CONFIG_NETDEVICES is not set
> >>> 
> >>> #
> >>> # Input device support
> >>> #
> >>> CONFIG_INPUT=y
> >>> CONFIG_INPUT_LEDS=y
> >>> CONFIG_INPUT_FF_MEMLESS=y
> >>> CONFIG_INPUT_POLLDEV=y
> >>> CONFIG_INPUT_SPARSEKMAP=y
> >>> CONFIG_INPUT_MATRIXKMAP=y
> >>> 
> >>> #
> >>> # Userland interfaces
> >>> #
> >>> CONFIG_INPUT_MOUSEDEV=y
> >>> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> >>> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> >>> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> >>> CONFIG_INPUT_JOYDEV=y
> >>> # CONFIG_INPUT_EVDEV is not set
> >>> # CONFIG_INPUT_EVBUG is not set
> >>> 
> >>> #
> >>> # Input Device Drivers
> >>> #
> >>> CONFIG_INPUT_KEYBOARD=y
> >>> # CONFIG_KEYBOARD_ADP5520 is not set
> >>> # CONFIG_KEYBOARD_ADP5588 is not set
> >>> # CONFIG_KEYBOARD_ADP5589 is not set
> >>> CONFIG_KEYBOARD_ATKBD=y
> >>> # CONFIG_KEYBOARD_QT1070 is not set
> >>> # CONFIG_KEYBOARD_QT2160 is not set
> >>> # CONFIG_KEYBOARD_LKKBD is not set
> >>> # CONFIG_KEYBOARD_GPIO is not set
> >>> # CONFIG_KEYBOARD_GPIO_POLLED is not set
> >>> # CONFIG_KEYBOARD_TCA6416 is not set
> >>> # CONFIG_KEYBOARD_TCA8418 is not set
> >>> # CONFIG_KEYBOARD_MATRIX is not set
> >>> # CONFIG_KEYBOARD_LM8323 is not set
> >>> # CONFIG_KEYBOARD_LM8333 is not set
> >>> # CONFIG_KEYBOARD_MAX7359 is not set
> >>> # CONFIG_KEYBOARD_MCS is not set
> >>> # CONFIG_KEYBOARD_MPR121 is not set
> >>> # CONFIG_KEYBOARD_NEWTON is not set
> >>> # CONFIG_KEYBOARD_OPENCORES is not set
> >>> # CONFIG_KEYBOARD_SAMSUNG is not set
> >>> # CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
> >>> # CONFIG_KEYBOARD_STOWAWAY is not set
> >>> # CONFIG_KEYBOARD_SUNKBD is not set
> >>> # CONFIG_KEYBOARD_OMAP4 is not set
> >>> # CONFIG_KEYBOARD_TC3589X is not set
> >>> # CONFIG_KEYBOARD_TWL4030 is not set
> >>> # CONFIG_KEYBOARD_XTKBD is not set
> >>> # CONFIG_KEYBOARD_CROS_EC is not set
> >>> # CONFIG_KEYBOARD_CAP11XX is not set
> >>> # CONFIG_KEYBOARD_BCM is not set
> >>> # CONFIG_INPUT_MOUSE is not set
> >>> CONFIG_INPUT_JOYSTICK=y
> >>> CONFIG_JOYSTICK_ANALOG=y
> >>> CONFIG_JOYSTICK_A3D=y
> >>> # CONFIG_JOYSTICK_ADI is not set
> >>> CONFIG_JOYSTICK_COBRA=y
> >>> CONFIG_JOYSTICK_GF2K=y
> >>> CONFIG_JOYSTICK_GRIP=y
> >>> CONFIG_JOYSTICK_GRIP_MP=y
> >>> CONFIG_JOYSTICK_GUILLEMOT=y
> >>> CONFIG_JOYSTICK_INTERACT=y
> >>> CONFIG_JOYSTICK_SIDEWINDER=y
> >>> CONFIG_JOYSTICK_TMDC=y
> >>> CONFIG_JOYSTICK_IFORCE=y
> >>> CONFIG_JOYSTICK_IFORCE_USB=y
> >>> # CONFIG_JOYSTICK_IFORCE_232 is not set
> >>> # CONFIG_JOYSTICK_WARRIOR is not set
> >>> CONFIG_JOYSTICK_MAGELLAN=y
> >>> CONFIG_JOYSTICK_SPACEORB=y
> >>> CONFIG_JOYSTICK_SPACEBALL=y
> >>> CONFIG_JOYSTICK_STINGER=y
> >>> CONFIG_JOYSTICK_TWIDJOY=y
> >>> CONFIG_JOYSTICK_ZHENHUA=y
> >>> # CONFIG_JOYSTICK_AS5011 is not set
> >>> CONFIG_JOYSTICK_JOYDUMP=y
> >>> CONFIG_JOYSTICK_XPAD=y
> >>> CONFIG_JOYSTICK_XPAD_FF=y
> >>> CONFIG_JOYSTICK_XPAD_LEDS=y
> >>> CONFIG_INPUT_TABLET=y
> >>> # CONFIG_TABLET_USB_ACECAD is not set
> >>> # CONFIG_TABLET_USB_AIPTEK is not set
> >>> CONFIG_TABLET_USB_GTCO=y
> >>> CONFIG_TABLET_USB_HANWANG=y
> >>> CONFIG_TABLET_USB_KBTAB=y
> >>> CONFIG_TABLET_USB_PEGASUS=y
> >>> # CONFIG_TABLET_SERIAL_WACOM4 is not set
> >>> # CONFIG_INPUT_TOUCHSCREEN is not set
> >>> CONFIG_INPUT_MISC=y
> >>> CONFIG_INPUT_88PM80X_ONKEY=y
> >>> CONFIG_INPUT_AD714X=y
> >>> # CONFIG_INPUT_AD714X_I2C is not set
> >>> CONFIG_INPUT_ARIZONA_HAPTICS=y
> >>> CONFIG_INPUT_ATMEL_CAPTOUCH=y
> >>> # CONFIG_INPUT_BMA150 is not set
> >>> CONFIG_INPUT_E3X0_BUTTON=y
> >>> # CONFIG_INPUT_PCSPKR is not set
> >>> # CONFIG_INPUT_MC13783_PWRBUTTON is not set
> >>> CONFIG_INPUT_MMA8450=y
> >>> # CONFIG_INPUT_MPU3050 is not set
> >>> CONFIG_INPUT_APANEL=y
> >>> CONFIG_INPUT_GP2A=y
> >>> CONFIG_INPUT_GPIO_BEEPER=y
> >>> CONFIG_INPUT_GPIO_TILT_POLLED=y
> >>> CONFIG_INPUT_WISTRON_BTNS=y
> >>> CONFIG_INPUT_ATLAS_BTNS=y
> >>> # CONFIG_INPUT_ATI_REMOTE2 is not set
> >>> CONFIG_INPUT_KEYSPAN_REMOTE=y
> >>> # CONFIG_INPUT_KXTJ9 is not set
> >>> CONFIG_INPUT_POWERMATE=y
> >>> CONFIG_INPUT_YEALINK=y
> >>> CONFIG_INPUT_CM109=y
> >>> CONFIG_INPUT_REGULATOR_HAPTIC=y
> >>> CONFIG_INPUT_RETU_PWRBUTTON=y
> >>> CONFIG_INPUT_TPS65218_PWRBUTTON=y
> >>> CONFIG_INPUT_AXP20X_PEK=y
> >>> CONFIG_INPUT_TWL4030_PWRBUTTON=y
> >>> # CONFIG_INPUT_TWL4030_VIBRA is not set
> >>> # CONFIG_INPUT_TWL6040_VIBRA is not set
> >>> CONFIG_INPUT_UINPUT=y
> >>> CONFIG_INPUT_PCF8574=y
> >>> # CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
> >>> CONFIG_INPUT_DA9052_ONKEY=y
> >>> CONFIG_INPUT_DA9055_ONKEY=y
> >>> # CONFIG_INPUT_DA9063_ONKEY is not set
> >>> CONFIG_INPUT_ADXL34X=y
> >>> CONFIG_INPUT_ADXL34X_I2C=y
> >>> CONFIG_INPUT_IMS_PCU=y
> >>> CONFIG_INPUT_CMA3000=y
> >>> # CONFIG_INPUT_CMA3000_I2C is not set
> >>> # CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
> >>> # CONFIG_INPUT_DRV260X_HAPTICS is not set
> >>> CONFIG_INPUT_DRV2665_HAPTICS=y
> >>> CONFIG_INPUT_DRV2667_HAPTICS=y
> >>> CONFIG_RMI4_CORE=y
> >>> # CONFIG_RMI4_I2C is not set
> >>> CONFIG_RMI4_2D_SENSOR=y
> >>> CONFIG_RMI4_F11=y
> >>> # CONFIG_RMI4_F12 is not set
> >>> # CONFIG_RMI4_F30 is not set
> >>> 
> >>> #
> >>> # Hardware I/O ports
> >>> #
> >>> CONFIG_SERIO=y
> >>> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> >>> CONFIG_SERIO_I8042=y
> >>> CONFIG_SERIO_SERPORT=y
> >>> # CONFIG_SERIO_CT82C710 is not set
> >>> CONFIG_SERIO_PCIPS2=y
> >>> CONFIG_SERIO_LIBPS2=y
> >>> # CONFIG_SERIO_RAW is not set
> >>> # CONFIG_SERIO_ALTERA_PS2 is not set
> >>> # CONFIG_SERIO_PS2MULT is not set
> >>> CONFIG_SERIO_ARC_PS2=y
> >>> # CONFIG_SERIO_APBPS2 is not set
> >>> # CONFIG_SERIO_OLPC_APSP is not set
> >>> CONFIG_HYPERV_KEYBOARD=y
> >>> CONFIG_USERIO=y
> >>> CONFIG_GAMEPORT=y
> >>> CONFIG_GAMEPORT_NS558=y
> >>> CONFIG_GAMEPORT_L4=y
> >>> # CONFIG_GAMEPORT_EMU10K1 is not set
> >>> # CONFIG_GAMEPORT_FM801 is not set
> >>> 
> >>> #
> >>> # Character devices
> >>> #
> >>> CONFIG_TTY=y
> >>> # CONFIG_VT is not set
> >>> CONFIG_UNIX98_PTYS=y
> >>> CONFIG_LEGACY_PTYS=y
> >>> CONFIG_LEGACY_PTY_COUNT=256
> >>> CONFIG_SERIAL_NONSTANDARD=y
> >>> # CONFIG_ROCKETPORT is not set
> >>> CONFIG_CYCLADES=y
> >>> # CONFIG_CYZ_INTR is not set
> >>> CONFIG_MOXA_INTELLIO=y
> >>> CONFIG_MOXA_SMARTIO=y
> >>> CONFIG_SYNCLINK=y
> >>> CONFIG_SYNCLINKMP=y
> >>> # CONFIG_SYNCLINK_GT is not set
> >>> # CONFIG_NOZOMI is not set
> >>> CONFIG_ISI=y
> >>> CONFIG_N_HDLC=y
> >>> # CONFIG_N_GSM is not set
> >>> # CONFIG_TRACE_SINK is not set
> >>> # CONFIG_GOLDFISH_TTY is not set
> >>> CONFIG_DEVMEM=y
> >>> CONFIG_DEVKMEM=y
> >>> 
> >>> #
> >>> # Serial drivers
> >>> #
> >>> CONFIG_SERIAL_EARLYCON=y
> >>> CONFIG_SERIAL_8250=y
> >>> # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> >>> CONFIG_SERIAL_8250_PNP=y
> >>> # CONFIG_SERIAL_8250_FINTEK is not set
> >>> CONFIG_SERIAL_8250_CONSOLE=y
> >>> CONFIG_SERIAL_8250_PCI=y
> >>> CONFIG_SERIAL_8250_NR_UARTS=4
> >>> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> >>> # CONFIG_SERIAL_8250_EXTENDED is not set
> >>> # CONFIG_SERIAL_8250_FSL is not set
> >>> # CONFIG_SERIAL_8250_DW is not set
> >>> CONFIG_SERIAL_8250_RT288X=y
> >>> CONFIG_SERIAL_8250_MID=y
> >>> CONFIG_SERIAL_8250_MOXA=y
> >>> CONFIG_SERIAL_OF_PLATFORM=y
> >>> 
> >>> #
> >>> # Non-8250 serial port support
> >>> #
> >>> # CONFIG_SERIAL_UARTLITE is not set
> >>> CONFIG_SERIAL_CORE=y
> >>> CONFIG_SERIAL_CORE_CONSOLE=y
> >>> CONFIG_SERIAL_JSM=y
> >>> CONFIG_SERIAL_SCCNXP=y
> >>> # CONFIG_SERIAL_SCCNXP_CONSOLE is not set
> >>> CONFIG_SERIAL_SC16IS7XX=y
> >>> # CONFIG_SERIAL_SC16IS7XX_I2C is not set
> >>> CONFIG_SERIAL_TIMBERDALE=y
> >>> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> >>> CONFIG_SERIAL_ALTERA_UART=y
> >>> CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
> >>> CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
> >>> CONFIG_SERIAL_ALTERA_UART_CONSOLE=y
> >>> # CONFIG_SERIAL_PCH_UART is not set
> >>> CONFIG_SERIAL_XILINX_PS_UART=y
> >>> CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
> >>> # CONFIG_SERIAL_ARC is not set
> >>> CONFIG_SERIAL_RP2=y
> >>> CONFIG_SERIAL_RP2_NR_UARTS=32
> >>> # CONFIG_SERIAL_FSL_LPUART is not set
> >>> CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
> >>> CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE=y
> >>> # CONFIG_SERIAL_MEN_Z135 is not set
> >>> CONFIG_SERIAL_MCTRL_GPIO=y
> >>> CONFIG_TTY_PRINTK=y
> >>> # CONFIG_VIRTIO_CONSOLE is not set
> >>> CONFIG_IPMI_HANDLER=y
> >>> CONFIG_IPMI_PANIC_EVENT=y
> >>> # CONFIG_IPMI_PANIC_STRING is not set
> >>> CONFIG_IPMI_DEVICE_INTERFACE=y
> >>> CONFIG_IPMI_SI=y
> >>> CONFIG_IPMI_SSIF=y
> >>> # CONFIG_IPMI_WATCHDOG is not set
> >>> CONFIG_IPMI_POWEROFF=y
> >>> CONFIG_HW_RANDOM=y
> >>> # CONFIG_HW_RANDOM_TIMERIOMEM is not set
> >>> # CONFIG_HW_RANDOM_INTEL is not set
> >>> # CONFIG_HW_RANDOM_AMD is not set
> >>> CONFIG_HW_RANDOM_GEODE=y
> >>> CONFIG_HW_RANDOM_VIA=y
> >>> CONFIG_HW_RANDOM_VIRTIO=y
> >>> CONFIG_NVRAM=y
> >>> # CONFIG_DTLK is not set
> >>> CONFIG_R3964=y
> >>> CONFIG_APPLICOM=y
> >>> # CONFIG_SONYPI is not set
> >>> CONFIG_MWAVE=y
> >>> CONFIG_SCx200_GPIO=y
> >>> CONFIG_PC8736x_GPIO=y
> >>> CONFIG_NSC_GPIO=y
> >>> CONFIG_HPET=y
> >>> CONFIG_HPET_MMAP=y
> >>> CONFIG_HPET_MMAP_DEFAULT=y
> >>> CONFIG_HANGCHECK_TIMER=y
> >>> # CONFIG_TCG_TPM is not set
> >>> # CONFIG_TELCLOCK is not set
> >>> CONFIG_DEVPORT=y
> >>> # CONFIG_XILLYBUS is not set
> >>> 
> >>> #
> >>> # I2C support
> >>> #
> >>> CONFIG_I2C=y
> >>> # CONFIG_ACPI_I2C_OPREGION is not set
> >>> CONFIG_I2C_BOARDINFO=y
> >>> # CONFIG_I2C_COMPAT is not set
> >>> CONFIG_I2C_CHARDEV=y
> >>> CONFIG_I2C_MUX=y
> >>> 
> >>> #
> >>> # Multiplexer I2C Chip support
> >>> #
> >>> CONFIG_I2C_ARB_GPIO_CHALLENGE=y
> >>> CONFIG_I2C_MUX_GPIO=y
> >>> CONFIG_I2C_MUX_PCA9541=y
> >>> # CONFIG_I2C_MUX_PCA954x is not set
> >>> CONFIG_I2C_MUX_PINCTRL=y
> >>> CONFIG_I2C_MUX_REG=y
> >>> CONFIG_I2C_DEMUX_PINCTRL=y
> >>> # CONFIG_I2C_HELPER_AUTO is not set
> >>> CONFIG_I2C_SMBUS=y
> >>> 
> >>> #
> >>> # I2C Algorithms
> >>> #
> >>> CONFIG_I2C_ALGOBIT=y
> >>> CONFIG_I2C_ALGOPCF=y
> >>> CONFIG_I2C_ALGOPCA=y
> >>> 
> >>> #
> >>> # I2C Hardware Bus support
> >>> #
> >>> 
> >>> #
> >>> # PC SMBus host controller drivers
> >>> #
> >>> CONFIG_I2C_ALI1535=y
> >>> CONFIG_I2C_ALI1563=y
> >>> # CONFIG_I2C_ALI15X3 is not set
> >>> # CONFIG_I2C_AMD756 is not set
> >>> # CONFIG_I2C_AMD8111 is not set
> >>> CONFIG_I2C_I801=y
> >>> CONFIG_I2C_ISCH=y
> >>> CONFIG_I2C_ISMT=y
> >>> # CONFIG_I2C_PIIX4 is not set
> >>> CONFIG_I2C_NFORCE2=y
> >>> CONFIG_I2C_NFORCE2_S4985=y
> >>> # CONFIG_I2C_SIS5595 is not set
> >>> CONFIG_I2C_SIS630=y
> >>> CONFIG_I2C_SIS96X=y
> >>> CONFIG_I2C_VIA=y
> >>> CONFIG_I2C_VIAPRO=y
> >>> 
> >>> #
> >>> # ACPI drivers
> >>> #
> >>> CONFIG_I2C_SCMI=y
> >>> 
> >>> #
> >>> # I2C system bus drivers (mostly embedded / system-on-chip)
> >>> #
> >>> CONFIG_I2C_CBUS_GPIO=y
> >>> CONFIG_I2C_DESIGNWARE_CORE=y
> >>> CONFIG_I2C_DESIGNWARE_PLATFORM=y
> >>> CONFIG_I2C_DESIGNWARE_PCI=y
> >>> CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
> >>> # CONFIG_I2C_EG20T is not set
> >>> # CONFIG_I2C_EMEV2 is not set
> >>> CONFIG_I2C_GPIO=y
> >>> CONFIG_I2C_OCORES=y
> >>> CONFIG_I2C_PCA_PLATFORM=y
> >>> CONFIG_I2C_PXA=y
> >>> CONFIG_I2C_PXA_PCI=y
> >>> CONFIG_I2C_RK3X=y
> >>> CONFIG_I2C_SIMTEC=y
> >>> # CONFIG_I2C_XILINX is not set
> >>> 
> >>> #
> >>> # External I2C/SMBus adapter drivers
> >>> #
> >>> # CONFIG_I2C_DIOLAN_U2C is not set
> >>> CONFIG_I2C_DLN2=y
> >>> CONFIG_I2C_PARPORT_LIGHT=y
> >>> CONFIG_I2C_ROBOTFUZZ_OSIF=y
> >>> CONFIG_I2C_TAOS_EVM=y
> >>> CONFIG_I2C_TINY_USB=y
> >>> CONFIG_I2C_VIPERBOARD=y
> >>> 
> >>> #
> >>> # Other I2C/SMBus bus drivers
> >>> #
> >>> CONFIG_I2C_PCA_ISA=y
> >>> # CONFIG_I2C_CROS_EC_TUNNEL is not set
> >>> # CONFIG_SCx200_ACB is not set
> >>> # CONFIG_I2C_SLAVE is not set
> >>> # CONFIG_I2C_DEBUG_CORE is not set
> >>> # CONFIG_I2C_DEBUG_ALGO is not set
> >>> # CONFIG_I2C_DEBUG_BUS is not set
> >>> # CONFIG_SPI is not set
> >>> CONFIG_SPMI=y
> >>> CONFIG_HSI=y
> >>> CONFIG_HSI_BOARDINFO=y
> >>> 
> >>> #
> >>> # HSI controllers
> >>> #
> >>> 
> >>> #
> >>> # HSI clients
> >>> #
> >>> CONFIG_HSI_CHAR=y
> >>> 
> >>> #
> >>> # PPS support
> >>> #
> >>> CONFIG_PPS=y
> >>> # CONFIG_PPS_DEBUG is not set
> >>> 
> >>> #
> >>> # PPS clients support
> >>> #
> >>> CONFIG_PPS_CLIENT_KTIMER=y
> >>> # CONFIG_PPS_CLIENT_LDISC is not set
> >>> # CONFIG_PPS_CLIENT_GPIO is not set
> >>> 
> >>> #
> >>> # PPS generators support
> >>> #
> >>> 
> >>> #
> >>> # PTP clock support
> >>> #
> >>> # CONFIG_PTP_1588_CLOCK is not set
> >>> 
> >>> #
> >>> # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
> >>> #
> >>> # CONFIG_PTP_1588_CLOCK_PCH is not set
> >>> CONFIG_PINCTRL=y
> >>> 
> >>> #
> >>> # Pin controllers
> >>> #
> >>> CONFIG_PINMUX=y
> >>> CONFIG_PINCONF=y
> >>> CONFIG_GENERIC_PINCONF=y
> >>> # CONFIG_DEBUG_PINCTRL is not set
> >>> CONFIG_PINCTRL_AS3722=y
> >>> CONFIG_PINCTRL_AMD=y
> >>> CONFIG_PINCTRL_SINGLE=y
> >>> CONFIG_PINCTRL_BAYTRAIL=y
> >>> CONFIG_PINCTRL_CHERRYVIEW=y
> >>> CONFIG_PINCTRL_INTEL=y
> >>> CONFIG_PINCTRL_BROXTON=y
> >>> CONFIG_PINCTRL_SUNRISEPOINT=y
> >>> CONFIG_GPIOLIB=y
> >>> CONFIG_GPIO_DEVRES=y
> >>> CONFIG_OF_GPIO=y
> >>> CONFIG_GPIO_ACPI=y
> >>> CONFIG_GPIOLIB_IRQCHIP=y
> >>> CONFIG_DEBUG_GPIO=y
> >>> CONFIG_GPIO_SYSFS=y
> >>> CONFIG_GPIO_GENERIC=y
> >>> 
> >>> #
> >>> # Memory mapped GPIO drivers
> >>> #
> >>> # CONFIG_GPIO_74XX_MMIO is not set
> >>> # CONFIG_GPIO_ALTERA is not set
> >>> # CONFIG_GPIO_AMDPT is not set
> >>> CONFIG_GPIO_DWAPB=y
> >>> CONFIG_GPIO_GENERIC_PLATFORM=y
> >>> CONFIG_GPIO_GRGPIO=y
> >>> CONFIG_GPIO_ICH=y
> >>> CONFIG_GPIO_LYNXPOINT=y
> >>> CONFIG_GPIO_MENZ127=y
> >>> CONFIG_GPIO_SYSCON=y
> >>> CONFIG_GPIO_VX855=y
> >>> CONFIG_GPIO_XILINX=y
> >>> # CONFIG_GPIO_ZX is not set
> >>> 
> >>> #
> >>> # Port-mapped I/O GPIO drivers
> >>> #
> >>> # CONFIG_GPIO_104_DIO_48E is not set
> >>> CONFIG_GPIO_104_IDIO_16=y
> >>> # CONFIG_GPIO_104_IDI_48 is not set
> >>> CONFIG_GPIO_F7188X=y
> >>> CONFIG_GPIO_IT87=y
> >>> CONFIG_GPIO_SCH=y
> >>> # CONFIG_GPIO_SCH311X is not set
> >>> CONFIG_GPIO_WS16C48=y
> >>> 
> >>> #
> >>> # I2C GPIO expanders
> >>> #
> >>> # CONFIG_GPIO_ADP5588 is not set
> >>> CONFIG_GPIO_ADNP=y
> >>> # CONFIG_GPIO_MAX7300 is not set
> >>> CONFIG_GPIO_MAX732X=y
> >>> # CONFIG_GPIO_MAX732X_IRQ is not set
> >>> CONFIG_GPIO_PCA953X=y
> >>> CONFIG_GPIO_PCA953X_IRQ=y
> >>> # CONFIG_GPIO_PCF857X is not set
> >>> # CONFIG_GPIO_SX150X is not set
> >>> CONFIG_GPIO_TPIC2810=y
> >>> 
> >>> #
> >>> # MFD GPIO expanders
> >>> #
> >>> CONFIG_GPIO_ADP5520=y
> >>> # CONFIG_GPIO_ARIZONA is not set
> >>> CONFIG_GPIO_CRYSTAL_COVE=y
> >>> # CONFIG_GPIO_CS5535 is not set
> >>> CONFIG_GPIO_DA9052=y
> >>> # CONFIG_GPIO_DA9055 is not set
> >>> CONFIG_GPIO_DLN2=y
> >>> CONFIG_GPIO_JANZ_TTL=y
> >>> # CONFIG_GPIO_TC3589X is not set
> >>> CONFIG_GPIO_TIMBERDALE=y
> >>> CONFIG_GPIO_TPS65086=y
> >>> # CONFIG_GPIO_TPS65218 is not set
> >>> CONFIG_GPIO_TWL4030=y
> >>> CONFIG_GPIO_TWL6040=y
> >>> CONFIG_GPIO_UCB1400=y
> >>> # CONFIG_GPIO_WM8350 is not set
> >>> # CONFIG_GPIO_WM8994 is not set
> >>> 
> >>> #
> >>> # PCI GPIO expanders
> >>> #
> >>> CONFIG_GPIO_AMD8111=y
> >>> CONFIG_GPIO_BT8XX=y
> >>> CONFIG_GPIO_ML_IOH=y
> >>> CONFIG_GPIO_PCH=y
> >>> # CONFIG_GPIO_RDC321X is not set
> >>> # CONFIG_GPIO_SODAVILLE is not set
> >>> 
> >>> #
> >>> # SPI or I2C GPIO expanders
> >>> #
> >>> CONFIG_GPIO_MCP23S08=y
> >>> 
> >>> #
> >>> # USB GPIO expanders
> >>> #
> >>> CONFIG_GPIO_VIPERBOARD=y
> >>> CONFIG_W1=y
> >>> 
> >>> #
> >>> # 1-wire Bus Masters
> >>> #
> >>> # CONFIG_W1_MASTER_MATROX is not set
> >>> CONFIG_W1_MASTER_DS2490=y
> >>> # CONFIG_W1_MASTER_DS2482 is not set
> >>> CONFIG_W1_MASTER_DS1WM=y
> >>> CONFIG_W1_MASTER_GPIO=y
> >>> 
> >>> #
> >>> # 1-wire Slaves
> >>> #
> >>> CONFIG_W1_SLAVE_THERM=y
> >>> CONFIG_W1_SLAVE_SMEM=y
> >>> CONFIG_W1_SLAVE_DS2408=y
> >>> # CONFIG_W1_SLAVE_DS2408_READBACK is not set
> >>> CONFIG_W1_SLAVE_DS2413=y
> >>> # CONFIG_W1_SLAVE_DS2406 is not set
> >>> CONFIG_W1_SLAVE_DS2423=y
> >>> CONFIG_W1_SLAVE_DS2431=y
> >>> # CONFIG_W1_SLAVE_DS2433 is not set
> >>> # CONFIG_W1_SLAVE_DS2760 is not set
> >>> # CONFIG_W1_SLAVE_DS2780 is not set
> >>> # CONFIG_W1_SLAVE_DS2781 is not set
> >>> CONFIG_W1_SLAVE_DS28E04=y
> >>> CONFIG_W1_SLAVE_BQ27000=y
> >>> CONFIG_POWER_SUPPLY=y
> >>> # CONFIG_POWER_SUPPLY_DEBUG is not set
> >>> CONFIG_PDA_POWER=y
> >>> CONFIG_GENERIC_ADC_BATTERY=y
> >>> CONFIG_WM8350_POWER=y
> >>> # CONFIG_TEST_POWER is not set
> >>> # CONFIG_BATTERY_DS2780 is not set
> >>> # CONFIG_BATTERY_DS2781 is not set
> >>> # CONFIG_BATTERY_DS2782 is not set
> >>> CONFIG_BATTERY_OLPC=y
> >>> # CONFIG_BATTERY_SBS is not set
> >>> # CONFIG_BATTERY_BQ27XXX is not set
> >>> CONFIG_BATTERY_DA9052=y
> >>> # CONFIG_AXP288_CHARGER is not set
> >>> CONFIG_AXP288_FUEL_GAUGE=y
> >>> CONFIG_BATTERY_MAX17040=y
> >>> # CONFIG_BATTERY_MAX17042 is not set
> >>> # CONFIG_BATTERY_TWL4030_MADC is not set
> >>> CONFIG_BATTERY_RX51=y
> >>> CONFIG_CHARGER_ISP1704=y
> >>> CONFIG_CHARGER_MAX8903=y
> >>> CONFIG_CHARGER_TWL4030=y
> >>> CONFIG_CHARGER_LP8727=y
> >>> CONFIG_CHARGER_LP8788=y
> >>> CONFIG_CHARGER_GPIO=y
> >>> # CONFIG_CHARGER_MANAGER is not set
> >>> CONFIG_CHARGER_MAX14577=y
> >>> # CONFIG_CHARGER_MAX77693 is not set
> >>> CONFIG_CHARGER_MAX8998=y
> >>> CONFIG_CHARGER_BQ2415X=y
> >>> CONFIG_CHARGER_BQ24190=y
> >>> CONFIG_CHARGER_BQ24257=y
> >>> CONFIG_CHARGER_BQ24735=y
> >>> CONFIG_CHARGER_BQ25890=y
> >>> CONFIG_CHARGER_SMB347=y
> >>> CONFIG_CHARGER_TPS65090=y
> >>> # CONFIG_CHARGER_TPS65217 is not set
> >>> CONFIG_BATTERY_GAUGE_LTC2941=y
> >>> CONFIG_BATTERY_GOLDFISH=y
> >>> CONFIG_CHARGER_RT9455=y
> >>> CONFIG_AXP20X_POWER=y
> >>> # CONFIG_POWER_RESET is not set
> >>> # CONFIG_POWER_AVS is not set
> >>> CONFIG_HWMON=y
> >>> CONFIG_HWMON_VID=y
> >>> CONFIG_HWMON_DEBUG_CHIP=y
> >>> 
> >>> #
> >>> # Native drivers
> >>> #
> >>> CONFIG_SENSORS_ABITUGURU=y
> >>> CONFIG_SENSORS_ABITUGURU3=y
> >>> CONFIG_SENSORS_AD7414=y
> >>> # CONFIG_SENSORS_AD7418 is not set
> >>> # CONFIG_SENSORS_ADM1021 is not set
> >>> # CONFIG_SENSORS_ADM1025 is not set
> >>> CONFIG_SENSORS_ADM1026=y
> >>> CONFIG_SENSORS_ADM1029=y
> >>> CONFIG_SENSORS_ADM1031=y
> >>> CONFIG_SENSORS_ADM9240=y
> >>> CONFIG_SENSORS_ADT7X10=y
> >>> CONFIG_SENSORS_ADT7410=y
> >>> # CONFIG_SENSORS_ADT7411 is not set
> >>> # CONFIG_SENSORS_ADT7462 is not set
> >>> CONFIG_SENSORS_ADT7470=y
> >>> CONFIG_SENSORS_ADT7475=y
> >>> CONFIG_SENSORS_ASC7621=y
> >>> CONFIG_SENSORS_K8TEMP=y
> >>> # CONFIG_SENSORS_K10TEMP is not set
> >>> CONFIG_SENSORS_FAM15H_POWER=y
> >>> # CONFIG_SENSORS_APPLESMC is not set
> >>> CONFIG_SENSORS_ARM_SCPI=y
> >>> # CONFIG_SENSORS_ASB100 is not set
> >>> CONFIG_SENSORS_ATXP1=y
> >>> CONFIG_SENSORS_DS620=y
> >>> # CONFIG_SENSORS_DS1621 is not set
> >>> CONFIG_SENSORS_DELL_SMM=y
> >>> CONFIG_SENSORS_DA9052_ADC=y
> >>> CONFIG_SENSORS_DA9055=y
> >>> CONFIG_SENSORS_I5K_AMB=y
> >>> CONFIG_SENSORS_F71805F=y
> >>> CONFIG_SENSORS_F71882FG=y
> >>> # CONFIG_SENSORS_F75375S is not set
> >>> CONFIG_SENSORS_MC13783_ADC=y
> >>> # CONFIG_SENSORS_FSCHMD is not set
> >>> CONFIG_SENSORS_FTSTEUTATES=y
> >>> CONFIG_SENSORS_GL518SM=y
> >>> # CONFIG_SENSORS_GL520SM is not set
> >>> CONFIG_SENSORS_G760A=y
> >>> CONFIG_SENSORS_G762=y
> >>> # CONFIG_SENSORS_GPIO_FAN is not set
> >>> CONFIG_SENSORS_HIH6130=y
> >>> CONFIG_SENSORS_IBMAEM=y
> >>> # CONFIG_SENSORS_IBMPEX is not set
> >>> CONFIG_SENSORS_IIO_HWMON=y
> >>> CONFIG_SENSORS_I5500=y
> >>> # CONFIG_SENSORS_CORETEMP is not set
> >>> CONFIG_SENSORS_IT87=y
> >>> CONFIG_SENSORS_JC42=y
> >>> CONFIG_SENSORS_POWR1220=y
> >>> CONFIG_SENSORS_LINEAGE=y
> >>> CONFIG_SENSORS_LTC2945=y
> >>> CONFIG_SENSORS_LTC2990=y
> >>> # CONFIG_SENSORS_LTC4151 is not set
> >>> CONFIG_SENSORS_LTC4215=y
> >>> CONFIG_SENSORS_LTC4222=y
> >>> CONFIG_SENSORS_LTC4245=y
> >>> CONFIG_SENSORS_LTC4260=y
> >>> CONFIG_SENSORS_LTC4261=y
> >>> CONFIG_SENSORS_MAX16065=y
> >>> CONFIG_SENSORS_MAX1619=y
> >>> # CONFIG_SENSORS_MAX1668 is not set
> >>> # CONFIG_SENSORS_MAX197 is not set
> >>> CONFIG_SENSORS_MAX6639=y
> >>> CONFIG_SENSORS_MAX6642=y
> >>> CONFIG_SENSORS_MAX6650=y
> >>> CONFIG_SENSORS_MAX6697=y
> >>> CONFIG_SENSORS_MAX31790=y
> >>> CONFIG_SENSORS_MCP3021=y
> >>> # CONFIG_SENSORS_LM63 is not set
> >>> CONFIG_SENSORS_LM73=y
> >>> CONFIG_SENSORS_LM75=y
> >>> CONFIG_SENSORS_LM77=y
> >>> CONFIG_SENSORS_LM78=y
> >>> CONFIG_SENSORS_LM80=y
> >>> CONFIG_SENSORS_LM83=y
> >>> CONFIG_SENSORS_LM85=y
> >>> # CONFIG_SENSORS_LM87 is not set
> >>> CONFIG_SENSORS_LM90=y
> >>> CONFIG_SENSORS_LM92=y
> >>> CONFIG_SENSORS_LM93=y
> >>> CONFIG_SENSORS_LM95234=y
> >>> CONFIG_SENSORS_LM95241=y
> >>> # CONFIG_SENSORS_LM95245 is not set
> >>> CONFIG_SENSORS_PC87360=y
> >>> CONFIG_SENSORS_PC87427=y
> >>> CONFIG_SENSORS_NTC_THERMISTOR=y
> >>> CONFIG_SENSORS_NCT6683=y
> >>> # CONFIG_SENSORS_NCT6775 is not set
> >>> CONFIG_SENSORS_NCT7802=y
> >>> # CONFIG_SENSORS_NCT7904 is not set
> >>> CONFIG_SENSORS_PCF8591=y
> >>> # CONFIG_PMBUS is not set
> >>> # CONFIG_SENSORS_SHT15 is not set
> >>> CONFIG_SENSORS_SHT21=y
> >>> CONFIG_SENSORS_SHT3x=y
> >>> CONFIG_SENSORS_SHTC1=y
> >>> # CONFIG_SENSORS_SIS5595 is not set
> >>> CONFIG_SENSORS_DME1737=y
> >>> CONFIG_SENSORS_EMC1403=y
> >>> # CONFIG_SENSORS_EMC2103 is not set
> >>> CONFIG_SENSORS_EMC6W201=y
> >>> # CONFIG_SENSORS_SMSC47M1 is not set
> >>> # CONFIG_SENSORS_SMSC47M192 is not set
> >>> CONFIG_SENSORS_SMSC47B397=y
> >>> CONFIG_SENSORS_SCH56XX_COMMON=y
> >>> CONFIG_SENSORS_SCH5627=y
> >>> CONFIG_SENSORS_SCH5636=y
> >>> # CONFIG_SENSORS_SMM665 is not set
> >>> CONFIG_SENSORS_ADC128D818=y
> >>> CONFIG_SENSORS_ADS1015=y
> >>> # CONFIG_SENSORS_ADS7828 is not set
> >>> CONFIG_SENSORS_AMC6821=y
> >>> # CONFIG_SENSORS_INA209 is not set
> >>> CONFIG_SENSORS_INA2XX=y
> >>> CONFIG_SENSORS_INA3221=y
> >>> # CONFIG_SENSORS_TC74 is not set
> >>> CONFIG_SENSORS_THMC50=y
> >>> # CONFIG_SENSORS_TMP102 is not set
> >>> # CONFIG_SENSORS_TMP103 is not set
> >>> CONFIG_SENSORS_TMP401=y
> >>> # CONFIG_SENSORS_TMP421 is not set
> >>> CONFIG_SENSORS_TWL4030_MADC=y
> >>> # CONFIG_SENSORS_VIA_CPUTEMP is not set
> >>> CONFIG_SENSORS_VIA686A=y
> >>> CONFIG_SENSORS_VT1211=y
> >>> # CONFIG_SENSORS_VT8231 is not set
> >>> CONFIG_SENSORS_W83781D=y
> >>> CONFIG_SENSORS_W83791D=y
> >>> CONFIG_SENSORS_W83792D=y
> >>> CONFIG_SENSORS_W83793=y
> >>> CONFIG_SENSORS_W83795=y
> >>> CONFIG_SENSORS_W83795_FANCTRL=y
> >>> CONFIG_SENSORS_W83L785TS=y
> >>> CONFIG_SENSORS_W83L786NG=y
> >>> CONFIG_SENSORS_W83627HF=y
> >>> # CONFIG_SENSORS_W83627EHF is not set
> >>> CONFIG_SENSORS_WM8350=y
> >>> 
> >>> #
> >>> # ACPI drivers
> >>> #
> >>> CONFIG_SENSORS_ACPI_POWER=y
> >>> CONFIG_SENSORS_ATK0110=y
> >>> CONFIG_THERMAL=y
> >>> CONFIG_THERMAL_HWMON=y
> >>> # CONFIG_THERMAL_OF is not set
> >>> CONFIG_THERMAL_WRITABLE_TRIPS=y
> >>> # CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
> >>> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> >>> CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
> >>> # CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
> >>> CONFIG_THERMAL_GOV_FAIR_SHARE=y
> >>> # CONFIG_THERMAL_GOV_STEP_WISE is not set
> >>> CONFIG_THERMAL_GOV_BANG_BANG=y
> >>> CONFIG_THERMAL_GOV_USER_SPACE=y
> >>> # CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
> >>> # CONFIG_CLOCK_THERMAL is not set
> >>> # CONFIG_DEVFREQ_THERMAL is not set
> >>> CONFIG_THERMAL_EMULATION=y
> >>> # CONFIG_INTEL_POWERCLAMP is not set
> >>> CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
> >>> CONFIG_INTEL_SOC_DTS_THERMAL=y
> >>> 
> >>> #
> >>> # ACPI INT340X thermal drivers
> >>> #
> >>> # CONFIG_INT340X_THERMAL is not set
> >>> # CONFIG_INTEL_PCH_THERMAL is not set
> >>> CONFIG_QCOM_SPMI_TEMP_ALARM=y
> >>> # CONFIG_GENERIC_ADC_THERMAL is not set
> >>> CONFIG_WATCHDOG=y
> >>> CONFIG_WATCHDOG_CORE=y
> >>> # CONFIG_WATCHDOG_NOWAYOUT is not set
> >>> # CONFIG_WATCHDOG_SYSFS is not set
> >>> 
> >>> #
> >>> # Watchdog Device Drivers
> >>> #
> >>> CONFIG_SOFT_WATCHDOG=y
> >>> CONFIG_DA9052_WATCHDOG=y
> >>> # CONFIG_DA9055_WATCHDOG is not set
> >>> # CONFIG_DA9063_WATCHDOG is not set
> >>> CONFIG_GPIO_WATCHDOG=y
> >>> # CONFIG_GPIO_WATCHDOG_ARCH_INITCALL is not set
> >>> CONFIG_WM8350_WATCHDOG=y
> >>> CONFIG_XILINX_WATCHDOG=y
> >>> CONFIG_ZIIRAVE_WATCHDOG=y
> >>> CONFIG_CADENCE_WATCHDOG=y
> >>> # CONFIG_DW_WATCHDOG is not set
> >>> CONFIG_TWL4030_WATCHDOG=y
> >>> CONFIG_MAX63XX_WATCHDOG=y
> >>> # CONFIG_RETU_WATCHDOG is not set
> >>> CONFIG_ACQUIRE_WDT=y
> >>> CONFIG_ADVANTECH_WDT=y
> >>> # CONFIG_ALIM1535_WDT is not set
> >>> # CONFIG_ALIM7101_WDT is not set
> >>> CONFIG_EBC_C384_WDT=y
> >>> # CONFIG_F71808E_WDT is not set
> >>> # CONFIG_SP5100_TCO is not set
> >>> # CONFIG_GEODE_WDT is not set
> >>> CONFIG_SBC_FITPC2_WATCHDOG=y
> >>> # CONFIG_EUROTECH_WDT is not set
> >>> # CONFIG_IB700_WDT is not set
> >>> # CONFIG_IBMASR is not set
> >>> CONFIG_WAFER_WDT=y
> >>> # CONFIG_I6300ESB_WDT is not set
> >>> CONFIG_IE6XX_WDT=y
> >>> CONFIG_ITCO_WDT=y
> >>> # CONFIG_ITCO_VENDOR_SUPPORT is not set
> >>> # CONFIG_IT8712F_WDT is not set
> >>> # CONFIG_IT87_WDT is not set
> >>> CONFIG_HP_WATCHDOG=y
> >>> # CONFIG_HPWDT_NMI_DECODING is not set
> >>> CONFIG_SC1200_WDT=y
> >>> # CONFIG_SCx200_WDT is not set
> >>> CONFIG_PC87413_WDT=y
> >>> # CONFIG_NV_TCO is not set
> >>> CONFIG_60XX_WDT=y
> >>> CONFIG_SBC8360_WDT=y
> >>> CONFIG_SBC7240_WDT=y
> >>> # CONFIG_CPU5_WDT is not set
> >>> # CONFIG_SMSC_SCH311X_WDT is not set
> >>> CONFIG_SMSC37B787_WDT=y
> >>> # CONFIG_VIA_WDT is not set
> >>> # CONFIG_W83627HF_WDT is not set
> >>> CONFIG_W83877F_WDT=y
> >>> CONFIG_W83977F_WDT=y
> >>> CONFIG_MACHZ_WDT=y
> >>> # CONFIG_SBC_EPX_C3_WATCHDOG is not set
> >>> CONFIG_INTEL_MEI_WDT=y
> >>> # CONFIG_NI903X_WDT is not set
> >>> CONFIG_MEN_A21_WDT=y
> >>> 
> >>> #
> >>> # ISA-based Watchdog Cards
> >>> #
> >>> CONFIG_PCWATCHDOG=y
> >>> CONFIG_MIXCOMWD=y
> >>> # CONFIG_WDT is not set
> >>> 
> >>> #
> >>> # PCI-based Watchdog Cards
> >>> #
> >>> CONFIG_PCIPCWATCHDOG=y
> >>> CONFIG_WDTPCI=y
> >>> 
> >>> #
> >>> # USB-based Watchdog Cards
> >>> #
> >>> CONFIG_USBPCWATCHDOG=y
> >>> CONFIG_SSB_POSSIBLE=y
> >>> 
> >>> #
> >>> # Sonics Silicon Backplane
> >>> #
> >>> CONFIG_SSB=y
> >>> CONFIG_SSB_SPROM=y
> >>> CONFIG_SSB_PCIHOST_POSSIBLE=y
> >>> CONFIG_SSB_PCIHOST=y
> >>> # CONFIG_SSB_B43_PCI_BRIDGE is not set
> >>> CONFIG_SSB_SDIOHOST_POSSIBLE=y
> >>> CONFIG_SSB_SDIOHOST=y
> >>> CONFIG_SSB_SILENT=y
> >>> CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
> >>> CONFIG_SSB_DRIVER_PCICORE=y
> >>> CONFIG_SSB_DRIVER_GPIO=y
> >>> CONFIG_BCMA_POSSIBLE=y
> >>> 
> >>> #
> >>> # Broadcom specific AMBA
> >>> #
> >>> # CONFIG_BCMA is not set
> >>> 
> >>> #
> >>> # Multifunction device drivers
> >>> #
> >>> CONFIG_MFD_CORE=y
> >>> CONFIG_MFD_CS5535=y
> >>> # CONFIG_MFD_ACT8945A is not set
> >>> CONFIG_MFD_AS3711=y
> >>> CONFIG_MFD_AS3722=y
> >>> CONFIG_PMIC_ADP5520=y
> >>> # CONFIG_MFD_AAT2870_CORE is not set
> >>> CONFIG_MFD_ATMEL_FLEXCOM=y
> >>> CONFIG_MFD_ATMEL_HLCDC=y
> >>> CONFIG_MFD_BCM590XX=y
> >>> CONFIG_MFD_AXP20X=y
> >>> CONFIG_MFD_AXP20X_I2C=y
> >>> CONFIG_MFD_CROS_EC=y
> >>> # CONFIG_MFD_CROS_EC_I2C is not set
> >>> # CONFIG_PMIC_DA903X is not set
> >>> CONFIG_PMIC_DA9052=y
> >>> CONFIG_MFD_DA9052_I2C=y
> >>> CONFIG_MFD_DA9055=y
> >>> # CONFIG_MFD_DA9062 is not set
> >>> CONFIG_MFD_DA9063=y
> >>> # CONFIG_MFD_DA9150 is not set
> >>> CONFIG_MFD_DLN2=y
> >>> CONFIG_MFD_MC13XXX=y
> >>> CONFIG_MFD_MC13XXX_I2C=y
> >>> CONFIG_MFD_HI6421_PMIC=y
> >>> CONFIG_HTC_PASIC3=y
> >>> # CONFIG_HTC_I2CPLD is not set
> >>> CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
> >>> CONFIG_LPC_ICH=y
> >>> CONFIG_LPC_SCH=y
> >>> CONFIG_INTEL_SOC_PMIC=y
> >>> CONFIG_MFD_INTEL_LPSS=y
> >>> CONFIG_MFD_INTEL_LPSS_ACPI=y
> >>> # CONFIG_MFD_INTEL_LPSS_PCI is not set
> >>> CONFIG_MFD_JANZ_CMODIO=y
> >>> # CONFIG_MFD_KEMPLD is not set
> >>> CONFIG_MFD_88PM800=y
> >>> CONFIG_MFD_88PM805=y
> >>> # CONFIG_MFD_88PM860X is not set
> >>> CONFIG_MFD_MAX14577=y
> >>> # CONFIG_MFD_MAX77620 is not set
> >>> # CONFIG_MFD_MAX77686 is not set
> >>> CONFIG_MFD_MAX77693=y
> >>> # CONFIG_MFD_MAX77843 is not set
> >>> CONFIG_MFD_MAX8907=y
> >>> # CONFIG_MFD_MAX8925 is not set
> >>> # CONFIG_MFD_MAX8997 is not set
> >>> CONFIG_MFD_MAX8998=y
> >>> CONFIG_MFD_MT6397=y
> >>> # CONFIG_MFD_MENF21BMC is not set
> >>> CONFIG_MFD_VIPERBOARD=y
> >>> CONFIG_MFD_RETU=y
> >>> # CONFIG_MFD_PCF50633 is not set
> >>> CONFIG_UCB1400_CORE=y
> >>> # CONFIG_MFD_RDC321X is not set
> >>> CONFIG_MFD_RTSX_PCI=y
> >>> # CONFIG_MFD_RT5033 is not set
> >>> # CONFIG_MFD_RTSX_USB is not set
> >>> # CONFIG_MFD_RC5T583 is not set
> >>> CONFIG_MFD_RK808=y
> >>> # CONFIG_MFD_RN5T618 is not set
> >>> CONFIG_MFD_SEC_CORE=y
> >>> CONFIG_MFD_SI476X_CORE=y
> >>> CONFIG_MFD_SM501=y
> >>> CONFIG_MFD_SM501_GPIO=y
> >>> CONFIG_MFD_SKY81452=y
> >>> CONFIG_MFD_SMSC=y
> >>> # CONFIG_ABX500_CORE is not set
> >>> # CONFIG_MFD_STMPE is not set
> >>> CONFIG_MFD_SYSCON=y
> >>> CONFIG_MFD_TI_AM335X_TSCADC=y
> >>> # CONFIG_MFD_LP3943 is not set
> >>> CONFIG_MFD_LP8788=y
> >>> # CONFIG_MFD_PALMAS is not set
> >>> CONFIG_TPS6105X=y
> >>> # CONFIG_TPS65010 is not set
> >>> CONFIG_TPS6507X=y
> >>> CONFIG_MFD_TPS65086=y
> >>> CONFIG_MFD_TPS65090=y
> >>> CONFIG_MFD_TPS65217=y
> >>> CONFIG_MFD_TPS65218=y
> >>> # CONFIG_MFD_TPS6586X is not set
> >>> # CONFIG_MFD_TPS65910 is not set
> >>> # CONFIG_MFD_TPS65912_I2C is not set
> >>> CONFIG_MFD_TPS80031=y
> >>> CONFIG_TWL4030_CORE=y
> >>> CONFIG_MFD_TWL4030_AUDIO=y
> >>> CONFIG_TWL6040_CORE=y
> >>> CONFIG_MFD_WL1273_CORE=y
> >>> CONFIG_MFD_LM3533=y
> >>> CONFIG_MFD_TIMBERDALE=y
> >>> CONFIG_MFD_TC3589X=y
> >>> # CONFIG_MFD_TMIO is not set
> >>> CONFIG_MFD_VX855=y
> >>> CONFIG_MFD_ARIZONA=y
> >>> CONFIG_MFD_ARIZONA_I2C=y
> >>> # CONFIG_MFD_CS47L24 is not set
> >>> # CONFIG_MFD_WM5102 is not set
> >>> CONFIG_MFD_WM5110=y
> >>> # CONFIG_MFD_WM8997 is not set
> >>> CONFIG_MFD_WM8998=y
> >>> # CONFIG_MFD_WM8400 is not set
> >>> # CONFIG_MFD_WM831X_I2C is not set
> >>> CONFIG_MFD_WM8350=y
> >>> CONFIG_MFD_WM8350_I2C=y
> >>> CONFIG_MFD_WM8994=y
> >>> CONFIG_REGULATOR=y
> >>> # CONFIG_REGULATOR_DEBUG is not set
> >>> CONFIG_REGULATOR_FIXED_VOLTAGE=y
> >>> CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
> >>> CONFIG_REGULATOR_USERSPACE_CONSUMER=y
> >>> CONFIG_REGULATOR_88PM800=y
> >>> CONFIG_REGULATOR_ACT8865=y
> >>> CONFIG_REGULATOR_AD5398=y
> >>> CONFIG_REGULATOR_ANATOP=y
> >>> CONFIG_REGULATOR_ARIZONA=y
> >>> CONFIG_REGULATOR_AS3711=y
> >>> # CONFIG_REGULATOR_AS3722 is not set
> >>> CONFIG_REGULATOR_AXP20X=y
> >>> CONFIG_REGULATOR_BCM590XX=y
> >>> CONFIG_REGULATOR_DA9052=y
> >>> # CONFIG_REGULATOR_DA9055 is not set
> >>> CONFIG_REGULATOR_DA9063=y
> >>> # CONFIG_REGULATOR_DA9210 is not set
> >>> CONFIG_REGULATOR_DA9211=y
> >>> CONFIG_REGULATOR_FAN53555=y
> >>> CONFIG_REGULATOR_GPIO=y
> >>> CONFIG_REGULATOR_HI6421=y
> >>> CONFIG_REGULATOR_ISL9305=y
> >>> # CONFIG_REGULATOR_ISL6271A is not set
> >>> CONFIG_REGULATOR_LP3971=y
> >>> # CONFIG_REGULATOR_LP3972 is not set
> >>> # CONFIG_REGULATOR_LP872X is not set
> >>> CONFIG_REGULATOR_LP8755=y
> >>> CONFIG_REGULATOR_LP8788=y
> >>> # CONFIG_REGULATOR_LTC3589 is not set
> >>> # CONFIG_REGULATOR_MAX14577 is not set
> >>> CONFIG_REGULATOR_MAX1586=y
> >>> # CONFIG_REGULATOR_MAX8649 is not set
> >>> # CONFIG_REGULATOR_MAX8660 is not set
> >>> # CONFIG_REGULATOR_MAX8907 is not set
> >>> # CONFIG_REGULATOR_MAX8952 is not set
> >>> CONFIG_REGULATOR_MAX8998=y
> >>> CONFIG_REGULATOR_MAX77693=y
> >>> CONFIG_REGULATOR_MC13XXX_CORE=y
> >>> CONFIG_REGULATOR_MC13783=y
> >>> # CONFIG_REGULATOR_MC13892 is not set
> >>> # CONFIG_REGULATOR_MT6311 is not set
> >>> # CONFIG_REGULATOR_MT6323 is not set
> >>> CONFIG_REGULATOR_MT6397=y
> >>> # CONFIG_REGULATOR_PFUZE100 is not set
> >>> CONFIG_REGULATOR_PV88060=y
> >>> CONFIG_REGULATOR_PV88080=y
> >>> # CONFIG_REGULATOR_PV88090 is not set
> >>> CONFIG_REGULATOR_QCOM_SPMI=y
> >>> # CONFIG_REGULATOR_RK808 is not set
> >>> # CONFIG_REGULATOR_S2MPA01 is not set
> >>> # CONFIG_REGULATOR_S2MPS11 is not set
> >>> CONFIG_REGULATOR_S5M8767=y
> >>> CONFIG_REGULATOR_SKY81452=y
> >>> CONFIG_REGULATOR_TPS51632=y
> >>> # CONFIG_REGULATOR_TPS6105X is not set
> >>> CONFIG_REGULATOR_TPS62360=y
> >>> CONFIG_REGULATOR_TPS65023=y
> >>> # CONFIG_REGULATOR_TPS6507X is not set
> >>> CONFIG_REGULATOR_TPS65086=y
> >>> CONFIG_REGULATOR_TPS65090=y
> >>> CONFIG_REGULATOR_TPS65217=y
> >>> CONFIG_REGULATOR_TPS65218=y
> >>> # CONFIG_REGULATOR_TPS80031 is not set
> >>> CONFIG_REGULATOR_TWL4030=y
> >>> CONFIG_REGULATOR_WM8350=y
> >>> CONFIG_REGULATOR_WM8994=y
> >>> CONFIG_MEDIA_SUPPORT=y
> >>> 
> >>> #
> >>> # Multimedia core support
> >>> #
> >>> # CONFIG_MEDIA_CAMERA_SUPPORT is not set
> >>> CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
> >>> # CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
> >>> CONFIG_MEDIA_RADIO_SUPPORT=y
> >>> # CONFIG_MEDIA_SDR_SUPPORT is not set
> >>> # CONFIG_MEDIA_RC_SUPPORT is not set
> >>> # CONFIG_MEDIA_CONTROLLER is not set
> >>> CONFIG_VIDEO_DEV=y
> >>> CONFIG_VIDEO_V4L2=y
> >>> CONFIG_VIDEO_ADV_DEBUG=y
> >>> CONFIG_VIDEO_FIXED_MINOR_RANGES=y
> >>> # CONFIG_VIDEO_PCI_SKELETON is not set
> >>> CONFIG_VIDEO_TUNER=y
> >>> CONFIG_VIDEOBUF_GEN=y
> >>> CONFIG_VIDEOBUF_DMA_SG=y
> >>> CONFIG_VIDEOBUF2_CORE=y
> >>> CONFIG_VIDEOBUF2_MEMOPS=y
> >>> CONFIG_VIDEOBUF2_DMA_CONTIG=y
> >>> CONFIG_VIDEOBUF2_DMA_SG=y
> >>> # CONFIG_TTPCI_EEPROM is not set
> >>> 
> >>> #
> >>> # Media drivers
> >>> #
> >>> CONFIG_MEDIA_USB_SUPPORT=y
> >>> 
> >>> #
> >>> # Analog TV USB devices
> >>> #
> >>> CONFIG_VIDEO_PVRUSB2=y
> >>> # CONFIG_VIDEO_PVRUSB2_SYSFS is not set
> >>> CONFIG_VIDEO_HDPVR=y
> >>> CONFIG_VIDEO_USBVISION=y
> >>> # CONFIG_VIDEO_STK1160_COMMON is not set
> >>> # CONFIG_VIDEO_GO7007 is not set
> >>> 
> >>> #
> >>> # Analog/digital TV USB devices
> >>> #
> >>> 
> >>> #
> >>> # Webcam, TV (analog/digital) USB devices
> >>> #
> >>> # CONFIG_VIDEO_EM28XX is not set
> >>> CONFIG_MEDIA_PCI_SUPPORT=y
> >>> 
> >>> #
> >>> # Media capture/analog TV support
> >>> #
> >>> CONFIG_VIDEO_HEXIUM_GEMINI=y
> >>> # CONFIG_VIDEO_HEXIUM_ORION is not set
> >>> CONFIG_VIDEO_MXB=y
> >>> CONFIG_VIDEO_DT3155=y
> >>> 
> >>> #
> >>> # Media capture/analog/hybrid TV support
> >>> #
> >>> CONFIG_VIDEO_CX25821=y
> >>> CONFIG_VIDEO_CX25821_ALSA=y
> >>> CONFIG_VIDEO_SAA7134=y
> >>> # CONFIG_VIDEO_SAA7134_ALSA is not set
> >>> 
> >>> #
> >>> # Supported MMC/SDIO adapters
> >>> #
> >>> CONFIG_RADIO_ADAPTERS=y
> >>> CONFIG_RADIO_SI470X=y
> >>> CONFIG_USB_SI470X=y
> >>> # CONFIG_RADIO_SI4713 is not set
> >>> CONFIG_RADIO_SI476X=y
> >>> # CONFIG_USB_MR800 is not set
> >>> # CONFIG_USB_DSBR is not set
> >>> # CONFIG_RADIO_MAXIRADIO is not set
> >>> # CONFIG_RADIO_SHARK is not set
> >>> CONFIG_RADIO_SHARK2=y
> >>> CONFIG_USB_KEENE=y
> >>> CONFIG_USB_RAREMONO=y
> >>> CONFIG_USB_MA901=y
> >>> CONFIG_RADIO_TEA5764=y
> >>> # CONFIG_RADIO_TEA5764_XTAL is not set
> >>> CONFIG_RADIO_SAA7706H=y
> >>> CONFIG_RADIO_TEF6862=y
> >>> CONFIG_RADIO_TIMBERDALE=y
> >>> CONFIG_RADIO_WL1273=y
> >>> 
> >>> #
> >>> # Texas Instruments WL128x FM driver (ST based)
> >>> #
> >>> CONFIG_V4L_RADIO_ISA_DRIVERS=y
> >>> CONFIG_RADIO_ISA=y
> >>> CONFIG_RADIO_CADET=y
> >>> # CONFIG_RADIO_RTRACK is not set
> >>> # CONFIG_RADIO_RTRACK2 is not set
> >>> CONFIG_RADIO_AZTECH=y
> >>> CONFIG_RADIO_AZTECH_PORT=350
> >>> CONFIG_RADIO_GEMTEK=y
> >>> CONFIG_RADIO_GEMTEK_PORT=34c
> >>> # CONFIG_RADIO_GEMTEK_PROBE is not set
> >>> CONFIG_RADIO_MIROPCM20=y
> >>> CONFIG_RADIO_SF16FMI=y
> >>> # CONFIG_RADIO_SF16FMR2 is not set
> >>> CONFIG_RADIO_TERRATEC=y
> >>> # CONFIG_RADIO_TRUST is not set
> >>> CONFIG_RADIO_TYPHOON=y
> >>> CONFIG_RADIO_TYPHOON_PORT=316
> >>> CONFIG_RADIO_TYPHOON_MUTEFREQ=87500
> >>> CONFIG_RADIO_ZOLTRIX=y
> >>> CONFIG_RADIO_ZOLTRIX_PORT=20c
> >>> CONFIG_VIDEO_CX2341X=y
> >>> CONFIG_VIDEO_TVEEPROM=y
> >>> # CONFIG_CYPRESS_FIRMWARE is not set
> >>> CONFIG_VIDEO_SAA7146=y
> >>> CONFIG_VIDEO_SAA7146_VV=y
> >>> 
> >>> #
> >>> # Media ancillary drivers (tuners, sensors, i2c, frontends)
> >>> #
> >>> # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
> >>> 
> >>> #
> >>> # Encoders, decoders, sensors and other helper chips
> >>> #
> >>> 
> >>> #
> >>> # Audio decoders, processors and mixers
> >>> #
> >>> # CONFIG_VIDEO_TVAUDIO is not set
> >>> CONFIG_VIDEO_TDA7432=y
> >>> CONFIG_VIDEO_TDA9840=y
> >>> CONFIG_VIDEO_TEA6415C=y
> >>> CONFIG_VIDEO_TEA6420=y
> >>> CONFIG_VIDEO_MSP3400=y
> >>> # CONFIG_VIDEO_CS3308 is not set
> >>> CONFIG_VIDEO_CS5345=y
> >>> CONFIG_VIDEO_CS53L32A=y
> >>> CONFIG_VIDEO_TLV320AIC23B=y
> >>> CONFIG_VIDEO_UDA1342=y
> >>> CONFIG_VIDEO_WM8775=y
> >>> CONFIG_VIDEO_WM8739=y
> >>> CONFIG_VIDEO_VP27SMPX=y
> >>> CONFIG_VIDEO_SONY_BTF_MPX=y
> >>> 
> >>> #
> >>> # RDS decoders
> >>> #
> >>> # CONFIG_VIDEO_SAA6588 is not set
> >>> 
> >>> #
> >>> # Video decoders
> >>> #
> >>> # CONFIG_VIDEO_ADV7183 is not set
> >>> CONFIG_VIDEO_BT819=y
> >>> CONFIG_VIDEO_BT856=y
> >>> CONFIG_VIDEO_BT866=y
> >>> CONFIG_VIDEO_KS0127=y
> >>> CONFIG_VIDEO_ML86V7667=y
> >>> # CONFIG_VIDEO_SAA7110 is not set
> >>> CONFIG_VIDEO_SAA711X=y
> >>> # CONFIG_VIDEO_TVP514X is not set
> >>> CONFIG_VIDEO_TVP5150=y
> >>> CONFIG_VIDEO_TVP7002=y
> >>> CONFIG_VIDEO_TW2804=y
> >>> CONFIG_VIDEO_TW9903=y
> >>> # CONFIG_VIDEO_TW9906 is not set
> >>> CONFIG_VIDEO_VPX3220=y
> >>> 
> >>> #
> >>> # Video and audio decoders
> >>> #
> >>> # CONFIG_VIDEO_SAA717X is not set
> >>> CONFIG_VIDEO_CX25840=y
> >>> 
> >>> #
> >>> # Video encoders
> >>> #
> >>> # CONFIG_VIDEO_SAA7127 is not set
> >>> CONFIG_VIDEO_SAA7185=y
> >>> CONFIG_VIDEO_ADV7170=y
> >>> CONFIG_VIDEO_ADV7175=y
> >>> # CONFIG_VIDEO_ADV7343 is not set
> >>> # CONFIG_VIDEO_ADV7393 is not set
> >>> # CONFIG_VIDEO_AK881X is not set
> >>> # CONFIG_VIDEO_THS8200 is not set
> >>> 
> >>> #
> >>> # Camera sensor devices
> >>> #
> >>> 
> >>> #
> >>> # Flash devices
> >>> #
> >>> 
> >>> #
> >>> # Video improvement chips
> >>> #
> >>> CONFIG_VIDEO_UPD64031A=y
> >>> CONFIG_VIDEO_UPD64083=y
> >>> 
> >>> #
> >>> # Audio/Video compression chips
> >>> #
> >>> CONFIG_VIDEO_SAA6752HS=y
> >>> 
> >>> #
> >>> # Miscellaneous helper chips
> >>> #
> >>> # CONFIG_VIDEO_THS7303 is not set
> >>> # CONFIG_VIDEO_M52790 is not set
> >>> 
> >>> #
> >>> # Sensors used on soc_camera driver
> >>> #
> >>> CONFIG_MEDIA_TUNER=y
> >>> 
> >>> #
> >>> # Customize TV tuners
> >>> #
> >>> CONFIG_MEDIA_TUNER_SIMPLE=y
> >>> CONFIG_MEDIA_TUNER_TDA8290=y
> >>> CONFIG_MEDIA_TUNER_TDA827X=y
> >>> CONFIG_MEDIA_TUNER_TDA18271=y
> >>> CONFIG_MEDIA_TUNER_TDA9887=y
> >>> CONFIG_MEDIA_TUNER_TEA5761=y
> >>> CONFIG_MEDIA_TUNER_TEA5767=y
> >>> # CONFIG_MEDIA_TUNER_MT20XX is not set
> >>> CONFIG_MEDIA_TUNER_MT2060=y
> >>> CONFIG_MEDIA_TUNER_MT2063=y
> >>> # CONFIG_MEDIA_TUNER_MT2266 is not set
> >>> CONFIG_MEDIA_TUNER_MT2131=y
> >>> # CONFIG_MEDIA_TUNER_QT1010 is not set
> >>> CONFIG_MEDIA_TUNER_XC2028=y
> >>> # CONFIG_MEDIA_TUNER_XC5000 is not set
> >>> # CONFIG_MEDIA_TUNER_XC4000 is not set
> >>> CONFIG_MEDIA_TUNER_MXL5005S=y
> >>> CONFIG_MEDIA_TUNER_MXL5007T=y
> >>> CONFIG_MEDIA_TUNER_MC44S803=y
> >>> # CONFIG_MEDIA_TUNER_MAX2165 is not set
> >>> CONFIG_MEDIA_TUNER_TDA18218=y
> >>> # CONFIG_MEDIA_TUNER_FC0011 is not set
> >>> CONFIG_MEDIA_TUNER_FC0012=y
> >>> CONFIG_MEDIA_TUNER_FC0013=y
> >>> # CONFIG_MEDIA_TUNER_TDA18212 is not set
> >>> CONFIG_MEDIA_TUNER_E4000=y
> >>> CONFIG_MEDIA_TUNER_FC2580=y
> >>> CONFIG_MEDIA_TUNER_M88RS6000T=y
> >>> CONFIG_MEDIA_TUNER_TUA9001=y
> >>> # CONFIG_MEDIA_TUNER_SI2157 is not set
> >>> CONFIG_MEDIA_TUNER_IT913X=y
> >>> CONFIG_MEDIA_TUNER_R820T=y
> >>> CONFIG_MEDIA_TUNER_MXL301RF=y
> >>> CONFIG_MEDIA_TUNER_QM1D1C0042=y
> >>> 
> >>> #
> >>> # Customise DVB Frontends
> >>> #
> >>> CONFIG_DVB_AU8522=y
> >>> CONFIG_DVB_AU8522_V4L=y
> >>> CONFIG_DVB_TUNER_DIB0070=y
> >>> CONFIG_DVB_TUNER_DIB0090=y
> >>> 
> >>> #
> >>> # Tools to develop new frontends
> >>> #
> >>> # CONFIG_DVB_DUMMY_FE is not set
> >>> 
> >>> #
> >>> # Graphics support
> >>> #
> >>> # CONFIG_AGP is not set
> >>> # CONFIG_VGA_ARB is not set
> >>> # CONFIG_VGA_SWITCHEROO is not set
> >>> # CONFIG_DRM is not set
> >>> 
> >>> #
> >>> # ACP (Audio CoProcessor) Configuration
> >>> #
> >>> 
> >>> #
> >>> # Frame buffer Devices
> >>> #
> >>> CONFIG_FB=y
> >>> # CONFIG_FIRMWARE_EDID is not set
> >>> CONFIG_FB_CMDLINE=y
> >>> CONFIG_FB_NOTIFY=y
> >>> CONFIG_FB_DDC=y
> >>> # CONFIG_FB_BOOT_VESA_SUPPORT is not set
> >>> CONFIG_FB_CFB_FILLRECT=y
> >>> CONFIG_FB_CFB_COPYAREA=y
> >>> CONFIG_FB_CFB_IMAGEBLIT=y
> >>> # CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
> >>> CONFIG_FB_SYS_FILLRECT=y
> >>> CONFIG_FB_SYS_COPYAREA=y
> >>> CONFIG_FB_SYS_IMAGEBLIT=y
> >>> # CONFIG_FB_FOREIGN_ENDIAN is not set
> >>> CONFIG_FB_SYS_FOPS=y
> >>> CONFIG_FB_DEFERRED_IO=y
> >>> CONFIG_FB_HECUBA=y
> >>> CONFIG_FB_SVGALIB=y
> >>> # CONFIG_FB_MACMODES is not set
> >>> # CONFIG_FB_BACKLIGHT is not set
> >>> CONFIG_FB_MODE_HELPERS=y
> >>> CONFIG_FB_TILEBLITTING=y
> >>> 
> >>> #
> >>> # Frame buffer hardware drivers
> >>> #
> >>> CONFIG_FB_CIRRUS=y
> >>> CONFIG_FB_PM2=y
> >>> CONFIG_FB_PM2_FIFO_DISCONNECT=y
> >>> CONFIG_FB_CYBER2000=y
> >>> CONFIG_FB_CYBER2000_DDC=y
> >>> CONFIG_FB_ARC=y
> >>> # CONFIG_FB_ASILIANT is not set
> >>> # CONFIG_FB_IMSTT is not set
> >>> # CONFIG_FB_VGA16 is not set
> >>> # CONFIG_FB_VESA is not set
> >>> CONFIG_FB_N411=y
> >>> CONFIG_FB_HGA=y
> >>> CONFIG_FB_OPENCORES=y
> >>> # CONFIG_FB_S1D13XXX is not set
> >>> CONFIG_FB_NVIDIA=y
> >>> CONFIG_FB_NVIDIA_I2C=y
> >>> # CONFIG_FB_NVIDIA_DEBUG is not set
> >>> # CONFIG_FB_NVIDIA_BACKLIGHT is not set
> >>> CONFIG_FB_RIVA=y
> >>> CONFIG_FB_RIVA_I2C=y
> >>> CONFIG_FB_RIVA_DEBUG=y
> >>> # CONFIG_FB_RIVA_BACKLIGHT is not set
> >>> CONFIG_FB_I740=y
> >>> CONFIG_FB_LE80578=y
> >>> CONFIG_FB_CARILLO_RANCH=y
> >>> CONFIG_FB_MATROX=y
> >>> CONFIG_FB_MATROX_MILLENIUM=y
> >>> CONFIG_FB_MATROX_MYSTIQUE=y
> >>> CONFIG_FB_MATROX_G=y
> >>> CONFIG_FB_MATROX_I2C=y
> >>> # CONFIG_FB_MATROX_MAVEN is not set
> >>> # CONFIG_FB_RADEON is not set
> >>> # CONFIG_FB_ATY128 is not set
> >>> CONFIG_FB_ATY=y
> >>> # CONFIG_FB_ATY_CT is not set
> >>> CONFIG_FB_ATY_GX=y
> >>> # CONFIG_FB_ATY_BACKLIGHT is not set
> >>> # CONFIG_FB_S3 is not set
> >>> CONFIG_FB_SAVAGE=y
> >>> CONFIG_FB_SAVAGE_I2C=y
> >>> # CONFIG_FB_SAVAGE_ACCEL is not set
> >>> # CONFIG_FB_SIS is not set
> >>> # CONFIG_FB_VIA is not set
> >>> CONFIG_FB_NEOMAGIC=y
> >>> # CONFIG_FB_KYRO is not set
> >>> # CONFIG_FB_3DFX is not set
> >>> CONFIG_FB_VOODOO1=y
> >>> # CONFIG_FB_VT8623 is not set
> >>> CONFIG_FB_TRIDENT=y
> >>> CONFIG_FB_ARK=y
> >>> # CONFIG_FB_PM3 is not set
> >>> CONFIG_FB_CARMINE=y
> >>> # CONFIG_FB_CARMINE_DRAM_EVAL is not set
> >>> CONFIG_CARMINE_DRAM_CUSTOM=y
> >>> CONFIG_FB_GEODE=y
> >>> # CONFIG_FB_GEODE_LX is not set
> >>> # CONFIG_FB_GEODE_GX is not set
> >>> # CONFIG_FB_GEODE_GX1 is not set
> >>> # CONFIG_FB_SM501 is not set
> >>> CONFIG_FB_SMSCUFX=y
> >>> # CONFIG_FB_UDL is not set
> >>> CONFIG_FB_IBM_GXT4500=y
> >>> CONFIG_FB_GOLDFISH=y
> >>> CONFIG_FB_VIRTUAL=y
> >>> # CONFIG_FB_METRONOME is not set
> >>> CONFIG_FB_MB862XX=y
> >>> CONFIG_FB_MB862XX_PCI_GDC=y
> >>> # CONFIG_FB_MB862XX_I2C is not set
> >>> # CONFIG_FB_BROADSHEET is not set
> >>> CONFIG_FB_AUO_K190X=y
> >>> CONFIG_FB_AUO_K1900=y
> >>> # CONFIG_FB_AUO_K1901 is not set
> >>> CONFIG_FB_HYPERV=y
> >>> # CONFIG_FB_SIMPLE is not set
> >>> # CONFIG_FB_SSD1307 is not set
> >>> # CONFIG_FB_SM712 is not set
> >>> CONFIG_BACKLIGHT_LCD_SUPPORT=y
> >>> CONFIG_LCD_CLASS_DEVICE=y
> >>> # CONFIG_LCD_PLATFORM is not set
> >>> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> >>> # CONFIG_BACKLIGHT_GENERIC is not set
> >>> CONFIG_BACKLIGHT_LM3533=y
> >>> # CONFIG_BACKLIGHT_CARILLO_RANCH is not set
> >>> CONFIG_BACKLIGHT_DA9052=y
> >>> CONFIG_BACKLIGHT_APPLE=y
> >>> CONFIG_BACKLIGHT_PM8941_WLED=y
> >>> CONFIG_BACKLIGHT_SAHARA=y
> >>> # CONFIG_BACKLIGHT_ADP5520 is not set
> >>> # CONFIG_BACKLIGHT_ADP8860 is not set
> >>> CONFIG_BACKLIGHT_ADP8870=y
> >>> # CONFIG_BACKLIGHT_LM3639 is not set
> >>> CONFIG_BACKLIGHT_PANDORA=y
> >>> # CONFIG_BACKLIGHT_SKY81452 is not set
> >>> # CONFIG_BACKLIGHT_TPS65217 is not set
> >>> CONFIG_BACKLIGHT_AS3711=y
> >>> # CONFIG_BACKLIGHT_GPIO is not set
> >>> CONFIG_BACKLIGHT_LV5207LP=y
> >>> # CONFIG_BACKLIGHT_BD6107 is not set
> >>> CONFIG_VGASTATE=y
> >>> CONFIG_HDMI=y
> >>> # CONFIG_LOGO is not set
> >>> CONFIG_SOUND=y
> >>> CONFIG_SOUND_OSS_CORE=y
> >>> CONFIG_SOUND_OSS_CORE_PRECLAIM=y
> >>> CONFIG_SND=y
> >>> CONFIG_SND_TIMER=y
> >>> CONFIG_SND_PCM=y
> >>> CONFIG_SND_PCM_ELD=y
> >>> CONFIG_SND_DMAENGINE_PCM=y
> >>> CONFIG_SND_HWDEP=y
> >>> CONFIG_SND_RAWMIDI=y
> >>> CONFIG_SND_COMPRESS_OFFLOAD=y
> >>> CONFIG_SND_JACK=y
> >>> CONFIG_SND_JACK_INPUT_DEV=y
> >>> # CONFIG_SND_SEQUENCER is not set
> >>> CONFIG_SND_OSSEMUL=y
> >>> CONFIG_SND_MIXER_OSS=y
> >>> # CONFIG_SND_PCM_OSS is not set
> >>> # CONFIG_SND_PCM_TIMER is not set
> >>> # CONFIG_SND_HRTIMER is not set
> >>> CONFIG_SND_DYNAMIC_MINORS=y
> >>> CONFIG_SND_MAX_CARDS=32
> >>> # CONFIG_SND_SUPPORT_OLD_API is not set
> >>> CONFIG_SND_PROC_FS=y
> >>> CONFIG_SND_VERBOSE_PROCFS=y
> >>> CONFIG_SND_VERBOSE_PRINTK=y
> >>> CONFIG_SND_DEBUG=y
> >>> CONFIG_SND_DEBUG_VERBOSE=y
> >>> # CONFIG_SND_PCM_XRUN_DEBUG is not set
> >>> CONFIG_SND_VMASTER=y
> >>> CONFIG_SND_DMA_SGBUF=y
> >>> # CONFIG_SND_RAWMIDI_SEQ is not set
> >>> # CONFIG_SND_OPL3_LIB_SEQ is not set
> >>> # CONFIG_SND_OPL4_LIB_SEQ is not set
> >>> # CONFIG_SND_SBAWE_SEQ is not set
> >>> # CONFIG_SND_EMU10K1_SEQ is not set
> >>> CONFIG_SND_MPU401_UART=y
> >>> CONFIG_SND_OPL3_LIB=y
> >>> CONFIG_SND_OPL4_LIB=y
> >>> CONFIG_SND_AC97_CODEC=y
> >>> CONFIG_SND_DRIVERS=y
> >>> CONFIG_SND_PCSP=y
> >>> # CONFIG_SND_DUMMY is not set
> >>> CONFIG_SND_ALOOP=y
> >>> CONFIG_SND_MTPAV=y
> >>> # CONFIG_SND_SERIAL_U16550 is not set
> >>> CONFIG_SND_MPU401=y
> >>> CONFIG_SND_AC97_POWER_SAVE=y
> >>> CONFIG_SND_AC97_POWER_SAVE_DEFAULT=0
> >>> CONFIG_SND_WSS_LIB=y
> >>> CONFIG_SND_SB_COMMON=y
> >>> CONFIG_SND_SB8_DSP=y
> >>> CONFIG_SND_SB16_DSP=y
> >>> CONFIG_SND_ISA=y
> >>> CONFIG_SND_ADLIB=y
> >>> CONFIG_SND_AD1816A=y
> >>> CONFIG_SND_AD1848=y
> >>> CONFIG_SND_ALS100=y
> >>> # CONFIG_SND_AZT1605 is not set
> >>> CONFIG_SND_AZT2316=y
> >>> # CONFIG_SND_AZT2320 is not set
> >>> CONFIG_SND_CMI8328=y
> >>> CONFIG_SND_CMI8330=y
> >>> # CONFIG_SND_CS4231 is not set
> >>> # CONFIG_SND_CS4236 is not set
> >>> CONFIG_SND_ES1688=y
> >>> CONFIG_SND_ES18XX=y
> >>> CONFIG_SND_SC6000=y
> >>> CONFIG_SND_GUSCLASSIC=y
> >>> CONFIG_SND_GUSEXTREME=y
> >>> CONFIG_SND_GUSMAX=y
> >>> # CONFIG_SND_INTERWAVE is not set
> >>> # CONFIG_SND_INTERWAVE_STB is not set
> >>> CONFIG_SND_JAZZ16=y
> >>> CONFIG_SND_OPL3SA2=y
> >>> CONFIG_SND_OPTI92X_AD1848=y
> >>> CONFIG_SND_OPTI92X_CS4231=y
> >>> CONFIG_SND_OPTI93X=y
> >>> CONFIG_SND_MIRO=y
> >>> CONFIG_SND_SB8=y
> >>> # CONFIG_SND_SB16 is not set
> >>> CONFIG_SND_SBAWE=y
> >>> # CONFIG_SND_SB16_CSP is not set
> >>> # CONFIG_SND_SSCAPE is not set
> >>> CONFIG_SND_WAVEFRONT=y
> >>> # CONFIG_SND_MSND_PINNACLE is not set
> >>> CONFIG_SND_MSND_CLASSIC=y
> >>> # CONFIG_SND_PCI is not set
> >>> 
> >>> #
> >>> # HD-Audio
> >>> #
> >>> CONFIG_SND_HDA_CORE=y
> >>> CONFIG_SND_HDA_DSP_LOADER=y
> >>> CONFIG_SND_HDA_EXT_CORE=y
> >>> CONFIG_SND_HDA_PREALLOC_SIZE=64
> >>> # CONFIG_SND_USB is not set
> >>> CONFIG_SND_FIREWIRE=y
> >>> CONFIG_SND_FIREWIRE_LIB=y
> >>> CONFIG_SND_DICE=y
> >>> CONFIG_SND_OXFW=y
> >>> CONFIG_SND_ISIGHT=y
> >>> # CONFIG_SND_FIREWORKS is not set
> >>> # CONFIG_SND_BEBOB is not set
> >>> CONFIG_SND_FIREWIRE_DIGI00X=y
> >>> # CONFIG_SND_FIREWIRE_TASCAM is not set
> >>> CONFIG_SND_SOC=y
> >>> CONFIG_SND_SOC_AC97_BUS=y
> >>> CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
> >>> CONFIG_SND_SOC_COMPRESS=y
> >>> CONFIG_SND_SOC_TOPOLOGY=y
> >>> CONFIG_SND_SOC_AMD_ACP=y
> >>> # CONFIG_SND_ATMEL_SOC is not set
> >>> # CONFIG_SND_DESIGNWARE_I2S is not set
> >>> 
> >>> #
> >>> # SoC Audio for Freescale CPUs
> >>> #
> >>> 
> >>> #
> >>> # Common SoC Audio options for Freescale CPUs:
> >>> #
> >>> CONFIG_SND_SOC_FSL_ASRC=y
> >>> CONFIG_SND_SOC_FSL_SAI=y
> >>> CONFIG_SND_SOC_FSL_SSI=y
> >>> CONFIG_SND_SOC_FSL_SPDIF=y
> >>> # CONFIG_SND_SOC_FSL_ESAI is not set
> >>> # CONFIG_SND_SOC_IMX_AUDMUX is not set
> >>> CONFIG_SND_SOC_IMG=y
> >>> # CONFIG_SND_SOC_IMG_I2S_IN is not set
> >>> CONFIG_SND_SOC_IMG_I2S_OUT=y
> >>> # CONFIG_SND_SOC_IMG_PARALLEL_OUT is not set
> >>> # CONFIG_SND_SOC_IMG_SPDIF_IN is not set
> >>> CONFIG_SND_SOC_IMG_SPDIF_OUT=y
> >>> # CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC is not set
> >>> CONFIG_SND_SST_MFLD_PLATFORM=y
> >>> CONFIG_SND_SST_IPC=y
> >>> CONFIG_SND_SST_IPC_ACPI=y
> >>> CONFIG_SND_SOC_INTEL_SST=y
> >>> CONFIG_SND_SOC_INTEL_SST_ACPI=y
> >>> CONFIG_SND_SOC_INTEL_SST_MATCH=y
> >>> CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=y
> >>> CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=y
> >>> CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=y
> >>> # CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH is not set
> >>> CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=y
> >>> # CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH is not set
> >>> # CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH is not set
> >>> CONFIG_SND_SOC_INTEL_SKYLAKE=y
> >>> CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=y
> >>> CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=y
> >>> # CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH is not set
> >>> 
> >>> #
> >>> # Allwinner SoC Audio support
> >>> #
> >>> # CONFIG_SND_SUN4I_CODEC is not set
> >>> # CONFIG_SND_SUN4I_I2S is not set
> >>> # CONFIG_SND_SUN4I_SPDIF is not set
> >>> CONFIG_SND_SOC_XTFPGA_I2S=y
> >>> CONFIG_SND_SOC_I2C_AND_SPI=y
> >>> 
> >>> #
> >>> # CODEC drivers
> >>> #
> >>> CONFIG_SND_SOC_AC97_CODEC=y
> >>> CONFIG_SND_SOC_ADAU1701=y
> >>> CONFIG_SND_SOC_ADAU7002=y
> >>> CONFIG_SND_SOC_AK4554=y
> >>> # CONFIG_SND_SOC_AK4613 is not set
> >>> CONFIG_SND_SOC_AK4642=y
> >>> # CONFIG_SND_SOC_AK5386 is not set
> >>> CONFIG_SND_SOC_ALC5623=y
> >>> CONFIG_SND_SOC_BT_SCO=y
> >>> # CONFIG_SND_SOC_CS35L32 is not set
> >>> CONFIG_SND_SOC_CS35L33=y
> >>> CONFIG_SND_SOC_CS42L51=y
> >>> CONFIG_SND_SOC_CS42L51_I2C=y
> >>> # CONFIG_SND_SOC_CS42L52 is not set
> >>> CONFIG_SND_SOC_CS42L56=y
> >>> CONFIG_SND_SOC_CS42L73=y
> >>> CONFIG_SND_SOC_CS4265=y
> >>> CONFIG_SND_SOC_CS4270=y
> >>> # CONFIG_SND_SOC_CS4271_I2C is not set
> >>> # CONFIG_SND_SOC_CS42XX8_I2C is not set
> >>> # CONFIG_SND_SOC_CS4349 is not set
> >>> CONFIG_SND_SOC_CS53L30=y
> >>> CONFIG_SND_SOC_DA7219=y
> >>> CONFIG_SND_SOC_DMIC=y
> >>> CONFIG_SND_SOC_ES8328=y
> >>> CONFIG_SND_SOC_GTM601=y
> >>> CONFIG_SND_SOC_HDAC_HDMI=y
> >>> # CONFIG_SND_SOC_INNO_RK3036 is not set
> >>> CONFIG_SND_SOC_MAX98357A=y
> >>> # CONFIG_SND_SOC_MAX98504 is not set
> >>> CONFIG_SND_SOC_MAX9860=y
> >>> # CONFIG_SND_SOC_PCM1681 is not set
> >>> CONFIG_SND_SOC_PCM179X=y
> >>> CONFIG_SND_SOC_PCM179X_I2C=y
> >>> CONFIG_SND_SOC_PCM3168A=y
> >>> CONFIG_SND_SOC_PCM3168A_I2C=y
> >>> CONFIG_SND_SOC_PCM512x=y
> >>> CONFIG_SND_SOC_PCM512x_I2C=y
> >>> CONFIG_SND_SOC_RL6231=y
> >>> CONFIG_SND_SOC_RL6347A=y
> >>> CONFIG_SND_SOC_RT286=y
> >>> CONFIG_SND_SOC_RT298=y
> >>> CONFIG_SND_SOC_RT5616=y
> >>> CONFIG_SND_SOC_RT5631=y
> >>> CONFIG_SND_SOC_RT5640=y
> >>> CONFIG_SND_SOC_RT5670=y
> >>> # CONFIG_SND_SOC_RT5677_SPI is not set
> >>> CONFIG_SND_SOC_SGTL5000=y
> >>> CONFIG_SND_SOC_SI476X=y
> >>> CONFIG_SND_SOC_SIGMADSP=y
> >>> CONFIG_SND_SOC_SIGMADSP_I2C=y
> >>> CONFIG_SND_SOC_SIRF_AUDIO_CODEC=y
> >>> # CONFIG_SND_SOC_SPDIF is not set
> >>> # CONFIG_SND_SOC_SSM2602_I2C is not set
> >>> CONFIG_SND_SOC_SSM4567=y
> >>> # CONFIG_SND_SOC_STA32X is not set
> >>> # CONFIG_SND_SOC_STA350 is not set
> >>> CONFIG_SND_SOC_STI_SAS=y
> >>> CONFIG_SND_SOC_TAS2552=y
> >>> CONFIG_SND_SOC_TAS5086=y
> >>> # CONFIG_SND_SOC_TAS571X is not set
> >>> CONFIG_SND_SOC_TAS5720=y
> >>> CONFIG_SND_SOC_TFA9879=y
> >>> CONFIG_SND_SOC_TLV320AIC23=y
> >>> CONFIG_SND_SOC_TLV320AIC23_I2C=y
> >>> CONFIG_SND_SOC_TLV320AIC31XX=y
> >>> CONFIG_SND_SOC_TLV320AIC3X=y
> >>> CONFIG_SND_SOC_TS3A227E=y
> >>> CONFIG_SND_SOC_WM8510=y
> >>> CONFIG_SND_SOC_WM8523=y
> >>> # CONFIG_SND_SOC_WM8580 is not set
> >>> CONFIG_SND_SOC_WM8711=y
> >>> CONFIG_SND_SOC_WM8728=y
> >>> # CONFIG_SND_SOC_WM8731 is not set
> >>> CONFIG_SND_SOC_WM8737=y
> >>> # CONFIG_SND_SOC_WM8741 is not set
> >>> CONFIG_SND_SOC_WM8750=y
> >>> CONFIG_SND_SOC_WM8753=y
> >>> CONFIG_SND_SOC_WM8776=y
> >>> # CONFIG_SND_SOC_WM8804_I2C is not set
> >>> # CONFIG_SND_SOC_WM8903 is not set
> >>> CONFIG_SND_SOC_WM8960=y
> >>> CONFIG_SND_SOC_WM8962=y
> >>> # CONFIG_SND_SOC_WM8974 is not set
> >>> CONFIG_SND_SOC_WM8978=y
> >>> CONFIG_SND_SOC_WM8985=y
> >>> CONFIG_SND_SOC_NAU8825=y
> >>> CONFIG_SND_SOC_TPA6130A2=y
> >>> # CONFIG_SND_SIMPLE_CARD is not set
> >>> # CONFIG_SOUND_PRIME is not set
> >>> CONFIG_AC97_BUS=y
> >>> 
> >>> #
> >>> # HID support
> >>> #
> >>> CONFIG_HID=y
> >>> CONFIG_HID_BATTERY_STRENGTH=y
> >>> # CONFIG_HIDRAW is not set
> >>> CONFIG_UHID=y
> >>> CONFIG_HID_GENERIC=y
> >>> 
> >>> #
> >>> # Special HID drivers
> >>> #
> >>> # CONFIG_HID_A4TECH is not set
> >>> CONFIG_HID_ACRUX=y
> >>> # CONFIG_HID_ACRUX_FF is not set
> >>> # CONFIG_HID_APPLE is not set
> >>> CONFIG_HID_APPLEIR=y
> >>> # CONFIG_HID_AUREAL is not set
> >>> # CONFIG_HID_BELKIN is not set
> >>> # CONFIG_HID_BETOP_FF is not set
> >>> CONFIG_HID_CHERRY=y
> >>> CONFIG_HID_CHICONY=y
> >>> # CONFIG_HID_CORSAIR is not set
> >>> # CONFIG_HID_PRODIKEYS is not set
> >>> CONFIG_HID_CMEDIA=y
> >>> CONFIG_HID_CP2112=y
> >>> # CONFIG_HID_CYPRESS is not set
> >>> CONFIG_HID_DRAGONRISE=y
> >>> # CONFIG_DRAGONRISE_FF is not set
> >>> # CONFIG_HID_EMS_FF is not set
> >>> CONFIG_HID_ELECOM=y
> >>> CONFIG_HID_ELO=y
> >>> CONFIG_HID_EZKEY=y
> >>> CONFIG_HID_GEMBIRD=y
> >>> # CONFIG_HID_GFRM is not set
> >>> CONFIG_HID_HOLTEK=y
> >>> CONFIG_HOLTEK_FF=y
> >>> # CONFIG_HID_GT683R is not set
> >>> # CONFIG_HID_KEYTOUCH is not set
> >>> CONFIG_HID_KYE=y
> >>> CONFIG_HID_UCLOGIC=y
> >>> CONFIG_HID_WALTOP=y
> >>> # CONFIG_HID_GYRATION is not set
> >>> # CONFIG_HID_ICADE is not set
> >>> CONFIG_HID_TWINHAN=y
> >>> # CONFIG_HID_KENSINGTON is not set
> >>> CONFIG_HID_LCPOWER=y
> >>> # CONFIG_HID_LED is not set
> >>> CONFIG_HID_LENOVO=y
> >>> CONFIG_HID_LOGITECH=y
> >>> CONFIG_HID_LOGITECH_HIDPP=y
> >>> CONFIG_LOGITECH_FF=y
> >>> CONFIG_LOGIRUMBLEPAD2_FF=y
> >>> # CONFIG_LOGIG940_FF is not set
> >>> # CONFIG_LOGIWHEELS_FF is not set
> >>> CONFIG_HID_MAGICMOUSE=y
> >>> # CONFIG_HID_MICROSOFT is not set
> >>> CONFIG_HID_MONTEREY=y
> >>> # CONFIG_HID_MULTITOUCH is not set
> >>> # CONFIG_HID_NTRIG is not set
> >>> # CONFIG_HID_ORTEK is not set
> >>> CONFIG_HID_PANTHERLORD=y
> >>> CONFIG_PANTHERLORD_FF=y
> >>> CONFIG_HID_PENMOUNT=y
> >>> CONFIG_HID_PETALYNX=y
> >>> CONFIG_HID_PICOLCD=y
> >>> # CONFIG_HID_PICOLCD_FB is not set
> >>> CONFIG_HID_PICOLCD_BACKLIGHT=y
> >>> CONFIG_HID_PICOLCD_LCD=y
> >>> # CONFIG_HID_PICOLCD_LEDS is not set
> >>> CONFIG_HID_PLANTRONICS=y
> >>> CONFIG_HID_PRIMAX=y
> >>> # CONFIG_HID_ROCCAT is not set
> >>> # CONFIG_HID_SAITEK is not set
> >>> CONFIG_HID_SAMSUNG=y
> >>> CONFIG_HID_SONY=y
> >>> CONFIG_SONY_FF=y
> >>> CONFIG_HID_SPEEDLINK=y
> >>> CONFIG_HID_STEELSERIES=y
> >>> CONFIG_HID_SUNPLUS=y
> >>> CONFIG_HID_RMI=y
> >>> CONFIG_HID_GREENASIA=y
> >>> CONFIG_GREENASIA_FF=y
> >>> # CONFIG_HID_HYPERV_MOUSE is not set
> >>> CONFIG_HID_SMARTJOYPLUS=y
> >>> # CONFIG_SMARTJOYPLUS_FF is not set
> >>> # CONFIG_HID_TIVO is not set
> >>> # CONFIG_HID_TOPSEED is not set
> >>> # CONFIG_HID_THINGM is not set
> >>> CONFIG_HID_THRUSTMASTER=y
> >>> # CONFIG_THRUSTMASTER_FF is not set
> >>> CONFIG_HID_WACOM=y
> >>> CONFIG_HID_WIIMOTE=y
> >>> # CONFIG_HID_XINMO is not set
> >>> CONFIG_HID_ZEROPLUS=y
> >>> CONFIG_ZEROPLUS_FF=y
> >>> CONFIG_HID_ZYDACRON=y
> >>> CONFIG_HID_SENSOR_HUB=y
> >>> CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
> >>> # CONFIG_HID_ALPS is not set
> >>> 
> >>> #
> >>> # USB HID support
> >>> #
> >>> CONFIG_USB_HID=y
> >>> # CONFIG_HID_PID is not set
> >>> CONFIG_USB_HIDDEV=y
> >>> 
> >>> #
> >>> # I2C HID support
> >>> #
> >>> # CONFIG_I2C_HID is not set
> >>> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> >>> CONFIG_USB_SUPPORT=y
> >>> CONFIG_USB_COMMON=y
> >>> CONFIG_USB_ARCH_HAS_HCD=y
> >>> CONFIG_USB=y
> >>> CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> >>> 
> >>> #
> >>> # Miscellaneous USB options
> >>> #
> >>> # CONFIG_USB_DEFAULT_PERSIST is not set
> >>> CONFIG_USB_DYNAMIC_MINORS=y
> >>> CONFIG_USB_OTG=y
> >>> # CONFIG_USB_OTG_WHITELIST is not set
> >>> CONFIG_USB_OTG_BLACKLIST_HUB=y
> >>> CONFIG_USB_OTG_FSM=y
> >>> CONFIG_USB_ULPI_BUS=y
> >>> # CONFIG_USB_MON is not set
> >>> CONFIG_USB_WUSB=y
> >>> CONFIG_USB_WUSB_CBAF=y
> >>> CONFIG_USB_WUSB_CBAF_DEBUG=y
> >>> 
> >>> #
> >>> # USB Host Controller Drivers
> >>> #
> >>> # CONFIG_USB_C67X00_HCD is not set
> >>> CONFIG_USB_XHCI_HCD=y
> >>> CONFIG_USB_XHCI_PCI=y
> >>> CONFIG_USB_XHCI_PLATFORM=y
> >>> CONFIG_USB_EHCI_HCD=y
> >>> # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
> >>> CONFIG_USB_EHCI_TT_NEWSCHED=y
> >>> CONFIG_USB_EHCI_PCI=y
> >>> CONFIG_USB_EHCI_HCD_PLATFORM=y
> >>> # CONFIG_USB_OXU210HP_HCD is not set
> >>> # CONFIG_USB_ISP116X_HCD is not set
> >>> # CONFIG_USB_ISP1362_HCD is not set
> >>> # CONFIG_USB_FOTG210_HCD is not set
> >>> # CONFIG_USB_OHCI_HCD is not set
> >>> CONFIG_USB_UHCI_HCD=y
> >>> CONFIG_USB_SL811_HCD=y
> >>> # CONFIG_USB_SL811_HCD_ISO is not set
> >>> CONFIG_USB_R8A66597_HCD=y
> >>> CONFIG_USB_WHCI_HCD=y
> >>> CONFIG_USB_HWA_HCD=y
> >>> CONFIG_USB_HCD_SSB=y
> >>> # CONFIG_USB_HCD_TEST_MODE is not set
> >>> 
> >>> #
> >>> # USB Device Class drivers
> >>> #
> >>> CONFIG_USB_ACM=y
> >>> # CONFIG_USB_PRINTER is not set
> >>> # CONFIG_USB_WDM is not set
> >>> # CONFIG_USB_TMC is not set
> >>> 
> >>> #
> >>> # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> >>> #
> >>> 
> >>> #
> >>> # also be needed; see USB_STORAGE Help for more info
> >>> #
> >>> 
> >>> #
> >>> # USB Imaging devices
> >>> #
> >>> CONFIG_USB_MDC800=y
> >>> # CONFIG_USBIP_CORE is not set
> >>> # CONFIG_USB_MUSB_HDRC is not set
> >>> CONFIG_USB_DWC3=y
> >>> CONFIG_USB_DWC3_ULPI=y
> >>> # CONFIG_USB_DWC3_HOST is not set
> >>> CONFIG_USB_DWC3_GADGET=y
> >>> # CONFIG_USB_DWC3_DUAL_ROLE is not set
> >>> 
> >>> #
> >>> # Platform Glue Driver Support
> >>> #
> >>> CONFIG_USB_DWC3_PCI=y
> >>> # CONFIG_USB_DWC3_OF_SIMPLE is not set
> >>> # CONFIG_USB_DWC2 is not set
> >>> # CONFIG_USB_CHIPIDEA is not set
> >>> # CONFIG_USB_ISP1760 is not set
> >>> 
> >>> #
> >>> # USB port drivers
> >>> #
> >>> # CONFIG_USB_SERIAL is not set
> >>> 
> >>> #
> >>> # USB Miscellaneous drivers
> >>> #
> >>> # CONFIG_USB_EMI62 is not set
> >>> # CONFIG_USB_EMI26 is not set
> >>> CONFIG_USB_ADUTUX=y
> >>> CONFIG_USB_SEVSEG=y
> >>> # CONFIG_USB_RIO500 is not set
> >>> CONFIG_USB_LEGOTOWER=y
> >>> # CONFIG_USB_LCD is not set
> >>> CONFIG_USB_CYPRESS_CY7C63=y
> >>> # CONFIG_USB_CYTHERM is not set
> >>> CONFIG_USB_IDMOUSE=y
> >>> # CONFIG_USB_FTDI_ELAN is not set
> >>> CONFIG_USB_APPLEDISPLAY=y
> >>> CONFIG_USB_SISUSBVGA=y
> >>> # CONFIG_USB_LD is not set
> >>> # CONFIG_USB_TRANCEVIBRATOR is not set
> >>> CONFIG_USB_IOWARRIOR=y
> >>> # CONFIG_USB_TEST is not set
> >>> # CONFIG_USB_EHSET_TEST_FIXTURE is not set
> >>> # CONFIG_USB_ISIGHTFW is not set
> >>> CONFIG_USB_YUREX=y
> >>> CONFIG_USB_EZUSB_FX2=y
> >>> CONFIG_USB_HSIC_USB3503=y
> >>> # CONFIG_USB_LINK_LAYER_TEST is not set
> >>> CONFIG_USB_CHAOSKEY=y
> >>> CONFIG_UCSI=y
> >>> 
> >>> #
> >>> # USB Physical Layer drivers
> >>> #
> >>> CONFIG_USB_PHY=y
> >>> CONFIG_NOP_USB_XCEIV=y
> >>> CONFIG_USB_GPIO_VBUS=y
> >>> # CONFIG_TAHVO_USB is not set
> >>> CONFIG_USB_ISP1301=y
> >>> CONFIG_USB_GADGET=y
> >>> # CONFIG_USB_GADGET_DEBUG is not set
> >>> # CONFIG_USB_GADGET_DEBUG_FILES is not set
> >>> # CONFIG_USB_GADGET_DEBUG_FS is not set
> >>> CONFIG_USB_GADGET_VBUS_DRAW=2
> >>> CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
> >>> 
> >>> #
> >>> # USB Peripheral Controller
> >>> #
> >>> CONFIG_USB_FUSB300=y
> >>> CONFIG_USB_FOTG210_UDC=y
> >>> CONFIG_USB_GR_UDC=y
> >>> CONFIG_USB_R8A66597=y
> >>> CONFIG_USB_PXA27X=y
> >>> CONFIG_USB_MV_UDC=y
> >>> # CONFIG_USB_MV_U3D is not set
> >>> CONFIG_USB_M66592=y
> >>> CONFIG_USB_BDC_UDC=y
> >>> 
> >>> #
> >>> # Platform Support
> >>> #
> >>> CONFIG_USB_BDC_PCI=y
> >>> CONFIG_USB_AMD5536UDC=y
> >>> CONFIG_USB_NET2272=y
> >>> CONFIG_USB_NET2272_DMA=y
> >>> CONFIG_USB_NET2280=y
> >>> # CONFIG_USB_GOKU is not set
> >>> CONFIG_USB_EG20T=y
> >>> # CONFIG_USB_GADGET_XILINX is not set
> >>> CONFIG_USB_DUMMY_HCD=y
> >>> CONFIG_USB_LIBCOMPOSITE=y
> >>> CONFIG_USB_U_SERIAL=y
> >>> # CONFIG_USB_CONFIGFS is not set
> >>> # CONFIG_USB_ZERO is not set
> >>> # CONFIG_USB_AUDIO is not set
> >>> # CONFIG_USB_ETH is not set
> >>> # CONFIG_USB_G_NCM is not set
> >>> # CONFIG_USB_GADGETFS is not set
> >>> # CONFIG_USB_FUNCTIONFS is not set
> >>> # CONFIG_USB_G_SERIAL is not set
> >>> # CONFIG_USB_MIDI_GADGET is not set
> >>> # CONFIG_USB_G_PRINTER is not set
> >>> # CONFIG_USB_CDC_COMPOSITE is not set
> >>> # CONFIG_USB_G_HID is not set
> >>> CONFIG_USB_G_DBGP=y
> >>> # CONFIG_USB_G_DBGP_PRINTK is not set
> >>> CONFIG_USB_G_DBGP_SERIAL=y
> >>> # CONFIG_USB_G_WEBCAM is not set
> >>> # CONFIG_USB_LED_TRIG is not set
> >>> CONFIG_UWB=y
> >>> CONFIG_UWB_HWA=y
> >>> CONFIG_UWB_WHCI=y
> >>> # CONFIG_UWB_I1480U is not set
> >>> CONFIG_MMC=y
> >>> CONFIG_MMC_DEBUG=y
> >>> CONFIG_PWRSEQ_EMMC=y
> >>> CONFIG_PWRSEQ_SIMPLE=y
> >>> 
> >>> #
> >>> # MMC/SD/SDIO Card Drivers
> >>> #
> >>> CONFIG_SDIO_UART=y
> >>> # CONFIG_MMC_TEST is not set
> >>> 
> >>> #
> >>> # MMC/SD/SDIO Host Controller Drivers
> >>> #
> >>> CONFIG_MMC_SDHCI=y
> >>> CONFIG_MMC_SDHCI_IO_ACCESSORS=y
> >>> CONFIG_MMC_SDHCI_PCI=y
> >>> # CONFIG_MMC_RICOH_MMC is not set
> >>> # CONFIG_MMC_SDHCI_ACPI is not set
> >>> CONFIG_MMC_SDHCI_PLTFM=y
> >>> CONFIG_MMC_SDHCI_OF_ARASAN=y
> >>> CONFIG_MMC_SDHCI_OF_AT91=y
> >>> CONFIG_MMC_SDHCI_F_SDH30=y
> >>> CONFIG_MMC_WBSD=y
> >>> CONFIG_MMC_TIFM_SD=y
> >>> # CONFIG_MMC_GOLDFISH is not set
> >>> CONFIG_MMC_CB710=y
> >>> # CONFIG_MMC_VIA_SDMMC is not set
> >>> # CONFIG_MMC_VUB300 is not set
> >>> CONFIG_MMC_USHC=y
> >>> CONFIG_MMC_USDHI6ROL0=y
> >>> CONFIG_MMC_REALTEK_PCI=y
> >>> CONFIG_MMC_TOSHIBA_PCI=y
> >>> # CONFIG_MMC_MTK is not set
> >>> # CONFIG_MEMSTICK is not set
> >>> CONFIG_NEW_LEDS=y
> >>> CONFIG_LEDS_CLASS=y
> >>> CONFIG_LEDS_CLASS_FLASH=y
> >>> 
> >>> #
> >>> # LED drivers
> >>> #
> >>> # CONFIG_LEDS_AAT1290 is not set
> >>> CONFIG_LEDS_BCM6328=y
> >>> CONFIG_LEDS_BCM6358=y
> >>> CONFIG_LEDS_LM3530=y
> >>> # CONFIG_LEDS_LM3533 is not set
> >>> # CONFIG_LEDS_LM3642 is not set
> >>> # CONFIG_LEDS_NET48XX is not set
> >>> CONFIG_LEDS_WRAP=y
> >>> CONFIG_LEDS_PCA9532=y
> >>> # CONFIG_LEDS_PCA9532_GPIO is not set
> >>> CONFIG_LEDS_GPIO=y
> >>> CONFIG_LEDS_LP3944=y
> >>> CONFIG_LEDS_LP3952=y
> >>> CONFIG_LEDS_LP55XX_COMMON=y
> >>> CONFIG_LEDS_LP5521=y
> >>> CONFIG_LEDS_LP5523=y
> >>> CONFIG_LEDS_LP5562=y
> >>> # CONFIG_LEDS_LP8501 is not set
> >>> CONFIG_LEDS_LP8788=y
> >>> CONFIG_LEDS_LP8860=y
> >>> # CONFIG_LEDS_CLEVO_MAIL is not set
> >>> # CONFIG_LEDS_PCA955X is not set
> >>> CONFIG_LEDS_PCA963X=y
> >>> # CONFIG_LEDS_WM8350 is not set
> >>> CONFIG_LEDS_DA9052=y
> >>> # CONFIG_LEDS_REGULATOR is not set
> >>> # CONFIG_LEDS_BD2802 is not set
> >>> # CONFIG_LEDS_INTEL_SS4200 is not set
> >>> CONFIG_LEDS_LT3593=y
> >>> # CONFIG_LEDS_ADP5520 is not set
> >>> # CONFIG_LEDS_MC13783 is not set
> >>> # CONFIG_LEDS_TCA6507 is not set
> >>> CONFIG_LEDS_TLC591XX=y
> >>> CONFIG_LEDS_MAX77693=y
> >>> CONFIG_LEDS_LM355x=y
> >>> # CONFIG_LEDS_OT200 is not set
> >>> # CONFIG_LEDS_KTD2692 is not set
> >>> CONFIG_LEDS_IS31FL32XX=y
> >>> 
> >>> #
> >>> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> >>> #
> >>> CONFIG_LEDS_BLINKM=y
> >>> CONFIG_LEDS_SYSCON=y
> >>> 
> >>> #
> >>> # LED Triggers
> >>> #
> >>> CONFIG_LEDS_TRIGGERS=y
> >>> # CONFIG_LEDS_TRIGGER_TIMER is not set
> >>> CONFIG_LEDS_TRIGGER_ONESHOT=y
> >>> # CONFIG_LEDS_TRIGGER_MTD is not set
> >>> CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> >>> # CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
> >>> # CONFIG_LEDS_TRIGGER_CPU is not set
> >>> # CONFIG_LEDS_TRIGGER_GPIO is not set
> >>> # CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set
> >>> 
> >>> #
> >>> # iptables trigger is under Netfilter config (LED target)
> >>> #
> >>> CONFIG_LEDS_TRIGGER_TRANSIENT=y
> >>> CONFIG_LEDS_TRIGGER_CAMERA=y
> >>> CONFIG_LEDS_TRIGGER_PANIC=y
> >>> # CONFIG_ACCESSIBILITY is not set
> >>> CONFIG_EDAC_ATOMIC_SCRUB=y
> >>> CONFIG_EDAC_SUPPORT=y
> >>> CONFIG_EDAC=y
> >>> CONFIG_EDAC_LEGACY_SYSFS=y
> >>> # CONFIG_EDAC_DEBUG is not set
> >>> CONFIG_EDAC_DECODE_MCE=y
> >>> # CONFIG_EDAC_MM_EDAC is not set
> >>> CONFIG_RTC_LIB=y
> >>> CONFIG_RTC_MC146818_LIB=y
> >>> CONFIG_RTC_CLASS=y
> >>> CONFIG_RTC_HCTOSYS=y
> >>> CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
> >>> # CONFIG_RTC_SYSTOHC is not set
> >>> CONFIG_RTC_DEBUG=y
> >>> 
> >>> #
> >>> # RTC interfaces
> >>> #
> >>> CONFIG_RTC_INTF_SYSFS=y
> >>> CONFIG_RTC_INTF_PROC=y
> >>> # CONFIG_RTC_INTF_DEV is not set
> >>> CONFIG_RTC_DRV_TEST=y
> >>> 
> >>> #
> >>> # I2C RTC drivers
> >>> #
> >>> CONFIG_RTC_DRV_88PM80X=y
> >>> CONFIG_RTC_DRV_ABB5ZES3=y
> >>> CONFIG_RTC_DRV_ABX80X=y
> >>> CONFIG_RTC_DRV_AS3722=y
> >>> CONFIG_RTC_DRV_DS1307=y
> >>> CONFIG_RTC_DRV_DS1307_HWMON=y
> >>> CONFIG_RTC_DRV_DS1374=y
> >>> # CONFIG_RTC_DRV_DS1374_WDT is not set
> >>> CONFIG_RTC_DRV_DS1672=y
> >>> # CONFIG_RTC_DRV_HYM8563 is not set
> >>> # CONFIG_RTC_DRV_LP8788 is not set
> >>> CONFIG_RTC_DRV_MAX6900=y
> >>> CONFIG_RTC_DRV_MAX8907=y
> >>> CONFIG_RTC_DRV_MAX8998=y
> >>> CONFIG_RTC_DRV_RK808=y
> >>> # CONFIG_RTC_DRV_RS5C372 is not set
> >>> # CONFIG_RTC_DRV_ISL1208 is not set
> >>> CONFIG_RTC_DRV_ISL12022=y
> >>> # CONFIG_RTC_DRV_ISL12057 is not set
> >>> CONFIG_RTC_DRV_X1205=y
> >>> # CONFIG_RTC_DRV_PCF8523 is not set
> >>> CONFIG_RTC_DRV_PCF85063=y
> >>> # CONFIG_RTC_DRV_PCF8563 is not set
> >>> # CONFIG_RTC_DRV_PCF8583 is not set
> >>> # CONFIG_RTC_DRV_M41T80 is not set
> >>> # CONFIG_RTC_DRV_BQ32K is not set
> >>> CONFIG_RTC_DRV_TWL4030=y
> >>> CONFIG_RTC_DRV_TPS80031=y
> >>> # CONFIG_RTC_DRV_S35390A is not set
> >>> # CONFIG_RTC_DRV_FM3130 is not set
> >>> # CONFIG_RTC_DRV_RX8010 is not set
> >>> CONFIG_RTC_DRV_RX8581=y
> >>> CONFIG_RTC_DRV_RX8025=y
> >>> # CONFIG_RTC_DRV_EM3027 is not set
> >>> CONFIG_RTC_DRV_RV8803=y
> >>> CONFIG_RTC_DRV_S5M=y
> >>> 
> >>> #
> >>> # SPI RTC drivers
> >>> #
> >>> CONFIG_RTC_I2C_AND_SPI=y
> >>> 
> >>> #
> >>> # SPI and I2C RTC drivers
> >>> #
> >>> CONFIG_RTC_DRV_DS3232=y
> >>> # CONFIG_RTC_DRV_PCF2127 is not set
> >>> # CONFIG_RTC_DRV_RV3029C2 is not set
> >>> 
> >>> #
> >>> # Platform RTC drivers
> >>> #
> >>> CONFIG_RTC_DRV_CMOS=y
> >>> CONFIG_RTC_DRV_DS1286=y
> >>> CONFIG_RTC_DRV_DS1511=y
> >>> CONFIG_RTC_DRV_DS1553=y
> >>> CONFIG_RTC_DRV_DS1685_FAMILY=y
> >>> # CONFIG_RTC_DRV_DS1685 is not set
> >>> # CONFIG_RTC_DRV_DS1689 is not set
> >>> # CONFIG_RTC_DRV_DS17285 is not set
> >>> # CONFIG_RTC_DRV_DS17485 is not set
> >>> CONFIG_RTC_DRV_DS17885=y
> >>> # CONFIG_RTC_DS1685_PROC_REGS is not set
> >>> # CONFIG_RTC_DS1685_SYSFS_REGS is not set
> >>> CONFIG_RTC_DRV_DS1742=y
> >>> CONFIG_RTC_DRV_DS2404=y
> >>> # CONFIG_RTC_DRV_DA9052 is not set
> >>> # CONFIG_RTC_DRV_DA9055 is not set
> >>> CONFIG_RTC_DRV_DA9063=y
> >>> # CONFIG_RTC_DRV_STK17TA8 is not set
> >>> CONFIG_RTC_DRV_M48T86=y
> >>> CONFIG_RTC_DRV_M48T35=y
> >>> CONFIG_RTC_DRV_M48T59=y
> >>> CONFIG_RTC_DRV_MSM6242=y
> >>> # CONFIG_RTC_DRV_BQ4802 is not set
> >>> # CONFIG_RTC_DRV_RP5C01 is not set
> >>> CONFIG_RTC_DRV_V3020=y
> >>> # CONFIG_RTC_DRV_WM8350 is not set
> >>> # CONFIG_RTC_DRV_ZYNQMP is not set
> >>> 
> >>> #
> >>> # on-CPU RTC drivers
> >>> #
> >>> # CONFIG_RTC_DRV_MC13XXX is not set
> >>> CONFIG_RTC_DRV_SNVS=y
> >>> CONFIG_RTC_DRV_MT6397=y
> >>> 
> >>> #
> >>> # HID Sensor RTC drivers
> >>> #
> >>> CONFIG_RTC_DRV_HID_SENSOR_TIME=y
> >>> # CONFIG_DMADEVICES is not set
> >>> 
> >>> #
> >>> # DMABUF options
> >>> #
> >>> # CONFIG_SYNC_FILE is not set
> >>> CONFIG_AUXDISPLAY=y
> >>> CONFIG_UIO=y
> >>> CONFIG_UIO_CIF=y
> >>> CONFIG_UIO_PDRV_GENIRQ=y
> >>> CONFIG_UIO_DMEM_GENIRQ=y
> >>> # CONFIG_UIO_AEC is not set
> >>> CONFIG_UIO_SERCOS3=y
> >>> # CONFIG_UIO_PCI_GENERIC is not set
> >>> CONFIG_UIO_NETX=y
> >>> # CONFIG_UIO_PRUSS is not set
> >>> # CONFIG_UIO_MF624 is not set
> >>> # CONFIG_VIRT_DRIVERS is not set
> >>> CONFIG_VIRTIO=y
> >>> 
> >>> #
> >>> # Virtio drivers
> >>> #
> >>> # CONFIG_VIRTIO_PCI is not set
> >>> # CONFIG_VIRTIO_BALLOON is not set
> >>> CONFIG_VIRTIO_INPUT=y
> >>> CONFIG_VIRTIO_MMIO=y
> >>> # CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set
> >>> 
> >>> #
> >>> # Microsoft Hyper-V guest support
> >>> #
> >>> CONFIG_HYPERV=y
> >>> # CONFIG_HYPERV_BALLOON is not set
> >>> CONFIG_STAGING=y
> >>> # CONFIG_SLICOSS is not set
> >>> # CONFIG_FB_OLPC_DCON is not set
> >>> 
> >>> #
> >>> # IIO staging drivers
> >>> #
> >>> 
> >>> #
> >>> # Accelerometers
> >>> #
> >>> 
> >>> #
> >>> # Analog to digital converters
> >>> #
> >>> CONFIG_AD7606=y
> >>> # CONFIG_AD7606_IFACE_PARALLEL is not set
> >>> 
> >>> #
> >>> # Analog digital bi-direction converters
> >>> #
> >>> CONFIG_ADT7316=y
> >>> # CONFIG_ADT7316_I2C is not set
> >>> 
> >>> #
> >>> # Capacitance to digital converters
> >>> #
> >>> CONFIG_AD7150=y
> >>> # CONFIG_AD7152 is not set
> >>> # CONFIG_AD7746 is not set
> >>> 
> >>> #
> >>> # Direct Digital Synthesis
> >>> #
> >>> 
> >>> #
> >>> # Digital gyroscope sensors
> >>> #
> >>> 
> >>> #
> >>> # Network Analyzer, Impedance Converters
> >>> #
> >>> # CONFIG_AD5933 is not set
> >>> 
> >>> #
> >>> # Light sensors
> >>> #
> >>> # CONFIG_SENSORS_ISL29018 is not set
> >>> CONFIG_SENSORS_ISL29028=y
> >>> CONFIG_TSL2583=y
> >>> # CONFIG_TSL2x7x is not set
> >>> 
> >>> #
> >>> # Active energy metering IC
> >>> #
> >>> CONFIG_ADE7854=y
> >>> CONFIG_ADE7854_I2C=y
> >>> 
> >>> #
> >>> # Resolver to digital converters
> >>> #
> >>> 
> >>> #
> >>> # Triggers - standalone
> >>> #
> >>> CONFIG_FB_SM750=y
> >>> # CONFIG_FB_XGI is not set
> >>> 
> >>> #
> >>> # Speakup console speech
> >>> #
> >>> CONFIG_STAGING_MEDIA=y
> >>> CONFIG_I2C_BCM2048=y
> >>> # CONFIG_MEDIA_CEC is not set
> >>> # CONFIG_VIDEO_TW686X_KH is not set
> >>> 
> >>> #
> >>> # Android
> >>> #
> >>> CONFIG_ASHMEM=y
> >>> CONFIG_ANDROID_LOW_MEMORY_KILLER=y
> >>> # CONFIG_ION is not set
> >>> # CONFIG_STAGING_BOARD is not set
> >>> # CONFIG_FIREWIRE_SERIAL is not set
> >>> CONFIG_GOLDFISH_AUDIO=y
> >>> CONFIG_MTD_GOLDFISH_NAND=y
> >>> # CONFIG_DGNC is not set
> >>> # CONFIG_GS_FPGABOOT is not set
> >>> CONFIG_COMMON_CLK_XLNX_CLKWZRD=y
> >>> CONFIG_MOST=y
> >>> CONFIG_MOSTCORE=y
> >>> # CONFIG_AIM_CDEV is not set
> >>> # CONFIG_AIM_NETWORK is not set
> >>> CONFIG_AIM_SOUND=y
> >>> CONFIG_AIM_V4L2=y
> >>> CONFIG_HDM_I2C=y
> >>> # CONFIG_HDM_USB is not set
> >>> # CONFIG_KS7010 is not set
> >>> # CONFIG_X86_PLATFORM_DEVICES is not set
> >>> CONFIG_GOLDFISH_BUS=y
> >>> # CONFIG_GOLDFISH_PIPE is not set
> >>> CONFIG_CHROME_PLATFORMS=y
> >>> # CONFIG_CHROMEOS_LAPTOP is not set
> >>> CONFIG_CHROMEOS_PSTORE=y
> >>> CONFIG_CROS_EC_CHARDEV=y
> >>> CONFIG_CROS_EC_LPC=y
> >>> CONFIG_CROS_EC_PROTO=y
> >>> # CONFIG_CROS_KBD_LED_BACKLIGHT is not set
> >>> CONFIG_CLKDEV_LOOKUP=y
> >>> CONFIG_HAVE_CLK_PREPARE=y
> >>> CONFIG_COMMON_CLK=y
> >>> 
> >>> #
> >>> # Common Clock Framework
> >>> #
> >>> CONFIG_COMMON_CLK_RK808=y
> >>> CONFIG_COMMON_CLK_SCPI=y
> >>> CONFIG_COMMON_CLK_SI5351=y
> >>> CONFIG_COMMON_CLK_SI514=y
> >>> # CONFIG_COMMON_CLK_SI570 is not set
> >>> CONFIG_COMMON_CLK_CDCE706=y
> >>> # CONFIG_COMMON_CLK_CDCE925 is not set
> >>> # CONFIG_COMMON_CLK_CS2000_CP is not set
> >>> CONFIG_COMMON_CLK_S2MPS11=y
> >>> CONFIG_CLK_TWL6040=y
> >>> # CONFIG_COMMON_CLK_NXP is not set
> >>> # CONFIG_COMMON_CLK_PXA is not set
> >>> # CONFIG_COMMON_CLK_PIC32 is not set
> >>> # CONFIG_SUNXI_CCU is not set
> >>> 
> >>> #
> >>> # Hardware Spinlock drivers
> >>> #
> >>> 
> >>> #
> >>> # Clock Source drivers
> >>> #
> >>> CONFIG_CLKSRC_I8253=y
> >>> CONFIG_CLKEVT_I8253=y
> >>> CONFIG_I8253_LOCK=y
> >>> CONFIG_CLKBLD_I8253=y
> >>> # CONFIG_ATMEL_PIT is not set
> >>> # CONFIG_SH_TIMER_CMT is not set
> >>> # CONFIG_SH_TIMER_MTU2 is not set
> >>> # CONFIG_SH_TIMER_TMU is not set
> >>> # CONFIG_EM_TIMER_STI is not set
> >>> CONFIG_MAILBOX=y
> >>> # CONFIG_PCC is not set
> >>> # CONFIG_ALTERA_MBOX is not set
> >>> # CONFIG_MAILBOX_TEST is not set
> >>> CONFIG_IOMMU_SUPPORT=y
> >>> 
> >>> #
> >>> # Generic IOMMU Pagetable Support
> >>> #
> >>> 
> >>> #
> >>> # Remoteproc drivers
> >>> #
> >>> # CONFIG_STE_MODEM_RPROC is not set
> >>> 
> >>> #
> >>> # Rpmsg drivers
> >>> #
> >>> 
> >>> #
> >>> # SOC (System On Chip) specific Drivers
> >>> #
> >>> 
> >>> #
> >>> # Broadcom SoC drivers
> >>> #
> >>> # CONFIG_SUNXI_SRAM is not set
> >>> # CONFIG_SOC_TI is not set
> >>> CONFIG_PM_DEVFREQ=y
> >>> 
> >>> #
> >>> # DEVFREQ Governors
> >>> #
> >>> CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
> >>> CONFIG_DEVFREQ_GOV_PERFORMANCE=y
> >>> CONFIG_DEVFREQ_GOV_POWERSAVE=y
> >>> # CONFIG_DEVFREQ_GOV_USERSPACE is not set
> >>> CONFIG_DEVFREQ_GOV_PASSIVE=y
> >>> 
> >>> #
> >>> # DEVFREQ Drivers
> >>> #
> >>> CONFIG_PM_DEVFREQ_EVENT=y
> >>> CONFIG_EXTCON=y
> >>> 
> >>> #
> >>> # Extcon Device Drivers
> >>> #
> >>> CONFIG_EXTCON_ADC_JACK=y
> >>> CONFIG_EXTCON_ARIZONA=y
> >>> CONFIG_EXTCON_AXP288=y
> >>> CONFIG_EXTCON_GPIO=y
> >>> CONFIG_EXTCON_MAX14577=y
> >>> CONFIG_EXTCON_MAX3355=y
> >>> CONFIG_EXTCON_MAX77693=y
> >>> # CONFIG_EXTCON_RT8973A is not set
> >>> CONFIG_EXTCON_SM5502=y
> >>> # CONFIG_EXTCON_USB_GPIO is not set
> >>> # CONFIG_MEMORY is not set
> >>> CONFIG_IIO=y
> >>> CONFIG_IIO_BUFFER=y
> >>> CONFIG_IIO_BUFFER_CB=y
> >>> CONFIG_IIO_KFIFO_BUF=y
> >>> CONFIG_IIO_TRIGGERED_BUFFER=y
> >>> CONFIG_IIO_CONFIGFS=y
> >>> CONFIG_IIO_TRIGGER=y
> >>> CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
> >>> CONFIG_IIO_SW_DEVICE=y
> >>> # CONFIG_IIO_SW_TRIGGER is not set
> >>> 
> >>> #
> >>> # Accelerometers
> >>> #
> >>> # CONFIG_BMA180 is not set
> >>> CONFIG_BMC150_ACCEL=y
> >>> CONFIG_BMC150_ACCEL_I2C=y
> >>> # CONFIG_HID_SENSOR_ACCEL_3D is not set
> >>> CONFIG_IIO_ST_ACCEL_3AXIS=y
> >>> CONFIG_IIO_ST_ACCEL_I2C_3AXIS=y
> >>> # CONFIG_KXCJK1013 is not set
> >>> CONFIG_MMA7455=y
> >>> CONFIG_MMA7455_I2C=y
> >>> # CONFIG_MMA7660 is not set
> >>> CONFIG_MMA8452=y
> >>> CONFIG_MMA9551_CORE=y
> >>> # CONFIG_MMA9551 is not set
> >>> CONFIG_MMA9553=y
> >>> # CONFIG_MXC4005 is not set
> >>> CONFIG_MXC6255=y
> >>> CONFIG_STK8312=y
> >>> CONFIG_STK8BA50=y
> >>> 
> >>> #
> >>> # Analog to digital converters
> >>> #
> >>> CONFIG_AD7291=y
> >>> CONFIG_AD799X=y
> >>> CONFIG_AXP288_ADC=y
> >>> CONFIG_CC10001_ADC=y
> >>> CONFIG_LP8788_ADC=y
> >>> # CONFIG_MAX1363 is not set
> >>> CONFIG_MCP3422=y
> >>> CONFIG_MEN_Z188_ADC=y
> >>> # CONFIG_NAU7802 is not set
> >>> # CONFIG_QCOM_SPMI_IADC is not set
> >>> CONFIG_QCOM_SPMI_VADC=y
> >>> CONFIG_TI_ADC081C=y
> >>> # CONFIG_TI_AM335X_ADC is not set
> >>> CONFIG_TWL4030_MADC=y
> >>> CONFIG_TWL6030_GPADC=y
> >>> CONFIG_VF610_ADC=y
> >>> CONFIG_VIPERBOARD_ADC=y
> >>> 
> >>> #
> >>> # Amplifiers
> >>> #
> >>> 
> >>> #
> >>> # Chemical Sensors
> >>> #
> >>> CONFIG_ATLAS_PH_SENSOR=y
> >>> # CONFIG_IAQCORE is not set
> >>> CONFIG_VZ89X=y
> >>> 
> >>> #
> >>> # Hid Sensor IIO Common
> >>> #
> >>> CONFIG_HID_SENSOR_IIO_COMMON=y
> >>> CONFIG_HID_SENSOR_IIO_TRIGGER=y
> >>> CONFIG_IIO_MS_SENSORS_I2C=y
> >>> 
> >>> #
> >>> # SSP Sensor Common
> >>> #
> >>> CONFIG_IIO_ST_SENSORS_I2C=y
> >>> CONFIG_IIO_ST_SENSORS_CORE=y
> >>> 
> >>> #
> >>> # Digital to analog converters
> >>> #
> >>> # CONFIG_AD5064 is not set
> >>> # CONFIG_AD5380 is not set
> >>> CONFIG_AD5446=y
> >>> CONFIG_AD5592R_BASE=y
> >>> CONFIG_AD5593R=y
> >>> # CONFIG_M62332 is not set
> >>> CONFIG_MAX517=y
> >>> # CONFIG_MAX5821 is not set
> >>> CONFIG_MCP4725=y
> >>> CONFIG_STX104=y
> >>> CONFIG_VF610_DAC=y
> >>> 
> >>> #
> >>> # IIO dummy driver
> >>> #
> >>> CONFIG_IIO_SIMPLE_DUMMY=y
> >>> # CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
> >>> # CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set
> >>> 
> >>> #
> >>> # Frequency Synthesizers DDS/PLL
> >>> #
> >>> 
> >>> #
> >>> # Clock Generator/Distribution
> >>> #
> >>> 
> >>> #
> >>> # Phase-Locked Loop (PLL) frequency synthesizers
> >>> #
> >>> 
> >>> #
> >>> # Digital gyroscope sensors
> >>> #
> >>> # CONFIG_BMG160 is not set
> >>> # CONFIG_HID_SENSOR_GYRO_3D is not set
> >>> # CONFIG_IIO_ST_GYRO_3AXIS is not set
> >>> CONFIG_ITG3200=y
> >>> 
> >>> #
> >>> # Health Sensors
> >>> #
> >>> 
> >>> #
> >>> # Heart Rate Monitors
> >>> #
> >>> CONFIG_AFE4404=y
> >>> CONFIG_MAX30100=y
> >>> 
> >>> #
> >>> # Humidity sensors
> >>> #
> >>> CONFIG_AM2315=y
> >>> # CONFIG_DHT11 is not set
> >>> # CONFIG_HDC100X is not set
> >>> CONFIG_HTU21=y
> >>> # CONFIG_SI7005 is not set
> >>> CONFIG_SI7020=y
> >>> 
> >>> #
> >>> # Inertial measurement units
> >>> #
> >>> # CONFIG_BMI160_I2C is not set
> >>> CONFIG_KMX61=y
> >>> CONFIG_INV_MPU6050_IIO=y
> >>> CONFIG_INV_MPU6050_I2C=y
> >>> 
> >>> #
> >>> # Light sensors
> >>> #
> >>> CONFIG_ACPI_ALS=y
> >>> CONFIG_ADJD_S311=y
> >>> # CONFIG_AL3320A is not set
> >>> CONFIG_APDS9300=y
> >>> # CONFIG_APDS9960 is not set
> >>> CONFIG_BH1750=y
> >>> # CONFIG_BH1780 is not set
> >>> # CONFIG_CM32181 is not set
> >>> CONFIG_CM3232=y
> >>> # CONFIG_CM3323 is not set
> >>> CONFIG_CM36651=y
> >>> CONFIG_GP2AP020A00F=y
> >>> CONFIG_ISL29125=y
> >>> # CONFIG_HID_SENSOR_ALS is not set
> >>> # CONFIG_HID_SENSOR_PROX is not set
> >>> CONFIG_JSA1212=y
> >>> CONFIG_RPR0521=y
> >>> # CONFIG_SENSORS_LM3533 is not set
> >>> CONFIG_LTR501=y
> >>> # CONFIG_MAX44000 is not set
> >>> # CONFIG_OPT3001 is not set
> >>> # CONFIG_PA12203001 is not set
> >>> CONFIG_STK3310=y
> >>> # CONFIG_TCS3414 is not set
> >>> # CONFIG_TCS3472 is not set
> >>> CONFIG_SENSORS_TSL2563=y
> >>> CONFIG_TSL4531=y
> >>> CONFIG_US5182D=y
> >>> CONFIG_VCNL4000=y
> >>> # CONFIG_VEML6070 is not set
> >>> 
> >>> #
> >>> # Magnetometer sensors
> >>> #
> >>> CONFIG_AK8975=y
> >>> CONFIG_AK09911=y
> >>> CONFIG_BMC150_MAGN=y
> >>> CONFIG_BMC150_MAGN_I2C=y
> >>> # CONFIG_MAG3110 is not set
> >>> CONFIG_HID_SENSOR_MAGNETOMETER_3D=y
> >>> CONFIG_MMC35240=y
> >>> # CONFIG_IIO_ST_MAGN_3AXIS is not set
> >>> CONFIG_SENSORS_HMC5843=y
> >>> CONFIG_SENSORS_HMC5843_I2C=y
> >>> 
> >>> #
> >>> # Inclinometer sensors
> >>> #
> >>> # CONFIG_HID_SENSOR_INCLINOMETER_3D is not set
> >>> CONFIG_HID_SENSOR_DEVICE_ROTATION=y
> >>> 
> >>> #
> >>> # Triggers - standalone
> >>> #
> >>> CONFIG_IIO_INTERRUPT_TRIGGER=y
> >>> CONFIG_IIO_SYSFS_TRIGGER=y
> >>> 
> >>> #
> >>> # Digital potentiometers
> >>> #
> >>> CONFIG_DS1803=y
> >>> # CONFIG_MCP4531 is not set
> >>> CONFIG_TPL0102=y
> >>> 
> >>> #
> >>> # Pressure sensors
> >>> #
> >>> # CONFIG_BMP280 is not set
> >>> CONFIG_HID_SENSOR_PRESS=y
> >>> # CONFIG_HP03 is not set
> >>> CONFIG_MPL115=y
> >>> CONFIG_MPL115_I2C=y
> >>> CONFIG_MPL3115=y
> >>> CONFIG_MS5611=y
> >>> # CONFIG_MS5611_I2C is not set
> >>> CONFIG_MS5637=y
> >>> # CONFIG_IIO_ST_PRESS is not set
> >>> # CONFIG_T5403 is not set
> >>> CONFIG_HP206C=y
> >>> 
> >>> #
> >>> # Lightning sensors
> >>> #
> >>> 
> >>> #
> >>> # Proximity sensors
> >>> #
> >>> # CONFIG_LIDAR_LITE_V2 is not set
> >>> CONFIG_SX9500=y
> >>> 
> >>> #
> >>> # Temperature sensors
> >>> #
> >>> CONFIG_MLX90614=y
> >>> # CONFIG_TMP006 is not set
> >>> CONFIG_TSYS01=y
> >>> CONFIG_TSYS02D=y
> >>> CONFIG_NTB=y
> >>> CONFIG_NTB_PINGPONG=y
> >>> CONFIG_NTB_TOOL=y
> >>> CONFIG_NTB_PERF=y
> >>> CONFIG_NTB_TRANSPORT=y
> >>> # CONFIG_VME_BUS is not set
> >>> # CONFIG_PWM is not set
> >>> CONFIG_IRQCHIP=y
> >>> CONFIG_ARM_GIC_MAX_NR=1
> >>> # CONFIG_IPACK_BUS is not set
> >>> # CONFIG_RESET_CONTROLLER is not set
> >>> CONFIG_FMC=y
> >>> # CONFIG_FMC_FAKEDEV is not set
> >>> CONFIG_FMC_TRIVIAL=y
> >>> CONFIG_FMC_WRITE_EEPROM=y
> >>> # CONFIG_FMC_CHARDEV is not set
> >>> 
> >>> #
> >>> # PHY Subsystem
> >>> #
> >>> CONFIG_GENERIC_PHY=y
> >>> CONFIG_PHY_PXA_28NM_HSIC=y
> >>> CONFIG_PHY_PXA_28NM_USB2=y
> >>> CONFIG_BCM_KONA_USB2_PHY=y
> >>> CONFIG_PHY_TUSB1210=y
> >>> # CONFIG_POWERCAP is not set
> >>> CONFIG_MCB=y
> >>> CONFIG_MCB_PCI=y
> >>> 
> >>> #
> >>> # Performance monitor support
> >>> #
> >>> CONFIG_RAS=y
> >>> CONFIG_MCE_AMD_INJ=y
> >>> CONFIG_THUNDERBOLT=y
> >>> 
> >>> #
> >>> # Android
> >>> #
> >>> CONFIG_ANDROID=y
> >>> CONFIG_ANDROID_BINDER_IPC=y
> >>> CONFIG_ANDROID_BINDER_IPC_32BIT=y
> >>> # CONFIG_DEV_DAX is not set
> >>> CONFIG_NVMEM=y
> >>> CONFIG_STM=y
> >>> CONFIG_STM_DUMMY=y
> >>> CONFIG_STM_SOURCE_CONSOLE=y
> >>> # CONFIG_STM_SOURCE_HEARTBEAT is not set
> >>> # CONFIG_INTEL_TH is not set
> >>> 
> >>> #
> >>> # FPGA Configuration Support
> >>> #
> >>> CONFIG_FPGA=y
> >>> # CONFIG_FPGA_MGR_ZYNQ_FPGA is not set
> >>> 
> >>> #
> >>> # Firmware Drivers
> >>> #
> >>> CONFIG_ARM_SCPI_PROTOCOL=y
> >>> CONFIG_ARM_SCPI_POWER_DOMAIN=y
> >>> CONFIG_EDD=y
> >>> CONFIG_EDD_OFF=y
> >>> CONFIG_FIRMWARE_MEMMAP=y
> >>> # CONFIG_DELL_RBU is not set
> >>> CONFIG_DCDBAS=y
> >>> CONFIG_DMIID=y
> >>> CONFIG_DMI_SYSFS=y
> >>> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> >>> CONFIG_ISCSI_IBFT_FIND=y
> >>> CONFIG_FW_CFG_SYSFS=y
> >>> # CONFIG_FW_CFG_SYSFS_CMDLINE is not set
> >>> CONFIG_GOOGLE_FIRMWARE=y
> >>> 
> >>> #
> >>> # Google Firmware Drivers
> >>> #
> >>> CONFIG_GOOGLE_MEMCONSOLE=y
> >>> CONFIG_UEFI_CPER=y
> >>> 
> >>> #
> >>> # File systems
> >>> #
> >>> CONFIG_DCACHE_WORD_ACCESS=y
> >>> CONFIG_FS_POSIX_ACL=y
> >>> CONFIG_EXPORTFS=y
> >>> # CONFIG_EXPORTFS_BLOCK_OPS is not set
> >>> CONFIG_FILE_LOCKING=y
> >>> CONFIG_MANDATORY_FILE_LOCKING=y
> >>> CONFIG_FSNOTIFY=y
> >>> CONFIG_DNOTIFY=y
> >>> CONFIG_INOTIFY_USER=y
> >>> # CONFIG_FANOTIFY is not set
> >>> CONFIG_QUOTA=y
> >>> # CONFIG_QUOTA_NETLINK_INTERFACE is not set
> >>> CONFIG_PRINT_QUOTA_WARNING=y
> >>> # CONFIG_QUOTA_DEBUG is not set
> >>> CONFIG_QUOTA_TREE=y
> >>> # CONFIG_QFMT_V1 is not set
> >>> CONFIG_QFMT_V2=y
> >>> CONFIG_QUOTACTL=y
> >>> # CONFIG_AUTOFS4_FS is not set
> >>> CONFIG_FUSE_FS=y
> >>> CONFIG_CUSE=y
> >>> CONFIG_OVERLAY_FS=y
> >>> 
> >>> #
> >>> # Caches
> >>> #
> >>> CONFIG_FSCACHE=y
> >>> # CONFIG_FSCACHE_STATS is not set
> >>> # CONFIG_FSCACHE_HISTOGRAM is not set
> >>> CONFIG_FSCACHE_DEBUG=y
> >>> # CONFIG_FSCACHE_OBJECT_LIST is not set
> >>> 
> >>> #
> >>> # Pseudo filesystems
> >>> #
> >>> CONFIG_PROC_FS=y
> >>> # CONFIG_PROC_KCORE is not set
> >>> CONFIG_PROC_SYSCTL=y
> >>> CONFIG_PROC_PAGE_MONITOR=y
> >>> CONFIG_PROC_CHILDREN=y
> >>> CONFIG_KERNFS=y
> >>> CONFIG_SYSFS=y
> >>> CONFIG_TMPFS=y
> >>> # CONFIG_TMPFS_POSIX_ACL is not set
> >>> # CONFIG_TMPFS_XATTR is not set
> >>> CONFIG_HUGETLBFS=y
> >>> CONFIG_HUGETLB_PAGE=y
> >>> CONFIG_CONFIGFS_FS=y
> >>> CONFIG_MISC_FILESYSTEMS=y
> >>> CONFIG_ORANGEFS_FS=y
> >>> CONFIG_JFFS2_FS=y
> >>> CONFIG_JFFS2_FS_DEBUG=0
> >>> CONFIG_JFFS2_FS_WRITEBUFFER=y
> >>> CONFIG_JFFS2_FS_WBUF_VERIFY=y
> >>> # CONFIG_JFFS2_SUMMARY is not set
> >>> # CONFIG_JFFS2_FS_XATTR is not set
> >>> CONFIG_JFFS2_COMPRESSION_OPTIONS=y
> >>> CONFIG_JFFS2_ZLIB=y
> >>> # CONFIG_JFFS2_LZO is not set
> >>> CONFIG_JFFS2_RTIME=y
> >>> CONFIG_JFFS2_RUBIN=y
> >>> CONFIG_JFFS2_CMODE_NONE=y
> >>> # CONFIG_JFFS2_CMODE_PRIORITY is not set
> >>> # CONFIG_JFFS2_CMODE_SIZE is not set
> >>> # CONFIG_JFFS2_CMODE_FAVOURLZO is not set
> >>> # CONFIG_UBIFS_FS is not set
> >>> # CONFIG_LOGFS is not set
> >>> CONFIG_ROMFS_FS=y
> >>> CONFIG_ROMFS_BACKED_BY_MTD=y
> >>> CONFIG_ROMFS_ON_MTD=y
> >>> CONFIG_PSTORE=y
> >>> # CONFIG_PSTORE_ZLIB_COMPRESS is not set
> >>> # CONFIG_PSTORE_LZO_COMPRESS is not set
> >>> CONFIG_PSTORE_LZ4_COMPRESS=y
> >>> CONFIG_PSTORE_CONSOLE=y
> >>> # CONFIG_PSTORE_PMSG is not set
> >>> # CONFIG_PSTORE_RAM is not set
> >>> CONFIG_NETWORK_FILESYSTEMS=y
> >>> CONFIG_NLS=y
> >>> CONFIG_NLS_DEFAULT="iso8859-1"
> >>> CONFIG_NLS_CODEPAGE_437=y
> >>> # CONFIG_NLS_CODEPAGE_737 is not set
> >>> CONFIG_NLS_CODEPAGE_775=y
> >>> # CONFIG_NLS_CODEPAGE_850 is not set
> >>> # CONFIG_NLS_CODEPAGE_852 is not set
> >>> CONFIG_NLS_CODEPAGE_855=y
> >>> CONFIG_NLS_CODEPAGE_857=y
> >>> CONFIG_NLS_CODEPAGE_860=y
> >>> CONFIG_NLS_CODEPAGE_861=y
> >>> CONFIG_NLS_CODEPAGE_862=y
> >>> # CONFIG_NLS_CODEPAGE_863 is not set
> >>> CONFIG_NLS_CODEPAGE_864=y
> >>> CONFIG_NLS_CODEPAGE_865=y
> >>> CONFIG_NLS_CODEPAGE_866=y
> >>> CONFIG_NLS_CODEPAGE_869=y
> >>> CONFIG_NLS_CODEPAGE_936=y
> >>> CONFIG_NLS_CODEPAGE_950=y
> >>> CONFIG_NLS_CODEPAGE_932=y
> >>> CONFIG_NLS_CODEPAGE_949=y
> >>> # CONFIG_NLS_CODEPAGE_874 is not set
> >>> CONFIG_NLS_ISO8859_8=y
> >>> CONFIG_NLS_CODEPAGE_1250=y
> >>> CONFIG_NLS_CODEPAGE_1251=y
> >>> CONFIG_NLS_ASCII=y
> >>> CONFIG_NLS_ISO8859_1=y
> >>> CONFIG_NLS_ISO8859_2=y
> >>> # CONFIG_NLS_ISO8859_3 is not set
> >>> CONFIG_NLS_ISO8859_4=y
> >>> # CONFIG_NLS_ISO8859_5 is not set
> >>> CONFIG_NLS_ISO8859_6=y
> >>> CONFIG_NLS_ISO8859_7=y
> >>> CONFIG_NLS_ISO8859_9=y
> >>> CONFIG_NLS_ISO8859_13=y
> >>> # CONFIG_NLS_ISO8859_14 is not set
> >>> CONFIG_NLS_ISO8859_15=y
> >>> CONFIG_NLS_KOI8_R=y
> >>> # CONFIG_NLS_KOI8_U is not set
> >>> CONFIG_NLS_MAC_ROMAN=y
> >>> # CONFIG_NLS_MAC_CELTIC is not set
> >>> # CONFIG_NLS_MAC_CENTEURO is not set
> >>> # CONFIG_NLS_MAC_CROATIAN is not set
> >>> CONFIG_NLS_MAC_CYRILLIC=y
> >>> CONFIG_NLS_MAC_GAELIC=y
> >>> # CONFIG_NLS_MAC_GREEK is not set
> >>> CONFIG_NLS_MAC_ICELAND=y
> >>> CONFIG_NLS_MAC_INUIT=y
> >>> CONFIG_NLS_MAC_ROMANIAN=y
> >>> CONFIG_NLS_MAC_TURKISH=y
> >>> # CONFIG_NLS_UTF8 is not set
> >>> 
> >>> #
> >>> # Kernel hacking
> >>> #
> >>> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> >>> 
> >>> #
> >>> # printk and dmesg options
> >>> #
> >>> CONFIG_PRINTK_TIME=y
> >>> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> >>> # CONFIG_BOOT_PRINTK_DELAY is not set
> >>> # CONFIG_DYNAMIC_DEBUG is not set
> >>> 
> >>> #
> >>> # Compile-time checks and compiler options
> >>> #
> >>> # CONFIG_DEBUG_INFO is not set
> >>> CONFIG_ENABLE_WARN_DEPRECATED=y
> >>> CONFIG_ENABLE_MUST_CHECK=y
> >>> CONFIG_FRAME_WARN=2048
> >>> # CONFIG_STRIP_ASM_SYMS is not set
> >>> CONFIG_READABLE_ASM=y
> >>> CONFIG_UNUSED_SYMBOLS=y
> >>> CONFIG_PAGE_OWNER=y
> >>> CONFIG_DEBUG_FS=y
> >>> CONFIG_HEADERS_CHECK=y
> >>> CONFIG_DEBUG_SECTION_MISMATCH=y
> >>> # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
> >>> CONFIG_ARCH_WANT_FRAME_POINTERS=y
> >>> CONFIG_FRAME_POINTER=y
> >>> CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
> >>> CONFIG_MAGIC_SYSRQ=y
> >>> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> >>> CONFIG_DEBUG_KERNEL=y
> >>> 
> >>> #
> >>> # Memory Debugging
> >>> #
> >>> CONFIG_PAGE_EXTENSION=y
> >>> CONFIG_DEBUG_PAGEALLOC=y
> >>> CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
> >>> # CONFIG_PAGE_POISONING is not set
> >>> # CONFIG_DEBUG_OBJECTS is not set
> >>> # CONFIG_DEBUG_SLAB is not set
> >>> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> >>> # CONFIG_DEBUG_KMEMLEAK is not set
> >>> CONFIG_DEBUG_STACK_USAGE=y
> >>> # CONFIG_DEBUG_VM is not set
> >>> CONFIG_DEBUG_VIRTUAL=y
> >>> CONFIG_DEBUG_MEMORY_INIT=y
> >>> CONFIG_DEBUG_PER_CPU_MAPS=y
> >>> CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
> >>> CONFIG_DEBUG_STACKOVERFLOW=y
> >>> CONFIG_HAVE_ARCH_KMEMCHECK=y
> >>> CONFIG_DEBUG_SHIRQ=y
> >>> 
> >>> #
> >>> # Debug Lockups and Hangs
> >>> #
> >>> CONFIG_LOCKUP_DETECTOR=y
> >>> CONFIG_HARDLOCKUP_DETECTOR=y
> >>> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
> >>> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
> >>> # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> >>> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
> >>> # CONFIG_DETECT_HUNG_TASK is not set
> >>> # CONFIG_WQ_WATCHDOG is not set
> >>> CONFIG_PANIC_ON_OOPS=y
> >>> CONFIG_PANIC_ON_OOPS_VALUE=1
> >>> CONFIG_PANIC_TIMEOUT=0
> >>> CONFIG_SCHED_DEBUG=y
> >>> # CONFIG_SCHED_INFO is not set
> >>> # CONFIG_SCHEDSTATS is not set
> >>> CONFIG_SCHED_STACK_END_CHECK=y
> >>> # CONFIG_DEBUG_TIMEKEEPING is not set
> >>> # CONFIG_TIMER_STATS is not set
> >>> 
> >>> #
> >>> # Lock Debugging (spinlocks, mutexes, etc...)
> >>> #
> >>> # CONFIG_DEBUG_RT_MUTEXES is not set
> >>> CONFIG_DEBUG_SPINLOCK=y
> >>> CONFIG_DEBUG_MUTEXES=y
> >>> CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
> >>> CONFIG_DEBUG_LOCK_ALLOC=y
> >>> # CONFIG_PROVE_LOCKING is not set
> >>> CONFIG_LOCKDEP=y
> >>> CONFIG_LOCK_STAT=y
> >>> CONFIG_DEBUG_LOCKDEP=y
> >>> CONFIG_DEBUG_ATOMIC_SLEEP=y
> >>> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> >>> CONFIG_LOCK_TORTURE_TEST=y
> >>> CONFIG_STACKTRACE=y
> >>> # CONFIG_DEBUG_KOBJECT is not set
> >>> CONFIG_DEBUG_BUGVERBOSE=y
> >>> # CONFIG_DEBUG_LIST is not set
> >>> # CONFIG_DEBUG_PI_LIST is not set
> >>> # CONFIG_DEBUG_SG is not set
> >>> CONFIG_DEBUG_NOTIFIERS=y
> >>> CONFIG_DEBUG_CREDENTIALS=y
> >>> 
> >>> #
> >>> # RCU Debugging
> >>> #
> >>> # CONFIG_PROVE_RCU is not set
> >>> # CONFIG_SPARSE_RCU_POINTER is not set
> >>> CONFIG_TORTURE_TEST=y
> >>> # CONFIG_RCU_PERF_TEST is not set
> >>> CONFIG_RCU_TORTURE_TEST=y
> >>> CONFIG_RCU_TORTURE_TEST_SLOW_PREINIT=y
> >>> CONFIG_RCU_TORTURE_TEST_SLOW_PREINIT_DELAY=3
> >>> CONFIG_RCU_TORTURE_TEST_SLOW_INIT=y
> >>> CONFIG_RCU_TORTURE_TEST_SLOW_INIT_DELAY=3
> >>> CONFIG_RCU_TORTURE_TEST_SLOW_CLEANUP=y
> >>> CONFIG_RCU_TORTURE_TEST_SLOW_CLEANUP_DELAY=3
> >>> CONFIG_RCU_CPU_STALL_TIMEOUT=21
> >>> CONFIG_RCU_TRACE=y
> >>> # CONFIG_RCU_EQS_DEBUG is not set
> >>> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> >>> # CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
> >>> # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> >>> # CONFIG_FAULT_INJECTION is not set
> >>> # CONFIG_LATENCYTOP is not set
> >>> CONFIG_ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS=y
> >>> # CONFIG_DEBUG_STRICT_USER_COPY_CHECKS is not set
> >>> CONFIG_USER_STACKTRACE_SUPPORT=y
> >>> CONFIG_HAVE_FUNCTION_TRACER=y
> >>> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> >>> CONFIG_HAVE_FUNCTION_GRAPH_FP_TEST=y
> >>> CONFIG_HAVE_DYNAMIC_FTRACE=y
> >>> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> >>> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> >>> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> >>> CONFIG_HAVE_C_RECORDMCOUNT=y
> >>> CONFIG_TRACE_CLOCK=y
> >>> CONFIG_TRACING_SUPPORT=y
> >>> # CONFIG_FTRACE is not set
> >>> 
> >>> #
> >>> # Runtime Testing
> >>> #
> >>> # CONFIG_TEST_LIST_SORT is not set
> >>> # CONFIG_BACKTRACE_SELF_TEST is not set
> >>> CONFIG_RBTREE_TEST=y
> >>> # CONFIG_ATOMIC64_SELFTEST is not set
> >>> CONFIG_TEST_HEXDUMP=y
> >>> CONFIG_TEST_STRING_HELPERS=y
> >>> # CONFIG_TEST_KSTRTOX is not set
> >>> CONFIG_TEST_PRINTF=y
> >>> CONFIG_TEST_BITMAP=y
> >>> CONFIG_TEST_UUID=y
> >>> CONFIG_TEST_RHASHTABLE=y
> >>> # CONFIG_TEST_HASH is not set
> >>> # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
> >>> CONFIG_BUILD_DOCSRC=y
> >>> # CONFIG_DMA_API_DEBUG is not set
> >>> CONFIG_TEST_FIRMWARE=y
> >>> # CONFIG_TEST_UDELAY is not set
> >>> CONFIG_MEMTEST=y
> >>> # CONFIG_SAMPLES is not set
> >>> CONFIG_HAVE_ARCH_KGDB=y
> >>> # CONFIG_KGDB is not set
> >>> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> >>> # CONFIG_UBSAN is not set
> >>> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> >>> CONFIG_STRICT_DEVMEM=y
> >>> CONFIG_IO_STRICT_DEVMEM=y
> >>> CONFIG_X86_VERBOSE_BOOTUP=y
> >>> # CONFIG_EARLY_PRINTK is not set
> >>> CONFIG_X86_PTDUMP_CORE=y
> >>> CONFIG_X86_PTDUMP=y
> >>> # CONFIG_DEBUG_RODATA_TEST is not set
> >>> # CONFIG_DEBUG_WX is not set
> >>> # CONFIG_DOUBLEFAULT is not set
> >>> # CONFIG_DEBUG_TLBFLUSH is not set
> >>> # CONFIG_IOMMU_STRESS is not set
> >>> CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> >>> CONFIG_IO_DELAY_TYPE_0X80=0
> >>> CONFIG_IO_DELAY_TYPE_0XED=1
> >>> CONFIG_IO_DELAY_TYPE_UDELAY=2
> >>> CONFIG_IO_DELAY_TYPE_NONE=3
> >>> # CONFIG_IO_DELAY_0X80 is not set
> >>> CONFIG_IO_DELAY_0XED=y
> >>> # CONFIG_IO_DELAY_UDELAY is not set
> >>> # CONFIG_IO_DELAY_NONE is not set
> >>> CONFIG_DEFAULT_IO_DELAY_TYPE=1
> >>> # CONFIG_DEBUG_BOOT_PARAMS is not set
> >>> # CONFIG_CPA_DEBUG is not set
> >>> # CONFIG_OPTIMIZE_INLINING is not set
> >>> CONFIG_DEBUG_ENTRY=y
> >>> # CONFIG_DEBUG_NMI_SELFTEST is not set
> >>> # CONFIG_X86_DEBUG_FPU is not set
> >>> CONFIG_PUNIT_ATOM_DEBUG=y
> >>> 
> >>> #
> >>> # Security options
> >>> #
> >>> # CONFIG_KEYS is not set
> >>> CONFIG_SECURITY_DMESG_RESTRICT=y
> >>> CONFIG_SECURITY=y
> >>> # CONFIG_SECURITYFS is not set
> >>> # CONFIG_SECURITY_NETWORK is not set
> >>> CONFIG_SECURITY_PATH=y
> >>> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> >>> CONFIG_HAVE_ARCH_HARDENED_USERCOPY=y
> >>> # CONFIG_HARDENED_USERCOPY is not set
> >>> # CONFIG_SECURITY_TOMOYO is not set
> >>> # CONFIG_SECURITY_APPARMOR is not set
> >>> # CONFIG_SECURITY_YAMA is not set
> >>> CONFIG_INTEGRITY=y
> >>> # CONFIG_IMA is not set
> >>> # CONFIG_EVM is not set
> >>> CONFIG_DEFAULT_SECURITY_DAC=y
> >>> CONFIG_DEFAULT_SECURITY=""
> >>> CONFIG_CRYPTO=y
> >>> 
> >>> #
> >>> # Crypto core or helper
> >>> #
> >>> CONFIG_CRYPTO_ALGAPI=y
> >>> CONFIG_CRYPTO_ALGAPI2=y
> >>> CONFIG_CRYPTO_AEAD=y
> >>> CONFIG_CRYPTO_AEAD2=y
> >>> CONFIG_CRYPTO_BLKCIPHER=y
> >>> CONFIG_CRYPTO_BLKCIPHER2=y
> >>> CONFIG_CRYPTO_HASH=y
> >>> CONFIG_CRYPTO_HASH2=y
> >>> CONFIG_CRYPTO_RNG=y
> >>> CONFIG_CRYPTO_RNG2=y
> >>> CONFIG_CRYPTO_RNG_DEFAULT=y
> >>> CONFIG_CRYPTO_AKCIPHER2=y
> >>> CONFIG_CRYPTO_KPP2=y
> >>> # CONFIG_CRYPTO_RSA is not set
> >>> # CONFIG_CRYPTO_DH is not set
> >>> CONFIG_CRYPTO_ECDH=y
> >>> CONFIG_CRYPTO_MANAGER=y
> >>> CONFIG_CRYPTO_MANAGER2=y
> >>> # CONFIG_CRYPTO_USER is not set
> >>> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> >>> CONFIG_CRYPTO_GF128MUL=y
> >>> CONFIG_CRYPTO_NULL=y
> >>> CONFIG_CRYPTO_NULL2=y
> >>> CONFIG_CRYPTO_PCRYPT=y
> >>> CONFIG_CRYPTO_WORKQUEUE=y
> >>> CONFIG_CRYPTO_CRYPTD=y
> >>> # CONFIG_CRYPTO_MCRYPTD is not set
> >>> CONFIG_CRYPTO_AUTHENC=y
> >>> CONFIG_CRYPTO_ABLK_HELPER=y
> >>> CONFIG_CRYPTO_GLUE_HELPER_X86=y
> >>> 
> >>> #
> >>> # Authenticated Encryption with Associated Data
> >>> #
> >>> CONFIG_CRYPTO_CCM=y
> >>> CONFIG_CRYPTO_GCM=y
> >>> CONFIG_CRYPTO_CHACHA20POLY1305=y
> >>> CONFIG_CRYPTO_SEQIV=y
> >>> CONFIG_CRYPTO_ECHAINIV=y
> >>> 
> >>> #
> >>> # Block modes
> >>> #
> >>> CONFIG_CRYPTO_CBC=y
> >>> CONFIG_CRYPTO_CTR=y
> >>> CONFIG_CRYPTO_CTS=y
> >>> # CONFIG_CRYPTO_ECB is not set
> >>> CONFIG_CRYPTO_LRW=y
> >>> # CONFIG_CRYPTO_PCBC is not set
> >>> CONFIG_CRYPTO_XTS=y
> >>> CONFIG_CRYPTO_KEYWRAP=y
> >>> 
> >>> #
> >>> # Hash modes
> >>> #
> >>> CONFIG_CRYPTO_CMAC=y
> >>> CONFIG_CRYPTO_HMAC=y
> >>> # CONFIG_CRYPTO_XCBC is not set
> >>> CONFIG_CRYPTO_VMAC=y
> >>> 
> >>> #
> >>> # Digest
> >>> #
> >>> # CONFIG_CRYPTO_CRC32C is not set
> >>> CONFIG_CRYPTO_CRC32C_INTEL=y
> >>> CONFIG_CRYPTO_CRC32=y
> >>> CONFIG_CRYPTO_CRC32_PCLMUL=y
> >>> CONFIG_CRYPTO_CRCT10DIF=y
> >>> CONFIG_CRYPTO_GHASH=y
> >>> CONFIG_CRYPTO_POLY1305=y
> >>> CONFIG_CRYPTO_MD4=y
> >>> # CONFIG_CRYPTO_MD5 is not set
> >>> CONFIG_CRYPTO_MICHAEL_MIC=y
> >>> CONFIG_CRYPTO_RMD128=y
> >>> # CONFIG_CRYPTO_RMD160 is not set
> >>> # CONFIG_CRYPTO_RMD256 is not set
> >>> CONFIG_CRYPTO_RMD320=y
> >>> CONFIG_CRYPTO_SHA1=y
> >>> CONFIG_CRYPTO_SHA256=y
> >>> CONFIG_CRYPTO_SHA512=y
> >>> CONFIG_CRYPTO_SHA3=y
> >>> # CONFIG_CRYPTO_TGR192 is not set
> >>> CONFIG_CRYPTO_WP512=y
> >>> 
> >>> #
> >>> # Ciphers
> >>> #
> >>> CONFIG_CRYPTO_AES=y
> >>> CONFIG_CRYPTO_AES_586=y
> >>> # CONFIG_CRYPTO_AES_NI_INTEL is not set
> >>> # CONFIG_CRYPTO_ANUBIS is not set
> >>> # CONFIG_CRYPTO_ARC4 is not set
> >>> CONFIG_CRYPTO_BLOWFISH=y
> >>> CONFIG_CRYPTO_BLOWFISH_COMMON=y
> >>> CONFIG_CRYPTO_CAMELLIA=y
> >>> CONFIG_CRYPTO_CAST_COMMON=y
> >>> CONFIG_CRYPTO_CAST5=y
> >>> CONFIG_CRYPTO_CAST6=y
> >>> CONFIG_CRYPTO_DES=y
> >>> CONFIG_CRYPTO_FCRYPT=y
> >>> CONFIG_CRYPTO_KHAZAD=y
> >>> CONFIG_CRYPTO_SALSA20=y
> >>> CONFIG_CRYPTO_SALSA20_586=y
> >>> CONFIG_CRYPTO_CHACHA20=y
> >>> # CONFIG_CRYPTO_SEED is not set
> >>> CONFIG_CRYPTO_SERPENT=y
> >>> CONFIG_CRYPTO_SERPENT_SSE2_586=y
> >>> CONFIG_CRYPTO_TEA=y
> >>> CONFIG_CRYPTO_TWOFISH=y
> >>> CONFIG_CRYPTO_TWOFISH_COMMON=y
> >>> CONFIG_CRYPTO_TWOFISH_586=y
> >>> 
> >>> #
> >>> # Compression
> >>> #
> >>> CONFIG_CRYPTO_DEFLATE=y
> >>> CONFIG_CRYPTO_LZO=y
> >>> # CONFIG_CRYPTO_842 is not set
> >>> # CONFIG_CRYPTO_LZ4 is not set
> >>> # CONFIG_CRYPTO_LZ4HC is not set
> >>> 
> >>> #
> >>> # Random Number Generation
> >>> #
> >>> # CONFIG_CRYPTO_ANSI_CPRNG is not set
> >>> CONFIG_CRYPTO_DRBG_MENU=y
> >>> CONFIG_CRYPTO_DRBG_HMAC=y
> >>> CONFIG_CRYPTO_DRBG_HASH=y
> >>> # CONFIG_CRYPTO_DRBG_CTR is not set
> >>> CONFIG_CRYPTO_DRBG=y
> >>> CONFIG_CRYPTO_JITTERENTROPY=y
> >>> # CONFIG_CRYPTO_USER_API_HASH is not set
> >>> # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
> >>> # CONFIG_CRYPTO_USER_API_RNG is not set
> >>> # CONFIG_CRYPTO_USER_API_AEAD is not set
> >>> # CONFIG_CRYPTO_HW is not set
> >>> 
> >>> #
> >>> # Certificates for signature checking
> >>> #
> >>> CONFIG_HAVE_KVM=y
> >>> # CONFIG_VIRTUALIZATION is not set
> >>> # CONFIG_BINARY_PRINTF is not set
> >>> 
> >>> #
> >>> # Library routines
> >>> #
> >>> CONFIG_BITREVERSE=y
> >>> # CONFIG_HAVE_ARCH_BITREVERSE is not set
> >>> CONFIG_RATIONAL=y
> >>> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> >>> CONFIG_GENERIC_STRNLEN_USER=y
> >>> CONFIG_GENERIC_NET_UTILS=y
> >>> CONFIG_GENERIC_FIND_FIRST_BIT=y
> >>> CONFIG_GENERIC_PCI_IOMAP=y
> >>> CONFIG_GENERIC_IOMAP=y
> >>> CONFIG_GENERIC_IO=y
> >>> CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> >>> CONFIG_CRC_CCITT=y
> >>> CONFIG_CRC16=y
> >>> CONFIG_CRC_T10DIF=y
> >>> CONFIG_CRC_ITU_T=y
> >>> CONFIG_CRC32=y
> >>> CONFIG_CRC32_SELFTEST=y
> >>> CONFIG_CRC32_SLICEBY8=y
> >>> # CONFIG_CRC32_SLICEBY4 is not set
> >>> # CONFIG_CRC32_SARWATE is not set
> >>> # CONFIG_CRC32_BIT is not set
> >>> # CONFIG_CRC7 is not set
> >>> # CONFIG_LIBCRC32C is not set
> >>> CONFIG_CRC8=y
> >>> # CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
> >>> CONFIG_RANDOM32_SELFTEST=y
> >>> CONFIG_ZLIB_INFLATE=y
> >>> CONFIG_ZLIB_DEFLATE=y
> >>> CONFIG_LZO_COMPRESS=y
> >>> CONFIG_LZO_DECOMPRESS=y
> >>> CONFIG_LZ4_COMPRESS=y
> >>> CONFIG_LZ4_DECOMPRESS=y
> >>> CONFIG_XZ_DEC=y
> >>> # CONFIG_XZ_DEC_X86 is not set
> >>> CONFIG_XZ_DEC_POWERPC=y
> >>> # CONFIG_XZ_DEC_IA64 is not set
> >>> # CONFIG_XZ_DEC_ARM is not set
> >>> # CONFIG_XZ_DEC_ARMTHUMB is not set
> >>> CONFIG_XZ_DEC_SPARC=y
> >>> CONFIG_XZ_DEC_BCJ=y
> >>> CONFIG_XZ_DEC_TEST=y
> >>> CONFIG_DECOMPRESS_GZIP=y
> >>> CONFIG_DECOMPRESS_BZIP2=y
> >>> CONFIG_DECOMPRESS_LZMA=y
> >>> CONFIG_DECOMPRESS_LZO=y
> >>> CONFIG_GENERIC_ALLOCATOR=y
> >>> CONFIG_REED_SOLOMON=y
> >>> CONFIG_REED_SOLOMON_DEC16=y
> >>> CONFIG_BCH=y
> >>> CONFIG_BCH_CONST_PARAMS=y
> >>> CONFIG_RADIX_TREE_MULTIORDER=y
> >>> CONFIG_HAS_IOMEM=y
> >>> CONFIG_HAS_IOPORT_MAP=y
> >>> CONFIG_HAS_DMA=y
> >>> CONFIG_CHECK_SIGNATURE=y
> >>> # CONFIG_CPUMASK_OFFSTACK is not set
> >>> CONFIG_CPU_RMAP=y
> >>> CONFIG_DQL=y
> >>> CONFIG_NLATTR=y
> >>> CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE=y
> >>> # CONFIG_CORDIC is not set
> >>> # CONFIG_DDR is not set
> >>> # CONFIG_IRQ_POLL is not set
> >>> CONFIG_LIBFDT=y
> >>> # CONFIG_SG_SPLIT is not set
> >>> # CONFIG_SG_POOL is not set
> >>> CONFIG_ARCH_HAS_SG_CHAIN=y
> >>> CONFIG_ARCH_HAS_MMIO_FLUSH=y
> >>> CONFIG_STACKDEPOT=y
> >>
> >>
> >>-- 
> >>
> >>Best Regards,
> >>Peter Chen
> >_______________________________________________
> >LKP mailing list
> >LKP@lists.01.org
> >https://lists.01.org/mailman/listinfo/lkp

-- 

Best Regards,
Peter Chen
