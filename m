From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] rtmutex: allow specifying a subclass for nested
 locking
Date: Sat, 26 May 2018 17:26:55 +0800
Message-ID: <201805261718.qrBlBpkP%fengguang.wu@intel.com>
References: <20180524073255.22495-2-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180524073255.22495-2-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Davidlohr Bueso <dave@stgolabs.net>, linux-i2c@vger.kernel.org, Peter Chang <dpf@google.com>, Deepa Dinamani <deepadinamani@google.com>, John Sperbeck <jsperbeck@google.com>
List-Id: linux-i2c@vger.kernel.org

Hi Peter,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.17-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Peter-Rosin/rtmutex-allow-specifying-a-subclass-for-nested-locking/20180526-140421
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   kernel/locking/locktorture.c:444:9: sparse: undefined identifier 'rt_mutex_lock'
   kernel/locking/locktorture.c:586:6: sparse: symbol 'torture_percpu_rwsem_init' was not declared. Should it be static?
   kernel/locking/locktorture.c:331:12: sparse: context imbalance in 'torture_mutex_lock' - wrong count at exit
   kernel/locking/locktorture.c:351:13: sparse: context imbalance in 'torture_mutex_unlock' - wrong count at exit
   kernel/locking/locktorture.c:373:12: sparse: context imbalance in 'torture_ww_mutex_lock' - wrong count at exit
   kernel/locking/locktorture.c:418:13: sparse: context imbalance in 'torture_ww_mutex_unlock' - wrong count at exit
>> kernel/locking/locktorture.c:444:22: sparse: call with no type!
   kernel/locking/locktorture.c:442:12: sparse: context imbalance in 'torture_rtmutex_lock' - wrong count at exit
   kernel/locking/locktorture.c:504:13: sparse: context imbalance in 'torture_rtmutex_unlock' - wrong count at exit
   kernel/locking/locktorture.c:522:12: sparse: context imbalance in 'torture_rwsem_down_write' - wrong count at exit
   kernel/locking/locktorture.c:542:13: sparse: context imbalance in 'torture_rwsem_up_write' - wrong count at exit
   kernel/locking/locktorture.c:547:12: sparse: context imbalance in 'torture_rwsem_down_read' - wrong count at exit
   kernel/locking/locktorture.c:567:13: sparse: context imbalance in 'torture_rwsem_up_read' - wrong count at exit
   kernel/locking/locktorture.c:591:12: sparse: context imbalance in 'torture_percpu_rwsem_down_write' - wrong count at exit
   kernel/locking/locktorture.c:597:13: sparse: context imbalance in 'torture_percpu_rwsem_up_write' - wrong count at exit
   include/linux/percpu-rwsem.h:50:9: sparse: context imbalance in 'torture_percpu_rwsem_down_read' - wrong count at exit
   include/linux/percpu-rwsem.h:100:9: sparse: context imbalance in 'torture_percpu_rwsem_up_read' - wrong count at exit
   kernel/locking/locktorture.c: In function 'torture_rtmutex_lock':
   kernel/locking/locktorture.c:444:2: error: implicit declaration of function 'rt_mutex_lock'; did you mean 'ww_mutex_lock'? [-Werror=implicit-function-declaration]
     rt_mutex_lock(&torture_rtmutex);
     ^~~~~~~~~~~~~
     ww_mutex_lock
   cc1: some warnings being treated as errors
--
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_compat_css20.c:4225:9: sparse: undefined identifier 'rt_mutex_lock'
>> drivers/staging/media/atomisp/pci/atomisp2/atomisp_compat_css20.c:4225:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_compat_css20.c: In function 'atomisp_css_wait_acc_finish':
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_compat_css20.c:4225:2: error: implicit declaration of function 'rt_mutex_lock'; did you mean 'rt_mutex_unlock'? [-Werror=implicit-function-declaration]
     rt_mutex_lock(&isp->mutex);
     ^~~~~~~~~~~~~
     rt_mutex_unlock
   cc1: some warnings being treated as errors
--
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_fops.c:774:9: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_fops.c:910:9: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_fops.c:1174:9: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_fops.c:1265:9: sparse: undefined identifier 'rt_mutex_lock'
>> drivers/staging/media/atomisp/pci/atomisp2/atomisp_fops.c:774:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_fops.c:910:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_fops.c:1174:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_fops.c:1265:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_fops.c: In function 'atomisp_open':
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_fops.c:774:2: error: implicit declaration of function 'rt_mutex_lock'; did you mean 'rt_mutex_unlock'? [-Werror=implicit-function-declaration]
     rt_mutex_lock(&isp->mutex);
     ^~~~~~~~~~~~~
     rt_mutex_unlock
   cc1: some warnings being treated as errors
