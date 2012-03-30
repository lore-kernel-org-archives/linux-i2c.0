From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv3 00/16] I2C updates
Date: Fri, 30 Mar 2012 21:19:55 +0530
Message-ID: <1333122611-29953-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The patch series does the following

- Warn fixes if CONFIG_PM_RUNTIME is not selected.
- I2C register restore only if context if the context is lost
- Bus busy recovery mechanism.
- the reset is not done in init.

v2 changes
-Adds a patch to use devm_* functions
-Also checks the return type of the get_sync and in case
 of errors prevents register access.
- In case of i2c remove register access was done without any
 get_sync fix the same.
- Adds a pdata function pointer to do context save restore

v3 changes
- Split the omap_i2c_isr to increase readability
- Adds the restore flag patch for OMAP4 to the series
- Make the i2c use SET_RUNTIME_PM_OPS

Tested on omap4sdp and omap3sdp.

Also available through

git://gitorious.org/linus-tree/linus-tree.git for_3.5_i2c

Previous discussion can be found
http://www.spinics.net/lists/linux-i2c/msg07380.html


Jon Hunter (1):
  I2C: OMAP: Correct I2C revision for OMAP3

Shubhrajyoti D (14):
  I2C : OMAP : make omap_i2c_unidle/idle functions depend on
    CONFIG_PM_RUNTIME
  OMAP : I2C : Remove reset at init
  OMAP: I2C: I2C register restore only if context is lost
  OMAP: I2C: Fix the interrupt clearing in OMAP4
  OMAP: I2C: Fix the mismatch of pm_runtime enable and disable
  OMAP: I2C: Optimise the remove code
  OMAP: I2C: Fix the error handling
  I2C: OMAP: Don't check if wait_for_completion_timeout() returns less
    than zero
  OMAP : I2C : use devm_* functions
  I2C : OMAP : Fix the crash in i2c remove
  OMAP: I2C: Handle error check for pm runtime
  I2C : OMAP : Use SET_RUNTIME_PM_OPS
  OMAP4: hwmod data: I2C: add flag for context restore
  i2c: omap: make the read ready processing a separate function

Vikram Pandita (1):
  I2C: OMAP: Recover from Bus Busy condition

 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 +-
 arch/arm/plat-omap/i2c.c                   |    3 +
 drivers/i2c/busses/i2c-omap.c              |  318 +++++++++++++++-------------
 include/linux/i2c-omap.h                   |    1 +
 4 files changed, 182 insertions(+), 143 deletions(-)
