From: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/2] i2c: Imagination Technologies I2C adapter driver
Date: Wed, 29 Oct 2014 16:57:19 -0300
Message-ID: <1414612641-4259-1-git-send-email-ezequiel.garcia@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

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

 .../devicetree/bindings/i2c/i2c-img-scb.txt        |   14 +
 drivers/i2c/busses/Kconfig                         |   10 +
 drivers/i2c/busses/Makefile                        |    1 +
 drivers/i2c/busses/i2c-img-scb.c                   | 1369 ++++++++++++++++++++
 4 files changed, 1394 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-img-scb.txt
 create mode 100644 drivers/i2c/busses/i2c-img-scb.c

-- 
2.1.0