--
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:663:9: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:680:9: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:781:9: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:829:9: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:842:9: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:857:9: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:870:9: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:888:9: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:1109:9: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:1171:9: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:1302:9: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:1377:9: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:1439:9: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:1460:9: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:1696:9: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:1757:33: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:2036:17: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:2182:9: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:2213:9: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:2292:9: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:2466:25: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:2577:25: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:2593:25: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:2655:9: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:2677:9: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:2735:9: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:2775:17: sparse: undefined identifier 'rt_mutex_lock'
>> drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:663:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:680:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:781:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:829:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:842:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:857:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:870:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:888:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:1109:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:1171:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:1302:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:1377:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:1439:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:1460:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:1696:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:1757:46: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:2036:30: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:2182:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:2213:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:2292:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:2466:38: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:2577:38: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:2593:38: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:2655:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:2677:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:2735:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:2775:30: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c: In function 'atomisp_g_input':
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:663:2: error: implicit declaration of function 'rt_mutex_lock'; did you mean 'rt_mutex_unlock'? [-Werror=implicit-function-declaration]
     rt_mutex_lock(&isp->mutex);
     ^~~~~~~~~~~~~
     rt_mutex_unlock
   cc1: some warnings being treated as errors
--
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:1466:9: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:1891:9: sparse: undefined identifier 'rt_mutex_lock'
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:3302:43: sparse: incorrect type in argument 2 (different address spaces) @@    expected void const [noderef] <asn:1>*from @@    got ef] <asn:1>*from @@
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:3302:43:    expected void const [noderef] <asn:1>*from
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:3302:43:    got void const *from
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4070:58: sparse: incorrect type in argument 2 (different address spaces) @@    expected void const *from @@    got unsigned short [nodervoid const *from @@
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4070:58:    expected void const *from
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4070:58:    got unsigned short [noderef] <asn:1>*<noident>
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4082:58: sparse: incorrect type in argument 2 (different address spaces) @@    expected void const *from @@    got unsigned short [nodervoid const *from @@
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4082:58:    expected void const *from
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4082:58:    got unsigned short [noderef] <asn:1>*<noident>
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4827:35: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4827:35: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4986:28: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4986:28: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4986:28: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4986:28: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4986:28: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4986:28: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4986:28: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4986:28: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4986:28: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4986:28: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4986:28: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4986:28: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4986:28: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4986:28: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4989:29: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4989:29: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4989:29: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4989:29: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4989:29: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4989:29: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4989:29: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4989:29: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4989:29: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4989:29: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4989:29: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4989:29: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4989:29: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:4989:29: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5020:28: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5020:28: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5020:28: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5020:28: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5020:28: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5020:28: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5020:28: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5023:29: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5023:29: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5023:29: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5023:29: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5023:29: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5023:29: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5023:29: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5875:36: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5875:36: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5875:36: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5875:36: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5875:36: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5875:36: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5875:36: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5875:36: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5875:36: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5875:36: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5875:36: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5875:36: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5875:36: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5875:36: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5879:37: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5879:37: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5879:37: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5879:37: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5879:37: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5879:37: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5879:37: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5879:37: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5879:37: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5879:37: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5879:37: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5879:37: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5879:37: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5879:37: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5967:33: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5967:33: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5970:33: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:5970:33: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:6179:62: sparse: incorrect type in argument 2 (different address spaces) @@    expected void const [noderef] <asn:1>*from @@    got id const [noderef] <asn:1>*from @@
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:6179:62:    expected void const [noderef] <asn:1>*from
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:6179:62:    got unsigned short [usertype] *<noident>
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:6327:33: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:6327:33: sparse: expression using sizeof(void)
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:6332:33: sparse: expression using sizeof(void)
>> drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:1466:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:1891:22: sparse: call with no type!
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c: In function 'atomisp_wdt_work':
   drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c:1466:2: error: implicit declaration of function 'rt_mutex_lock'; did you mean 'rt_mutex_unlock'? [-Werror=implicit-function-declaration]
     rt_mutex_lock(&isp->mutex);
     ^~~~~~~~~~~~~
     rt_mutex_unlock
   cc1: some warnings being treated as errors

vim +444 kernel/locking/locktorture.c

095777c4 Davidlohr Bueso 2015-07-22  441  
095777c4 Davidlohr Bueso 2015-07-22  442  static int torture_rtmutex_lock(void) __acquires(torture_rtmutex)
095777c4 Davidlohr Bueso 2015-07-22  443  {
095777c4 Davidlohr Bueso 2015-07-22 @444  	rt_mutex_lock(&torture_rtmutex);
095777c4 Davidlohr Bueso 2015-07-22  445  	return 0;
095777c4 Davidlohr Bueso 2015-07-22  446  }
095777c4 Davidlohr Bueso 2015-07-22  447  

:::::: The code at line 444 was first introduced by commit
:::::: 095777c417db142970adeb776fa0cb10810b8122 locktorture: Support rtmutex torturing

:::::: TO: Davidlohr Bueso <dave@stgolabs.net>
:::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
