From: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v6 0/2] i2c: Imagination Technologies I2C adapter driver
Date: Thu, 13 Nov 2014 10:25:09 -0300
Message-ID: <1415885111-4138-1-git-send-email-ezequiel.garcia@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Changes from v5:

  * Checked the return value of wait_for_completion_timeout

  * Removed the bus-delay devicetree parameter. After reviewing this logic
    in detail, we found a bug in the formulae involving the bus delay. Moreover,
    this parameter is not used by any product in the wild.

  * Use clk_prepare_enable/clk_disable_unprepare in the resume/suspend hooks.

Changes from v4:

  * Fixed the MODULE_LICENSE to "GPL v2", as per the comment at the top of
    the driver.

Changes from v3:

  * Checked for the return value of clk_enable and clk_prepare_enable calls.

Changes from v2:

  * Removed support for the "linux,i2c-index" devicetree property.

Changes from v1:

  * Cleaned-up the clock filter configuration by adding some macros.

  * Dropped the ISR_ATOMIC macro since it wasn't used anywhere and
    instead just return 0.

  * Rename some functions with the img_i2c_ prefix to follow the rest
    of the driver style.

  * Make img_i2c_{readl,writel} receive a struct img_i2c argument,
    instead of the register base.

  * Removed a duplicated flag in INT_ENABLE_MASK_ATOMIC macro definition.

  * Added the system clock to the devicetree binding. Improved the binding
    document.

  * Added an explanation by James Hogan with details about the timer-based
    abort condition detection.

This patchset adds a new adapter driver supporting the Imagination Technologies
I2C Serial Control Bus (SCB) controller.

The driver supports the usual FIFO-based mode of operation (so-called automatic
in the driver), and also a set lower-level modes of operation that is used
for 0-length writes and for bus recovery routines.

The recently merged bus recovery infrastructure is not used, given this driver
already implements a fairly complex bus recovery, and has been tested
extensively with it.

Based on v3.18-rc2.

James Hogan (2):
  i2c: Add Imagination Technologies I2C SCB driver
  DT: i2c: Add binding document for IMG I2C SCB

 .../devicetree/bindings/i2c/i2c-img-scb.txt        |   26 +
 drivers/i2c/busses/Kconfig                         |   10 +
 drivers/i2c/busses/Makefile                        |    1 +
 drivers/i2c/busses/i2c-img-scb.c                   | 1415 ++++++++++++++++++++
 4 files changed, 1452 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-img-scb.txt
 create mode 100644 drivers/i2c/busses/i2c-img-scb.c

-- 
2.1.0
