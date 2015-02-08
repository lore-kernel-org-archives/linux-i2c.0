From: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v9 0/3] Add I2C support to Broadcom iProc
Date: Sat, 7 Feb 2015 21:25:23 -0800
Message-ID: <1423373126-30024-1-git-send-email-rjui@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patchset contains the initial I2C support for Broadcom iProc family of
SoCs.

The iProc I2C controller has separate internal TX and RX FIFOs, each has a
size of 64 bytes. The iProc I2C controller supports two bus speeds including
standard mode (100 kHz) and fast mode (400 kHz)

Synced code base to Linux 3.19-rc7

Changes from v8:
 - Sort header includes in alphabetical order
 - Use correct error code
 - Get rid of redundant functions and combine functions to make driver more
   slim
 - Get rid of redundant debugging prints that are already available from the
   I2C framework
 - Other minor improvements

Changes from v7:
 - Remove redundant 10-bit address check in the driver
 - Fix the driver that accidentally emits 1-byte of data with zero content in
   the case of SMBUS quick command
 - Improve debugging prints in the driver
 - Other minor improvements

Changes from v6:
 - Get rid of unnecessary atomic variable usage in the driver
 - Improve the "waiting for transaction to complete" logic further by making
   sure there's no pending/ongoing interrupt by the time when flag
   'xfer_is_done' is checked
 - After disabling interrupt with 'writel', add 'readl' to the same register
   to flush the bus to ensure the write has gone through

Changes from v5:
 - Improve the "waiting for transaction to be complete" logic to take care of
   the corner case when an interrupt fires after wait_for_completion_timeout
   times out
 - Improve the logic to disable I2C interrupt in the remove function. Make it
   more generic so it works for both dedicated and shared interrupt

Changes from v4:
 - Remove redundant header file includes
 - Change the logic that waits for the host controller to be idle to
   simply return -EBUSY
 - Use proper print level and error codes in the driver
 - Allow zero length message in the driver to support I2C_SMBUS_QUICK
 - Change back to use devm_request_irq. Disable interrupt in the remove
   function so there's no outstanding I2C interrupt when the driver is
   being removed from the framework
 - Other minor miscellaneous improvements and fixes

Changes from v3:
 - Add config dependency to COMPILE_TEST to allow the driver to be build tested
   by other platforms
 - Improve CPU utilization efficiency in the loop of waiting for bus to idle
 - Add more comment in the driver to clarify the way how the "start busy"
   interrupt is triggered from the I2C controller
 - Fix inconsistent coding style and format
 - Improve the bus speed validation logic in the driver
 - Add code to free the interrupt line in driver's remove function. Also
   change to use non-devm API to request the interrupt line
 - Other miscellaneous improvements and fixes

Changes from v2:
 - Have the I2C driver default to y so it does not need to be selected from
   ARCH_BCM_IPROC. This also helps to get rid of one patch. The driver still
   depends on ARCH_BCM_IPROC
 - Get rid of redundant check on resource returned by platform_get_resource

Changes from v1:
 - Fix function argument parenthesis
 - Get rid of redundant driver owner field

Ray Jui (3):
  i2c: iProc: define Broadcom iProc I2C binding
  i2c: iproc: Add Broadcom iProc I2C Driver
  ARM: dts: add I2C device nodes for Broadcom Cygnus

 .../devicetree/bindings/i2c/brcm,iproc-i2c.txt     |   37 ++
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |   20 +
 drivers/i2c/busses/Kconfig                         |   10 +
 drivers/i2c/busses/Makefile                        |    1 +
 drivers/i2c/busses/i2c-bcm-iproc.c                 |  461 ++++++++++++++++++++
 5 files changed, 529 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
 create mode 100644 drivers/i2c/busses/i2c-bcm-iproc.c

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
