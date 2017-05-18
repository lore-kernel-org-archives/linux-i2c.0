From: kbuild test robot <fengguang.wu@intel.com>
Subject: [wsa:i2c/platform_data 24/27]
 drivers/i2c/busses/i2c-bfin-twi.c:38:46: error: passing argument 1 of
 'read_MASTER_STAT' from incompatible pointer type
Date: Thu, 18 May 2017 10:50:48 +0800
Message-ID: <201705181043.ZXz4lrw7%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:22819 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753868AbdERCvm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 17 May 2017 22:51:42 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: kbuild-all@01.org, linux-i2c@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/platform_data
head:   1c80c28c2b11b07c767d4d2694fbee14e498758d
commit: f49a5f5f913d556f74f9d5f787c195c4c9ac1ce6 [24/27] i2c: bfin_twi: merge the two header files
config: blackfin-BF526-EZBRD_defconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout f49a5f5f913d556f74f9d5f787c195c4c9ac1ce6
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

All errors (new ones prefixed by >>):

   arch/blackfin/include/asm/bfin_twi.h:36:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(RCV_DATA16, rcv_data16)
    ^~~~~~~~~~~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h: At top level:
   arch/blackfin/include/asm/bfin_twi.h:63:40: warning: 'struct bfin_twi_iface' declared inside parameter list will not be visible outside of this definition or declaration
    static inline u16 read_FIFO_CTL(struct bfin_twi_iface *iface)
                                           ^~~~~~~~~~~~~~
   In file included from arch/blackfin/mach-bf527/include/mach/blackfin.h:13:0,
                    from arch/blackfin/include/asm/irqflags.h:11,
                    from include/linux/irqflags.h:15,
                    from arch/blackfin/include/asm/bitops.h:33,
                    from include/linux/bitops.h:36,
                    from include/linux/kernel.h:10,
                    from include/linux/list.h:8,
                    from include/linux/module.h:9,
                    from drivers/i2c/busses/i2c-bfin-twi.c:11:
   arch/blackfin/include/asm/bfin_twi.h: In function 'read_FIFO_CTL':
   arch/blackfin/include/asm/bfin_twi.h:65:27: error: dereferencing pointer to incomplete type 'struct bfin_twi_iface'
     return bfin_read16(&iface->regs_base->fifo_ctl);
                              ^
   arch/blackfin/include/asm/def_LPBlackfin.h:34:10: note: in definition of macro '_bfin_readX'
      : "a" (addr) \
             ^~~~
   arch/blackfin/include/asm/bfin_twi.h:65:9: note: in expansion of macro 'bfin_read16'
     return bfin_read16(&iface->regs_base->fifo_ctl);
            ^~~~~~~~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h: At top level:
   arch/blackfin/include/asm/bfin_twi.h:68:42: warning: 'struct bfin_twi_iface' declared inside parameter list will not be visible outside of this definition or declaration
    static inline void write_FIFO_CTL(struct bfin_twi_iface *iface, u16 v)
                                             ^~~~~~~~~~~~~~
   In file included from arch/blackfin/mach-bf527/include/mach/blackfin.h:13:0,
                    from arch/blackfin/include/asm/irqflags.h:11,
                    from include/linux/irqflags.h:15,
                    from arch/blackfin/include/asm/bitops.h:33,
                    from include/linux/bitops.h:36,
                    from include/linux/kernel.h:10,
                    from include/linux/list.h:8,
                    from include/linux/module.h:9,
                    from drivers/i2c/busses/i2c-bfin-twi.c:11:
   arch/blackfin/include/asm/bfin_twi.h: In function 'write_FIFO_CTL':
   arch/blackfin/include/asm/bfin_twi.h:70:21: error: dereferencing pointer to incomplete type 'struct bfin_twi_iface'
     bfin_write16(&iface->regs_base->fifo_ctl, v);
                        ^
   arch/blackfin/include/asm/def_LPBlackfin.h:42:10: note: in definition of macro '_bfin_writeX'
      : "a" (addr), "d" ((u##size)(val)) \
             ^~~~
   arch/blackfin/include/asm/bfin_twi.h:70:2: note: in expansion of macro 'bfin_write16'
     bfin_write16(&iface->regs_base->fifo_ctl, v);
     ^~~~~~~~~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h: At top level:
   arch/blackfin/include/asm/bfin_twi.h:74:39: warning: 'struct bfin_twi_iface' declared inside parameter list will not be visible outside of this definition or declaration
    static inline u16 read_CONTROL(struct bfin_twi_iface *iface)
                                          ^~~~~~~~~~~~~~
   In file included from arch/blackfin/mach-bf527/include/mach/blackfin.h:13:0,
                    from arch/blackfin/include/asm/irqflags.h:11,
                    from include/linux/irqflags.h:15,
                    from arch/blackfin/include/asm/bitops.h:33,
                    from include/linux/bitops.h:36,
                    from include/linux/kernel.h:10,
                    from include/linux/list.h:8,
                    from include/linux/module.h:9,
                    from drivers/i2c/busses/i2c-bfin-twi.c:11:
   arch/blackfin/include/asm/bfin_twi.h: In function 'read_CONTROL':
   arch/blackfin/include/asm/bfin_twi.h:76:27: error: dereferencing pointer to incomplete type 'struct bfin_twi_iface'
     return bfin_read16(&iface->regs_base->control);
                              ^
   arch/blackfin/include/asm/def_LPBlackfin.h:34:10: note: in definition of macro '_bfin_readX'
      : "a" (addr) \
             ^~~~
   arch/blackfin/include/asm/bfin_twi.h:76:9: note: in expansion of macro 'bfin_read16'
     return bfin_read16(&iface->regs_base->control);
            ^~~~~~~~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h: At top level:
   arch/blackfin/include/asm/bfin_twi.h:79:41: warning: 'struct bfin_twi_iface' declared inside parameter list will not be visible outside of this definition or declaration
    static inline void write_CONTROL(struct bfin_twi_iface *iface, u16 v)
                                            ^~~~~~~~~~~~~~
   In file included from arch/blackfin/mach-bf527/include/mach/blackfin.h:13:0,
                    from arch/blackfin/include/asm/irqflags.h:11,
                    from include/linux/irqflags.h:15,
                    from arch/blackfin/include/asm/bitops.h:33,
                    from include/linux/bitops.h:36,
                    from include/linux/kernel.h:10,
                    from include/linux/list.h:8,
                    from include/linux/module.h:9,
                    from drivers/i2c/busses/i2c-bfin-twi.c:11:
   arch/blackfin/include/asm/bfin_twi.h: In function 'write_CONTROL':
   arch/blackfin/include/asm/bfin_twi.h:82:21: error: dereferencing pointer to incomplete type 'struct bfin_twi_iface'
     bfin_write16(&iface->regs_base->control, v);
                        ^
   arch/blackfin/include/asm/def_LPBlackfin.h:42:10: note: in definition of macro '_bfin_writeX'
      : "a" (addr), "d" ((u##size)(val)) \
             ^~~~
   arch/blackfin/include/asm/bfin_twi.h:82:2: note: in expansion of macro 'bfin_write16'
     bfin_write16(&iface->regs_base->control, v);
     ^~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c: In function 'bfin_twi_handle_interrupt':
>> drivers/i2c/busses/i2c-bfin-twi.c:38:46: error: passing argument 1 of 'read_MASTER_STAT' from incompatible pointer type [-Werror=incompatible-pointer-types]
     unsigned short mast_stat = read_MASTER_STAT(iface);
                                                 ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:17:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_##reg_name(struct bfin_twi_iface *iface) \
                      ^
   arch/blackfin/include/asm/bfin_twi.h:27:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_STAT, master_stat)
    ^~~~~~~~~~~~~~
>> drivers/i2c/busses/i2c-bfin-twi.c:47:22: error: passing argument 1 of 'read_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
         read_MASTER_CTL(iface) | MDIR);
                         ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:17:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_##reg_name(struct bfin_twi_iface *iface) \
                      ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
>> drivers/i2c/busses/i2c-bfin-twi.c:46:22: error: passing argument 1 of 'write_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
        write_MASTER_CTL(iface,
                         ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:50:22: error: passing argument 1 of 'read_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
         read_MASTER_CTL(iface) | STOP);
                         ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:17:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_##reg_name(struct bfin_twi_iface *iface) \
                      ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:49:22: error: passing argument 1 of 'write_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
        write_MASTER_CTL(iface,
                         ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:56:23: error: passing argument 1 of 'read_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
          read_MASTER_CTL(iface) |
                          ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:17:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_##reg_name(struct bfin_twi_iface *iface) \
                      ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:55:23: error: passing argument 1 of 'write_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
         write_MASTER_CTL(iface,
                          ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:60:23: error: passing argument 1 of 'read_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
          read_MASTER_CTL(iface) &
                          ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:17:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_##reg_name(struct bfin_twi_iface *iface) \
                      ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:59:23: error: passing argument 1 of 'write_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
         write_MASTER_CTL(iface,
                          ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
>> drivers/i2c/busses/i2c-bfin-twi.c:66:20: error: passing argument 1 of 'read_FIFO_STAT' from incompatible pointer type [-Werror=incompatible-pointer-types]
       (read_FIFO_STAT(iface) & XMTSTAT) != XMT_FULL) {
                       ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:17:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_##reg_name(struct bfin_twi_iface *iface) \
                      ^
   arch/blackfin/include/asm/bfin_twi.h:31:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(FIFO_STAT, fifo_stat)
    ^~~~~~~~~~~~~~
>> drivers/i2c/busses/i2c-bfin-twi.c:67:20: error: passing argument 1 of 'write_XMT_DATA8' from incompatible pointer type [-Werror=incompatible-pointer-types]
       write_XMT_DATA8(iface, *(iface->transPtr++));
                       ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:32:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(XMT_DATA8, xmt_data8)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:73:20: error: passing argument 1 of 'read_FIFO_STAT' from incompatible pointer type [-Werror=incompatible-pointer-types]
       (read_FIFO_STAT(iface) & RCVSTAT)) {
                       ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:17:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_##reg_name(struct bfin_twi_iface *iface) \
                      ^
   arch/blackfin/include/asm/bfin_twi.h:31:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(FIFO_STAT, fifo_stat)
    ^~~~~~~~~~~~~~
>> drivers/i2c/busses/i2c-bfin-twi.c:75:40: error: passing argument 1 of 'read_RCV_DATA8' from incompatible pointer type [-Werror=incompatible-pointer-types]
       *(iface->transPtr) = read_RCV_DATA8(iface);
                                           ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:17:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_##reg_name(struct bfin_twi_iface *iface) \
                      ^
   arch/blackfin/include/asm/bfin_twi.h:35:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(RCV_DATA8, rcv_data8)
    ^~~~~~~~~~~~~~
>> drivers/i2c/busses/i2c-bfin-twi.c:96:21: error: passing argument 1 of 'read_RCV_DATA16' from incompatible pointer type [-Werror=incompatible-pointer-types]
        read_RCV_DATA16(iface);
                        ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:17:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_##reg_name(struct bfin_twi_iface *iface) \
                      ^
   arch/blackfin/include/asm/bfin_twi.h:36:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(RCV_DATA16, rcv_data16)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:98:22: error: passing argument 1 of 'read_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
         read_MASTER_CTL(iface) | STOP);
                         ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:17:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_##reg_name(struct bfin_twi_iface *iface) \
                      ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:97:22: error: passing argument 1 of 'write_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
        write_MASTER_CTL(iface,
                         ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:103:23: error: passing argument 1 of 'read_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
          read_MASTER_CTL(iface) | MDIR);
                          ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:17:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_##reg_name(struct bfin_twi_iface *iface) \
                      ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:102:23: error: passing argument 1 of 'write_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
         write_MASTER_CTL(iface,
                          ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:106:23: error: passing argument 1 of 'read_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
          read_MASTER_CTL(iface) & ~MDIR);
                          ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:17:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_##reg_name(struct bfin_twi_iface *iface) \
                      ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:105:23: error: passing argument 1 of 'write_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
         write_MASTER_CTL(iface,
                          ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
>> drivers/i2c/busses/i2c-bfin-twi.c:111:18: error: passing argument 1 of 'write_INT_MASK' from incompatible pointer type [-Werror=incompatible-pointer-types]
      write_INT_MASK(iface, 0);
                     ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:30:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(INT_MASK, int_mask)
    ^~~~~~~~~~~~~~
>> drivers/i2c/busses/i2c-bfin-twi.c:112:21: error: passing argument 1 of 'write_MASTER_STAT' from incompatible pointer type [-Werror=incompatible-pointer-types]
      write_MASTER_STAT(iface, 0x3e);
                        ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:27:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_STAT, master_stat)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:113:20: error: passing argument 1 of 'write_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
      write_MASTER_CTL(iface, 0);
                       ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:132:24: error: passing argument 1 of 'read_MASTER_STAT' from incompatible pointer type [-Werror=incompatible-pointer-types]
      if (read_MASTER_STAT(iface) & SDASEN) {
                           ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:17:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_##reg_name(struct bfin_twi_iface *iface) \
                      ^
   arch/blackfin/include/asm/bfin_twi.h:27:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_STAT, master_stat)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:135:22: error: passing argument 1 of 'write_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
        write_MASTER_CTL(iface, SCLOVR);
                         ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:137:22: error: passing argument 1 of 'write_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
        write_MASTER_CTL(iface, 0);
                         ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:139:31: error: passing argument 1 of 'read_MASTER_STAT' from incompatible pointer type [-Werror=incompatible-pointer-types]
       } while ((read_MASTER_STAT(iface) & SDASEN) && cnt--);
                                  ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:17:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_##reg_name(struct bfin_twi_iface *iface) \
                      ^
   arch/blackfin/include/asm/bfin_twi.h:27:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_STAT, master_stat)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:141:21: error: passing argument 1 of 'write_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
       write_MASTER_CTL(iface, SDAOVR | SCLOVR);
                        ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:143:21: error: passing argument 1 of 'write_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
       write_MASTER_CTL(iface, SDAOVR);
                        ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:145:21: error: passing argument 1 of 'write_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
       write_MASTER_CTL(iface, 0);
                        ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:161:21: error: passing argument 1 of 'read_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
       (read_MASTER_CTL(iface) & MEN) == 0 &&
                        ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:17:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_##reg_name(struct bfin_twi_iface *iface) \
                      ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:165:19: error: passing argument 1 of 'write_INT_MASK' from incompatible pointer type [-Werror=incompatible-pointer-types]
       write_INT_MASK(iface, 0);
                      ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:30:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(INT_MASK, int_mask)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:166:21: error: passing argument 1 of 'write_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
       write_MASTER_CTL(iface, 0);
                        ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:175:22: error: passing argument 1 of 'read_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
         read_MASTER_CTL(iface) | (0xff << 6));
                         ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:17:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_##reg_name(struct bfin_twi_iface *iface) \
                      ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:174:22: error: passing argument 1 of 'write_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
        write_MASTER_CTL(iface,
                         ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:181:23: error: passing argument 1 of 'read_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
         (read_MASTER_CTL(iface) &
                          ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:17:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_##reg_name(struct bfin_twi_iface *iface) \
                      ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:180:22: error: passing argument 1 of 'write_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
        write_MASTER_CTL(iface,
                         ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:187:21: error: passing argument 1 of 'read_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
        read_MASTER_CTL(iface) & ~RSTART);
                        ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:17:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_##reg_name(struct bfin_twi_iface *iface) \
                      ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:186:21: error: passing argument 1 of 'write_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
       write_MASTER_CTL(iface,
                        ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
>> drivers/i2c/busses/i2c-bfin-twi.c:195:22: error: passing argument 1 of 'write_MASTER_ADDR' from incompatible pointer type [-Werror=incompatible-pointer-types]
       write_MASTER_ADDR(iface,
                         ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:28:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_ADDR, master_addr)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:203:22: error: passing argument 1 of 'write_XMT_DATA8' from incompatible pointer type [-Werror=incompatible-pointer-types]
         write_XMT_DATA8(iface,
                         ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:32:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(XMT_DATA8, xmt_data8)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:211:23: error: passing argument 1 of 'read_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
         (read_MASTER_CTL(iface) &
                          ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:17:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_##reg_name(struct bfin_twi_iface *iface) \
                      ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:210:22: error: passing argument 1 of 'write_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
        write_MASTER_CTL(iface,
                         ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:217:23: error: passing argument 1 of 'read_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
         (read_MASTER_CTL(iface) |
                          ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:17:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_##reg_name(struct bfin_twi_iface *iface) \
                      ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:216:22: error: passing argument 1 of 'write_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
        write_MASTER_CTL(iface,
                         ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:224:22: error: passing argument 1 of 'read_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
         read_MASTER_CTL(iface) & ~RSTART);
                         ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:17:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_##reg_name(struct bfin_twi_iface *iface) \
                      ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:223:22: error: passing argument 1 of 'write_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
        write_MASTER_CTL(iface,
                         ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:227:19: error: passing argument 1 of 'write_INT_MASK' from incompatible pointer type [-Werror=incompatible-pointer-types]
       write_INT_MASK(iface, 0);
                      ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:30:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(INT_MASK, int_mask)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:228:21: error: passing argument 1 of 'write_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
       write_MASTER_CTL(iface, 0);
                        ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c: In function 'bfin_twi_interrupt_entry':
>> drivers/i2c/busses/i2c-bfin-twi.c:243:34: error: passing argument 1 of 'read_INT_STAT' from incompatible pointer type [-Werror=incompatible-pointer-types]
      twi_int_status = read_INT_STAT(iface);
                                     ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:17:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_##reg_name(struct bfin_twi_iface *iface) \
                      ^
   arch/blackfin/include/asm/bfin_twi.h:29:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(INT_STAT, int_stat)
    ^~~~~~~~~~~~~~
>> drivers/i2c/busses/i2c-bfin-twi.c:247:18: error: passing argument 1 of 'write_INT_STAT' from incompatible pointer type [-Werror=incompatible-pointer-types]
      write_INT_STAT(iface, twi_int_status);
                     ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:29:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(INT_STAT, int_stat)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c: In function 'bfin_twi_do_master_xfer':
>> drivers/i2c/busses/i2c-bfin-twi.c:264:21: error: passing argument 1 of 'read_CONTROL' from incompatible pointer type [-Werror=incompatible-pointer-types]
     if (!(read_CONTROL(iface) & TWI_ENA))
                        ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:74:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_CONTROL(struct bfin_twi_iface *iface)
                      ^~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:267:23: error: passing argument 1 of 'read_MASTER_STAT' from incompatible pointer type [-Werror=incompatible-pointer-types]
     if (read_MASTER_STAT(iface) & BUSBUSY)
                          ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:17:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_##reg_name(struct bfin_twi_iface *iface) \
                      ^
   arch/blackfin/include/asm/bfin_twi.h:27:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_STAT, master_stat)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:288:20: error: passing argument 1 of 'write_MASTER_ADDR' from incompatible pointer type [-Werror=incompatible-pointer-types]
     write_MASTER_ADDR(iface, pmsg->addr);
                       ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:28:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_ADDR, master_addr)
    ^~~~~~~~~~~~~~
>> drivers/i2c/busses/i2c-bfin-twi.c:293:17: error: passing argument 1 of 'write_FIFO_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
     write_FIFO_CTL(iface, 0x3);
                    ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:68:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_FIFO_CTL(struct bfin_twi_iface *iface, u16 v)
                       ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:294:17: error: passing argument 1 of 'write_FIFO_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
     write_FIFO_CTL(iface, 0);
                    ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:68:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_FIFO_CTL(struct bfin_twi_iface *iface, u16 v)
                       ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:302:20: error: passing argument 1 of 'write_XMT_DATA8' from incompatible pointer type [-Werror=incompatible-pointer-types]
       write_XMT_DATA8(iface, *(iface->transPtr++));
                       ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:32:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(XMT_DATA8, xmt_data8)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:308:17: error: passing argument 1 of 'write_INT_STAT' from incompatible pointer type [-Werror=incompatible-pointer-types]
     write_INT_STAT(iface, MERR | MCOMP | XMTSERV | RCVSERV);
                    ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:29:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(INT_STAT, int_stat)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:311:17: error: passing argument 1 of 'write_INT_MASK' from incompatible pointer type [-Werror=incompatible-pointer-types]
     write_INT_MASK(iface, MCOMP | MERR | RCVSERV | XMTSERV);
                    ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:30:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(INT_MASK, int_mask)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:314:20: error: passing argument 1 of 'write_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
      write_MASTER_CTL(iface, pmsg->len << 6);
                       ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:316:20: error: passing argument 1 of 'write_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
      write_MASTER_CTL(iface, 0xff << 6);
                       ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:321:42: error: passing argument 1 of 'read_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
     write_MASTER_CTL(iface, read_MASTER_CTL(iface) | MEN |
                                             ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:17:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_##reg_name(struct bfin_twi_iface *iface) \
                      ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:321:19: error: passing argument 1 of 'write_MASTER_CTL' from incompatible pointer type [-Werror=incompatible-pointer-types]
     write_MASTER_CTL(iface, read_MASTER_CTL(iface) | MEN |
                      ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:19:20: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
                       ^
   arch/blackfin/include/asm/bfin_twi.h:26:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_CTL, master_ctl)
    ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c: In function 'bfin_twi_do_smbus_xfer':
   drivers/i2c/busses/i2c-bfin-twi.c:361:21: error: passing argument 1 of 'read_CONTROL' from incompatible pointer type [-Werror=incompatible-pointer-types]
     if (!(read_CONTROL(iface) & TWI_ENA))
                        ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:74:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_CONTROL(struct bfin_twi_iface *iface)
                      ^~~~~~~~~~~~
   drivers/i2c/busses/i2c-bfin-twi.c:364:23: error: passing argument 1 of 'read_MASTER_STAT' from incompatible pointer type [-Werror=incompatible-pointer-types]
     if (read_MASTER_STAT(iface) & BUSBUSY)
                          ^~~~~
   In file included from drivers/i2c/busses/i2c-bfin-twi.c:27:0:
   arch/blackfin/include/asm/bfin_twi.h:17:19: note: expected 'struct bfin_twi_iface *' but argument is of type 'struct bfin_twi_iface *'
    static inline u16 read_##reg_name(struct bfin_twi_iface *iface) \
                      ^
   arch/blackfin/include/asm/bfin_twi.h:27:1: note: in expansion of macro 'DEFINE_TWI_REG'
    DEFINE_TWI_REG(MASTER_STAT, master_stat)
..

vim +/read_MASTER_STAT +38 drivers/i2c/busses/i2c-bfin-twi.c

d24ecfcc3 Bryan Wu          2007-05-01   21  #include <linux/interrupt.h>
d24ecfcc3 Bryan Wu          2007-05-01   22  #include <linux/platform_device.h>
540ac5553 Michael Hennerich 2011-01-11   23  #include <linux/delay.h>
d24ecfcc3 Bryan Wu          2007-05-01   24  
d24ecfcc3 Bryan Wu          2007-05-01   25  #include <asm/irq.h>
45126da22 Sonic Zhang       2014-01-28   26  #include <asm/portmux.h>
c9d87edbc Sonic Zhang       2012-06-13  @27  #include <asm/bfin_twi.h>
d24ecfcc3 Bryan Wu          2007-05-01   28  
d24ecfcc3 Bryan Wu          2007-05-01   29  /* SMBus mode*/
4dd39bb12 Sonic Zhang       2008-04-22   30  #define TWI_I2C_MODE_STANDARD		1
4dd39bb12 Sonic Zhang       2008-04-22   31  #define TWI_I2C_MODE_STANDARDSUB	2
4dd39bb12 Sonic Zhang       2008-04-22   32  #define TWI_I2C_MODE_COMBINED		3
4dd39bb12 Sonic Zhang       2008-04-22   33  #define TWI_I2C_MODE_REPEAT		4
d24ecfcc3 Bryan Wu          2007-05-01   34  
5481d0753 Sonic Zhang       2010-03-22   35  static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface,
5481d0753 Sonic Zhang       2010-03-22   36  					unsigned short twi_int_status)
d24ecfcc3 Bryan Wu          2007-05-01   37  {
aa3d02091 Bryan Wu          2008-04-22  @38  	unsigned short mast_stat = read_MASTER_STAT(iface);
d24ecfcc3 Bryan Wu          2007-05-01   39  
d24ecfcc3 Bryan Wu          2007-05-01   40  	if (twi_int_status & XMTSERV) {
8419c8deb Sonic Zhang       2013-05-28   41  		if (iface->writeNum <= 0) {
d24ecfcc3 Bryan Wu          2007-05-01   42  			/* start receive immediately after complete sending in
d24ecfcc3 Bryan Wu          2007-05-01   43  			 * combine mode.
d24ecfcc3 Bryan Wu          2007-05-01   44  			 */
8419c8deb Sonic Zhang       2013-05-28   45  			if (iface->cur_mode == TWI_I2C_MODE_COMBINED)
aa3d02091 Bryan Wu          2008-04-22  @46  				write_MASTER_CTL(iface,
28a377c79 Sonic Zhang       2012-06-13  @47  					read_MASTER_CTL(iface) | MDIR);
4dd39bb12 Sonic Zhang       2008-04-22   48  			else if (iface->manual_stop)
aa3d02091 Bryan Wu          2008-04-22   49  				write_MASTER_CTL(iface,
aa3d02091 Bryan Wu          2008-04-22   50  					read_MASTER_CTL(iface) | STOP);
4dd39bb12 Sonic Zhang       2008-04-22   51  			else if (iface->cur_mode == TWI_I2C_MODE_REPEAT &&
94327d009 Frank Shew        2009-05-19   52  				iface->cur_msg + 1 < iface->msg_num) {
8419c8deb Sonic Zhang       2013-05-28   53  				if (iface->pmsg[iface->cur_msg + 1].flags &
8419c8deb Sonic Zhang       2013-05-28   54  					I2C_M_RD)
94327d009 Frank Shew        2009-05-19   55  					write_MASTER_CTL(iface,
8419c8deb Sonic Zhang       2013-05-28   56  						read_MASTER_CTL(iface) |
8419c8deb Sonic Zhang       2013-05-28   57  						MDIR);
94327d009 Frank Shew        2009-05-19   58  				else
aa3d02091 Bryan Wu          2008-04-22   59  					write_MASTER_CTL(iface,
8419c8deb Sonic Zhang       2013-05-28   60  						read_MASTER_CTL(iface) &
8419c8deb Sonic Zhang       2013-05-28   61  						~MDIR);
8419c8deb Sonic Zhang       2013-05-28   62  			}
8419c8deb Sonic Zhang       2013-05-28   63  		}
8419c8deb Sonic Zhang       2013-05-28   64  		/* Transmit next data */
8419c8deb Sonic Zhang       2013-05-28   65  		while (iface->writeNum > 0 &&
8419c8deb Sonic Zhang       2013-05-28  @66  			(read_FIFO_STAT(iface) & XMTSTAT) != XMT_FULL) {
8419c8deb Sonic Zhang       2013-05-28  @67  			write_XMT_DATA8(iface, *(iface->transPtr++));
8419c8deb Sonic Zhang       2013-05-28   68  			iface->writeNum--;
94327d009 Frank Shew        2009-05-19   69  		}
d24ecfcc3 Bryan Wu          2007-05-01   70  	}
d24ecfcc3 Bryan Wu          2007-05-01   71  	if (twi_int_status & RCVSERV) {
8419c8deb Sonic Zhang       2013-05-28   72  		while (iface->readNum > 0 &&
8419c8deb Sonic Zhang       2013-05-28   73  			(read_FIFO_STAT(iface) & RCVSTAT)) {
d24ecfcc3 Bryan Wu          2007-05-01   74  			/* Receive next data */
aa3d02091 Bryan Wu          2008-04-22  @75  			*(iface->transPtr) = read_RCV_DATA8(iface);
d24ecfcc3 Bryan Wu          2007-05-01   76  			if (iface->cur_mode == TWI_I2C_MODE_COMBINED) {
d24ecfcc3 Bryan Wu          2007-05-01   77  				/* Change combine mode into sub mode after
d24ecfcc3 Bryan Wu          2007-05-01   78  				 * read first data.
d24ecfcc3 Bryan Wu          2007-05-01   79  				 */
d24ecfcc3 Bryan Wu          2007-05-01   80  				iface->cur_mode = TWI_I2C_MODE_STANDARDSUB;
d24ecfcc3 Bryan Wu          2007-05-01   81  				/* Get read number from first byte in block
d24ecfcc3 Bryan Wu          2007-05-01   82  				 * combine mode.
d24ecfcc3 Bryan Wu          2007-05-01   83  				 */
d24ecfcc3 Bryan Wu          2007-05-01   84  				if (iface->readNum == 1 && iface->manual_stop)
d24ecfcc3 Bryan Wu          2007-05-01   85  					iface->readNum = *iface->transPtr + 1;
d24ecfcc3 Bryan Wu          2007-05-01   86  			}
d24ecfcc3 Bryan Wu          2007-05-01   87  			iface->transPtr++;
d24ecfcc3 Bryan Wu          2007-05-01   88  			iface->readNum--;
a20a64d22 Sonic Zhang       2012-06-13   89  		}
a20a64d22 Sonic Zhang       2012-06-13   90  
a20a64d22 Sonic Zhang       2012-06-13   91  		if (iface->readNum == 0) {
a20a64d22 Sonic Zhang       2012-06-13   92  			if (iface->manual_stop) {
925594e03 Michael Hennerich 2012-06-13   93  				/* Temporary workaround to avoid possible bus stall -
925594e03 Michael Hennerich 2012-06-13   94  				 * Flush FIFO before issuing the STOP condition
925594e03 Michael Hennerich 2012-06-13   95  				 */
925594e03 Michael Hennerich 2012-06-13  @96  				read_RCV_DATA16(iface);
aa3d02091 Bryan Wu          2008-04-22   97  				write_MASTER_CTL(iface,
aa3d02091 Bryan Wu          2008-04-22   98  					read_MASTER_CTL(iface) | STOP);
4dd39bb12 Sonic Zhang       2008-04-22   99  			} else if (iface->cur_mode == TWI_I2C_MODE_REPEAT &&
4dd39bb12 Sonic Zhang       2008-04-22  100  					iface->cur_msg + 1 < iface->msg_num) {
94327d009 Frank Shew        2009-05-19  101  				if (iface->pmsg[iface->cur_msg + 1].flags & I2C_M_RD)
94327d009 Frank Shew        2009-05-19  102  					write_MASTER_CTL(iface,
28a377c79 Sonic Zhang       2012-06-13  103  						read_MASTER_CTL(iface) | MDIR);
94327d009 Frank Shew        2009-05-19  104  				else
aa3d02091 Bryan Wu          2008-04-22  105  					write_MASTER_CTL(iface,
28a377c79 Sonic Zhang       2012-06-13  106  						read_MASTER_CTL(iface) & ~MDIR);
d24ecfcc3 Bryan Wu          2007-05-01  107  			}
d24ecfcc3 Bryan Wu          2007-05-01  108  		}
a20a64d22 Sonic Zhang       2012-06-13  109  	}
d24ecfcc3 Bryan Wu          2007-05-01  110  	if (twi_int_status & MERR) {
aa3d02091 Bryan Wu          2008-04-22 @111  		write_INT_MASK(iface, 0);
aa3d02091 Bryan Wu          2008-04-22 @112  		write_MASTER_STAT(iface, 0x3e);
aa3d02091 Bryan Wu          2008-04-22  113  		write_MASTER_CTL(iface, 0);
4dd39bb12 Sonic Zhang       2008-04-22  114  		iface->result = -EIO;
5cfafc18f Michael Hennerich 2010-03-22  115  
5cfafc18f Michael Hennerich 2010-03-22  116  		if (mast_stat & LOSTARB)
5cfafc18f Michael Hennerich 2010-03-22  117  			dev_dbg(&iface->adap.dev, "Lost Arbitration\n");
5cfafc18f Michael Hennerich 2010-03-22  118  		if (mast_stat & ANAK)
5cfafc18f Michael Hennerich 2010-03-22  119  			dev_dbg(&iface->adap.dev, "Address Not Acknowledged\n");
5cfafc18f Michael Hennerich 2010-03-22  120  		if (mast_stat & DNAK)
5cfafc18f Michael Hennerich 2010-03-22  121  			dev_dbg(&iface->adap.dev, "Data Not Acknowledged\n");
5cfafc18f Michael Hennerich 2010-03-22  122  		if (mast_stat & BUFRDERR)
5cfafc18f Michael Hennerich 2010-03-22  123  			dev_dbg(&iface->adap.dev, "Buffer Read Error\n");
5cfafc18f Michael Hennerich 2010-03-22  124  		if (mast_stat & BUFWRERR)
5cfafc18f Michael Hennerich 2010-03-22  125  			dev_dbg(&iface->adap.dev, "Buffer Write Error\n");
5cfafc18f Michael Hennerich 2010-03-22  126  
540ac5553 Michael Hennerich 2011-01-11  127  		/* Faulty slave devices, may drive SDA low after a transfer
540ac5553 Michael Hennerich 2011-01-11  128  		 * finishes. To release the bus this code generates up to 9
540ac5553 Michael Hennerich 2011-01-11  129  		 * extra clocks until SDA is released.
540ac5553 Michael Hennerich 2011-01-11  130  		 */
540ac5553 Michael Hennerich 2011-01-11  131  
540ac5553 Michael Hennerich 2011-01-11  132  		if (read_MASTER_STAT(iface) & SDASEN) {
540ac5553 Michael Hennerich 2011-01-11  133  			int cnt = 9;
540ac5553 Michael Hennerich 2011-01-11  134  			do {
540ac5553 Michael Hennerich 2011-01-11  135  				write_MASTER_CTL(iface, SCLOVR);
540ac5553 Michael Hennerich 2011-01-11  136  				udelay(6);
540ac5553 Michael Hennerich 2011-01-11  137  				write_MASTER_CTL(iface, 0);
540ac5553 Michael Hennerich 2011-01-11  138  				udelay(6);
540ac5553 Michael Hennerich 2011-01-11  139  			} while ((read_MASTER_STAT(iface) & SDASEN) && cnt--);
540ac5553 Michael Hennerich 2011-01-11  140  
540ac5553 Michael Hennerich 2011-01-11  141  			write_MASTER_CTL(iface, SDAOVR | SCLOVR);
540ac5553 Michael Hennerich 2011-01-11  142  			udelay(6);
540ac5553 Michael Hennerich 2011-01-11  143  			write_MASTER_CTL(iface, SDAOVR);
540ac5553 Michael Hennerich 2011-01-11  144  			udelay(6);
540ac5553 Michael Hennerich 2011-01-11  145  			write_MASTER_CTL(iface, 0);
540ac5553 Michael Hennerich 2011-01-11  146  		}
540ac5553 Michael Hennerich 2011-01-11  147  
dd7319a52 Sonic Zhang       2010-03-22  148  		/* If it is a quick transfer, only address without data,
d24ecfcc3 Bryan Wu          2007-05-01  149  		 * not an err, return 1.
d24ecfcc3 Bryan Wu          2007-05-01  150  		 */
f0ac131a2 Sonic Zhang       2010-03-22  151  		if (iface->cur_mode == TWI_I2C_MODE_STANDARD &&
f0ac131a2 Sonic Zhang       2010-03-22  152  			iface->transPtr == NULL &&
f0ac131a2 Sonic Zhang       2010-03-22  153  			(twi_int_status & MCOMP) && (mast_stat & DNAK))
d24ecfcc3 Bryan Wu          2007-05-01  154  			iface->result = 1;
f0ac131a2 Sonic Zhang       2010-03-22  155  
d24ecfcc3 Bryan Wu          2007-05-01  156  		complete(&iface->complete);
d24ecfcc3 Bryan Wu          2007-05-01  157  		return;
d24ecfcc3 Bryan Wu          2007-05-01  158  	}
d24ecfcc3 Bryan Wu          2007-05-01  159  	if (twi_int_status & MCOMP) {
2ee74eb95 Sonic Zhang       2012-06-13  160  		if (twi_int_status & (XMTSERV | RCVSERV) &&
2ee74eb95 Sonic Zhang       2012-06-13  161  			(read_MASTER_CTL(iface) & MEN) == 0 &&
4a65163e3 Sonic Zhang       2011-06-23  162  			(iface->cur_mode == TWI_I2C_MODE_REPEAT ||
4a65163e3 Sonic Zhang       2011-06-23  163  			iface->cur_mode == TWI_I2C_MODE_COMBINED)) {
4a65163e3 Sonic Zhang       2011-06-23  164  			iface->result = -1;
4a65163e3 Sonic Zhang       2011-06-23  165  			write_INT_MASK(iface, 0);
4a65163e3 Sonic Zhang       2011-06-23  166  			write_MASTER_CTL(iface, 0);
4a65163e3 Sonic Zhang       2011-06-23  167  		} else if (iface->cur_mode == TWI_I2C_MODE_COMBINED) {
d24ecfcc3 Bryan Wu          2007-05-01  168  			if (iface->readNum == 0) {
d24ecfcc3 Bryan Wu          2007-05-01  169  				/* set the read number to 1 and ask for manual
d24ecfcc3 Bryan Wu          2007-05-01  170  				 * stop in block combine mode
d24ecfcc3 Bryan Wu          2007-05-01  171  				 */
d24ecfcc3 Bryan Wu          2007-05-01  172  				iface->readNum = 1;
d24ecfcc3 Bryan Wu          2007-05-01  173  				iface->manual_stop = 1;
aa3d02091 Bryan Wu          2008-04-22  174  				write_MASTER_CTL(iface,
aa3d02091 Bryan Wu          2008-04-22  175  					read_MASTER_CTL(iface) | (0xff << 6));
d24ecfcc3 Bryan Wu          2007-05-01  176  			} else {
d24ecfcc3 Bryan Wu          2007-05-01  177  				/* set the readd number in other
d24ecfcc3 Bryan Wu          2007-05-01  178  				 * combine mode.
d24ecfcc3 Bryan Wu          2007-05-01  179  				 */
aa3d02091 Bryan Wu          2008-04-22  180  				write_MASTER_CTL(iface,
aa3d02091 Bryan Wu          2008-04-22  181  					(read_MASTER_CTL(iface) &
d24ecfcc3 Bryan Wu          2007-05-01  182  					(~(0xff << 6))) |
d24ecfcc3 Bryan Wu          2007-05-01  183  					(iface->readNum << 6));
d24ecfcc3 Bryan Wu          2007-05-01  184  			}
d24ecfcc3 Bryan Wu          2007-05-01  185  			/* remove restart bit and enable master receive */
aa3d02091 Bryan Wu          2008-04-22  186  			write_MASTER_CTL(iface,
aa3d02091 Bryan Wu          2008-04-22  187  				read_MASTER_CTL(iface) & ~RSTART);
4dd39bb12 Sonic Zhang       2008-04-22  188  		} else if (iface->cur_mode == TWI_I2C_MODE_REPEAT &&
4dd39bb12 Sonic Zhang       2008-04-22  189  				iface->cur_msg + 1 < iface->msg_num) {
4dd39bb12 Sonic Zhang       2008-04-22  190  			iface->cur_msg++;
4dd39bb12 Sonic Zhang       2008-04-22  191  			iface->transPtr = iface->pmsg[iface->cur_msg].buf;
4dd39bb12 Sonic Zhang       2008-04-22  192  			iface->writeNum = iface->readNum =
4dd39bb12 Sonic Zhang       2008-04-22  193  				iface->pmsg[iface->cur_msg].len;
4dd39bb12 Sonic Zhang       2008-04-22  194  			/* Set Transmit device address */
aa3d02091 Bryan Wu          2008-04-22 @195  			write_MASTER_ADDR(iface,
4dd39bb12 Sonic Zhang       2008-04-22  196  				iface->pmsg[iface->cur_msg].addr);
4dd39bb12 Sonic Zhang       2008-04-22  197  			if (iface->pmsg[iface->cur_msg].flags & I2C_M_RD)
4dd39bb12 Sonic Zhang       2008-04-22  198  				iface->read_write = I2C_SMBUS_READ;

:::::: The code at line 38 was first introduced by commit
:::::: aa3d02091747727f7ff2e1f2455ad8363a9e6946 i2c-bfin-twi: Add platform_resource interface to support multi-port TWI controllers

:::::: TO: Bryan Wu <cooloney@kernel.org>
:::::: CC: Jean Delvare <khali@hyperion.delvare>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--ikeVEW9yuYc//A+q
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ikeVEW9yuYc//A+q--
