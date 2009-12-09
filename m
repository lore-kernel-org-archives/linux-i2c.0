From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdooks' i2c tree
Date: Wed, 09 Dec 2009 00:21:18 +0000
Message-ID: <E1NIAIw-0008IA-3S@teyla.home.fluff.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: apkm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit 6035ccd8e9e40bb654fbfdef325902ab531679a5:
  Linus Torvalds (1):
        Merge branch 'for-2.6.33' of git://git.kernel.dk/linux-2.6-block

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git next-i2c

Kevin Wells (1):
      i2c-pnx: Map I2C adapter number to platform ID number

Rajendra Nayak (1):
      i2c-omap: OMAP3: PM: (re)init for every transfer to support off-mode

Shinya Kuribayashi (23):
      i2c-designware: Consolidate to use 32-bit word accesses
      i2c-designware: Don't use the IC_CLR_INTR register to clear interrupts
      i2c-designware: Use platform_get_irq helper
      i2c-designware: i2c_dw_read: Use "struct dw_i2c_dev" pointer
      i2c-designware: i2c_dw_xfer_msg: Use "struct dw_i2c_dev" pointer
      i2c-designware: Remove an useless local variable "num"
      i2c-designware: Improved _HCNT/_LCNT calculation
      i2c-designware: i2c_dw_xfer_msg: Fix i2c_msg search bug
      i2c-designware: Process i2c_msg messages in the interrupt handler
      i2c-designware: Set Tx/Rx FIFO threshold levels
      i2c-designware: Enable RX_FULL interrupt
      i2c-designware: Divide i2c_dw_xfer_msg into two functions
      i2c-designware: i2c_dw_xfer_msg: Introduce a local "buf" pointer
      i2c-designware: Initialize byte count variables just prior to being used
      i2c-designware: i2c_dw_func: Set I2C_FUNC_SMBUS_foo bits
      i2c-designware: i2c_dw_read: Remove redundant target address checker
      i2c-designware: Process all i2c_msg messages in the interrupt handler
      i2c-designware: Disable TX_EMPTY when all i2c_msg msgs has been processed
      i2c-designware: i2c_dw_xfer_msg: Fix error handling procedures
      i2c-designware: Skip RX_FULL and TX_EMPTY bits on tx abort errors
      i2c-designware: Tx abort cleanups
      i2c-designware: Cosmetic cleanups
      i2c-designware: i2c_dw_handle_tx_abort: Use dev_dbg() for NOACK cases

 drivers/i2c/busses/i2c-designware.c |  488 +++++++++++++++++++++++++----------
 drivers/i2c/busses/i2c-omap.c       |   64 +++--
 drivers/i2c/busses/i2c-pnx.c        |    3 +-
 3 files changed, 398 insertions(+), 157 deletions(-)
