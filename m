From: "David E. Box" <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH V4 0/2] i2c-designware: Add Intel Baytrail pmic i2c bus support
Date: Thu, 15 Jan 2015 01:12:15 -0800
Message-ID: <1421313137-1613-1-git-send-email-david.e.box@linux.intel.com>
References: <1417478973-25522-1-git-send-email-david.e.box@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1417478973-25522-1-git-send-email-david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: jdelvare-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

V4:	- Added bus lock to i2c_dw_init() as suggested by Jarrko Nikula
	  <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>. Addresses infrequent hang that was
	  seen occuring during probe.
	- Added label in i2c_dw_xfer() to bypass unnecessary lock release when
	  acquire fails. Suggested by Mika.
	- Changed make to build driver as composite addition to
	  i2c-designware-platform. Driver can be module or built-in following
	  the platform driver selection. Tested as both.
	- Added EPROBE_DEFER return to baytrail definition of i2c_dw_eval_lock()
	  to defer probe if iosf_mbi driver (required for acquring bus lock) is
	  not available.

V3:	- Split lock support and driver into separate patches
	- Change module build to bool. Platforms running without this driver
	  cannot perform critical functions such as charging. Furthermore attempts
	  by other drivers to access the i2c bus without a lock will hang the
	  platform.
	- Replaced has_hw_lock flag with acquire/release function pointers.
	- Replaced acquire/release ifdef code with single
	  i2c_dw_eval_lock_support() test for cleaner (if still undesirable)
	  compile time scalability. Future Intel platforms will however continue
	  to use the Baytrail driver.

V2:	- Moved semaphore detection out of dw platform driver
	- Replaced function pointers with defined acquire/release functions in
	  dw core. This helps eliminate the ifdefery in the dw platform driver.
	- Use new has_hw_lock flag to check if the lock exists on a given bus.
	- Use new pm_runtime_disabled flag to conditionally turnoff runtime pm
	  in the dw platform driver.

David E. Box (2):
  i2c-designware: Add i2c bus locking support
  i2c-designware: Add Intel Baytrail PMIC I2C bus support

 drivers/i2c/busses/Kconfig                   |  11 ++
 drivers/i2c/busses/Makefile                  |   1 +
 drivers/i2c/busses/i2c-designware-baytrail.c | 160 +++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-designware-core.c     |  26 +++++
 drivers/i2c/busses/i2c-designware-core.h     |  12 ++
 drivers/i2c/busses/i2c-designware-platdrv.c  |  20 +++-
 6 files changed, 225 insertions(+), 5 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-designware-baytrail.c

-- 
1.9.1
