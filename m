From: "David E. Box" <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH V3 0/2] i2c-designware: Baytrail bus locking driver
Date: Mon,  1 Dec 2014 16:09:31 -0800
Message-ID: <1417478973-25522-1-git-send-email-david.e.box@linux.intel.com>
References: <1411497626-7984-1-git-send-email-david.e.box@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411497626-7984-1-git-send-email-david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: jdelvare-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Select Intel Baytrail platforms support PMIC's whose i2c bus may be controlled
exclusively by platform hardware. This patch set adds support for i2c bus
locking to the designware core and provides a driver module for managing
the lock on these platforms. Since the lock on these systems isn't enumerable
outside of the i2c platform driver, the locking functions are assigned at
compile time.

V2:     Moved semaphore detection out of dw platform driver
        Replaced function pointers with defined acquire/release functions in dw
                core. This helps elliminate the ifdefery in the dw platform driver.
        Use new has_hw_lock flag to check if the lock exists on a given bus.
        Use new pm_runtime_disabled flag to conditionally turnoff runtime pm
                in the dw platform driver.

V3:	Split lock support and driver into separate patches
	Change module build to bool. Platforms running without this driver cannot
		perform critical functions such as charging. Futhermore attempts by
		other drivers to access the i2c bus without a lock will hang the
		platform.
	Replaced has_hw_lock flag with acquire/release function pointers.
	Replaced acquire/release ifdef code with single i2c_dw_eval_lock_support()
		test for cleaner (if still undesireable) compile time scalability.
		Future Intel platforms will however continue to use the Baytrail
		driver.

David E. Box (2):
  i2c-designware: Add i2c bus locking support
  i2c-designware: Add Intel Baytrail PMIC I2C bus support

 drivers/i2c/busses/Kconfig                   |  12 +++
 drivers/i2c/busses/Makefile                  |   1 +
 drivers/i2c/busses/i2c-designware-baytrail.c | 155 +++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-designware-core.c     |  11 ++
 drivers/i2c/busses/i2c-designware-core.h     |  12 +++
 drivers/i2c/busses/i2c-designware-platdrv.c  |  18 +++-
 6 files changed, 204 insertions(+), 5 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-designware-baytrail.c

-- 
1.9.1
