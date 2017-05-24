From: kbuild test robot <fengguang.wu@intel.com>
Subject: [wsa:i2c/core-refactor 2/8] include/linux/compiler.h:163:17:
 warning: 'attach_adapter' is deprecated
Date: Wed, 24 May 2017 22:25:51 +0800
Message-ID: <201705242245.Z4Hm0I2U%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40652 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967538AbdEXO0I (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 24 May 2017 10:26:08 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: kbuild-all@01.org, linux-i2c@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/core-refactor
head:   4b14c21a1ad171ce9af12e6e3996b52837932d3a
commit: b922c0825dbb96b2a12e64a7768ae452c7bb79a6 [2/8] i2c: WIP refactor core
config: x86_64-randconfig-x012-201721 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout b922c0825dbb96b2a12e64a7768ae452c7bb79a6
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers//i2c/i2c-core-base.c: In function 'i2c_do_add_adapter':
   drivers//i2c/i2c-core-base.c:1978:2: warning: 'attach_adapter' is deprecated [-Wdeprecated-declarations]
     if (driver->attach_adapter) {
     ^~
   In file included from drivers//i2c/i2c-core-base.c:42:0:
   include/linux/i2c.h:181:8: note: declared here
     int (*attach_adapter)(struct i2c_adapter *) __deprecated;
           ^~~~~~~~~~~~~~
   drivers//i2c/i2c-core-base.c:1978:2: warning: 'attach_adapter' is deprecated [-Wdeprecated-declarations]
     if (driver->attach_adapter) {
     ^~
   In file included from drivers//i2c/i2c-core-base.c:42:0:
   include/linux/i2c.h:181:8: note: declared here
     int (*attach_adapter)(struct i2c_adapter *) __deprecated;
           ^~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/current.h:4:0,
                    from include/linux/sched.h:11,
                    from include/linux/uaccess.h:4,
                    from drivers//i2c/i2c-core-base.c:33:
>> include/linux/compiler.h:163:17: warning: 'attach_adapter' is deprecated [-Wdeprecated-declarations]
      static struct ftrace_branch_data   \
                    ^
   include/linux/compiler.h:158:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
>> drivers//i2c/i2c-core-base.c:1978:2: note: in expansion of macro 'if'
     if (driver->attach_adapter) {
     ^~
   In file included from drivers//i2c/i2c-core-base.c:42:0:
   include/linux/i2c.h:181:8: note: declared here
     int (*attach_adapter)(struct i2c_adapter *) __deprecated;
           ^~~~~~~~~~~~~~
   drivers//i2c/i2c-core-base.c:1984:3: warning: 'attach_adapter' is deprecated [-Wdeprecated-declarations]
      driver->attach_adapter(adap);
      ^~~~~~
   In file included from drivers//i2c/i2c-core-base.c:42:0:
   include/linux/i2c.h:181:8: note: declared here
     int (*attach_adapter)(struct i2c_adapter *) __deprecated;
           ^~~~~~~~~~~~~~
--
   drivers/i2c/i2c-core-base.c: In function 'i2c_do_add_adapter':
   drivers/i2c/i2c-core-base.c:1978:2: warning: 'attach_adapter' is deprecated [-Wdeprecated-declarations]
     if (driver->attach_adapter) {
     ^~
   In file included from drivers/i2c/i2c-core-base.c:42:0:
   include/linux/i2c.h:181:8: note: declared here
     int (*attach_adapter)(struct i2c_adapter *) __deprecated;
           ^~~~~~~~~~~~~~
   drivers/i2c/i2c-core-base.c:1978:2: warning: 'attach_adapter' is deprecated [-Wdeprecated-declarations]
     if (driver->attach_adapter) {
     ^~
   In file included from drivers/i2c/i2c-core-base.c:42:0:
   include/linux/i2c.h:181:8: note: declared here
     int (*attach_adapter)(struct i2c_adapter *) __deprecated;
           ^~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/current.h:4:0,
                    from include/linux/sched.h:11,
                    from include/linux/uaccess.h:4,
                    from drivers/i2c/i2c-core-base.c:33:
>> include/linux/compiler.h:163:17: warning: 'attach_adapter' is deprecated [-Wdeprecated-declarations]
      static struct ftrace_branch_data   \
                    ^
   include/linux/compiler.h:158:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   drivers/i2c/i2c-core-base.c:1978:2: note: in expansion of macro 'if'
     if (driver->attach_adapter) {
     ^~
   In file included from drivers/i2c/i2c-core-base.c:42:0:
   include/linux/i2c.h:181:8: note: declared here
     int (*attach_adapter)(struct i2c_adapter *) __deprecated;
           ^~~~~~~~~~~~~~
   drivers/i2c/i2c-core-base.c:1984:3: warning: 'attach_adapter' is deprecated [-Wdeprecated-declarations]
      driver->attach_adapter(adap);
      ^~~~~~
   In file included from drivers/i2c/i2c-core-base.c:42:0:
   include/linux/i2c.h:181:8: note: declared here
     int (*attach_adapter)(struct i2c_adapter *) __deprecated;
           ^~~~~~~~~~~~~~

vim +/attach_adapter +163 include/linux/compiler.h

d45ae1f7 Steven Rostedt (VMware  2017-01-17  147) #  define likely(x)	(__branch_check__(x, 1, __builtin_constant_p(x)))
1f0d69a9 Steven Rostedt          2008-11-12  148  # endif
1f0d69a9 Steven Rostedt          2008-11-12  149  # ifndef unlikely
d45ae1f7 Steven Rostedt (VMware  2017-01-17  150) #  define unlikely(x)	(__branch_check__(x, 0, __builtin_constant_p(x)))
1f0d69a9 Steven Rostedt          2008-11-12  151  # endif
2bcd521a Steven Rostedt          2008-11-21  152  
2bcd521a Steven Rostedt          2008-11-21  153  #ifdef CONFIG_PROFILE_ALL_BRANCHES
2bcd521a Steven Rostedt          2008-11-21  154  /*
2bcd521a Steven Rostedt          2008-11-21  155   * "Define 'is'", Bill Clinton
2bcd521a Steven Rostedt          2008-11-21  156   * "Define 'if'", Steven Rostedt
2bcd521a Steven Rostedt          2008-11-21  157   */
ab3c9c68 Linus Torvalds          2009-04-07  158  #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
ab3c9c68 Linus Torvalds          2009-04-07  159  #define __trace_if(cond) \
b33c8ff4 Arnd Bergmann           2016-02-12  160  	if (__builtin_constant_p(!!(cond)) ? !!(cond) :			\
2bcd521a Steven Rostedt          2008-11-21  161  	({								\
2bcd521a Steven Rostedt          2008-11-21  162  		int ______r;						\
2bcd521a Steven Rostedt          2008-11-21 @163  		static struct ftrace_branch_data			\
2bcd521a Steven Rostedt          2008-11-21  164  			__attribute__((__aligned__(4)))			\
2bcd521a Steven Rostedt          2008-11-21  165  			__attribute__((section("_ftrace_branch")))	\
2bcd521a Steven Rostedt          2008-11-21  166  			______f = {					\
2bcd521a Steven Rostedt          2008-11-21  167  				.func = __func__,			\
2bcd521a Steven Rostedt          2008-11-21  168  				.file = __FILE__,			\
2bcd521a Steven Rostedt          2008-11-21  169  				.line = __LINE__,			\
2bcd521a Steven Rostedt          2008-11-21  170  			};						\
2bcd521a Steven Rostedt          2008-11-21  171  		______r = !!(cond);					\

:::::: The code at line 163 was first introduced by commit
:::::: 2bcd521a684cc94befbe2ce7d5b613c841b0d304 trace: profile all if conditionals

:::::: TO: Steven Rostedt <srostedt@redhat.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--PEIAKu/WMn1b1Hv9
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--PEIAKu/WMn1b1Hv9--
