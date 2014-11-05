From: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 0/2] i2c: Imagination Technologies I2C adapter driver
Date: Wed, 5 Nov 2014 17:21:57 -0300
Message-ID: <1415218919-9085-1-git-send-email-ezequiel.garcia@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

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

 .../devicetree/bindings/i2c/i2c-img-scb.txt        |   29 +
 drivers/i2c/busses/Kconfig                         |   10 +
 drivers/i2c/busses/Makefile                        |    1 +
 drivers/i2c/busses/i2c-img-scb.c                   | 1397 ++++++++++++++++++++
 4 files changed, 1437 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-img-scb.txt
 create mode 100644 drivers/i2c/busses/i2c-img-scb.c

-- 
2.1.0
